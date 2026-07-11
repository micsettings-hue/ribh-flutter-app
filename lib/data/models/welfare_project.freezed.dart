// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'welfare_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WelfareProject {

 String get id; String get sector; String get title; String get district; int get target; int get raised; DateTime get createdAt;
/// Create a copy of WelfareProject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WelfareProjectCopyWith<WelfareProject> get copyWith => _$WelfareProjectCopyWithImpl<WelfareProject>(this as WelfareProject, _$identity);

  /// Serializes this WelfareProject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WelfareProject&&(identical(other.id, id) || other.id == id)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.title, title) || other.title == title)&&(identical(other.district, district) || other.district == district)&&(identical(other.target, target) || other.target == target)&&(identical(other.raised, raised) || other.raised == raised)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sector,title,district,target,raised,createdAt);

@override
String toString() {
  return 'WelfareProject(id: $id, sector: $sector, title: $title, district: $district, target: $target, raised: $raised, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WelfareProjectCopyWith<$Res>  {
  factory $WelfareProjectCopyWith(WelfareProject value, $Res Function(WelfareProject) _then) = _$WelfareProjectCopyWithImpl;
@useResult
$Res call({
 String id, String sector, String title, String district, int target, int raised, DateTime createdAt
});




}
/// @nodoc
class _$WelfareProjectCopyWithImpl<$Res>
    implements $WelfareProjectCopyWith<$Res> {
  _$WelfareProjectCopyWithImpl(this._self, this._then);

  final WelfareProject _self;
  final $Res Function(WelfareProject) _then;

/// Create a copy of WelfareProject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sector = null,Object? title = null,Object? district = null,Object? target = null,Object? raised = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,raised: null == raised ? _self.raised : raised // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WelfareProject].
extension WelfareProjectPatterns on WelfareProject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WelfareProject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WelfareProject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WelfareProject value)  $default,){
final _that = this;
switch (_that) {
case _WelfareProject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WelfareProject value)?  $default,){
final _that = this;
switch (_that) {
case _WelfareProject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sector,  String title,  String district,  int target,  int raised,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WelfareProject() when $default != null:
return $default(_that.id,_that.sector,_that.title,_that.district,_that.target,_that.raised,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sector,  String title,  String district,  int target,  int raised,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WelfareProject():
return $default(_that.id,_that.sector,_that.title,_that.district,_that.target,_that.raised,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sector,  String title,  String district,  int target,  int raised,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WelfareProject() when $default != null:
return $default(_that.id,_that.sector,_that.title,_that.district,_that.target,_that.raised,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WelfareProject extends WelfareProject {
  const _WelfareProject({required this.id, required this.sector, required this.title, required this.district, required this.target, required this.raised, required this.createdAt}): super._();
  factory _WelfareProject.fromJson(Map<String, dynamic> json) => _$WelfareProjectFromJson(json);

@override final  String id;
@override final  String sector;
@override final  String title;
@override final  String district;
@override final  int target;
@override final  int raised;
@override final  DateTime createdAt;

/// Create a copy of WelfareProject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WelfareProjectCopyWith<_WelfareProject> get copyWith => __$WelfareProjectCopyWithImpl<_WelfareProject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WelfareProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WelfareProject&&(identical(other.id, id) || other.id == id)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.title, title) || other.title == title)&&(identical(other.district, district) || other.district == district)&&(identical(other.target, target) || other.target == target)&&(identical(other.raised, raised) || other.raised == raised)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sector,title,district,target,raised,createdAt);

@override
String toString() {
  return 'WelfareProject(id: $id, sector: $sector, title: $title, district: $district, target: $target, raised: $raised, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WelfareProjectCopyWith<$Res> implements $WelfareProjectCopyWith<$Res> {
  factory _$WelfareProjectCopyWith(_WelfareProject value, $Res Function(_WelfareProject) _then) = __$WelfareProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String sector, String title, String district, int target, int raised, DateTime createdAt
});




}
/// @nodoc
class __$WelfareProjectCopyWithImpl<$Res>
    implements _$WelfareProjectCopyWith<$Res> {
  __$WelfareProjectCopyWithImpl(this._self, this._then);

  final _WelfareProject _self;
  final $Res Function(_WelfareProject) _then;

/// Create a copy of WelfareProject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sector = null,Object? title = null,Object? district = null,Object? target = null,Object? raised = null,Object? createdAt = null,}) {
  return _then(_WelfareProject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,raised: null == raised ? _self.raised : raised // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
