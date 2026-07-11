import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'money_request.freezed.dart';
part 'money_request.g.dart';

/// A deposit or withdrawal request on the money rail. Requests never touch
/// the ledger; only back-office confirmation writes the wallet_transactions
/// row and links it here via [txId]. Pending is a real, honest state.
@freezed
abstract class MoneyRequest with _$MoneyRequest {
  const factory MoneyRequest({
    required String id,
    required String profileId,
    required MoneyRequestKind kind,
    required PaymentMethod method,
    required int amount,
    String? reference,
    required MoneyRequestStatus status,
    String? txId,
    DateTime? decidedAt,
    required DateTime createdAt,
  }) = _MoneyRequest;

  factory MoneyRequest.fromJson(Map<String, dynamic> json) =>
      _$MoneyRequestFromJson(json);
}
