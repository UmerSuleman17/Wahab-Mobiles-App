import 'package:drift/drift.dart';

/// Key-value store for application preferences
/// (reminder settings, stock behaviour, etc.).
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
