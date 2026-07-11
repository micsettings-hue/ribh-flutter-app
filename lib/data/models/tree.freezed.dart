// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tree.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tree {

 String get id; String get profileId; TreeSource get source; String? get drive; String? get district; DateTime? get plantedAt; DateTime get createdAt;
/// Create a copy of Tree
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TreeCopyWith<Tree> get copyWith => _$TreeCopyWithImpl<Tree>(this as Tree, _$identity);

  /// Serializes this Tree to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tree&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.source, source) || other.source == source)&&(identical(other.drive, drive) || other.drive == drive)&&(identical(other.district, district) || other.district == district)&&(identical(other.plantedAt, plantedAt) || other.plantedAt == plantedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,source,drive,district,plantedAt,createdAt);

@override
String toString() {
  return 'Tree(id: $id, profileId: $profileId, source: $source, drive: $drive, district: $district, plantedAt: $plantedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TreeCopyWith<$Res>  {
  factory $TreeCopyWith(Tree value, $Res Function(Tree) _then) = _$TreeCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, TreeSource source, String? drive, String? district, DateTime? plantedAt, DateTime createdAt
});




}
/// @nodoc
class _$TreeCopyWithImpl<$Res>
    implements $TreeCopyWith<$Res> {
  _$TreeCopyWithImpl(this._self, this._then);

  final Tree _self;
  final $Res Function(Tree) _then;

/// Create a copy of Tree
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? source = null,Object? drive = freezed,Object? district = freezed,Object? plantedAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TreeSource,drive: freezed == drive ? _self.drive : drive // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,plantedAt: freezed == plantedAt ? _self.plantedAt : plantedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Tree].
extension TreePatterns on Tree {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tree value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tree() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tree value)  $default,){
final _that = this;
switch (_that) {
case _Tree():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tree value)?  $default,){
final _that = this;
switch (_that) {
case _Tree() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  TreeSource source,  String? drive,  String? district,  DateTime? plantedAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tree() when $default != null:
return $default(_that.id,_that.profileId,_that.source,_that.drive,_that.district,_that.plantedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  TreeSource source,  String? drive,  String? district,  DateTime? plantedAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Tree():
return $default(_that.id,_that.profileId,_that.source,_that.drive,_that.district,_that.plantedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  TreeSource source,  String? drive,  String? district,  DateTime? plantedAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Tree() when $default != null:
return $default(_that.id,_that.profileId,_that.source,_that.drive,_that.district,_that.plantedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tree implements Tree {
  const _Tree({required this.id, required this.profileId, required this.source, this.drive, this.district, this.plantedAt, required this.createdAt});
  factory _Tree.fromJson(Map<String, dynamic> json) => _$TreeFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  TreeSource source;
@override final  String? drive;
@override final  String? district;
@override final  DateTime? plantedAt;
@override final  DateTime createdAt;

/// Create a copy of Tree
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TreeCopyWith<_Tree> get copyWith => __$TreeCopyWithImpl<_Tree>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TreeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tree&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.source, source) || other.source == source)&&(identical(other.drive, drive) || other.drive == drive)&&(identical(other.district, district) || other.district == district)&&(identical(other.plantedAt, plantedAt) || other.plantedAt == plantedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,source,drive,district,plantedAt,createdAt);

@override
String toString() {
  return 'Tree(id: $id, profileId: $profileId, source: $source, drive: $drive, district: $district, plantedAt: $plantedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TreeCopyWith<$Res> implements $TreeCopyWith<$Res> {
  factory _$TreeCopyWith(_Tree value, $Res Function(_Tree) _then) = __$TreeCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, TreeSource source, String? drive, String? district, DateTime? plantedAt, DateTime createdAt
});




}
/// @nodoc
class __$TreeCopyWithImpl<$Res>
    implements _$TreeCopyWith<$Res> {
  __$TreeCopyWithImpl(this._self, this._then);

  final _Tree _self;
  final $Res Function(_Tree) _then;

/// Create a copy of Tree
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? source = null,Object? drive = freezed,Object? district = freezed,Object? plantedAt = freezed,Object? createdAt = null,}) {
  return _then(_Tree(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TreeSource,drive: freezed == drive ? _self.drive : drive // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,plantedAt: freezed == plantedAt ? _self.plantedAt : plantedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
