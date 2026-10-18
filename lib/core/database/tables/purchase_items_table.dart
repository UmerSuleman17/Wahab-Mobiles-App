import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/products_table.dart';
import 'package:wm_app/core/database/tables/purchases_table.dart';

/// Table for storing individual line items within a purchase.
class PurchaseItems extends Table {
  TextColumn get id => text()();
  TextColumn get purchaseId => text().references(Purchases, #id)();
  TextColumn get productId => text().references(Products, #id)();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();
  RealColumn get total => real()();

  @override
  Set<Column> get primaryKey => {id};
}
