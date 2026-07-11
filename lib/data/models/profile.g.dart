// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  kycTier: (json['kyc_tier'] as num).toInt(),
  nidHash: json['nid_hash'] as String?,
  riskTier: json['risk_tier'] as String?,
  lang: json['lang'] as String,
  theme: json['theme'] as String,
  twofaEnabled: json['twofa_enabled'] as bool,
  nomineeId: json['nominee_id'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'role': _$UserRoleEnumMap[instance.role]!,
  'kyc_tier': instance.kycTier,
  'nid_hash': instance.nidHash,
  'risk_tier': instance.riskTier,
  'lang': instance.lang,
  'theme': instance.theme,
  'twofa_enabled': instance.twofaEnabled,
  'nominee_id': instance.nomineeId,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$UserRoleEnumMap = {
  UserRole.investor: 'investor',
  UserRole.business: 'business',
  UserRole.admin: 'admin',
};
