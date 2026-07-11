// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_invest_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AutoInvestRule _$AutoInvestRuleFromJson(Map<String, dynamic> json) =>
    _AutoInvestRule(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      strategy: json['strategy'] as String,
      budget: (json['budget'] as num).toInt(),
      active: json['active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AutoInvestRuleToJson(_AutoInvestRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'strategy': instance.strategy,
      'budget': instance.budget,
      'active': instance.active,
      'created_at': instance.createdAt.toIso8601String(),
    };
