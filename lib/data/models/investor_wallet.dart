import 'package:freezed_annotation/freezed_annotation.dart';

part 'investor_wallet.freezed.dart';
part 'investor_wallet.g.dart';

/// The wallet row itself. It has NO balance field by design: balance is
/// always derived from the transaction ledger.
@freezed
abstract class InvestorWallet with _$InvestorWallet {
  const factory InvestorWallet({
    required String id,
    required String profileId,
    required DateTime createdAt,
  }) = _InvestorWallet;

  factory InvestorWallet.fromJson(Map<String, dynamic> json) =>
      _$InvestorWalletFromJson(json);
}
