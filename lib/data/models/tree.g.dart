// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tree _$TreeFromJson(Map<String, dynamic> json) => _Tree(
  id: json['id'] as String,
  profileId: json['profile_id'] as String,
  source: $enumDecode(_$TreeSourceEnumMap, json['source']),
  drive: json['drive'] as String?,
  district: json['district'] as String?,
  plantedAt: json['planted_at'] == null
      ? null
      : DateTime.parse(json['planted_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TreeToJson(_Tree instance) => <String, dynamic>{
  'id': instance.id,
  'profile_id': instance.profileId,
  'source': _$TreeSourceEnumMap[instance.source]!,
  'drive': instance.drive,
  'district': instance.district,
  'planted_at': instance.plantedAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
};

const _$TreeSourceEnumMap = {
  TreeSource.referral: 'referral',
  TreeSource.sadaqah: 'sadaqah',
};
