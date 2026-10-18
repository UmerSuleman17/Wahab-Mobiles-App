import 'package:drift/drift.dart';

/// Table for storing audit trail entries.
class AuditEntries extends Table {
  TextColumn get id => text()();

  /// Maps to AuditAction enum. Conversion handled in DAO/repository layer.
  IntColumn get action => integer()();

  /// Maps to AuditEntityType enum. Conversion handled in DAO/repository layer.
  IntColumn get entityType => integer()();

  TextColumn get entityId => text()();
  TextColumn get previousValue => text().nullable()();
  TextColumn get newValue => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
