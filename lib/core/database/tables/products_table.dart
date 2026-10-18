import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/categories_table.dart';
import 'package:wm_app/core/database/tables/suppliers_table.dart';

/// Table for storing product inventory.
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get categoryId =>
      text().nullable().references(Categories, #id)();
  RealColumn get purchasePrice => real()();
  RealColumn get sellingPrice => real()();
  RealColumn get quantity => real().withDefault(const Constant(0))();
  IntColumn get minStock => integer().withDefault(const Constant(5))();
  TextColumn get supplierId =>
      text().nullable().references(Suppliers, #id)();
  TextColumn get imagePath => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
