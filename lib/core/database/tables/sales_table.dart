import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/customers_table.dart';

/// Table for storing sales transactions.
class Sales extends Table {
  TextColumn get id => text()();
  TextColumn get receiptId => text().nullable()();
  TextColumn get customerId =>
      text().nullable().references(Customers, #id)();
  RealColumn get total => real()();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get amountReceived => real().withDefault(const Constant(0))();

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  IntColumn get paymentMethod => integer()();

  /// Maps to PaymentStatus enum. Conversion handled in DAO/repository layer.
  IntColumn get paymentStatus => integer()();

  /// Maps to SaleType enum. Conversion handled in DAO/repository layer.
  IntColumn get saleType => integer()();

  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isVoided =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
