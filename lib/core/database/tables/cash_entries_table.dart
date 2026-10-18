import 'package:drift/drift.dart';

/// Table for tracking cash flow entries.
class CashEntries extends Table {
  TextColumn get id => text()();

  /// Maps to CashEntryType enum. Conversion handled in DAO/repository layer.
  IntColumn get type => integer()();

  RealColumn get amount => real()();
  TextColumn get description => text()();
  TextColumn get referenceId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
