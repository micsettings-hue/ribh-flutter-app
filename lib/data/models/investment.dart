import 'package:freezed_annotation/freezed_annotation.dart';

part 'investment.freezed.dart';
part 'investment.g.dart';

@freezed
abstract class Investment with _$Investment {
  const factory Investment({
    required String id,
    required String profileId,
    required String campaignId,
    required int amount,
    // Snake-casing would give risk_ack1; the column is risk_ack_1.
    @JsonKey(name: 'risk_ack_1') required bool riskAck1,
    @JsonKey(name: 'risk_ack_2') required bool riskAck2,
    required String source,
    required DateTime createdAt,
  }) = _Investment;

  factory Investment.fromJson(Map<String, dynamic> json) =>
      _$InvestmentFromJson(json);
}
