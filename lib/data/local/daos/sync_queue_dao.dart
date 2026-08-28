import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/sync_tables.dart';

part 'sync_queue_dao.g.dart';

@DriftAccessor(tables: [SyncQueueItems])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Stream<int> watchPendingCount() {
    final query = selectOnly(syncQueueItems)
      ..addColumns([syncQueueItems.id.count()])
      ..where(syncQueueItems.syncedAt.isNull());
    return query
        .watchSingle()
        .map((row) => row.read(syncQueueItems.id.count()) ?? 0);
  }

  Future<List<SyncQueueItem>> pending() => (select(syncQueueItems)
        ..where((t) => t.syncedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
      .get();

  Future<void> markSynced(Iterable<String> ids) async {
    if (ids.isEmpty) return;
    await (update(syncQueueItems)..where((t) => t.id.isIn(ids))).write(
      SyncQueueItemsCompanion(syncedAt: Value(DateTime.now())),
    );
  }
}
