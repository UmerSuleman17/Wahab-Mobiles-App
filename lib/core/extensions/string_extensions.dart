extension StringExtensions on String {
  /// Capitalize the first letter
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize each word
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalized).join(' ');
  }

  /// Check if this string contains [other] case-insensitively
  bool containsIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }

  /// Truncate to [maxLength] and append ellipsis if needed
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Check if string is a valid email format
  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  /// Check if string is a valid phone number (basic check)
  bool get isValidPhone {
    return RegExp(r'^[+]?[\d\s\-()]{7,20}$').hasMatch(this);
  }

  /// Check if string is null or whitespace only
  bool get isBlank => trim().isEmpty;

  /// Return null if blank, otherwise return trimmed string
  String? get nullIfBlank => isBlank ? null : trim();
}

extension NullableStringExtensions on String? {
  /// Check if null or blank
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  /// Return empty string if null
  String get orEmpty => this ?? '';
}
