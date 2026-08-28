import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/server_time.dart';
import '../database.dart';
import '../tables/pelantikan_tables.dart';
import '../tables/sync_tables.dart';

part 'pelantikan_dao.g.dart';

const _uuid = Uuid();

@DriftAccessor(tables: [Pelantikans, SyncQueueItems])
class PelantikanDao extends DatabaseAccessor<AppDatabase>
    with _$PelantikanDaoMixin {
  PelantikanDao(super.db);

  /// Riwayat TKU/TKK anggota — portofolio digital (PRD §8, P0-8).
  Stream<List<Pelantikan>> watchRiwayat(String anggotaId) =>
      (select(pelantikans)
            ..where((t) => t.anggotaId.equals(anggotaId))
            ..orderBy([(t) => OrderingTerm.desc(t.tanggal)]))
          .watch();

  Future<void> catatPelantikan({
    required String anggotaId,
    required String jenis,
    required String referensiLabel,
    required DateTime tanggal,
    required String pembinaId,
    String? catatan,
    required String deviceId,
  }) async {
    final id = _uuid.v4();
    await into(pelantikans).insert(
      PelantikansCompanion.insert(
        id: id,
        anggotaId: anggotaId,
        jenis: jenis,
        referensiLabel: referensiLabel,
        tanggal: tanggal,
        pembinaId: pembinaId,
        catatan: Value(catatan),
      ),
    );

    await into(syncQueueItems).insert(
      SyncQueueItemsCompanion.insert(
        id: _uuid.v4(),
        deviceId: deviceId,
        penggunaId: pembinaId,
        entityType: 'pelantikan',
        entityId: id,
        aksi: 'catat',
        payloadJson: jsonEncode({
          'anggota_id': anggotaId,
          'jenis': jenis,
          'referensi_label': referensiLabel,
          'tanggal': tanggal.toIso8601String(),
          'pembina_id': pembinaId,
          'catatan': catatan,
        }),
      ),
    );
  }

  /// Insert-or-ignore merge from `/api/sync/pull` — a pelantikan record is
  /// never edited once created, so duplicates are simply skipped.
  Future<void> mergeFromPull(List<dynamic> rows) async {
    await transaction(() async {
      for (final row in rows.cast<Map<String, dynamic>>()) {
        await into(pelantikans).insert(
          PelantikansCompanion.insert(
            id: row['id'] as String,
            anggotaId: row['anggota_id'] as String,
            jenis: row['jenis'] as String,
            referensiLabel: row['referensi_label'] as String,
            tanggal: parseServerDateTime(row['tanggal'] as String),
            pembinaId: row['pembina_id'] as String,
            catatan: Value(row['catatan'] as String?),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }
}
