/// Typed failures. Repositories never throw across their boundary; they
/// return `Result<T>` carrying one of these.
sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'network_unavailable']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'not_authenticated']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class InsufficientFundsFailure extends Failure {
  const InsufficientFundsFailure([super.message = 'insufficient_funds']);
}

class NotVerifiedFailure extends Failure {
  const NotVerifiedFailure([super.message = 'not_verified']);
}

/// Supabase credentials were not provided at build time. Surfaced as a real
/// error state; never faked as success.
class NotConfiguredFailure extends Failure {
  const NotConfiguredFailure([super.message = 'backend_not_configured']);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
