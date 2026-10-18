import 'package:intl/intl.dart';

/// Sequential receipt number generator.
///
/// Generates receipt numbers in the format: PREFIX-YYYYMMDD-NNNN
/// Example: SL-20260926-0001
class ReceiptNumberGenerator {
  ReceiptNumberGenerator._();

  /// Generate a receipt number from a prefix and a sequence number
  static String generate({
    required String prefix,
    required int sequence,
    DateTime? date,
  }) {
    final dateStr = DateFormat('yyyyMMdd').format(date ?? DateTime.now());
    final seqStr = sequence.toString().padLeft(4, '0');
    return '$prefix-$dateStr-$seqStr';
  }
}
