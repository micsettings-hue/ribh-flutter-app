import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'referral.freezed.dart';
part 'referral.g.dart';

/// Referral record. Rewards are trees only, never cash or fee credit, and
/// points accrue on sign-up and verification only.
@freezed
abstract class Referral with _$Referral {
  const factory Referral({
    required String id,
    required String referrerId,
    required String inviteeId,
    required ReferralStatus status,
    required DateTime createdAt,
  }) = _Referral;

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);
}
