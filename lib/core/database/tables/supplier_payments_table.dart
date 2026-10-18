import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/suppliers_table.dart';

/// Table for storing payments made to suppliers.
class SupplierPayments extends Table {
  TextColumn get id => text()();
  TextColumn get supplierId => text().references(Suppliers, #id)();
  RealColumn get amount => real()();

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  IntColumn get paymentMethod => integer()();

  TextColumn get reference => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isVoided =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
