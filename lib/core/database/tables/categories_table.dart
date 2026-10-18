import 'package:drift/drift.dart';

/// Table for storing product categories.
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();

  @override
  Set<Column> get primaryKey => {id};
}
