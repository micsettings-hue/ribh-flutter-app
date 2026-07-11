// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Campaign _$CampaignFromJson(Map<String, dynamic> json) => _Campaign(
  id: json['id'] as String,
  businessId: json['business_id'] as String?,
  contract: json['contract'] as String,
  sector: json['sector'] as String,
  pool: (json['pool'] as num).toInt(),
  raised: (json['raised'] as num).toInt(),
  profitPerLac: (json['profit_per_lac'] as num).toInt(),
  share: (json['share'] as num).toDouble(),
  tenure: (json['tenure'] as num).toInt(),
  risk: json['risk'] as String,
  status: $enumDecode(_$CampaignStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CampaignToJson(_Campaign instance) => <String, dynamic>{
  'id': instance.id,
  'business_id': instance.businessId,
  'contract': instance.contract,
  'sector': instance.sector,
  'pool': instance.pool,
  'raised': instance.raised,
  'profit_per_lac': instance.profitPerLac,
  'share': instance.share,
  'tenure': instance.tenure,
  'risk': instance.risk,
  'status': _$CampaignStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$CampaignStatusEnumMap = {
  CampaignStatus.open: 'open',
  CampaignStatus.running: 'running',
  CampaignStatus.matured: 'matured',
  CampaignStatus.inRecovery: 'in_recovery',
};
