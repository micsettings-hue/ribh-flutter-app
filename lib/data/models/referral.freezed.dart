// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Referral {

 String get id; String get referrerId; String get inviteeId; ReferralStatus get status; DateTime get createdAt;
/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferralCopyWith<Referral> get copyWith => _$ReferralCopyWithImpl<Referral>(this as Referral, _$identity);

  /// Serializes this Referral to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Referral&&(identical(other.id, id) || other.id == id)&&(identical(other.referrerId, referrerId) || other.referrerId == referrerId)&&(identical(other.inviteeId, inviteeId) || other.inviteeId == inviteeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referrerId,inviteeId,status,createdAt);

@override
String toString() {
  return 'Referral(id: $id, referrerId: $referrerId, inviteeId: $inviteeId, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ReferralCopyWith<$Res>  {
  factory $ReferralCopyWith(Referral value, $Res Function(Referral) _then) = _$ReferralCopyWithImpl;
@useResult
$Res call({
 String id, String referrerId, String inviteeId, ReferralStatus status, DateTime createdAt
});




}
/// @nodoc
class _$ReferralCopyWithImpl<$Res>
    implements $ReferralCopyWith<$Res> {
  _$ReferralCopyWithImpl(this._self, this._then);

  final Referral _self;
  final $Res Function(Referral) _then;

/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referrerId = null,Object? inviteeId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referrerId: null == referrerId ? _self.referrerId : referrerId // ignore: cast_nullable_to_non_nullable
as String,inviteeId: null == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReferralStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Referral].
extension ReferralPatterns on Referral {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Referral value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Referral() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Referral value)  $default,){
final _that = this;
switch (_that) {
case _Referral():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Referral value)?  $default,){
final _that = this;
switch (_that) {
case _Referral() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referrerId,  String inviteeId,  ReferralStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Referral() when $default != null:
return $default(_that.id,_that.referrerId,_that.inviteeId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referrerId,  String inviteeId,  ReferralStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Referral():
return $default(_that.id,_that.referrerId,_that.inviteeId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referrerId,  String inviteeId,  ReferralStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Referral() when $default != null:
return $default(_that.id,_that.referrerId,_that.inviteeId,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Referral implements Referral {
  const _Referral({required this.id, required this.referrerId, required this.inviteeId, required this.status, required this.createdAt});
  factory _Referral.fromJson(Map<String, dynamic> json) => _$ReferralFromJson(json);

@override final  String id;
@override final  String referrerId;
@override final  String inviteeId;
@override final  ReferralStatus status;
@override final  DateTime createdAt;

/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferralCopyWith<_Referral> get copyWith => __$ReferralCopyWithImpl<_Referral>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferralToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Referral&&(identical(other.id, id) || other.id == id)&&(identical(other.referrerId, referrerId) || other.referrerId == referrerId)&&(identical(other.inviteeId, inviteeId) || other.inviteeId == inviteeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referrerId,inviteeId,status,createdAt);

@override
String toString() {
  return 'Referral(id: $id, referrerId: $referrerId, inviteeId: $inviteeId, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReferralCopyWith<$Res> implements $ReferralCopyWith<$Res> {
  factory _$ReferralCopyWith(_Referral value, $Res Function(_Referral) _then) = __$ReferralCopyWithImpl;
@override @useResult
$Res call({
 String id, String referrerId, String inviteeId, ReferralStatus status, DateTime createdAt
});




}
/// @nodoc
class __$ReferralCopyWithImpl<$Res>
    implements _$ReferralCopyWith<$Res> {
  __$ReferralCopyWithImpl(this._self, this._then);

  final _Referral _self;
  final $Res Function(_Referral) _then;

/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referrerId = null,Object? inviteeId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_Referral(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referrerId: null == referrerId ? _self.referrerId : referrerId // ignore: cast_nullable_to_non_nullable
as String,inviteeId: null == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReferralStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
