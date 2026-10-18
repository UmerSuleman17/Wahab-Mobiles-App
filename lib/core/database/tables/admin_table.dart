import 'package:drift/drift.dart';

/// Table for storing admin credentials.
class AdminEntries extends Table {
  TextColumn get id => text()();
  TextColumn get pinHash => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
