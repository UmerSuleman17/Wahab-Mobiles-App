import 'package:drift/drift.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/ledger.dart';

class SalesReportData {
  const SalesReportData({required this.totalSales, required this.count});
  final double totalSales;
  final int count;
}

class PurchasesReportData {
  const PurchasesReportData({required this.totalPurchases, required this.count});
  final double totalPurchases;
  final int count;
}

class ExpenseReportData {
  const ExpenseReportData({required this.totalExpenses, required this.count});
  final double totalExpenses;
  final int count;
}

class CashFlowReportData {
  const CashFlowReportData({
    required this.inflow,
    required this.outflow,
    required this.net,
  });
  final double inflow;
  final double outflow;
  final double net;
}

class SupplierBalanceData {
  const SupplierBalanceData({
    required this.supplierId,
    required this.name,
    required this.balance,
  });
  final String supplierId;
  final String name;
  final double balance;
}

class CustomerReceivableData {
  const CustomerReceivableData({
    required this.customerId,
    required this.name,
    required this.balance,
  });
  final String customerId;
  final String name;
  final double balance;
}

class StockSummaryData {
  const StockSummaryData({
    required this.totalItems,
    required this.totalValue,
    required this.lowStockItems,
  });
  final int totalItems;
  final double totalValue;
  final int lowStockItems;
}

class ReportService {
  ReportService(this._db);

  final AppDatabase _db;

  Future<SalesReportData> getSalesReport(DateTime start, DateTime end) async {
    final sumExpr = _db.sales.total.sum();
    final countExpr = _db.sales.id.count();

    final row = await (_db.selectOnly(_db.sales)
          ..addColumns([sumExpr, countExpr])
          ..where(_db.sales.createdAt.isBetweenValues(start, end) &
              _db.sales.isVoided.equals(false)))
        .getSingle();

    return SalesReportData(
      totalSales: roundMoney(row.read(sumExpr) ?? 0.0),
      count: row.read(countExpr) ?? 0,
    );
  }

  Future<PurchasesReportData> getPurchasesReport(
    DateTime start,
    DateTime end,
  ) async {
    final sumExpr = _db.purchases.total.sum();
    final countExpr = _db.purchases.id.count();

    final row = await (_db.selectOnly(_db.purchases)
          ..addColumns([sumExpr, countExpr])
          ..where(_db.purchases.createdAt.isBetweenValues(start, end) &
              _db.purchases.isVoided.equals(false)))
        .getSingle();

    return PurchasesReportData(
      totalPurchases: roundMoney(row.read(sumExpr) ?? 0.0),
      count: row.read(countExpr) ?? 0,
    );
  }

  Future<ExpenseReportData> getExpenseReport(
    DateTime start,
    DateTime end,
  ) async {
    final sumExpr = _db.expenses.amount.sum();
    final countExpr = _db.expenses.id.count();

    final row = await (_db.selectOnly(_db.expenses)
          ..addColumns([sumExpr, countExpr])
          ..where(_db.expenses.createdAt.isBetweenValues(start, end) &
              _db.expenses.isVoided.equals(false)))
        .getSingle();

    return ExpenseReportData(
      totalExpenses: roundMoney(row.read(sumExpr) ?? 0.0),
      count: row.read(countExpr) ?? 0,
    );
  }

  Future<CashFlowReportData> getCashFlowReport(
    DateTime start,
    DateTime end,
  ) async {
    final entries = await (_db.select(_db.cashEntries)
          ..where((t) => t.createdAt.isBetweenValues(start, end)))
        .get();

    double inflow = 0;
    double outflow = 0;

    for (final e in entries) {
      if (e.amount > 0) {
        inflow += e.amount;
      } else {
        outflow += e.amount.abs();
      }
    }

    return CashFlowReportData(
      inflow: roundMoney(inflow),
      outflow: roundMoney(outflow),
      net: roundMoney(inflow - outflow),
    );
  }

  Future<List<SupplierBalanceData>> getSupplierBalances() async {
    final suppliers = await (_db.select(_db.suppliers)).get();
    final result = <SupplierBalanceData>[];

    for (final supplier in suppliers) {
      final purchaseRow = await (_db.selectOnly(_db.purchases)
            ..addColumns([_db.purchases.total.sum(), _db.purchases.amountPaid.sum()])
            ..where(_db.purchases.supplierId.equals(supplier.id) &
                _db.purchases.isVoided.equals(false)))
          .getSingle();

      final totalPurchases =
          purchaseRow.read(_db.purchases.total.sum()) ?? 0.0;
      final paidAtPurchase =
          purchaseRow.read(_db.purchases.amountPaid.sum()) ?? 0.0;

      final paymentRow = await (_db.selectOnly(_db.supplierPayments)
            ..addColumns([_db.supplierPayments.amount.sum()])
            ..where(_db.supplierPayments.supplierId.equals(supplier.id) &
                _db.supplierPayments.isVoided.equals(false)))
          .getSingle();

      final separatePayments =
          paymentRow.read(_db.supplierPayments.amount.sum()) ?? 0.0;

      final balance =
          roundMoney(totalPurchases - paidAtPurchase - separatePayments);

      result.add(SupplierBalanceData(
        supplierId: supplier.id,
        name: supplier.name,
        balance: balance,
      ));
    }

    return result;
  }

  Future<List<CustomerReceivableData>> getCustomerReceivables() async {
    final customers = await (_db.select(_db.customers)).get();
    final result = <CustomerReceivableData>[];

    for (final customer in customers) {
      final saleRow = await (_db.selectOnly(_db.sales)
            ..addColumns([_db.sales.total.sum(), _db.sales.amountReceived.sum()])
            ..where(_db.sales.customerId.equals(customer.id) &
                _db.sales.isVoided.equals(false)))
          .getSingle();

      final totalSales = saleRow.read(_db.sales.total.sum()) ?? 0.0;
      final received = saleRow.read(_db.sales.amountReceived.sum()) ?? 0.0;
      final balance = roundMoney(totalSales - received);

      result.add(CustomerReceivableData(
        customerId: customer.id,
        name: customer.name,
        balance: balance,
      ));
    }

    return result;
  }

  Future<StockSummaryData> getStockSummary() async {
    final products = await (_db.select(_db.products)).get();
    int lowStockCount = 0;
    double totalVal = 0;

    for (final p in products) {
      totalVal += p.quantity * p.purchasePrice;
      if (p.quantity <= p.minStock) {
        lowStockCount++;
      }
    }

    return StockSummaryData(
      totalItems: products.length,
      totalValue: roundMoney(totalVal),
      lowStockItems: lowStockCount,
    );
  }
}
