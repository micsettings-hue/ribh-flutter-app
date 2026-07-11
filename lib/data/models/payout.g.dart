// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payout _$PayoutFromJson(Map<String, dynamic> json) => _Payout(
  id: json['id'] as String,
  profileId: json['profile_id'] as String,
  distributionId: json['distribution_id'] as String,
  route: $enumDecode(_$PayoutRouteEnumMap, json['route']),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$PayoutToJson(_Payout instance) => <String, dynamic>{
  'id': instance.id,
  'profile_id': instance.profileId,
  'distribution_id': instance.distributionId,
  'route': _$PayoutRouteEnumMap[instance.route]!,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$PayoutRouteEnumMap = {
  PayoutRoute.bank: 'bank',
  PayoutRoute.reinvest: 'reinvest',
};
