import '../failures/failure.dart';

/// Result of a repository call: either a value or a typed [Failure].
/// Repositories never throw across their boundary.
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;

  T? get valueOrNull => switch (this) {
    Ok(:final value) => value,
    Err() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Ok() => null,
    Err(:final failure) => failure,
  };

  R fold<R>(R Function(T value) onOk, R Function(Failure failure) onErr) =>
      switch (this) {
        Ok(:final value) => onOk(value),
        Err(:final failure) => onErr(failure),
      };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok(:final value) => Ok(transform(value)),
    Err(:final failure) => Err(failure),
  };
}

class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
