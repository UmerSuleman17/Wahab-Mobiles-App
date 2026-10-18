import 'package:drift/drift.dart';
import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/data/models/models.dart';

class TransactionRepository {
  TransactionRepository(this._db);

  final AppDatabase _db;

  Future<List<TransactionRecord>> getAll(TransactionFilter filter) async {
    final records = <TransactionRecord>[];

    final shouldIncludeSale = filter.types.isEmpty ||
        filter.types.contains(TransactionType.sale);
    final shouldIncludePurchase = filter.types.isEmpty ||
        filter.types.contains(TransactionType.purchase);
    final shouldIncludeExpense = filter.types.isEmpty ||
        filter.types.contains(TransactionType.expense);
    final shouldIncludeSupplierPayment = filter.types.isEmpty ||
        filter.types.contains(TransactionType.supplierPayment);
    final shouldIncludeCustomerPayment = filter.types.isEmpty ||
        filter.types.contains(TransactionType.customerPayment);

    // 1. Sales
    if (shouldIncludeSale && filter.supplierId == null) {
      var query = _db.select(_db.sales);
      if (filter.start != null && filter.end != null) {
        query.where((t) => t.createdAt.isBetweenValues(filter.start!, filter.end!));
      } else if (filter.start != null) {
        query.where((t) => t.createdAt.isBiggerOrEqualValue(filter.start!));
      } else if (filter.end != null) {
        query.where((t) => t.createdAt.isSmallerOrEqualValue(filter.end!));
      }
      if (filter.customerId != null) {
        query.where((t) => t.customerId.equals(filter.customerId!));
      }
      final sales = await query.get();
      for (final s in sales) {
        records.add(TransactionRecord(
          id: s.id,
          type: TransactionType.sale,
          title: 'Sale #${s.receiptId ?? s.id.substring(0, 8)}',
          subtitle: s.notes,
          amount: s.total,
          date: s.createdAt,
          paymentMethod: PaymentMethod.values[s.paymentMethod],
          isVoided: s.isVoided,
          customerId: s.customerId,
          status: PaymentStatus.values[s.paymentStatus],
        ));
      }
    }

    // 2. Purchases
    if (shouldIncludePurchase && filter.customerId == null) {
      var query = _db.select(_db.purchases);
      if (filter.start != null && filter.end != null) {
        query.where((t) => t.createdAt.isBetweenValues(filter.start!, filter.end!));
      } else if (filter.start != null) {
        query.where((t) => t.createdAt.isBiggerOrEqualValue(filter.start!));
      } else if (filter.end != null) {
        query.where((t) => t.createdAt.isSmallerOrEqualValue(filter.end!));
      }
      if (filter.supplierId != null) {
        query.where((t) => t.supplierId.equals(filter.supplierId!));
      }
      final purchases = await query.get();
      for (final p in purchases) {
        records.add(TransactionRecord(
          id: p.id,
          type: TransactionType.purchase,
          title: 'Purchase #${p.receiptId ?? p.id.substring(0, 8)}',
          subtitle: p.notes,
          amount: p.total,
          date: p.createdAt,
          paymentMethod: PaymentMethod.values[p.paymentMethod],
          isVoided: p.isVoided,
          supplierId: p.supplierId,
          status: PaymentStatus.values[p.paymentStatus],
        ));
      }
    }

    // 3. Expenses
    if (shouldIncludeExpense && filter.customerId == null && filter.supplierId == null) {
      var query = _db.select(_db.expenses);
      if (filter.start != null && filter.end != null) {
        query.where((t) => t.createdAt.isBetweenValues(filter.start!, filter.end!));
      } else if (filter.start != null) {
        query.where((t) => t.createdAt.isBiggerOrEqualValue(filter.start!));
      } else if (filter.end != null) {
        query.where((t) => t.createdAt.isSmallerOrEqualValue(filter.end!));
      }
      final expenses = await query.get();
      for (final e in expenses) {
        records.add(TransactionRecord(
          id: e.id,
          type: TransactionType.expense,
          title: e.description.isNotEmpty ? e.description : 'Expense',
          subtitle: e.reference,
          amount: e.amount,
          date: e.createdAt,
          paymentMethod: PaymentMethod.values[e.paymentMethod],
          isVoided: e.isVoided,
        ));
      }
    }

    // 4. Supplier Payments
    if (shouldIncludeSupplierPayment && filter.customerId == null) {
      var query = _db.select(_db.supplierPayments);
      if (filter.start != null && filter.end != null) {
        query.where((t) => t.createdAt.isBetweenValues(filter.start!, filter.end!));
      } else if (filter.start != null) {
        query.where((t) => t.createdAt.isBiggerOrEqualValue(filter.start!));
      } else if (filter.end != null) {
        query.where((t) => t.createdAt.isSmallerOrEqualValue(filter.end!));
      }
      if (filter.supplierId != null) {
        query.where((t) => t.supplierId.equals(filter.supplierId!));
      }
      final sp = await query.get();
      for (final p in sp) {
        records.add(TransactionRecord(
          id: p.id,
          type: TransactionType.supplierPayment,
          title: 'Supplier Payment',
          subtitle: p.notes ?? p.reference,
          amount: p.amount,
          date: p.createdAt,
          paymentMethod: PaymentMethod.values[p.paymentMethod],
          isVoided: p.isVoided,
          supplierId: p.supplierId,
        ));
      }
    }

    // 5. Customer Payments
    if (shouldIncludeCustomerPayment && filter.supplierId == null) {
      var query = _db.select(_db.customerPayments);
      if (filter.start != null && filter.end != null) {
        query.where((t) => t.createdAt.isBetweenValues(filter.start!, filter.end!));
      } else if (filter.start != null) {
        query.where((t) => t.createdAt.isBiggerOrEqualValue(filter.start!));
      } else if (filter.end != null) {
        query.where((t) => t.createdAt.isSmallerOrEqualValue(filter.end!));
      }
      if (filter.customerId != null) {
        query.where((t) => t.customerId.equals(filter.customerId!));
      }
      final cp = await query.get();
      for (final p in cp) {
        records.add(TransactionRecord(
          id: p.id,
          type: TransactionType.customerPayment,
          title: 'Customer Payment',
          subtitle: p.notes ?? p.reference,
          amount: p.amount,
          date: p.createdAt,
          paymentMethod: PaymentMethod.values[p.paymentMethod],
          isVoided: false,
          customerId: p.customerId,
        ));
      }
    }

    // Post-query filtering
    var filtered = records;
    if (filter.paymentMethod != null) {
      filtered = filtered.where((r) => r.paymentMethod == filter.paymentMethod).toList();
    }
    if (filter.minAmount != null) {
      filtered = filtered.where((r) => r.amount >= filter.minAmount!).toList();
    }
    if (filter.maxAmount != null) {
      filtered = filtered.where((r) => r.amount <= filter.maxAmount!).toList();
    }
    if (filter.query.isNotEmpty) {
      final q = filter.query.toLowerCase();
      filtered = filtered.where((r) =>
          r.title.toLowerCase().contains(q) ||
          (r.subtitle != null && r.subtitle!.toLowerCase().contains(q))).toList();
    }

    // Sort descending by date
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }
}
