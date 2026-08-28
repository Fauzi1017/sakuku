import 'package:drift/drift.dart';

/// Local outbox — mirrors the purpose of `sync_log` in schema.sql, but
/// lives client-side as a queue of not-yet-pushed mutations (PRD §6.1/6.4:
/// "Sync di background... antri di local queue").
///
/// Every offline write that must reach the server (ajukan, sahkan/tolak,
/// pelantikan, dst) inserts one row here. [SyncService] drains this queue
/// once connectivity returns; `syncedAt` stays null until the push
/// succeeds. This table is the client-side half of the server's
/// `sync_log` — entity ids are already final (UUIDs, see database.dart)
/// so no id-remapping is needed once pushed.
class SyncQueueItems extends Table {
  TextColumn get id => text()();
  TextColumn get deviceId => text()();
  TextColumn get penggunaId => text()();
  // 'sku_event' | 'skk_event' | 'pelantikan' | ...
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get aksi => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
