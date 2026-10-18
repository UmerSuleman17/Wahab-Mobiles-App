import 'package:uuid/uuid.dart';

/// UUID-based ID generator for all entities.
class IdGenerator {
  IdGenerator._();

  static const _uuid = Uuid();

  /// Generate a new v4 UUID string
  static String generate() => _uuid.v4();
}
