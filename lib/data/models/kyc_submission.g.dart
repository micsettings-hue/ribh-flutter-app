// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KycSubmission _$KycSubmissionFromJson(Map<String, dynamic> json) =>
    _KycSubmission(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      nidHash: json['nid_hash'] as String,
      sourceOfFunds: $enumDecode(_$KycSourceEnumMap, json['source_of_funds']),
      selfieCaptured: json['selfie_captured'] as bool,
      status: $enumDecode(_$KycStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$KycSubmissionToJson(_KycSubmission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'nid_hash': instance.nidHash,
      'source_of_funds': _$KycSourceEnumMap[instance.sourceOfFunds]!,
      'selfie_captured': instance.selfieCaptured,
      'status': _$KycStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$KycSourceEnumMap = {
  KycSource.salary: 'salary',
  KycSource.businessIncome: 'business_income',
  KycSource.savings: 'savings',
  KycSource.remittance: 'remittance',
};

const _$KycStatusEnumMap = {
  KycStatus.pending: 'pending',
  KycStatus.approved: 'approved',
  KycStatus.rejected: 'rejected',
};
