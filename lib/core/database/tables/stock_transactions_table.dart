import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/products_table.dart';

/// Table for tracking stock movement history.
class StockTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get productId => text().references(Products, #id)();

  /// Maps to StockTransactionType enum. Conversion handled in DAO/repository layer.
  IntColumn get type => integer()();

  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();
  RealColumn get total => real()();
  TextColumn get referenceId => text().nullable()();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
