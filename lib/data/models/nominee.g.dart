// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nominee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Nominee _$NomineeFromJson(Map<String, dynamic> json) => _Nominee(
  id: json['id'] as String,
  profileId: json['profile_id'] as String,
  name: json['name'] as String,
  relation: json['relation'] as String,
  nidHash: json['nid_hash'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$NomineeToJson(_Nominee instance) => <String, dynamic>{
  'id': instance.id,
  'profile_id': instance.profileId,
  'name': instance.name,
  'relation': instance.relation,
  'nid_hash': instance.nidHash,
  'created_at': instance.createdAt.toIso8601String(),
};
