import 'package:drift/drift.dart';

/// Table for storing business profile information.
class BusinessEntries extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get logoPath => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('PKR'))();
  RealColumn get openingCash => real().withDefault(const Constant(0))();
  RealColumn get openingBank => real().withDefault(const Constant(0))();
  BoolColumn get isSetupComplete =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
