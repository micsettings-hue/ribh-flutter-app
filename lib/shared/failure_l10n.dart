import '../app/l10n/app_localizations.dart';
import '../core/failures/failure.dart';

/// One place that turns a typed [Failure] into user-facing copy.
String failureText(AppLocalizations l10n, Failure failure) => switch (failure) {
  NotConfiguredFailure() => l10n.errorNotConfigured,
  NetworkFailure() => l10n.errorNetwork,
  AuthFailure() => l10n.errorAuth,
  NotVerifiedFailure() => l10n.errorNotVerified,
  GatewayNotConnectedFailure() => l10n.errorGatewayNotConnected,
  InsufficientFundsFailure() => l10n.errorInsufficientFunds,
  ValidationFailure(:final message) => l10n.errorUnknown(message),
  UnknownFailure(:final message) => l10n.errorUnknown(message),
};
