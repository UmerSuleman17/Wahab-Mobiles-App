import 'package:drift/drift.dart';

/// Daily cash closing records (PRD §15 — Daily Closing).
///
/// One row per closed business day. Stores the system-calculated expected
/// closing balance alongside the physically counted amount.
class CashClosings extends Table {
  TextColumn get id => text()();

  /// Start of the business day that was closed (00:00 local time).
  DateTimeColumn get businessDate => dateTime().unique()();

  RealColumn get openingBalance => real()();
  RealColumn get expectedClosing => real()();
  RealColumn get actualClosing => real()();
  RealColumn get difference => real()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
