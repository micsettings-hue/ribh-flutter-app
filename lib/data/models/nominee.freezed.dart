// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nominee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Nominee {

 String get id; String get profileId; String get name; String get relation; String? get nidHash; DateTime get createdAt;
/// Create a copy of Nominee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NomineeCopyWith<Nominee> get copyWith => _$NomineeCopyWithImpl<Nominee>(this as Nominee, _$identity);

  /// Serializes this Nominee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Nominee&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.name, name) || other.name == name)&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.nidHash, nidHash) || other.nidHash == nidHash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,name,relation,nidHash,createdAt);

@override
String toString() {
  return 'Nominee(id: $id, profileId: $profileId, name: $name, relation: $relation, nidHash: $nidHash, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NomineeCopyWith<$Res>  {
  factory $NomineeCopyWith(Nominee value, $Res Function(Nominee) _then) = _$NomineeCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String name, String relation, String? nidHash, DateTime createdAt
});




}
/// @nodoc
class _$NomineeCopyWithImpl<$Res>
    implements $NomineeCopyWith<$Res> {
  _$NomineeCopyWithImpl(this._self, this._then);

  final Nominee _self;
  final $Res Function(Nominee) _then;

/// Create a copy of Nominee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? name = null,Object? relation = null,Object? nidHash = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String,nidHash: freezed == nidHash ? _self.nidHash : nidHash // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Nominee].
extension NomineePatterns on Nominee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Nominee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Nominee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Nominee value)  $default,){
final _that = this;
switch (_that) {
case _Nominee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Nominee value)?  $default,){
final _that = this;
switch (_that) {
case _Nominee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String name,  String relation,  String? nidHash,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Nominee() when $default != null:
return $default(_that.id,_that.profileId,_that.name,_that.relation,_that.nidHash,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String name,  String relation,  String? nidHash,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Nominee():
return $default(_that.id,_that.profileId,_that.name,_that.relation,_that.nidHash,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String name,  String relation,  String? nidHash,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Nominee() when $default != null:
return $default(_that.id,_that.profileId,_that.name,_that.relation,_that.nidHash,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Nominee implements Nominee {
  const _Nominee({required this.id, required this.profileId, required this.name, required this.relation, this.nidHash, required this.createdAt});
  factory _Nominee.fromJson(Map<String, dynamic> json) => _$NomineeFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String name;
@override final  String relation;
@override final  String? nidHash;
@override final  DateTime createdAt;

/// Create a copy of Nominee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NomineeCopyWith<_Nominee> get copyWith => __$NomineeCopyWithImpl<_Nominee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NomineeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Nominee&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.name, name) || other.name == name)&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.nidHash, nidHash) || other.nidHash == nidHash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,name,relation,nidHash,createdAt);

@override
String toString() {
  return 'Nominee(id: $id, profileId: $profileId, name: $name, relation: $relation, nidHash: $nidHash, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NomineeCopyWith<$Res> implements $NomineeCopyWith<$Res> {
  factory _$NomineeCopyWith(_Nominee value, $Res Function(_Nominee) _then) = __$NomineeCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String name, String relation, String? nidHash, DateTime createdAt
});




}
/// @nodoc
class __$NomineeCopyWithImpl<$Res>
    implements _$NomineeCopyWith<$Res> {
  __$NomineeCopyWithImpl(this._self, this._then);

  final _Nominee _self;
  final $Res Function(_Nominee) _then;

/// Create a copy of Nominee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? name = null,Object? relation = null,Object? nidHash = freezed,Object? createdAt = null,}) {
  return _then(_Nominee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String,nidHash: freezed == nidHash ? _self.nidHash : nidHash // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
