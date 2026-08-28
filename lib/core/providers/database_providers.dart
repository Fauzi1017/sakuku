import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../data/local/daos/materi_dao.dart';
import '../../data/local/daos/pelantikan_dao.dart';
import '../../data/local/daos/pengguna_dao.dart';
import '../../data/local/daos/sku_dao.dart';
import '../../data/local/daos/sync_queue_dao.dart';
import '../../data/local/database.dart';
import '../../data/seed/seed_data.dart';

/// Single [AppDatabase] instance for the app's lifetime.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final penggunaDaoProvider =
    Provider((ref) => PenggunaDao(ref.watch(databaseProvider)));
final skuDaoProvider = Provider((ref) => SkuDao(ref.watch(databaseProvider)));
final materiDaoProvider =
    Provider((ref) => MateriDao(ref.watch(databaseProvider)));
final pelantikanDaoProvider =
    Provider((ref) => PelantikanDao(ref.watch(databaseProvider)));
final syncQueueDaoProvider =
    Provider((ref) => SyncQueueDao(ref.watch(databaseProvider)));

/// Stable per-install device id, used to tag offline-created events
/// (`sku_event.device_id`, `sync_log.device_id` in schema.sql) so their
/// origin can be traced after sync.
final deviceIdProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('device_id');
  if (id == null) {
    id = const Uuid().v4();
    await prefs.setString('device_id', id);
  }
  return id;
});

/// Seeds demo data once, then app UI can be shown. Splash/loading screen
/// watches this.
final appInitProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  await SeedData.seedIfEmpty(db);
});
