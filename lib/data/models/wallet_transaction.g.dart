// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) =>
    _WalletTransaction(
      id: json['id'] as String,
      walletId: json['wallet_id'] as String,
      kind: $enumDecode(_$TxKindEnumMap, json['kind']),
      amount: (json['amount'] as num).toInt(),
      refType: json['ref_type'] as String?,
      refId: json['ref_id'] as String?,
      signature: json['signature'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$WalletTransactionToJson(_WalletTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wallet_id': instance.walletId,
      'kind': _$TxKindEnumMap[instance.kind]!,
      'amount': instance.amount,
      'ref_type': instance.refType,
      'ref_id': instance.refId,
      'signature': instance.signature,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$TxKindEnumMap = {
  TxKind.deposit: 'deposit',
  TxKind.investment: 'investment',
  TxKind.distribution: 'distribution',
  TxKind.payout: 'payout',
  TxKind.purification: 'purification',
  TxKind.writeDown: 'write_down',
  TxKind.recovery: 'recovery',
  TxKind.sadaqah: 'sadaqah',
  TxKind.zakat: 'zakat',
};
