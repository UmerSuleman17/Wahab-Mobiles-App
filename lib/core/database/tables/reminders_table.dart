import 'package:drift/drift.dart';

import 'package:wm_app/core/database/tables/customers_table.dart';
import 'package:wm_app/core/database/tables/sales_table.dart';

/// Table for storing payment reminders for customers.
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get customerId => text().references(Customers, #id)();
  TextColumn get saleId => text().references(Sales, #id)();
  RealColumn get outstandingAmount => real()();
  DateTimeColumn get scheduledAt => dateTime()();
  DateTimeColumn get sentAt => dateTime().nullable()();

  /// Maps to ReminderStatus enum. Conversion handled in DAO/repository layer.
  IntColumn get status => integer()();

  TextColumn get message => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
