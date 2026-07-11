import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../models/models.dart';

/// A live checkout handed to the UI: the tokenized merchant checkout URL to
/// open in a secure in-app WebView.
class CheckoutSession {
  const CheckoutSession({required this.requestId, required this.url});

  final String requestId;
  final Uri url;
}

/// Abstraction over the payment rails. Neither bKash nor Nagad offers an
/// official Flutter SDK; real implementations wrap their published merchant
/// REST APIs (tokenized checkout) with credentials injected from Supabase
/// secrets, never committed. Bank transfer is manual reference plus
/// back-office reconciliation and never has a checkout.
abstract class PaymentGateway {
  /// Whether a live checkout exists for [method] in this build.
  bool isCheckoutAvailable(PaymentMethod method);

  /// Starts checkout for an already-recorded pending deposit request.
  /// The ledger is only ever credited server-side after the merchant
  /// confirms payment; a completed WebView flow alone credits nothing.
  Future<Result<CheckoutSession>> startCheckout(MoneyRequest request);
}

/// The honest v1 gateway. No merchant credentials exist yet, so no checkout
/// starts and nothing pretends to succeed: requests stay pending until
/// back-office reconciliation confirms them via decide_money_request.
class UnconnectedPaymentGateway implements PaymentGateway {
  const UnconnectedPaymentGateway();

  @override
  bool isCheckoutAvailable(PaymentMethod method) => false;

  @override
  Future<Result<CheckoutSession>> startCheckout(MoneyRequest request) async =>
      const Err(GatewayNotConnectedFailure());
}

final paymentGatewayProvider = Provider<PaymentGateway>(
  (ref) => const UnconnectedPaymentGateway(),
);
