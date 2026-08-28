import 'package:drift/drift.dart';

import 'pengguna_tables.dart';

/// Mirrors `sku_item` in schema.sql.
class SkuItems extends Table {
  TextColumn get id => text()();
  // ENUM('siaga','penggalang','penegak','pandega')
  TextColumn get golongan => text()();
  // ramu/rakit/terap, dst
  TextColumn get tingkat => text()();
  IntColumn get nomorUrut => integer()();
  TextColumn get deskripsi => text()();
  // mis. 'spiritual','fisik','keterampilan'
  TextColumn get kategori => text().nullable()();
  BoolColumn get aktif => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `sku_progress` in schema.sql.
/// `status` is a cached/derived projection of the latest valid `SkuEvents`
/// row for this (anggota, sku_item) pair — see PRD §6.3 / §9. It is only
/// ever written by [SkuRepository] when appending a new event, never
/// edited directly by UI code.
@DataClassName('SkuProgress')
class SkuProgresses extends Table {
  TextColumn get id => text()();
  TextColumn get anggotaId => text()();
  TextColumn get skuItemId => text().references(SkuItems, #id)();
  // ENUM('belum','diajukan','disahkan','ditolak')
  TextColumn get status => text().withDefault(const Constant('belum'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {anggotaId, skuItemId},
      ];
}

/// Mirrors `sku_event` in schema.sql — append-only audit log. Status of a
/// point is *derived* from the latest event here, never overwritten
/// in-place, so concurrent offline pengesahan never silently clobbers data.
class SkuEvents extends Table {
  TextColumn get id => text()();
  TextColumn get skuProgressId => text().references(SkuProgresses, #id)();
  TextColumn get aktorId => text().references(Penggunas, #id)();
  // ENUM('ajukan','sahkan','tolak','batal')
  TextColumn get aksi => text()();
  TextColumn get catatan => text().nullable()();
  TextColumn get deviceId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
