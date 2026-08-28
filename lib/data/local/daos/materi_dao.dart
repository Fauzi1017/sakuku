import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database.dart';
import '../tables/materi_tables.dart';

part 'materi_dao.g.dart';

const _uuid = Uuid();

@DriftAccessor(tables: [
  MateriKategoris,
  MateriTopiks,
  MateriUnits,
  MateriRelasis,
  MateriProgressBacas,
])
class MateriDao extends DatabaseAccessor<AppDatabase> with _$MateriDaoMixin {
  MateriDao(super.db);

  Stream<List<MateriKategori>> watchKategori() =>
      (select(materiKategoris)..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
          .watch();

  Stream<List<MateriTopik>> watchTopik(String kategoriId) =>
      (select(materiTopiks)
            ..where((t) => t.kategoriId.equals(kategoriId))
            ..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
          .watch();

  Stream<List<MateriUnit>> watchUnit(String topikId) =>
      (select(materiUnits)
            ..where((t) => t.topikId.equals(topikId))
            ..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
          .watch();

  Future<MateriUnit?> unitById(String id) =>
      (select(materiUnits)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Materi yang terhubung ke satu poin SKU tertentu — tombol
  /// "Pelajari materinya" pada checklist (PRD §7.2).
  Future<List<MateriUnit>> materiUntukSkuItem(String skuItemId) async {
    final query = select(materiUnits).join([
      innerJoin(
        materiRelasis,
        materiRelasis.materiUnitId.equalsExp(materiUnits.id),
      ),
    ])
      ..where(materiRelasis.skuItemId.equals(skuItemId));
    final rows = await query.get();
    return rows.map((r) => r.readTable(materiUnits)).toList();
  }

  Future<void> tandaiSudahDibaca({
    required String anggotaId,
    required String materiUnitId,
  }) async {
    final existing = await (select(materiProgressBacas)
          ..where((t) =>
              t.anggotaId.equals(anggotaId) &
              t.materiUnitId.equals(materiUnitId)))
        .getSingleOrNull();
    if (existing != null) return;

    await into(materiProgressBacas).insert(
      MateriProgressBacasCompanion.insert(
        id: _uuid.v4(),
        anggotaId: anggotaId,
        materiUnitId: materiUnitId,
      ),
    );
  }

  Stream<Set<String>> watchDibacaIds(String anggotaId) {
    final query = select(materiProgressBacas)
      ..where((t) => t.anggotaId.equals(anggotaId));
    return query
        .watch()
        .map((rows) => rows.map((r) => r.materiUnitId).toSet());
  }
}
