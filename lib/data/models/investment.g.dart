// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Investment _$InvestmentFromJson(Map<String, dynamic> json) => _Investment(
  id: json['id'] as String,
  profileId: json['profile_id'] as String,
  campaignId: json['campaign_id'] as String,
  amount: (json['amount'] as num).toInt(),
  riskAck1: json['risk_ack_1'] as bool,
  riskAck2: json['risk_ack_2'] as bool,
  source: json['source'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$InvestmentToJson(_Investment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'campaign_id': instance.campaignId,
      'amount': instance.amount,
      'risk_ack_1': instance.riskAck1,
      'risk_ack_2': instance.riskAck2,
      'source': instance.source,
      'created_at': instance.createdAt.toIso8601String(),
    };
