// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoneyRequest _$MoneyRequestFromJson(Map<String, dynamic> json) =>
    _MoneyRequest(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      kind: $enumDecode(_$MoneyRequestKindEnumMap, json['kind']),
      method: $enumDecode(_$PaymentMethodEnumMap, json['method']),
      amount: (json['amount'] as num).toInt(),
      reference: json['reference'] as String?,
      status: $enumDecode(_$MoneyRequestStatusEnumMap, json['status']),
      txId: json['tx_id'] as String?,
      decidedAt: json['decided_at'] == null
          ? null
          : DateTime.parse(json['decided_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MoneyRequestToJson(_MoneyRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'kind': _$MoneyRequestKindEnumMap[instance.kind]!,
      'method': _$PaymentMethodEnumMap[instance.method]!,
      'amount': instance.amount,
      'reference': instance.reference,
      'status': _$MoneyRequestStatusEnumMap[instance.status]!,
      'tx_id': instance.txId,
      'decided_at': instance.decidedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$MoneyRequestKindEnumMap = {
  MoneyRequestKind.deposit: 'deposit',
  MoneyRequestKind.withdrawal: 'withdrawal',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.bkash: 'bkash',
  PaymentMethod.nagad: 'nagad',
  PaymentMethod.bank: 'bank',
};

const _$MoneyRequestStatusEnumMap = {
  MoneyRequestStatus.pending: 'pending',
  MoneyRequestStatus.confirmed: 'confirmed',
  MoneyRequestStatus.rejected: 'rejected',
  MoneyRequestStatus.cancelled: 'cancelled',
};
