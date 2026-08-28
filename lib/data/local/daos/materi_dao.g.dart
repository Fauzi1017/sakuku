// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materi_dao.dart';

// ignore_for_file: type=lint
mixin _$MateriDaoMixin on DatabaseAccessor<AppDatabase> {
  $MateriKategorisTable get materiKategoris => attachedDatabase.materiKategoris;
  $MateriTopiksTable get materiTopiks => attachedDatabase.materiTopiks;
  $MateriUnitsTable get materiUnits => attachedDatabase.materiUnits;
  $MateriRelasisTable get materiRelasis => attachedDatabase.materiRelasis;
  $MateriProgressBacasTable get materiProgressBacas =>
      attachedDatabase.materiProgressBacas;
  MateriDaoManager get managers => MateriDaoManager(this);
}

class MateriDaoManager {
  final _$MateriDaoMixin _db;
  MateriDaoManager(this._db);
  $$MateriKategorisTableTableManager get materiKategoris =>
      $$MateriKategorisTableTableManager(
        _db.attachedDatabase,
        _db.materiKategoris,
      );
  $$MateriTopiksTableTableManager get materiTopiks =>
      $$MateriTopiksTableTableManager(_db.attachedDatabase, _db.materiTopiks);
  $$MateriUnitsTableTableManager get materiUnits =>
      $$MateriUnitsTableTableManager(_db.attachedDatabase, _db.materiUnits);
  $$MateriRelasisTableTableManager get materiRelasis =>
      $$MateriRelasisTableTableManager(_db.attachedDatabase, _db.materiRelasis);
  $$MateriProgressBacasTableTableManager get materiProgressBacas =>
      $$MateriProgressBacasTableTableManager(
        _db.attachedDatabase,
        _db.materiProgressBacas,
      );
}
