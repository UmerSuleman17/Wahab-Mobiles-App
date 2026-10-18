import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Format as "26 Sep 2026"
  String toDateString() => DateFormat('dd MMM yyyy').format(this);

  /// Format as "02:30 PM"
  String toTimeString() => DateFormat('hh:mm a').format(this);

  /// Format as "26 Sep 2026, 02:30 PM"
  String toDateTimeString() => DateFormat('dd MMM yyyy, hh:mm a').format(this);

  /// Format as "2026-09-26"
  String toIsoDateString() => DateFormat('yyyy-MM-dd').format(this);

  /// Check if this date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if this date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Get the start of the day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get the end of the day (23:59:59.999)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get start of this week (Monday)
  DateTime get startOfWeek {
    final diff = weekday - DateTime.monday;
    return subtract(Duration(days: diff)).startOfDay;
  }

  /// Get end of this week (Sunday)
  DateTime get endOfWeek {
    final diff = DateTime.sunday - weekday;
    return add(Duration(days: diff)).endOfDay;
  }

  /// Get start of this month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of this month
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Check if this date is before today
  bool get isPast => isBefore(DateTime.now().startOfDay);

  /// Check if this date is after today
  bool get isFuture => isAfter(DateTime.now().endOfDay);

  /// Get relative description: "Today", "Yesterday", or formatted date
  String toRelativeString() {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    return toDateString();
  }
}
