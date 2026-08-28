import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/domain.dart';
import '../../../core/utils/server_time.dart';
import '../database.dart';
import '../tables/pengguna_tables.dart';
import '../tables/sku_tables.dart';
import '../tables/sync_tables.dart';

part 'sku_dao.g.dart';

const _uuid = Uuid();

/// One row of the SKU checklist: the static item joined with this member's
/// (possibly absent) progress.
class SkuChecklistRow {
  final SkuItem item;
  final SkuProgress? progress;

  const SkuChecklistRow(this.item, this.progress);

  ProgressStatus get status => progress == null
      ? ProgressStatus.belum
      : ProgressStatus.fromDb(progress!.status);
}

/// A pending pengajuan uji, as shown in the pembina's antrian screen.
class AntrianRow {
  final SkuItem item;
  final SkuProgress progress;
  final Anggota anggota;
  final Pengguna penggunaAnggota;

  const AntrianRow(
      this.item, this.progress, this.anggota, this.penggunaAnggota);
}

@DriftAccessor(
  tables: [SkuItems, SkuProgresses, SkuEvents, Anggotas, Penggunas, SyncQueueItems],
)
class SkuDao extends DatabaseAccessor<AppDatabase> with _$SkuDaoMixin {
  SkuDao(super.db);

  Stream<List<SkuChecklistRow>> watchChecklist({
    required String anggotaId,
    required String golongan,
    required String tingkat,
  }) {
    final query = select(skuItems).join([
      leftOuterJoin(
        skuProgresses,
        skuProgresses.skuItemId.equalsExp(skuItems.id) &
            skuProgresses.anggotaId.equals(anggotaId),
      ),
    ])
      ..where(skuItems.golongan.equals(golongan) &
          skuItems.tingkat.equals(tingkat) &
          skuItems.aktif.equals(true))
      ..orderBy([OrderingTerm.asc(skuItems.nomorUrut)]);

    return query.watch().map(
          (rows) => rows
              .map(
                (r) => SkuChecklistRow(
                  r.readTable(skuItems),
                  r.readTableOrNull(skuProgresses),
                ),
              )
              .toList(),
        );
  }

  Future<List<SkuItem>> allItems({
    required String golongan,
    required String tingkat,
  }) =>
      (select(skuItems)
            ..where((t) =>
                t.golongan.equals(golongan) &
                t.tingkat.equals(tingkat) &
                t.aktif.equals(true)))
          .get();

  /// Appends an event to the SKU event log and recomputes the derived
  /// status on `sku_progress` — the only place that table is ever written
  /// (PRD §6.3: pengesahan bukan field yang di-overwrite langsung).
  /// Also drops a row into the local sync outbox for [SyncService].
  Future<void> appendEvent({
    required String anggotaId,
    required String skuItemId,
    required String aktorId,
    required EventAksi aksi,
    String? catatan,
    required String deviceId,
  }) async {
    await transaction(() async {
      var progress = await (select(skuProgresses)
            ..where((t) =>
                t.anggotaId.equals(anggotaId) &
                t.skuItemId.equals(skuItemId)))
          .getSingleOrNull();

      final progressId = progress?.id ?? _uuid.v4();
      if (progress == null) {
        await into(skuProgresses).insert(
          SkuProgressesCompanion.insert(
            id: progressId,
            anggotaId: anggotaId,
            skuItemId: skuItemId,
          ),
        );
      }

      final newStatus = switch (aksi) {
        EventAksi.ajukan => ProgressStatus.diajukan,
        EventAksi.sahkan => ProgressStatus.disahkan,
        EventAksi.tolak => ProgressStatus.ditolak,
        EventAksi.batal => ProgressStatus.belum,
      };

      await (update(skuProgresses)..where((t) => t.id.equals(progressId)))
          .write(
        SkuProgressesCompanion(
          status: Value(newStatus.name),
          updatedAt: Value(DateTime.now()),
        ),
      );

      final eventId = _uuid.v4();
      await into(skuEvents).insert(
        SkuEventsCompanion.insert(
          id: eventId,
          skuProgressId: progressId,
          aktorId: aktorId,
          aksi: aksi.name,
          catatan: Value(catatan),
          deviceId: Value(deviceId),
        ),
      );

      await into(syncQueueItems).insert(
        SyncQueueItemsCompanion.insert(
          id: _uuid.v4(),
          deviceId: deviceId,
          penggunaId: aktorId,
          entityType: 'sku_event',
          entityId: eventId,
          aksi: aksi.name,
          payloadJson: jsonEncode({
            'sku_progress_id': progressId,
            'anggota_id': anggotaId,
            'sku_item_id': skuItemId,
            'aktor_id': aktorId,
            'aksi': aksi.name,
            'catatan': catatan,
            'device_id': deviceId,
          }),
        ),
      );
    });
  }

  /// Antrian pengesahan untuk pembina: seluruh poin berstatus `diajukan`
  /// milik anggota di gudep yang sama.
  Stream<List<AntrianRow>> watchAntrian(String gudepId) {
    final query = select(skuProgresses).join([
      innerJoin(skuItems, skuItems.id.equalsExp(skuProgresses.skuItemId)),
      innerJoin(anggotas, anggotas.id.equalsExp(skuProgresses.anggotaId)),
      innerJoin(penggunas, penggunas.id.equalsExp(anggotas.penggunaId)),
    ])
      ..where(skuProgresses.status.equals(ProgressStatus.diajukan.name) &
          penggunas.gudepId.equals(gudepId))
      ..orderBy([OrderingTerm.asc(skuProgresses.updatedAt)]);

    return query.watch().map(
          (rows) => rows
              .map((r) => AntrianRow(
                    r.readTable(skuItems),
                    r.readTable(skuProgresses),
                    r.readTable(anggotas),
                    r.readTable(penggunas),
                  ))
              .toList(),
        );
  }

  /// True jika seluruh poin SKU aktif golongan+tingkat anggota sudah
  /// `disahkan` — dipakai untuk badge "siap dilantik" (P0-4).
  Future<bool> isSiapDilantik({
    required String anggotaId,
    required String golongan,
    required String tingkat,
  }) async {
    final summary = await progressSummary(
      anggotaId: anggotaId,
      golongan: golongan,
      tingkat: tingkat,
    );
    return summary.siapDilantik;
  }

  /// Ringkasan progress (dipakai dashboard pembina): jumlah poin
  /// `disahkan` dari total poin aktif, dan apakah sudah siap dilantik.
  Future<SkuProgressSummary> progressSummary({
    required String anggotaId,
    required String golongan,
    required String tingkat,
  }) async {
    final items = await allItems(golongan: golongan, tingkat: tingkat);
    final progresses = await (select(skuProgresses)
          ..where((t) => t.anggotaId.equals(anggotaId)))
        .get();
    final byItem = {for (final p in progresses) p.skuItemId: p.status};

    final disahkan = items
        .where((item) => byItem[item.id] == ProgressStatus.disahkan.name)
        .length;

    return SkuProgressSummary(
      total: items.length,
      disahkan: disahkan,
      siapDilantik: items.isNotEmpty && disahkan == items.length,
    );
  }

  /// Merges a `/api/sync/pull` response into local storage. Progress rows
  /// are upserted (server is authoritative, same derivation rule as
  /// [appendEvent]); events are insert-or-ignore since the log is
  /// append-only and immutable once written.
  Future<void> mergeFromPull({
    required List<dynamic> skuProgress,
    required List<dynamic> skuEventRows,
  }) async {
    await transaction(() async {
      for (final row in skuProgress.cast<Map<String, dynamic>>()) {
        await into(skuProgresses).insertOnConflictUpdate(
          SkuProgressesCompanion.insert(
            id: row['id'] as String,
            anggotaId: row['anggota_id'] as String,
            skuItemId: row['sku_item_id'] as String,
            status: Value(row['status'] as String),
            updatedAt: Value(parseServerDateTime(row['updated_at'] as String)),
          ),
        );
      }
      for (final row in skuEventRows.cast<Map<String, dynamic>>()) {
        await into(skuEvents).insert(
          SkuEventsCompanion.insert(
            id: row['id'] as String,
            skuProgressId: row['sku_progress_id'] as String,
            aktorId: row['aktor_id'] as String,
            aksi: row['aksi'] as String,
            catatan: Value(row['catatan'] as String?),
            deviceId: Value(row['device_id'] as String?),
            createdAt: Value(parseServerDateTime(row['created_at'] as String)),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }
}

class SkuProgressSummary {
  final int total;
  final int disahkan;
  final bool siapDilantik;

  const SkuProgressSummary({
    required this.total,
    required this.disahkan,
    required this.siapDilantik,
  });
}
