/// A small Result/Either type to represent success or failure.
///
/// Usage:
/// - `Result<MyData>.success(data)`
/// - `Result<MyData>.failure('reason')`
class Result<T> {
  const Result._();

  /// Success factory
  factory Result.success(T data) = Success<T>;

  /// Failure factory
  factory Result.failure(String message) = Failure<T>;

  /// Returns true when this is a [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns true when this is a [Failure].
  bool get isFailure => this is Failure<T>;

  /// Returns the success data or null if this is a failure.
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;

  /// Returns the failure message or null if this is a success.
  String? get messageOrNull => this is Failure<T> ? (this as Failure<T>).message : null;

  /// Pattern match helper.
  R when<R>({required R Function(T data) success, required R Function(String message) failure}) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    }
    return failure((this as Failure<T>).message);
  }

  @override
  String toString() => isSuccess ? 'Result.success(${dataOrNull.toString()})' : 'Result.failure(${messageOrNull})';
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data) : super._();

  @override
  bool operator ==(Object other) => identical(this, other) || other is Success<T> && other.data == data;

  @override
  int get hashCode => data.hashCode;
}

class Failure<T> extends Result<T> {
  final String message;

  const Failure(this.message) : super._();

  @override
  bool operator ==(Object other) => identical(this, other) || other is Failure<T> && other.message == message;

  @override
  int get hashCode => message.hashCode;
}