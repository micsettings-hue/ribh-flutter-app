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

/// No live payment checkout exists for the chosen method (no merchant
/// credentials yet). The request stays honestly pending; nothing is charged.
class GatewayNotConnectedFailure extends Failure {
  const GatewayNotConnectedFailure([super.message = 'gateway_not_connected']);
}

/// A live external data source (for example the metals price feed behind
/// the Nisab threshold) is not connected in this build. The dependent figure
/// is shown as unavailable, never invented.
class DataSourceUnavailableFailure extends Failure {
  const DataSourceUnavailableFailure([
    super.message = 'data_source_unavailable',
  ]);
}

/// Device location is off or permission was refused. Location-derived
/// figures (prayer times, qibla) are shown as unavailable, never estimated.
class LocationUnavailableFailure extends Failure {
  const LocationUnavailableFailure([super.message = 'location_unavailable']);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
