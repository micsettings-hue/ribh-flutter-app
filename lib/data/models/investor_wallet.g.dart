// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investor_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvestorWallet _$InvestorWalletFromJson(Map<String, dynamic> json) =>
    _InvestorWallet(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$InvestorWalletToJson(_InvestorWallet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'created_at': instance.createdAt.toIso8601String(),
    };
