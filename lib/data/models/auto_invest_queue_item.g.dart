// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_invest_queue_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AutoInvestQueueItem _$AutoInvestQueueItemFromJson(Map<String, dynamic> json) =>
    _AutoInvestQueueItem(
      id: json['id'] as String,
      ruleId: json['rule_id'] as String,
      campaignId: json['campaign_id'] as String,
      status: $enumDecode(_$QueueStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AutoInvestQueueItemToJson(
  _AutoInvestQueueItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'rule_id': instance.ruleId,
  'campaign_id': instance.campaignId,
  'status': _$QueueStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$QueueStatusEnumMap = {
  QueueStatus.pending: 'pending',
  QueueStatus.approved: 'approved',
  QueueStatus.declined: 'declined',
};
