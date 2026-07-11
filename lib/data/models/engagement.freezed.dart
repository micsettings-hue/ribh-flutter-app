// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Engagement {

 String get profileId; Map<String, dynamic> get adhkarCounts; Map<String, dynamic> get habitDays; int get prayerStreak; int get score; DateTime get updatedAt;
/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EngagementCopyWith<Engagement> get copyWith => _$EngagementCopyWithImpl<Engagement>(this as Engagement, _$identity);

  /// Serializes this Engagement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Engagement&&(identical(other.profileId, profileId) || other.profileId == profileId)&&const DeepCollectionEquality().equals(other.adhkarCounts, adhkarCounts)&&const DeepCollectionEquality().equals(other.habitDays, habitDays)&&(identical(other.prayerStreak, prayerStreak) || other.prayerStreak == prayerStreak)&&(identical(other.score, score) || other.score == score)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,const DeepCollectionEquality().hash(adhkarCounts),const DeepCollectionEquality().hash(habitDays),prayerStreak,score,updatedAt);

@override
String toString() {
  return 'Engagement(profileId: $profileId, adhkarCounts: $adhkarCounts, habitDays: $habitDays, prayerStreak: $prayerStreak, score: $score, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EngagementCopyWith<$Res>  {
  factory $EngagementCopyWith(Engagement value, $Res Function(Engagement) _then) = _$EngagementCopyWithImpl;
@useResult
$Res call({
 String profileId, Map<String, dynamic> adhkarCounts, Map<String, dynamic> habitDays, int prayerStreak, int score, DateTime updatedAt
});




}
/// @nodoc
class _$EngagementCopyWithImpl<$Res>
    implements $EngagementCopyWith<$Res> {
  _$EngagementCopyWithImpl(this._self, this._then);

  final Engagement _self;
  final $Res Function(Engagement) _then;

/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? adhkarCounts = null,Object? habitDays = null,Object? prayerStreak = null,Object? score = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,adhkarCounts: null == adhkarCounts ? _self.adhkarCounts : adhkarCounts // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,habitDays: null == habitDays ? _self.habitDays : habitDays // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,prayerStreak: null == prayerStreak ? _self.prayerStreak : prayerStreak // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Engagement].
extension EngagementPatterns on Engagement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Engagement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Engagement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Engagement value)  $default,){
final _that = this;
switch (_that) {
case _Engagement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Engagement value)?  $default,){
final _that = this;
switch (_that) {
case _Engagement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String profileId,  Map<String, dynamic> adhkarCounts,  Map<String, dynamic> habitDays,  int prayerStreak,  int score,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Engagement() when $default != null:
return $default(_that.profileId,_that.adhkarCounts,_that.habitDays,_that.prayerStreak,_that.score,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String profileId,  Map<String, dynamic> adhkarCounts,  Map<String, dynamic> habitDays,  int prayerStreak,  int score,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Engagement():
return $default(_that.profileId,_that.adhkarCounts,_that.habitDays,_that.prayerStreak,_that.score,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String profileId,  Map<String, dynamic> adhkarCounts,  Map<String, dynamic> habitDays,  int prayerStreak,  int score,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Engagement() when $default != null:
return $default(_that.profileId,_that.adhkarCounts,_that.habitDays,_that.prayerStreak,_that.score,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Engagement implements Engagement {
  const _Engagement({required this.profileId, required final  Map<String, dynamic> adhkarCounts, required final  Map<String, dynamic> habitDays, required this.prayerStreak, required this.score, required this.updatedAt}): _adhkarCounts = adhkarCounts,_habitDays = habitDays;
  factory _Engagement.fromJson(Map<String, dynamic> json) => _$EngagementFromJson(json);

@override final  String profileId;
 final  Map<String, dynamic> _adhkarCounts;
@override Map<String, dynamic> get adhkarCounts {
  if (_adhkarCounts is EqualUnmodifiableMapView) return _adhkarCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_adhkarCounts);
}

 final  Map<String, dynamic> _habitDays;
@override Map<String, dynamic> get habitDays {
  if (_habitDays is EqualUnmodifiableMapView) return _habitDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_habitDays);
}

@override final  int prayerStreak;
@override final  int score;
@override final  DateTime updatedAt;

/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EngagementCopyWith<_Engagement> get copyWith => __$EngagementCopyWithImpl<_Engagement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EngagementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Engagement&&(identical(other.profileId, profileId) || other.profileId == profileId)&&const DeepCollectionEquality().equals(other._adhkarCounts, _adhkarCounts)&&const DeepCollectionEquality().equals(other._habitDays, _habitDays)&&(identical(other.prayerStreak, prayerStreak) || other.prayerStreak == prayerStreak)&&(identical(other.score, score) || other.score == score)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,const DeepCollectionEquality().hash(_adhkarCounts),const DeepCollectionEquality().hash(_habitDays),prayerStreak,score,updatedAt);

@override
String toString() {
  return 'Engagement(profileId: $profileId, adhkarCounts: $adhkarCounts, habitDays: $habitDays, prayerStreak: $prayerStreak, score: $score, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EngagementCopyWith<$Res> implements $EngagementCopyWith<$Res> {
  factory _$EngagementCopyWith(_Engagement value, $Res Function(_Engagement) _then) = __$EngagementCopyWithImpl;
@override @useResult
$Res call({
 String profileId, Map<String, dynamic> adhkarCounts, Map<String, dynamic> habitDays, int prayerStreak, int score, DateTime updatedAt
});




}
/// @nodoc
class __$EngagementCopyWithImpl<$Res>
    implements _$EngagementCopyWith<$Res> {
  __$EngagementCopyWithImpl(this._self, this._then);

  final _Engagement _self;
  final $Res Function(_Engagement) _then;

/// Create a copy of Engagement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? adhkarCounts = null,Object? habitDays = null,Object? prayerStreak = null,Object? score = null,Object? updatedAt = null,}) {
  return _then(_Engagement(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,adhkarCounts: null == adhkarCounts ? _self._adhkarCounts : adhkarCounts // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,habitDays: null == habitDays ? _self._habitDays : habitDays // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,prayerStreak: null == prayerStreak ? _self.prayerStreak : prayerStreak // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
