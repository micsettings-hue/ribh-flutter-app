// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletTransaction {

 String get id; String get walletId; TxKind get kind; int get amount; String? get refType; String? get refId; String? get signature; DateTime get createdAt;
/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionCopyWith<WalletTransaction> get copyWith => _$WalletTransactionCopyWithImpl<WalletTransaction>(this as WalletTransaction, _$identity);

  /// Serializes this WalletTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.refType, refType) || other.refType == refType)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,walletId,kind,amount,refType,refId,signature,createdAt);

@override
String toString() {
  return 'WalletTransaction(id: $id, walletId: $walletId, kind: $kind, amount: $amount, refType: $refType, refId: $refId, signature: $signature, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WalletTransactionCopyWith<$Res>  {
  factory $WalletTransactionCopyWith(WalletTransaction value, $Res Function(WalletTransaction) _then) = _$WalletTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String walletId, TxKind kind, int amount, String? refType, String? refId, String? signature, DateTime createdAt
});




}
/// @nodoc
class _$WalletTransactionCopyWithImpl<$Res>
    implements $WalletTransactionCopyWith<$Res> {
  _$WalletTransactionCopyWithImpl(this._self, this._then);

  final WalletTransaction _self;
  final $Res Function(WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? walletId = null,Object? kind = null,Object? amount = null,Object? refType = freezed,Object? refId = freezed,Object? signature = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TxKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,refType: freezed == refType ? _self.refType : refType // ignore: cast_nullable_to_non_nullable
as String?,refId: freezed == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String?,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletTransaction].
extension WalletTransactionPatterns on WalletTransaction {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTransaction value)  $default,){
final _that = this;
switch (_that) {
case _WalletTransaction():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String walletId,  TxKind kind,  int amount,  String? refType,  String? refId,  String? signature,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that.id,_that.walletId,_that.kind,_that.amount,_that.refType,_that.refId,_that.signature,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String walletId,  TxKind kind,  int amount,  String? refType,  String? refId,  String? signature,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WalletTransaction():
return $default(_that.id,_that.walletId,_that.kind,_that.amount,_that.refType,_that.refId,_that.signature,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String walletId,  TxKind kind,  int amount,  String? refType,  String? refId,  String? signature,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that.id,_that.walletId,_that.kind,_that.amount,_that.refType,_that.refId,_that.signature,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletTransaction extends WalletTransaction {
  const _WalletTransaction({required this.id, required this.walletId, required this.kind, required this.amount, this.refType, this.refId, this.signature, required this.createdAt}): super._();
  factory _WalletTransaction.fromJson(Map<String, dynamic> json) => _$WalletTransactionFromJson(json);

@override final  String id;
@override final  String walletId;
@override final  TxKind kind;
@override final  int amount;
@override final  String? refType;
@override final  String? refId;
@override final  String? signature;
@override final  DateTime createdAt;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionCopyWith<_WalletTransaction> get copyWith => __$WalletTransactionCopyWithImpl<_WalletTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.refType, refType) || other.refType == refType)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,walletId,kind,amount,refType,refId,signature,createdAt);

@override
String toString() {
  return 'WalletTransaction(id: $id, walletId: $walletId, kind: $kind, amount: $amount, refType: $refType, refId: $refId, signature: $signature, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionCopyWith<$Res> implements $WalletTransactionCopyWith<$Res> {
  factory _$WalletTransactionCopyWith(_WalletTransaction value, $Res Function(_WalletTransaction) _then) = __$WalletTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String walletId, TxKind kind, int amount, String? refType, String? refId, String? signature, DateTime createdAt
});




}
/// @nodoc
class __$WalletTransactionCopyWithImpl<$Res>
    implements _$WalletTransactionCopyWith<$Res> {
  __$WalletTransactionCopyWithImpl(this._self, this._then);

  final _WalletTransaction _self;
  final $Res Function(_WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? walletId = null,Object? kind = null,Object? amount = null,Object? refType = freezed,Object? refId = freezed,Object? signature = freezed,Object? createdAt = null,}) {
  return _then(_WalletTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TxKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,refType: freezed == refType ? _self.refType : refType // ignore: cast_nullable_to_non_nullable
as String?,refId: freezed == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String?,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
