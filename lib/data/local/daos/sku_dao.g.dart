// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sku_dao.dart';

// ignore_for_file: type=lint
mixin _$SkuDaoMixin on DatabaseAccessor<AppDatabase> {
  $SkuItemsTable get skuItems => attachedDatabase.skuItems;
  $SkuProgressesTable get skuProgresses => attachedDatabase.skuProgresses;
  $SkuEventsTable get skuEvents => attachedDatabase.skuEvents;
  $AnggotasTable get anggotas => attachedDatabase.anggotas;
  $PenggunasTable get penggunas => attachedDatabase.penggunas;
  $SyncQueueItemsTable get syncQueueItems => attachedDatabase.syncQueueItems;
  SkuDaoManager get managers => SkuDaoManager(this);
}

class SkuDaoManager {
  final _$SkuDaoMixin _db;
  SkuDaoManager(this._db);
  $$SkuItemsTableTableManager get skuItems =>
      $$SkuItemsTableTableManager(_db.attachedDatabase, _db.skuItems);
  $$SkuProgressesTableTableManager get skuProgresses =>
      $$SkuProgressesTableTableManager(_db.attachedDatabase, _db.skuProgresses);
  $$SkuEventsTableTableManager get skuEvents =>
      $$SkuEventsTableTableManager(_db.attachedDatabase, _db.skuEvents);
  $$AnggotasTableTableManager get anggotas =>
      $$AnggotasTableTableManager(_db.attachedDatabase, _db.anggotas);
  $$PenggunasTableTableManager get penggunas =>
      $$PenggunasTableTableManager(_db.attachedDatabase, _db.penggunas);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(
        _db.attachedDatabase,
        _db.syncQueueItems,
      );
}
