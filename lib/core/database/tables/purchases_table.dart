import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/suppliers_table.dart';

/// Table for storing purchase transactions from suppliers.
class Purchases extends Table {
  TextColumn get id => text()();
  TextColumn get supplierId => text().references(Suppliers, #id)();
  TextColumn get receiptId => text().nullable()();
  RealColumn get total => real()();
  RealColumn get discount => real().withDefault(const Constant(0))();

  /// Amount paid to the supplier at the time of purchase.
  /// Supplier payable for this purchase = total − amountPaid.
  RealColumn get amountPaid => real().withDefault(const Constant(0))();

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  IntColumn get paymentMethod => integer()();

  /// Maps to PaymentStatus enum. Conversion handled in DAO/repository layer.
  IntColumn get paymentStatus => integer()();

  TextColumn get notes => text().nullable()();
  BoolColumn get isVoided =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
