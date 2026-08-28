import 'package:drift/drift.dart';

import 'sku_tables.dart';
import 'skk_tables.dart';

/// Mirrors `materi_kategori` in schema.sql.
class MateriKategoris extends Table {
  TextColumn get id => text()();
  TextColumn get nama => text().withLength(min: 1, max: 150)();
  IntColumn get urutan => integer().withDefault(const Constant(0))();
  TextColumn get ikon => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `materi_topik` in schema.sql.
class MateriTopiks extends Table {
  TextColumn get id => text()();
  TextColumn get kategoriId => text().references(MateriKategoris, #id)();
  TextColumn get nama => text().withLength(min: 1, max: 150)();
  IntColumn get urutan => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `materi_unit` in schema.sql. `mediaUrls` stored as a JSON-encoded
/// string list (drift has no native JSON column outside of a plain text
/// column across all target platforms).
class MateriUnits extends Table {
  TextColumn get id => text()();
  TextColumn get topikId => text().references(MateriTopiks, #id)();
  TextColumn get judul => text().withLength(min: 1, max: 200)();
  TextColumn get kontenMarkdown => text()();
  TextColumn get mediaUrlsJson => text().nullable()();
  IntColumn get versi => integer().withDefault(const Constant(1))();
  IntColumn get urutan => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `materi_relasi` in schema.sql — many-to-many antara materi dan
/// poin SKU/SKK (exactly one of skuItemId/skkItemId is set).
class MateriRelasis extends Table {
  TextColumn get id => text()();
  TextColumn get materiUnitId => text().references(MateriUnits, #id)();
  TextColumn get skuItemId => text().nullable().references(SkuItems, #id)();
  TextColumn get skkItemId => text().nullable().references(SkkItems, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `materi_progress_baca` in schema.sql (P1 — tanda "sudah dibaca").
class MateriProgressBacas extends Table {
  TextColumn get id => text()();
  TextColumn get anggotaId => text()();
  TextColumn get materiUnitId => text().references(MateriUnits, #id)();
  DateTimeColumn get dibacaPada => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {anggotaId, materiUnitId},
      ];
}
