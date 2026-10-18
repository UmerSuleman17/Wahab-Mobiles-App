import 'package:drift/drift.dart';

/// Table for storing generated receipts.
class Receipts extends Table {
  TextColumn get id => text()();
  TextColumn get receiptNumber => text().unique()();
  TextColumn get transactionId => text()();

  /// Maps to ReceiptType enum. Conversion handled in DAO/repository layer.
  IntColumn get type => integer()();

  RealColumn get total => real()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
