// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Referral _$ReferralFromJson(Map<String, dynamic> json) => _Referral(
  id: json['id'] as String,
  referrerId: json['referrer_id'] as String,
  inviteeId: json['invitee_id'] as String,
  status: $enumDecode(_$ReferralStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ReferralToJson(_Referral instance) => <String, dynamic>{
  'id': instance.id,
  'referrer_id': instance.referrerId,
  'invitee_id': instance.inviteeId,
  'status': _$ReferralStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$ReferralStatusEnumMap = {
  ReferralStatus.joined: 'joined',
  ReferralStatus.verified: 'verified',
};
