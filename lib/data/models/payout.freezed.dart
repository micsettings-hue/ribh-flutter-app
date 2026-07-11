// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payout {

 String get id; String get profileId; String get distributionId; PayoutRoute get route; DateTime get createdAt;
/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutCopyWith<Payout> get copyWith => _$PayoutCopyWithImpl<Payout>(this as Payout, _$identity);

  /// Serializes this Payout to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payout&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.distributionId, distributionId) || other.distributionId == distributionId)&&(identical(other.route, route) || other.route == route)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,distributionId,route,createdAt);

@override
String toString() {
  return 'Payout(id: $id, profileId: $profileId, distributionId: $distributionId, route: $route, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PayoutCopyWith<$Res>  {
  factory $PayoutCopyWith(Payout value, $Res Function(Payout) _then) = _$PayoutCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String distributionId, PayoutRoute route, DateTime createdAt
});




}
/// @nodoc
class _$PayoutCopyWithImpl<$Res>
    implements $PayoutCopyWith<$Res> {
  _$PayoutCopyWithImpl(this._self, this._then);

  final Payout _self;
  final $Res Function(Payout) _then;

/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? distributionId = null,Object? route = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,distributionId: null == distributionId ? _self.distributionId : distributionId // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PayoutRoute,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Payout].
extension PayoutPatterns on Payout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payout value)  $default,){
final _that = this;
switch (_that) {
case _Payout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payout value)?  $default,){
final _that = this;
switch (_that) {
case _Payout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String distributionId,  PayoutRoute route,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payout() when $default != null:
return $default(_that.id,_that.profileId,_that.distributionId,_that.route,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String distributionId,  PayoutRoute route,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Payout():
return $default(_that.id,_that.profileId,_that.distributionId,_that.route,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String distributionId,  PayoutRoute route,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Payout() when $default != null:
return $default(_that.id,_that.profileId,_that.distributionId,_that.route,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payout implements Payout {
  const _Payout({required this.id, required this.profileId, required this.distributionId, required this.route, required this.createdAt});
  factory _Payout.fromJson(Map<String, dynamic> json) => _$PayoutFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String distributionId;
@override final  PayoutRoute route;
@override final  DateTime createdAt;

/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutCopyWith<_Payout> get copyWith => __$PayoutCopyWithImpl<_Payout>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayoutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payout&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.distributionId, distributionId) || other.distributionId == distributionId)&&(identical(other.route, route) || other.route == route)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,distributionId,route,createdAt);

@override
String toString() {
  return 'Payout(id: $id, profileId: $profileId, distributionId: $distributionId, route: $route, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PayoutCopyWith<$Res> implements $PayoutCopyWith<$Res> {
  factory _$PayoutCopyWith(_Payout value, $Res Function(_Payout) _then) = __$PayoutCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String distributionId, PayoutRoute route, DateTime createdAt
});




}
/// @nodoc
class __$PayoutCopyWithImpl<$Res>
    implements _$PayoutCopyWith<$Res> {
  __$PayoutCopyWithImpl(this._self, this._then);

  final _Payout _self;
  final $Res Function(_Payout) _then;

/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? distributionId = null,Object? route = null,Object? createdAt = null,}) {
  return _then(_Payout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,distributionId: null == distributionId ? _self.distributionId : distributionId // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PayoutRoute,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
