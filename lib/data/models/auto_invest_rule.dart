import 'package:freezed_annotation/freezed_annotation.dart';

part 'auto_invest_rule.freezed.dart';
part 'auto_invest_rule.g.dart';

@freezed
abstract class AutoInvestRule with _$AutoInvestRule {
  const factory AutoInvestRule({
    required String id,
    required String profileId,
    required String strategy,
    required int budget,
    required bool active,
    required DateTime createdAt,
  }) = _AutoInvestRule;

  factory AutoInvestRule.fromJson(Map<String, dynamic> json) =>
      _$AutoInvestRuleFromJson(json);
}
