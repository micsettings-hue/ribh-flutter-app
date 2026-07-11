import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'wallet_transaction.freezed.dart';
part 'wallet_transaction.g.dart';

/// One append-only ledger row. Amounts are positive integers in poisha; the
/// sign comes from [TxKind] via [TxKindSign].
@freezed
abstract class WalletTransaction with _$WalletTransaction {
  const WalletTransaction._();

  const factory WalletTransaction({
    required String id,
    required String walletId,
    required TxKind kind,
    required int amount,
    String? refType,
    String? refId,
    String? signature,
    required DateTime createdAt,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);

  int get signedAmount => kind.signedAmount(amount);
}

/// Client-side balance derivation over a full ledger. The server-side view
/// `wallet_balances` is authoritative; this exists for display math and is
/// unit-tested against the same row set as the SQL invariant test.
int deriveBalance(Iterable<WalletTransaction> transactions) =>
    transactions.fold(0, (sum, tx) => sum + tx.signedAmount);
