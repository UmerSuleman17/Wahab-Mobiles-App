/// Failure class for representing operation results without throwing exceptions.
///
/// Used in the Result pattern for error handling in repositories and services.

class Failure {
  const Failure(this.message, {this.code, this.exception});

  final String message;
  final String? code;
  final Exception? exception;

  @override
  String toString() => 'Failure($code): $message';
}

/// Result type for operations that can fail.
///
/// Usage:
/// ```dart
/// final result = await repository.createProduct(product);
/// result.when(
///   success: (product) => print('Created: ${product.name}'),
///   failure: (failure) => print('Error: ${failure.message}'),
/// );
/// ```
sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(Failure failure) = FailureResult<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  T? get dataOrNull => switch (this) {
        Success<T>(data: final d) => d,
        _ => null,
      };

  Failure? get failureOrNull => switch (this) {
        FailureResult<T>(failure: final f) => f,
        _ => null,
      };
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) =>
      success(data);
}

class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) =>
      failure(this.failure);
}
