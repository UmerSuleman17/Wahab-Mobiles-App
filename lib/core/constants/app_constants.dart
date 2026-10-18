class AppConstants {
  AppConstants._();

  // App Info
  static const appName = 'WM Business';
  static const appVersion = '1.0.0';

  // Business Setup Defaults
  static const defaultCurrency = 'PKR';
  static const defaultMinStock = 5;

  // Pagination
  static const pageSize = 20;

  // Reminder Defaults
  static const defaultReminderDelayHours = 24;
  static const defaultReminderMessage =
      'Hello {customerName}, this is a payment reminder from {businessName}.\n'
      'Your outstanding balance is {currency} {amount} for your purchase.\n'
      'Please contact us regarding your payment. Thank you.';

  // Receipt
  static const receiptNumberPrefix = 'RCT';
  static const saleReceiptPrefix = 'SL';
  static const purchaseReceiptPrefix = 'PUR';
  static const paymentReceiptPrefix = 'PAY';

  // Date Formats
  static const dateFormat = 'dd MMM yyyy';
  static const timeFormat = 'hh:mm a';
  static const dateTimeFormat = 'dd MMM yyyy, hh:mm a';

  // Validation
  static const maxProductNameLength = 100;
  static const maxDescriptionLength = 500;
  static const maxNotesLength = 1000;
  static const maxPhoneLength = 20;
  static const maxEmailLength = 100;
  static const maxAddressLength = 300;

  // Database
  static const databaseName = 'wm_app.db';
  static const databaseVersion = 1;

  // Backup
  static const backupFileExtension = '.wmbackup';
  static const backupPrefix = 'wm_backup_';
}
