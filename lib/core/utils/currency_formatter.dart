import 'package:intl/intl.dart';

/// Configurable currency formatter.
///
/// Supports dynamic currency symbols and locale-aware formatting.
class CurrencyFormatter {
  CurrencyFormatter({
    this.symbol = 'PKR',
    this.locale = 'en_PK',
    this.decimalDigits = 2,
  });

  final String symbol;
  final String locale;
  final int decimalDigits;

  /// Format a number as currency: "PKR 1,000.00"
  String format(double amount) {
    final formatter = NumberFormat.currency(
      symbol: '$symbol ',
      decimalDigits: decimalDigits,
      locale: locale,
    );
    return formatter.format(amount);
  }

  /// Format without symbol: "1,000.00"
  String formatWithoutSymbol(double amount) {
    final formatter = NumberFormat('#,##0.${'0' * decimalDigits}');
    return formatter.format(amount);
  }

  /// Format compactly: "PKR 1K", "PKR 1.5M"
  String formatCompact(double amount) {
    if (amount >= 1000000) {
      return '$symbol ${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '$symbol ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return format(amount);
  }

  /// Create a copy with different settings
  CurrencyFormatter copyWith({
    String? symbol,
    String? locale,
    int? decimalDigits,
  }) {
    return CurrencyFormatter(
      symbol: symbol ?? this.symbol,
      locale: locale ?? this.locale,
      decimalDigits: decimalDigits ?? this.decimalDigits,
    );
  }
}
