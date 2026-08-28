import 'package:drift/drift.dart';

import 'pengguna_tables.dart';

/// Mirrors `skk_bidang` in schema.sql.
class SkkBidangs extends Table {
  TextColumn get id => text()();
  TextColumn get nama => text().withLength(min: 1, max: 150)();
  // Agama, Patriotisme & Seni Budaya, Ketangkasan & Kesehatan, dst
  TextColumn get kelompok => text().nullable()();
  // ENUM('purwa','madya','utama')
  TextColumn get level => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {nama, level},
      ];
}

/// Mirrors `skk_item` in schema.sql.
class SkkItems extends Table {
  TextColumn get id => text()();
  TextColumn get skkBidangId => text().references(SkkBidangs, #id)();
  IntColumn get nomorUrut => integer()();
  TextColumn get deskripsiSyarat => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `skk_progress` in schema.sql — status derived from [SkkEvents],
/// same append-only pattern as [SkuEvents] (see PRD §6.3).
@DataClassName('SkkProgress')
class SkkProgresses extends Table {
  TextColumn get id => text()();
  TextColumn get anggotaId => text()();
  TextColumn get skkItemId => text().references(SkkItems, #id)();
  TextColumn get status => text().withDefault(const Constant('belum'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {anggotaId, skkItemId},
      ];
}

/// Mirrors `skk_event` in schema.sql.
class SkkEvents extends Table {
  TextColumn get id => text()();
  TextColumn get skkProgressId => text().references(SkkProgresses, #id)();
  TextColumn get aktorId => text().references(Penggunas, #id)();
  TextColumn get aksi => text()();
  TextColumn get catatan => text().nullable()();
  TextColumn get deviceId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
