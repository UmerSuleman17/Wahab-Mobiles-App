/// Enums used across the application for type-safe database columns and business logic.

/// Type of stock transaction
enum StockTransactionType {
  stockIn,
  stockOut,
  adjustment,
  saleReturn,
  purchaseReturn,
}

/// Direction of stock adjustment
enum AdjustmentDirection {
  increase,
  decrease,
}

/// Reason for stock adjustment
enum AdjustmentReason {
  damaged,
  lost,
  missing,
  found,
  manualCorrection,
  stockCount,
  other,
}

/// Payment method
enum PaymentMethod {
  cash,
  bank,
  other,
}

/// Payment status for purchases and credit sales
enum PaymentStatus {
  paid,
  partiallyPaid,
  pending,
  overdue,
}

/// Type of sale
enum SaleType {
  cash,
  credit,
  partial,
}

/// Type of cash entry
enum CashEntryType {
  cashSale,
  cashPurchase,
  supplierPayment,
  customerPayment,
  expense,
  cashWithdrawal,
  cashDeposit,
  otherIncome,
  otherExpense,
  adjustment,
  openingBalance,
}

/// Type of receipt
enum ReceiptType {
  sale,
  purchase,
  supplierPayment,
  customerPayment,
}

/// Type of transaction in history
enum TransactionType {
  sale,
  purchase,
  expense,
  supplierPayment,
  customerPayment,
  cashAdjustment,
  stockAdjustment,
}

/// Audit action types
enum AuditAction {
  create,
  update,
  delete,
  void_,
  reverse,
  restore,
  adjust,
  login,
  logout,
  backup,
  importData,
}

/// Entity types for audit logging
enum AuditEntityType {
  product,
  category,
  supplier,
  customer,
  sale,
  purchase,
  expense,
  supplierPayment,
  customerPayment,
  stockAdjustment,
  cashEntry,
  receipt,
  business,
  admin,
  backup,
}

/// Reminder status
enum ReminderStatus {
  scheduled,
  sent,
  failed,
  cancelled,
}

/// Stock status for display
enum StockStatus {
  inStock,
  lowStock,
  outOfStock,
}

/// Report type
enum ReportType {
  dailySales,
  dailyPurchases,
  expenses,
  cashFlow,
  inventoryMovement,
  supplierBalances,
  customerReceivables,
  stockSummary,
}

/// Date filter presets for reports
enum DateFilterPreset {
  today,
  yesterday,
  thisWeek,
  thisMonth,
  custom,
}

/// Expense categories
enum ExpenseCategory {
  rent,
  utilities,
  transport,
  salaries,
  maintenance,
  miscellaneous,
  other,
}
