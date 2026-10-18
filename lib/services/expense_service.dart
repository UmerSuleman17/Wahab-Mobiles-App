import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';
import 'package:wm_app/core/errors/app_exception.dart';
import 'package:wm_app/core/utils/id_generator.dart';

class ExpenseService {
  ExpenseService(this._db);

  final AppDatabase _db;
  late final _ledger = Ledger(_db);

  Future<String> recordExpense(
    ExpenseCategory category,
    double amount,
    String description,
    PaymentMethod method, {
    String? reference,
  }) async {
    if (amount <= 0) {
      throw const InvalidAmountException('Expense amount must be greater than zero');
    }

    return _db.transaction(() async {
      final now = DateTime.now();
      final expenseId = IdGenerator.generate();

      // 1. Insert Expense Record
      await _db.into(_db.expenses).insert(
            ExpensesCompanion.insert(
              id: expenseId,
              category: category.index,
              amount: amount,
              description: description,
              paymentMethod: method.index,
              reference: Value(reference),
              createdAt: now,
            ),
          );

      // 2. Record Cash Outflow if Cash
      if (method == PaymentMethod.cash) {
        await _ledger.addCash(
          type: CashEntryType.expense,
          signedAmount: -amount,
          description: 'Expense: $description',
          referenceId: expenseId,
          at: now,
        );
      }

      // 3. Audit Log
      await _ledger.audit(
        action: AuditAction.create,
        entityType: AuditEntityType.expense,
        entityId: expenseId,
        newValue: 'Amount: $amount, Category: ${category.name}',
      );

      return expenseId;
    });
  }

  Future<void> voidExpense(String expenseId) async {
    await _db.transaction(() async {
      final expense = await (_db.select(_db.expenses)
            ..where((t) => t.id.equals(expenseId)))
          .getSingleOrNull();
      if (expense == null) {
        throw RecordNotFoundException('Expense', expenseId);
      }
      if (expense.isVoided) return;

      // 1. Mark Voided
      await (_db.update(_db.expenses)..where((t) => t.id.equals(expenseId)))
          .write(
        const ExpensesCompanion(
          isVoided: Value(true),
        ),
      );

      // 2. Reverse Cash Outflow
      await _ledger.reverseCash(
        referenceIds: [expenseId],
        description: 'Reversal for voided expense #$expenseId',
        reversalReferenceId: expenseId,
      );

      // 3. Audit Log
      await _ledger.audit(
        action: AuditAction.void_,
        entityType: AuditEntityType.expense,
        entityId: expenseId,
        previousValue: 'Amount: ${expense.amount}',
      );
    });
  }
}
