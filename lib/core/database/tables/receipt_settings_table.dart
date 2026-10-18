import 'package:drift/drift.dart';

/// Table for storing receipt printing/display settings.
class ReceiptSettings extends Table {
  TextColumn get id => text()();
  TextColumn get header => text().nullable()();
  TextColumn get footer => text().nullable()();
  BoolColumn get showLogo =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get showBusinessInfo =>
      boolean().withDefault(const Constant(true))();
  TextColumn get taxLabel => text().nullable()();
  RealColumn get taxPercentage => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
