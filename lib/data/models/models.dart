import 'package:wm_app/core/constants/enums.dart';
import 'package:wm_app/core/database/app_database.dart';

/// A product line in a sale or purchase being created.
class LineItemInput {
  const LineItemInput({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });

  final String productId;
  final double quantity;
  final double unitPrice;

  double get lineTotal => quantity * unitPrice;
}

/// A persisted line item joined with its product.
class LineItemView {
  const LineItemView({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  final String productId;
  final String productName;
  final double quantity;
  final double unitPrice;
  final double total;
}

/// Supplier with computed financial position (PRD §11, §16).
class SupplierAccount {
  const SupplierAccount({
    required this.supplier,
    required this.totalPurchases,
    required this.purchaseCount,
    required this.paidAtPurchase,
    required this.payments,
  });

  final Supplier supplier;
  final double totalPurchases;
  final int purchaseCount;
  final double paidAtPurchase;
  final double payments;

  double get amountPaid => paidAtPurchase + payments;

  /// Credit purchases − supplier payments.
  double get balance => totalPurchases - paidAtPurchase - payments;
}

/// Customer with computed receivable position (PRD §51).
class CustomerAccount {
  const CustomerAccount({
    required this.customer,
    required this.totalPurchases,
    required this.totalPaid,
    required this.activeCreditSales,
    required this.overdueAmount,
    this.nextDueDate,
  });

  final Customer customer;
  final double totalPurchases;
  final double totalPaid;
  final int activeCreditSales;
  final double overdueAmount;
  final DateTime? nextDueDate;

  double get outstanding => totalPurchases - totalPaid;
  bool get hasOverdue => overdueAmount > 0.009;
}

/// Sale with items, customer and receipt.
class SaleDetail {
  const SaleDetail({
    required this.sale,
    required this.items,
    this.customer,
    this.receipt,
    this.payments = const [],
  });

  final Sale sale;
  final List<LineItemView> items;
  final Customer? customer;
  final Receipt? receipt;
  final List<CustomerPayment> payments;

  double get subtotal => items.fold(0, (s, i) => s + i.total);
  double get outstanding => sale.total - sale.amountReceived;

  /// Paid / Partially Paid / Pending / Overdue, derived at read time.
  PaymentStatus get effectiveStatus => effectiveSaleStatus(sale);
}

/// Purchase with items, supplier and receipt.
class PurchaseDetail {
  const PurchaseDetail({
    required this.purchase,
    required this.items,
    required this.supplier,
    this.receipt,
  });

  final Purchase purchase;
  final List<LineItemView> items;
  final Supplier supplier;
  final Receipt? receipt;

  double get subtotal => items.fold(0, (s, i) => s + i.total);
  double get outstanding => purchase.total - purchase.amountPaid;
}

/// Derives the display status of a sale, including Overdue.
PaymentStatus effectiveSaleStatus(Sale sale, {DateTime? now}) {
  final outstanding = sale.total - sale.amountReceived;
  if (outstanding <= 0.009) return PaymentStatus.paid;
  final due = sale.dueDate;
  if (due != null && due.isBefore(now ?? DateTime.now())) {
    return PaymentStatus.overdue;
  }
  return sale.amountReceived > 0
      ? PaymentStatus.partiallyPaid
      : PaymentStatus.pending;
}

/// Unified row for the Transactions history (PRD §18).
class TransactionRecord {
  const TransactionRecord({
    required this.id,
    required this.type,
    required this.title,
    required this.amount,
    required this.date,
    this.subtitle,
    this.paymentMethod,
    this.isVoided = false,
    this.supplierId,
    this.customerId,
    this.productIds = const [],
    this.status,
  });

  final String id;
  final TransactionType type;
  final String title;
  final String? subtitle;
  final double amount;
  final DateTime date;
  final PaymentMethod? paymentMethod;
  final bool isVoided;
  final String? supplierId;
  final String? customerId;
  final List<String> productIds;
  final PaymentStatus? status;
}

/// Filters for the Transactions history.
class TransactionFilter {
  const TransactionFilter({
    this.start,
    this.end,
    this.types = const {},
    this.supplierId,
    this.customerId,
    this.productId,
    this.paymentMethod,
    this.minAmount,
    this.maxAmount,
    this.query = '',
  });

  final DateTime? start;
  final DateTime? end;
  final Set<TransactionType> types;
  final String? supplierId;
  final String? customerId;
  final String? productId;
  final PaymentMethod? paymentMethod;
  final double? minAmount;
  final double? maxAmount;
  final String query;

  bool get isEmpty =>
      start == null &&
      end == null &&
      types.isEmpty &&
      supplierId == null &&
      customerId == null &&
      productId == null &&
      paymentMethod == null &&
      minAmount == null &&
      maxAmount == null &&
      query.isEmpty;

  TransactionFilter copyWith({
    DateTime? Function()? start,
    DateTime? Function()? end,
    Set<TransactionType>? types,
    String? Function()? supplierId,
    String? Function()? customerId,
    String? Function()? productId,
    PaymentMethod? Function()? paymentMethod,
    double? Function()? minAmount,
    double? Function()? maxAmount,
    String? query,
  }) {
    return TransactionFilter(
      start: start != null ? start() : this.start,
      end: end != null ? end() : this.end,
      types: types ?? this.types,
      supplierId: supplierId != null ? supplierId() : this.supplierId,
      customerId: customerId != null ? customerId() : this.customerId,
      productId: productId != null ? productId() : this.productId,
      paymentMethod:
          paymentMethod != null ? paymentMethod() : this.paymentMethod,
      minAmount: minAmount != null ? minAmount() : this.minAmount,
      maxAmount: maxAmount != null ? maxAmount() : this.maxAmount,
      query: query ?? this.query,
    );
  }
}

/// Daily cash position (PRD §15, §16).
class DailyCashSummary {
  const DailyCashSummary({
    required this.date,
    required this.openingBalance,
    required this.cashSales,
    required this.customerCollections,
    required this.otherIncome,
    required this.cashPurchases,
    required this.supplierPayments,
    required this.expenses,
    required this.withdrawals,
    required this.adjustments,
    required this.entries,
    this.closing,
  });

  final DateTime date;
  final double openingBalance;
  final double cashSales;
  final double customerCollections;
  final double otherIncome;
  final double cashPurchases;
  final double supplierPayments;
  final double expenses;
  final double withdrawals;

  /// Signed net of adjustments/voids.
  final double adjustments;
  final List<CashEntry> entries;
  final CashClosing? closing;

  /// Opening + Cash Sales + Other Income − Cash Purchases − Supplier Payments
  /// − Cash Expenses − Withdrawals ± Adjustments.
  double get expectedClosing =>
      openingBalance +
      cashSales +
      customerCollections +
      otherIncome -
      cashPurchases -
      supplierPayments -
      expenses -
      withdrawals +
      adjustments;

  bool get isClosed => closing != null;
}

/// Data required to render/print/share a receipt (PRD §14).
class ReceiptData {
  const ReceiptData({
    required this.receipt,
    required this.type,
    required this.business,
    required this.settings,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    this.amountPaid,
    this.balanceDue,
    this.partyLabel,
    this.partyName,
    this.partyPhone,
    this.dueDate,
    this.notes,
    this.isVoided = false,
  });

  final Receipt receipt;
  final ReceiptType type;
  final BusinessEntry? business;
  final ReceiptSetting? settings;
  final List<LineItemView> items;
  final double subtotal;
  final double discount;
  final double total;
  final PaymentMethod paymentMethod;
  final double? amountPaid;
  final double? balanceDue;
  final String? partyLabel;
  final String? partyName;
  final String? partyPhone;
  final DateTime? dueDate;
  final String? notes;
  final bool isVoided;
}

/// Dashboard snapshot (PRD §4, §56).
class DashboardSnapshot {
  const DashboardSnapshot({
    required this.todaySales,
    required this.todayPurchases,
    required this.todayExpenses,
    required this.cashBalance,
    required this.todayTransactionCount,
    required this.productCount,
    required this.totalStockQuantity,
    required this.inventoryValue,
    required this.lowStockCount,
    required this.outOfStockCount,
    required this.supplierPayable,
    required this.suppliersWithBalance,
    required this.receivablesTotal,
    required this.receivablesDueToday,
    required this.receivablesOverdue,
    required this.customersWithBalance,
    required this.dueReminders,
    required this.recentActivity,
  });

  final double todaySales;
  final double todayPurchases;
  final double todayExpenses;
  final double cashBalance;
  final int todayTransactionCount;
  final int productCount;
  final double totalStockQuantity;
  final double inventoryValue;
  final int lowStockCount;
  final int outOfStockCount;
  final double supplierPayable;
  final int suppliersWithBalance;
  final double receivablesTotal;
  final double receivablesDueToday;
  final double receivablesOverdue;
  final int customersWithBalance;
  final int dueReminders;
  final List<TransactionRecord> recentActivity;
}

/// Inclusive date range used by reports and filters.
class DateRange {
  const DateRange(this.start, this.end);
  final DateTime start;
  final DateTime end;

  factory DateRange.forPreset(DateFilterPreset preset, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final today = DateTime(n.year, n.month, n.day);
    switch (preset) {
      case DateFilterPreset.today:
        return DateRange(today, _endOf(today));
      case DateFilterPreset.yesterday:
        final y = today.subtract(const Duration(days: 1));
        return DateRange(y, _endOf(y));
      case DateFilterPreset.thisWeek:
        final start = today.subtract(Duration(days: today.weekday - 1));
        return DateRange(start, _endOf(today));
      case DateFilterPreset.thisMonth:
        return DateRange(DateTime(n.year, n.month, 1), _endOf(today));
      case DateFilterPreset.custom:
        return DateRange(today, _endOf(today));
    }
  }

  static DateTime _endOf(DateTime d) =>
      DateTime(d.year, d.month, d.day, 23, 59, 59, 999);
}
