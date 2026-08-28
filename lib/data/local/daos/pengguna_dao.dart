import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/pengguna_tables.dart';

part 'pengguna_dao.g.dart';

@DriftAccessor(tables: [Penggunas, Anggotas, PembinaProfils])
class PenggunaDao extends DatabaseAccessor<AppDatabase>
    with _$PenggunaDaoMixin {
  PenggunaDao(super.db);

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
}
