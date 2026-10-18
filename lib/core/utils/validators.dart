/// Input validation utilities for the WM App.
///
/// Provides validators for forms, financial data, and business rules.
class Validators {
  Validators._();

  /// Validate required field
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate numeric value
  static String? numeric(String? value, {String fieldName = 'Value'}) {
    if (value == null || value.trim().isEmpty) return null;
    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }
    return null;
  }

  /// Validate positive number
  static String? positiveNumber(String? value, {String fieldName = 'Value'}) {
    if (value == null || value.trim().isEmpty) return null;
    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName must be a valid number';
    }
    if (number < 0) {
      return '$fieldName cannot be negative';
    }
    return null;
  }

  /// Validate that number is greater than zero
  static String? greaterThanZero(String? value, {String fieldName = 'Value'}) {
    if (value == null || value.trim().isEmpty) return null;
    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName must be a valid number';
    }
    if (number <= 0) {
      return '$fieldName must be greater than zero';
    }
    return null;
  }

  /// Validate price (non-negative, valid number)
  static String? price(String? value, {String fieldName = 'Price'}) {
    final requiredResult = required(value, fieldName: fieldName);
    if (requiredResult != null) return requiredResult;
    return positiveNumber(value, fieldName: fieldName);
  }

  /// Validate quantity (non-negative, valid number)
  static String? quantity(String? value, {String fieldName = 'Quantity'}) {
    final requiredResult = required(value, fieldName: fieldName);
    if (requiredResult != null) return requiredResult;
    return greaterThanZero(value, fieldName: fieldName);
  }

  /// Validate email format
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return null; // Optional
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Validate phone number
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return null; // Optional
    if (!RegExp(r'^[+]?[\d\s\-()]{7,20}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Validate max length
  static String? maxLength(String? value, int max,
      {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) return null;
    if (value.length > max) {
      return '$fieldName must not exceed $max characters';
    }
    return null;
  }

  /// Validate PIN (4-6 digits)
  static String? pin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'PIN is required';
    }
    if (!RegExp(r'^\d{4,6}$').hasMatch(value)) {
      return 'PIN must be 4-6 digits';
    }
    return null;
  }

  /// Validate that payment amount doesn't exceed outstanding balance
  static String? paymentAmount(
    String? value, {
    required double outstandingBalance,
    bool allowOverpayment = false,
  }) {
    final requiredResult = required(value, fieldName: 'Amount');
    if (requiredResult != null) return requiredResult;

    final amount = double.tryParse(value!);
    if (amount == null || amount <= 0) {
      return 'Enter a valid amount greater than zero';
    }

    if (!allowOverpayment && amount > outstandingBalance) {
      return 'Amount exceeds outstanding balance of '
          '${outstandingBalance.toStringAsFixed(2)}';
    }

    return null;
  }

  /// Validate stock availability
  static String? stockAvailability(
    String? value, {
    required double availableStock,
    required String productName,
    bool allowNegative = false,
  }) {
    final requiredResult = quantity(value, fieldName: 'Quantity');
    if (requiredResult != null) return requiredResult;

    final parsedQuantity = double.tryParse(value!);
    if (parsedQuantity == null) return null;

    if (!allowNegative && parsedQuantity > availableStock) {
      return 'Insufficient stock for $productName. '
          'Available: ${availableStock.toStringAsFixed(0)}';
    }

    return null;
  }

  /// Combine multiple validators
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
