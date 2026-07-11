// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welfare_contribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WelfareContribution _$WelfareContributionFromJson(Map<String, dynamic> json) =>
    _WelfareContribution(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      projectId: json['project_id'] as String,
      kind: $enumDecode(_$WelfareKindEnumMap, json['kind']),
      amount: (json['amount'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$WelfareContributionToJson(
  _WelfareContribution instance,
) => <String, dynamic>{
  'id': instance.id,
  'profile_id': instance.profileId,
  'project_id': instance.projectId,
  'kind': _$WelfareKindEnumMap[instance.kind]!,
  'amount': instance.amount,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$WelfareKindEnumMap = {
  WelfareKind.zakat: 'zakat',
  WelfareKind.sadaqah: 'sadaqah',
};
