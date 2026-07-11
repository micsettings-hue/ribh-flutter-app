// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_invest_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AutoInvestRule {

 String get id; String get profileId; String get strategy; int get budget; bool get active; DateTime get createdAt;
/// Create a copy of AutoInvestRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoInvestRuleCopyWith<AutoInvestRule> get copyWith => _$AutoInvestRuleCopyWithImpl<AutoInvestRule>(this as AutoInvestRule, _$identity);

  /// Serializes this AutoInvestRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoInvestRule&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,strategy,budget,active,createdAt);

@override
String toString() {
  return 'AutoInvestRule(id: $id, profileId: $profileId, strategy: $strategy, budget: $budget, active: $active, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AutoInvestRuleCopyWith<$Res>  {
  factory $AutoInvestRuleCopyWith(AutoInvestRule value, $Res Function(AutoInvestRule) _then) = _$AutoInvestRuleCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String strategy, int budget, bool active, DateTime createdAt
});




}
/// @nodoc
class _$AutoInvestRuleCopyWithImpl<$Res>
    implements $AutoInvestRuleCopyWith<$Res> {
  _$AutoInvestRuleCopyWithImpl(this._self, this._then);

  final AutoInvestRule _self;
  final $Res Function(AutoInvestRule) _then;

/// Create a copy of AutoInvestRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? strategy = null,Object? budget = null,Object? active = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoInvestRule].
extension AutoInvestRulePatterns on AutoInvestRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoInvestRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoInvestRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoInvestRule value)  $default,){
final _that = this;
switch (_that) {
case _AutoInvestRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoInvestRule value)?  $default,){
final _that = this;
switch (_that) {
case _AutoInvestRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String strategy,  int budget,  bool active,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoInvestRule() when $default != null:
return $default(_that.id,_that.profileId,_that.strategy,_that.budget,_that.active,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String strategy,  int budget,  bool active,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AutoInvestRule():
return $default(_that.id,_that.profileId,_that.strategy,_that.budget,_that.active,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String strategy,  int budget,  bool active,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AutoInvestRule() when $default != null:
return $default(_that.id,_that.profileId,_that.strategy,_that.budget,_that.active,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutoInvestRule implements AutoInvestRule {
  const _AutoInvestRule({required this.id, required this.profileId, required this.strategy, required this.budget, required this.active, required this.createdAt});
  factory _AutoInvestRule.fromJson(Map<String, dynamic> json) => _$AutoInvestRuleFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String strategy;
@override final  int budget;
@override final  bool active;
@override final  DateTime createdAt;

/// Create a copy of AutoInvestRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoInvestRuleCopyWith<_AutoInvestRule> get copyWith => __$AutoInvestRuleCopyWithImpl<_AutoInvestRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutoInvestRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoInvestRule&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.active, active) || other.active == active)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,strategy,budget,active,createdAt);

@override
String toString() {
  return 'AutoInvestRule(id: $id, profileId: $profileId, strategy: $strategy, budget: $budget, active: $active, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AutoInvestRuleCopyWith<$Res> implements $AutoInvestRuleCopyWith<$Res> {
  factory _$AutoInvestRuleCopyWith(_AutoInvestRule value, $Res Function(_AutoInvestRule) _then) = __$AutoInvestRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String strategy, int budget, bool active, DateTime createdAt
});




}
/// @nodoc
class __$AutoInvestRuleCopyWithImpl<$Res>
    implements _$AutoInvestRuleCopyWith<$Res> {
  __$AutoInvestRuleCopyWithImpl(this._self, this._then);

  final _AutoInvestRule _self;
  final $Res Function(_AutoInvestRule) _then;

/// Create a copy of AutoInvestRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? strategy = null,Object? budget = null,Object? active = null,Object? createdAt = null,}) {
  return _then(_AutoInvestRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
