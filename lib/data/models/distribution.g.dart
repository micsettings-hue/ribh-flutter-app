// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Distribution _$DistributionFromJson(Map<String, dynamic> json) =>
    _Distribution(
      id: json['id'] as String,
      campaignId: json['campaign_id'] as String,
      gross: (json['gross'] as num).toInt(),
      ribhFee: (json['ribh_fee'] as num).toInt(),
      investorShare: (json['investor_share'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$DistributionToJson(_Distribution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign_id': instance.campaignId,
      'gross': instance.gross,
      'ribh_fee': instance.ribhFee,
      'investor_share': instance.investorShare,
      'created_at': instance.createdAt.toIso8601String(),
    };
