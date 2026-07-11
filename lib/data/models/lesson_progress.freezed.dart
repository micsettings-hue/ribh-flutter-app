// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonProgress {

 String get id; String get profileId; String get moduleId; int get readCount; bool get completed; DateTime get createdAt;
/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonProgressCopyWith<LessonProgress> get copyWith => _$LessonProgressCopyWithImpl<LessonProgress>(this as LessonProgress, _$identity);

  /// Serializes this LessonProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonProgress&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.readCount, readCount) || other.readCount == readCount)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,moduleId,readCount,completed,createdAt);

@override
String toString() {
  return 'LessonProgress(id: $id, profileId: $profileId, moduleId: $moduleId, readCount: $readCount, completed: $completed, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LessonProgressCopyWith<$Res>  {
  factory $LessonProgressCopyWith(LessonProgress value, $Res Function(LessonProgress) _then) = _$LessonProgressCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String moduleId, int readCount, bool completed, DateTime createdAt
});




}
/// @nodoc
class _$LessonProgressCopyWithImpl<$Res>
    implements $LessonProgressCopyWith<$Res> {
  _$LessonProgressCopyWithImpl(this._self, this._then);

  final LessonProgress _self;
  final $Res Function(LessonProgress) _then;

/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? moduleId = null,Object? readCount = null,Object? completed = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonProgress].
extension LessonProgressPatterns on LessonProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonProgress value)  $default,){
final _that = this;
switch (_that) {
case _LessonProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonProgress value)?  $default,){
final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String moduleId,  int readCount,  bool completed,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
return $default(_that.id,_that.profileId,_that.moduleId,_that.readCount,_that.completed,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String moduleId,  int readCount,  bool completed,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _LessonProgress():
return $default(_that.id,_that.profileId,_that.moduleId,_that.readCount,_that.completed,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String moduleId,  int readCount,  bool completed,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LessonProgress() when $default != null:
return $default(_that.id,_that.profileId,_that.moduleId,_that.readCount,_that.completed,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LessonProgress implements LessonProgress {
  const _LessonProgress({required this.id, required this.profileId, required this.moduleId, required this.readCount, required this.completed, required this.createdAt});
  factory _LessonProgress.fromJson(Map<String, dynamic> json) => _$LessonProgressFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String moduleId;
@override final  int readCount;
@override final  bool completed;
@override final  DateTime createdAt;

/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonProgressCopyWith<_LessonProgress> get copyWith => __$LessonProgressCopyWithImpl<_LessonProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonProgress&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.readCount, readCount) || other.readCount == readCount)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,moduleId,readCount,completed,createdAt);

@override
String toString() {
  return 'LessonProgress(id: $id, profileId: $profileId, moduleId: $moduleId, readCount: $readCount, completed: $completed, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LessonProgressCopyWith<$Res> implements $LessonProgressCopyWith<$Res> {
  factory _$LessonProgressCopyWith(_LessonProgress value, $Res Function(_LessonProgress) _then) = __$LessonProgressCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String moduleId, int readCount, bool completed, DateTime createdAt
});




}
/// @nodoc
class __$LessonProgressCopyWithImpl<$Res>
    implements _$LessonProgressCopyWith<$Res> {
  __$LessonProgressCopyWithImpl(this._self, this._then);

  final _LessonProgress _self;
  final $Res Function(_LessonProgress) _then;

/// Create a copy of LessonProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? moduleId = null,Object? readCount = null,Object? completed = null,Object? createdAt = null,}) {
  return _then(_LessonProgress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
