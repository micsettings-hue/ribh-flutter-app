import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'welfare_contribution.freezed.dart';
part 'welfare_contribution.g.dart';

@freezed
abstract class WelfareContribution with _$WelfareContribution {
  const factory WelfareContribution({
    required String id,
    required String profileId,
    required String projectId,
    required WelfareKind kind,
    required int amount,
    required DateTime createdAt,
  }) = _WelfareContribution;

  factory WelfareContribution.fromJson(Map<String, dynamic> json) =>
      _$WelfareContributionFromJson(json);
}
