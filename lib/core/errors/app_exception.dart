/// Custom exception hierarchy for the WM App.
///
/// All exceptions extend [AppException] for consistent error handling.

abstract class AppException implements Exception {
  const AppException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'AppException($code): $message';
}

/// Authentication-related errors
class AuthException extends AppException {
  const AuthException(super.message, {super.code});
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException()
      : super('Invalid PIN or password', code: 'INVALID_CREDENTIALS');
}

class SessionExpiredException extends AuthException {
  const SessionExpiredException()
      : super('Session has expired', code: 'SESSION_EXPIRED');
}

/// Database / data layer errors
class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.code});
}

class RecordNotFoundException extends DatabaseException {
  const RecordNotFoundException(String entity, String id)
      : super('$entity with ID $id not found', code: 'RECORD_NOT_FOUND');
}

class DuplicateRecordException extends DatabaseException {
  const DuplicateRecordException(String field, String value)
      : super('Duplicate $field: $value', code: 'DUPLICATE_RECORD');
}

/// Inventory-related errors
class InventoryException extends AppException {
  const InventoryException(super.message, {super.code});
}

class InsufficientStockException extends InventoryException {
  InsufficientStockException({
    required String productName,
    required double available,
    required double requested,
  }) : super(
          'Insufficient stock for $productName. '
          'Available: ${available.toStringAsFixed(0)}, '
          'Requested: ${requested.toStringAsFixed(0)}',
          code: 'INSUFFICIENT_STOCK',
        );
}

/// Financial / transaction errors
class TransactionException extends AppException {
  const TransactionException(super.message, {super.code});
}

class InvalidAmountException extends TransactionException {
  const InvalidAmountException(String reason)
      : super('Invalid amount: $reason', code: 'INVALID_AMOUNT');
}

class OverpaymentException extends TransactionException {
  OverpaymentException({
    required double outstanding,
    required double payment,
  }) : super(
          'Payment of ${payment.toStringAsFixed(2)} exceeds outstanding '
          'balance of ${outstanding.toStringAsFixed(2)}',
          code: 'OVERPAYMENT',
        );
}

class TransactionIntegrityException extends TransactionException {
  const TransactionIntegrityException(String detail)
      : super(
          'Transaction integrity violation: $detail',
          code: 'INTEGRITY_VIOLATION',
        );
}

/// Validation errors
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}

/// Backup / restore errors
class BackupException extends AppException {
  const BackupException(super.message, {super.code});
}

class InvalidBackupException extends BackupException {
  const InvalidBackupException()
      : super('Invalid or corrupted backup file', code: 'INVALID_BACKUP');
}

/// Scanner errors
class ScannerException extends AppException {
  const ScannerException(super.message, {super.code});
}

class CameraPermissionException extends ScannerException {
  const CameraPermissionException()
      : super(
          'Camera permission is required to scan barcodes',
          code: 'CAMERA_PERMISSION',
        );
}

/// Receipt errors
class ReceiptException extends AppException {
  const ReceiptException(super.message, {super.code});
}
