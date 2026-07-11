// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'money_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoneyRequest {

 String get id; String get profileId; MoneyRequestKind get kind; PaymentMethod get method; int get amount; String? get reference; MoneyRequestStatus get status; String? get txId; DateTime? get decidedAt; DateTime get createdAt;
/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoneyRequestCopyWith<MoneyRequest> get copyWith => _$MoneyRequestCopyWithImpl<MoneyRequest>(this as MoneyRequest, _$identity);

  /// Serializes this MoneyRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoneyRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.method, method) || other.method == method)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,kind,method,amount,reference,status,txId,decidedAt,createdAt);

@override
String toString() {
  return 'MoneyRequest(id: $id, profileId: $profileId, kind: $kind, method: $method, amount: $amount, reference: $reference, status: $status, txId: $txId, decidedAt: $decidedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MoneyRequestCopyWith<$Res>  {
  factory $MoneyRequestCopyWith(MoneyRequest value, $Res Function(MoneyRequest) _then) = _$MoneyRequestCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, MoneyRequestKind kind, PaymentMethod method, int amount, String? reference, MoneyRequestStatus status, String? txId, DateTime? decidedAt, DateTime createdAt
});




}
/// @nodoc
class _$MoneyRequestCopyWithImpl<$Res>
    implements $MoneyRequestCopyWith<$Res> {
  _$MoneyRequestCopyWithImpl(this._self, this._then);

  final MoneyRequest _self;
  final $Res Function(MoneyRequest) _then;

/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? kind = null,Object? method = null,Object? amount = null,Object? reference = freezed,Object? status = null,Object? txId = freezed,Object? decidedAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MoneyRequestKind,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MoneyRequestStatus,txId: freezed == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String?,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MoneyRequest].
extension MoneyRequestPatterns on MoneyRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoneyRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoneyRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoneyRequest value)  $default,){
final _that = this;
switch (_that) {
case _MoneyRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoneyRequest value)?  $default,){
final _that = this;
switch (_that) {
case _MoneyRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  MoneyRequestKind kind,  PaymentMethod method,  int amount,  String? reference,  MoneyRequestStatus status,  String? txId,  DateTime? decidedAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoneyRequest() when $default != null:
return $default(_that.id,_that.profileId,_that.kind,_that.method,_that.amount,_that.reference,_that.status,_that.txId,_that.decidedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  MoneyRequestKind kind,  PaymentMethod method,  int amount,  String? reference,  MoneyRequestStatus status,  String? txId,  DateTime? decidedAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MoneyRequest():
return $default(_that.id,_that.profileId,_that.kind,_that.method,_that.amount,_that.reference,_that.status,_that.txId,_that.decidedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  MoneyRequestKind kind,  PaymentMethod method,  int amount,  String? reference,  MoneyRequestStatus status,  String? txId,  DateTime? decidedAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MoneyRequest() when $default != null:
return $default(_that.id,_that.profileId,_that.kind,_that.method,_that.amount,_that.reference,_that.status,_that.txId,_that.decidedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MoneyRequest implements MoneyRequest {
  const _MoneyRequest({required this.id, required this.profileId, required this.kind, required this.method, required this.amount, this.reference, required this.status, this.txId, this.decidedAt, required this.createdAt});
  factory _MoneyRequest.fromJson(Map<String, dynamic> json) => _$MoneyRequestFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  MoneyRequestKind kind;
@override final  PaymentMethod method;
@override final  int amount;
@override final  String? reference;
@override final  MoneyRequestStatus status;
@override final  String? txId;
@override final  DateTime? decidedAt;
@override final  DateTime createdAt;

/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoneyRequestCopyWith<_MoneyRequest> get copyWith => __$MoneyRequestCopyWithImpl<_MoneyRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoneyRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoneyRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.method, method) || other.method == method)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.status, status) || other.status == status)&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,kind,method,amount,reference,status,txId,decidedAt,createdAt);

@override
String toString() {
  return 'MoneyRequest(id: $id, profileId: $profileId, kind: $kind, method: $method, amount: $amount, reference: $reference, status: $status, txId: $txId, decidedAt: $decidedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MoneyRequestCopyWith<$Res> implements $MoneyRequestCopyWith<$Res> {
  factory _$MoneyRequestCopyWith(_MoneyRequest value, $Res Function(_MoneyRequest) _then) = __$MoneyRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, MoneyRequestKind kind, PaymentMethod method, int amount, String? reference, MoneyRequestStatus status, String? txId, DateTime? decidedAt, DateTime createdAt
});




}
/// @nodoc
class __$MoneyRequestCopyWithImpl<$Res>
    implements _$MoneyRequestCopyWith<$Res> {
  __$MoneyRequestCopyWithImpl(this._self, this._then);

  final _MoneyRequest _self;
  final $Res Function(_MoneyRequest) _then;

/// Create a copy of MoneyRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? kind = null,Object? method = null,Object? amount = null,Object? reference = freezed,Object? status = null,Object? txId = freezed,Object? decidedAt = freezed,Object? createdAt = null,}) {
  return _then(_MoneyRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MoneyRequestKind,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MoneyRequestStatus,txId: freezed == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String?,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
