import 'package:drift/drift.dart';

import 'pengguna_tables.dart';

/// Mirrors `pelantikan` in schema.sql — portofolio digital anggota
/// (PRD §8, P0-8).
class Pelantikans extends Table {
  TextColumn get id => text()();
  TextColumn get anggotaId => text()();
  // ENUM('TKU','TKK')
  TextColumn get jenis => text()();
  // mis. "Penggalang Rakit" atau "TKK Berkemah Purwa"
  TextColumn get referensiLabel => text()();
  DateTimeColumn get tanggal => dateTime()();
  TextColumn get pembinaId => text().references(Penggunas, #id)();
  TextColumn get catatan => text().nullable()();
  TextColumn get sertifikatUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
