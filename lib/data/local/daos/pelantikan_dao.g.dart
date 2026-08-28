// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pelantikan_dao.dart';

// ignore_for_file: type=lint
mixin _$PelantikanDaoMixin on DatabaseAccessor<AppDatabase> {
  $PelantikansTable get pelantikans => attachedDatabase.pelantikans;
  $SyncQueueItemsTable get syncQueueItems => attachedDatabase.syncQueueItems;
  PelantikanDaoManager get managers => PelantikanDaoManager(this);
}

class PelantikanDaoManager {
  final _$PelantikanDaoMixin _db;
  PelantikanDaoManager(this._db);
  $$PelantikansTableTableManager get pelantikans =>
      $$PelantikansTableTableManager(_db.attachedDatabase, _db.pelantikans);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(
        _db.attachedDatabase,
        _db.syncQueueItems,
      );
}
