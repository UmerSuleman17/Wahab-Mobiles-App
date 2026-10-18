import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/customers_table.dart';
import 'package:wm_app/core/database/tables/sales_table.dart';

/// Table for storing payments received from customers.
class CustomerPayments extends Table {
  TextColumn get id => text()();
  TextColumn get customerId => text().references(Customers, #id)();
  TextColumn get saleId =>
      text().nullable().references(Sales, #id)();
  RealColumn get amount => real()();

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  IntColumn get paymentMethod => integer()();

  TextColumn get reference => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
