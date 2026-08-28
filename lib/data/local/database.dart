import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/materi_dao.dart';
import 'daos/pelantikan_dao.dart';
import 'daos/pengguna_dao.dart';
import 'daos/sku_dao.dart';
import 'daos/sync_queue_dao.dart';
import 'tables/materi_tables.dart';
import 'tables/organisasi_tables.dart';
import 'tables/pelantikan_tables.dart';
import 'tables/pengguna_tables.dart';
import 'tables/skk_tables.dart';
import 'tables/sku_tables.dart';
import 'tables/sync_tables.dart';

part 'database.g.dart';

/// Local-first database — the single source of truth on-device.
///
/// Design decision vs. `schema.sql`: primary keys here are client-generated
/// UUID strings (see `Uuid().v4()` at call sites) rather than server
/// `BIGINT AUTO_INCREMENT`. A local-first app must be able to create new
/// SKU events, pelantikan records, etc. while fully offline (PRD §6.1/6.4),
/// so ids can't depend on a central sequence — this mirrors the intent of
/// `sku_event.device_id` / `sync_log` in the schema (tracing offline-origin
/// records) and keeps ids stable across the eventual sync to the MySQL
/// backend described in PRD §6.2, which can adopt them as its own primary
/// key (`VARCHAR` instead of `BIGINT`) or map them 1:1 on first push.
@DriftDatabase(
  tables: [
    Gudeps,
    Penggunas,
    Anggotas,
    PembinaProfils,
    SkuItems,
    SkuProgresses,
    SkuEvents,
    SkkBidangs,
    SkkItems,
    SkkProgresses,
    SkkEvents,
    Pelantikans,
    MateriKategoris,
    MateriTopiks,
    MateriUnits,
    MateriRelasis,
    MateriProgressBacas,
    SyncQueueItems,
  ],
  daos: [PenggunaDao, SkuDao, MateriDao, PelantikanDao, SyncQueueDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() => driftDatabase(
      name: 'sakuku_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
      native: const DriftNativeOptions(shareAcrossIsolates: false),
    );
