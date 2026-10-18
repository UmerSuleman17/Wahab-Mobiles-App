import 'package:drift/drift.dart';

/// Table for storing business expenses.
class Expenses extends Table {
  TextColumn get id => text()();

  /// Maps to ExpenseCategory enum. Conversion handled in DAO/repository layer.
  IntColumn get category => integer()();

  RealColumn get amount => real()();
  TextColumn get description => text()();

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  IntColumn get paymentMethod => integer()();

  TextColumn get reference => text().nullable()();
  BoolColumn get isVoided =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
