extension NumExtensions on num {
  /// Format as currency with 2 decimal places
  String toCurrency({String symbol = '', int decimals = 2}) {
    final formatted = toStringAsFixed(decimals)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
    return symbol.isEmpty ? formatted : '$symbol $formatted';
  }

  /// Format as compact number (1K, 1M, etc.)
  String toCompact() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    }
    if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toStringAsFixed(0);
  }

  /// Format as quantity (no unnecessary decimals)
  String toQuantityString() {
    if (this == toInt()) {
      return toInt().toString();
    }
    return toStringAsFixed(2);
  }

  /// Check if value is essentially zero
  bool get isZero => abs() < 0.001;

  /// Check if value is positive
  bool get isPositive => this > 0;

  /// Check if value is negative
  bool get isNegative => this < 0;

  /// Ensure value is not negative, returning 0 if it is
  num get nonNegative => this < 0 ? 0 : this;
}

extension DoubleExtensions on double {
  /// Round to [places] decimal places
  double roundTo(int places) {
    final mod = _pow10(places);
    return (this * mod).round() / mod;
  }

  static double _pow10(int exponent) {
    double result = 1.0;
    for (var i = 0; i < exponent; i++) {
      result *= 10;
    }
    return result;
  }
}
