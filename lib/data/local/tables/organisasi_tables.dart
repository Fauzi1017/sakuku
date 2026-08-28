import 'package:drift/drift.dart';

/// Mirrors `gudep` in schema.sql.
class Gudeps extends Table {
  TextColumn get id => text()();
  TextColumn get nama => text().withLength(min: 1, max: 150)();
  TextColumn get alamat => text().nullable()();
  TextColumn get kwarcab => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
