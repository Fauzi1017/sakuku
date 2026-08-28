import 'package:drift/drift.dart';

import 'organisasi_tables.dart';

/// Mirrors `pengguna` in schema.sql.
/// NOTE: `password_hash` here is a placeholder for the local demo — in
/// production, auth must go through the real backend (PRD §6.2); this app
/// only ever compares against locally-seeded demo credentials.
class Penggunas extends Table {
  TextColumn get id => text()();
  TextColumn get gudepId => text().references(Gudeps, #id)();
  TextColumn get nama => text().withLength(min: 1, max: 150)();
  TextColumn get email => text().nullable()();
  TextColumn get noHp => text().nullable()();
  TextColumn get passwordHash => text()();
  // ENUM('peserta_didik','pembina','pelatih_skk','admin_gudep','kwartir')
  TextColumn get role => text()();
  // ENUM('aktif','nonaktif')
  TextColumn get status => text().withDefault(const Constant('aktif'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `anggota` in schema.sql.
class Anggotas extends Table {
  TextColumn get id => text()();
  TextColumn get penggunaId =>
      text().unique().references(Penggunas, #id)();
  TextColumn get nis => text().nullable()();
  // ENUM('siaga','penggalang','penegak','pandega')
  TextColumn get golongan => text()();
  // mis. 'ramu','rakit','terap','bantara','laksana'
  TextColumn get tingkatSaatIni => text().nullable()();
  DateTimeColumn get tanggalLahir => dateTime().nullable()();
  TextColumn get namaWali => text().nullable()();
  TextColumn get kontakWali => text().nullable()();
  TextColumn get reguPasukan => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mirrors `pembina_profil` in schema.sql.
class PembinaProfils extends Table {
  TextColumn get id => text()();
  TextColumn get penggunaId =>
      text().unique().references(Penggunas, #id)();
  TextColumn get bidangKeahlian => text().nullable()();
  TextColumn get keterangan => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
