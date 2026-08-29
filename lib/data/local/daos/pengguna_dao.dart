import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/organisasi_tables.dart';
import '../tables/pengguna_tables.dart';

part 'pengguna_dao.g.dart';

@DriftAccessor(tables: [Gudeps, Penggunas, Anggotas, PembinaProfils])
class PenggunaDao extends DatabaseAccessor<AppDatabase>
    with _$PenggunaDaoMixin {
  PenggunaDao(super.db);

  /// The single gudep this device knows about — used by local-only
  /// registration (offline, or no backend configured) since v1 is
  /// single-gudep (PRD §3) and there's no gudep picker in the UI.
  Future<String?> firstGudepId() async {
    final row = await (select(gudeps)..limit(1)).getSingleOrNull();
    return row?.id;
  }

  Future<Pengguna?> findByEmail(String email) =>
      (select(penggunas)..where((t) => t.email.equals(email)))
          .getSingleOrNull();

  Future<Pengguna?> findById(String id) =>
      (select(penggunas)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<Anggota?> anggotaForPengguna(String penggunaId) =>
      (select(anggotas)..where((t) => t.penggunaId.equals(penggunaId)))
          .getSingleOrNull();

  Future<PembinaProfil?> pembinaProfilForPengguna(String penggunaId) =>
      (select(pembinaProfils)..where((t) => t.penggunaId.equals(penggunaId)))
          .getSingleOrNull();

  /// Semua anggota binaan (dipakai layar antrian pembina) — v1: satu gudep,
  /// jadi seluruh anggota di gudep yang sama dianggap binaan pembina
  /// tersebut (lihat PRD §3 non-goals: multi-tenant belum di v1).
  Future<List<Anggota>> anggotaSeGudep(String gudepId) async {
    final query = select(anggotas).join([
      innerJoin(penggunas, penggunas.id.equalsExp(anggotas.penggunaId)),
    ])
      ..where(penggunas.gudepId.equals(gudepId));
    final rows = await query.get();
    return rows.map((r) => r.readTable(anggotas)).toList();
  }

  Stream<List<(Anggota, Pengguna)>> watchAnggotaSeGudep(String gudepId) {
    final query = select(anggotas).join([
      innerJoin(penggunas, penggunas.id.equalsExp(anggotas.penggunaId)),
    ])
      ..where(penggunas.gudepId.equals(gudepId))
      ..orderBy([OrderingTerm.asc(penggunas.nama)]);
    return query.watch().map(
          (rows) => rows
              .map((r) => (r.readTable(anggotas), r.readTable(penggunas)))
              .toList(),
        );
  }

  Future<int> insertPengguna(PenggunasCompanion entry) =>
      into(penggunas).insert(entry);

  Future<int> insertAnggota(AnggotasCompanion entry) =>
      into(anggotas).insert(entry);

  Future<int> insertPembinaProfil(PembinaProfilsCompanion entry) =>
      into(pembinaProfils).insert(entry);

  /// Inserts a placeholder gudep row if one doesn't exist yet locally —
  /// needed when a device's first-ever action is an online login against
  /// a real backend it has never synced a gudep record from before.
  Future<void> ensureGudep(String id) async {
    final existing =
        await (select(gudeps)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (existing != null) return;
    await into(gudeps).insert(
      GudepsCompanion.insert(id: id, nama: '—'),
      mode: InsertMode.insertOrIgnore,
    );
  }

  /// Upserts a pengguna row from an API response, keyed by server id —
  /// used right after a successful online login (see AuthController) so
  /// the device has a local copy of this account for offline logins.
  Future<void> upsertPenggunaFromApi({
    required String id,
    required String gudepId,
    required String nama,
    String? email,
    required String role,
    required String status,
    required String passwordHash,
  }) async {
    await into(penggunas).insertOnConflictUpdate(
      PenggunasCompanion.insert(
        id: id,
        gudepId: gudepId,
        nama: nama,
        email: Value(email),
        role: role,
        status: Value(status),
        passwordHash: passwordHash,
      ),
    );
  }

  Future<void> upsertAnggotaFromApi({
    required String id,
    required String penggunaId,
    String? nis,
    required String golongan,
    String? tingkatSaatIni,
    String? reguPasukan,
  }) async {
    await into(anggotas).insertOnConflictUpdate(
      AnggotasCompanion.insert(
        id: id,
        penggunaId: penggunaId,
        nis: Value(nis),
        golongan: golongan,
        tingkatSaatIni: Value(tingkatSaatIni),
        reguPasukan: Value(reguPasukan),
      ),
    );
  }
}
