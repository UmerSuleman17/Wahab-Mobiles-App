import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/core/utils/id_generator.dart';
import 'package:wm_app/data/models/models.dart';

class CashService {
  CashService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<DailyCashSummary> getDailyCashSummary(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

    // Opening balance is all cash activity prior to start of day
    final openingExpr = _db.cashEntries.amount.sum();
    final openingRow = await (_db.selectOnly(_db.cashEntries)
          ..addColumns([openingExpr])
          ..where(_db.cashEntries.createdAt.isSmallerThanValue(startOfDay)))
        .getSingle();
    final openingBalance = roundMoney(openingRow.read(openingExpr) ?? 0.0);

    // Entries for the day
    final dayEntries = await (_db.select(_db.cashEntries)
          ..where((t) => t.createdAt.isBetweenValues(startOfDay, endOfDay))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();

    double cashSales = 0;
    double customerCollections = 0;
    double otherIncome = 0;
    double cashPurchases = 0;
    double supplierPayments = 0;
    double expenses = 0;
    double withdrawals = 0;
    double adjustments = 0;

    for (final entry in dayEntries) {
      final type = CashEntryType.values[entry.type];
      switch (type) {
        case CashEntryType.cashSale:
          cashSales += entry.amount.abs();
          break;
        case CashEntryType.customerPayment:
          customerCollections += entry.amount.abs();
          break;
        case CashEntryType.otherIncome:
        case CashEntryType.cashDeposit:
          otherIncome += entry.amount.abs();
          break;
        case CashEntryType.cashPurchase:
          cashPurchases += entry.amount.abs();
          break;
        case CashEntryType.supplierPayment:
          supplierPayments += entry.amount.abs();
          break;
        case CashEntryType.expense:
        case CashEntryType.otherExpense:
          expenses += entry.amount.abs();
          break;
        case CashEntryType.cashWithdrawal:
          withdrawals += entry.amount.abs();
          break;
        case CashEntryType.adjustment:
        case CashEntryType.openingBalance:
          adjustments += entry.amount;
          break;
      }
    }

    final closing = await (_db.select(_db.cashClosings)
          ..where((t) => t.businessDate.equals(startOfDay)))
        .getSingleOrNull();

    return DailyCashSummary(
      date: startOfDay,
      openingBalance: openingBalance,
      cashSales: roundMoney(cashSales),
      customerCollections: roundMoney(customerCollections),
      otherIncome: roundMoney(otherIncome),
      cashPurchases: roundMoney(cashPurchases),
      supplierPayments: roundMoney(supplierPayments),
      expenses: roundMoney(expenses),
      withdrawals: roundMoney(withdrawals),
      adjustments: roundMoney(adjustments),
      entries: dayEntries,
      closing: closing,
    );
  }

  Future<void> closeDay(
    DateTime date,
    double actualAmount, {
    String? notes,
  }) async {
    final businessDate = DateTime(date.year, date.month, date.day);
    final summary = await getDailyCashSummary(businessDate);
    final expected = summary.expectedClosing;
    final diff = roundMoney(actualAmount - expected);

    await _db.into(_db.cashClosings).insertOnConflictUpdate(
          CashClosingsCompanion.insert(
            id: IdGenerator.generate(),
            businessDate: businessDate,
            openingBalance: summary.openingBalance,
            expectedClosing: expected,
            actualClosing: actualAmount,
            difference: diff,
            notes: Value(notes),
            createdAt: DateTime.now(),
          ),
        );

    await _ledger.audit(
      action: AuditAction.create,
      entityType: AuditEntityType.cashEntry,
      entityId: businessDate.toIso8601String(),
      newValue: 'Expected: $expected, Actual: $actualAmount, Diff: $diff',
    );
  }

  Future<void> addCashEntry(
    CashEntryType type,
    double amount,
    String description, {
    String? referenceId,
  }) async {
    await _ledger.addCash(
      type: type,
      signedAmount: amount,
      description: description,
      referenceId: referenceId,
    );
  }
}
