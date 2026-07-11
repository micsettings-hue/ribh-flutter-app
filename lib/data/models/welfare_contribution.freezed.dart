// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'welfare_contribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WelfareContribution {

 String get id; String get profileId; String get projectId; WelfareKind get kind; int get amount; DateTime get createdAt;
/// Create a copy of WelfareContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WelfareContributionCopyWith<WelfareContribution> get copyWith => _$WelfareContributionCopyWithImpl<WelfareContribution>(this as WelfareContribution, _$identity);

  /// Serializes this WelfareContribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WelfareContribution&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,projectId,kind,amount,createdAt);

@override
String toString() {
  return 'WelfareContribution(id: $id, profileId: $profileId, projectId: $projectId, kind: $kind, amount: $amount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WelfareContributionCopyWith<$Res>  {
  factory $WelfareContributionCopyWith(WelfareContribution value, $Res Function(WelfareContribution) _then) = _$WelfareContributionCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String projectId, WelfareKind kind, int amount, DateTime createdAt
});




}
/// @nodoc
class _$WelfareContributionCopyWithImpl<$Res>
    implements $WelfareContributionCopyWith<$Res> {
  _$WelfareContributionCopyWithImpl(this._self, this._then);

  final WelfareContribution _self;
  final $Res Function(WelfareContribution) _then;

/// Create a copy of WelfareContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? projectId = null,Object? kind = null,Object? amount = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as WelfareKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WelfareContribution].
extension WelfareContributionPatterns on WelfareContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WelfareContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WelfareContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WelfareContribution value)  $default,){
final _that = this;
switch (_that) {
case _WelfareContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WelfareContribution value)?  $default,){
final _that = this;
switch (_that) {
case _WelfareContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String projectId,  WelfareKind kind,  int amount,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WelfareContribution() when $default != null:
return $default(_that.id,_that.profileId,_that.projectId,_that.kind,_that.amount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String projectId,  WelfareKind kind,  int amount,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WelfareContribution():
return $default(_that.id,_that.profileId,_that.projectId,_that.kind,_that.amount,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String projectId,  WelfareKind kind,  int amount,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WelfareContribution() when $default != null:
return $default(_that.id,_that.profileId,_that.projectId,_that.kind,_that.amount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WelfareContribution implements WelfareContribution {
  const _WelfareContribution({required this.id, required this.profileId, required this.projectId, required this.kind, required this.amount, required this.createdAt});
  factory _WelfareContribution.fromJson(Map<String, dynamic> json) => _$WelfareContributionFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String projectId;
@override final  WelfareKind kind;
@override final  int amount;
@override final  DateTime createdAt;

/// Create a copy of WelfareContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WelfareContributionCopyWith<_WelfareContribution> get copyWith => __$WelfareContributionCopyWithImpl<_WelfareContribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WelfareContributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WelfareContribution&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,projectId,kind,amount,createdAt);

@override
String toString() {
  return 'WelfareContribution(id: $id, profileId: $profileId, projectId: $projectId, kind: $kind, amount: $amount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WelfareContributionCopyWith<$Res> implements $WelfareContributionCopyWith<$Res> {
  factory _$WelfareContributionCopyWith(_WelfareContribution value, $Res Function(_WelfareContribution) _then) = __$WelfareContributionCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String projectId, WelfareKind kind, int amount, DateTime createdAt
});




}
/// @nodoc
class __$WelfareContributionCopyWithImpl<$Res>
    implements _$WelfareContributionCopyWith<$Res> {
  __$WelfareContributionCopyWithImpl(this._self, this._then);

  final _WelfareContribution _self;
  final $Res Function(_WelfareContribution) _then;

/// Create a copy of WelfareContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? projectId = null,Object? kind = null,Object? amount = null,Object? createdAt = null,}) {
  return _then(_WelfareContribution(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as WelfareKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
