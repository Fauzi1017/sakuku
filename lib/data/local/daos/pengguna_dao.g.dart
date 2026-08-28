// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pengguna_dao.dart';

// ignore_for_file: type=lint
mixin _$PenggunaDaoMixin on DatabaseAccessor<AppDatabase> {
  $GudepsTable get gudeps => attachedDatabase.gudeps;
  $PenggunasTable get penggunas => attachedDatabase.penggunas;
  $AnggotasTable get anggotas => attachedDatabase.anggotas;
  $PembinaProfilsTable get pembinaProfils => attachedDatabase.pembinaProfils;
  PenggunaDaoManager get managers => PenggunaDaoManager(this);
}

class PenggunaDaoManager {
  final _$PenggunaDaoMixin _db;
  PenggunaDaoManager(this._db);
  $$GudepsTableTableManager get gudeps =>
      $$GudepsTableTableManager(_db.attachedDatabase, _db.gudeps);
  $$PenggunasTableTableManager get penggunas =>
      $$PenggunasTableTableManager(_db.attachedDatabase, _db.penggunas);
  $$AnggotasTableTableManager get anggotas =>
      $$AnggotasTableTableManager(_db.attachedDatabase, _db.anggotas);
  $$PembinaProfilsTableTableManager get pembinaProfils =>
      $$PembinaProfilsTableTableManager(
        _db.attachedDatabase,
        _db.pembinaProfils,
      );
}
