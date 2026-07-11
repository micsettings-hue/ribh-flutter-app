// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_invest_queue_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AutoInvestQueueItem {

 String get id; String get ruleId; String get campaignId; QueueStatus get status; DateTime get createdAt;
/// Create a copy of AutoInvestQueueItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoInvestQueueItemCopyWith<AutoInvestQueueItem> get copyWith => _$AutoInvestQueueItemCopyWithImpl<AutoInvestQueueItem>(this as AutoInvestQueueItem, _$identity);

  /// Serializes this AutoInvestQueueItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoInvestQueueItem&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ruleId,campaignId,status,createdAt);

@override
String toString() {
  return 'AutoInvestQueueItem(id: $id, ruleId: $ruleId, campaignId: $campaignId, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AutoInvestQueueItemCopyWith<$Res>  {
  factory $AutoInvestQueueItemCopyWith(AutoInvestQueueItem value, $Res Function(AutoInvestQueueItem) _then) = _$AutoInvestQueueItemCopyWithImpl;
@useResult
$Res call({
 String id, String ruleId, String campaignId, QueueStatus status, DateTime createdAt
});




}
/// @nodoc
class _$AutoInvestQueueItemCopyWithImpl<$Res>
    implements $AutoInvestQueueItemCopyWith<$Res> {
  _$AutoInvestQueueItemCopyWithImpl(this._self, this._then);

  final AutoInvestQueueItem _self;
  final $Res Function(AutoInvestQueueItem) _then;

/// Create a copy of AutoInvestQueueItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ruleId = null,Object? campaignId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoInvestQueueItem].
extension AutoInvestQueueItemPatterns on AutoInvestQueueItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoInvestQueueItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoInvestQueueItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoInvestQueueItem value)  $default,){
final _that = this;
switch (_that) {
case _AutoInvestQueueItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoInvestQueueItem value)?  $default,){
final _that = this;
switch (_that) {
case _AutoInvestQueueItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ruleId,  String campaignId,  QueueStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoInvestQueueItem() when $default != null:
return $default(_that.id,_that.ruleId,_that.campaignId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ruleId,  String campaignId,  QueueStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AutoInvestQueueItem():
return $default(_that.id,_that.ruleId,_that.campaignId,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ruleId,  String campaignId,  QueueStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AutoInvestQueueItem() when $default != null:
return $default(_that.id,_that.ruleId,_that.campaignId,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutoInvestQueueItem implements AutoInvestQueueItem {
  const _AutoInvestQueueItem({required this.id, required this.ruleId, required this.campaignId, required this.status, required this.createdAt});
  factory _AutoInvestQueueItem.fromJson(Map<String, dynamic> json) => _$AutoInvestQueueItemFromJson(json);

@override final  String id;
@override final  String ruleId;
@override final  String campaignId;
@override final  QueueStatus status;
@override final  DateTime createdAt;

/// Create a copy of AutoInvestQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoInvestQueueItemCopyWith<_AutoInvestQueueItem> get copyWith => __$AutoInvestQueueItemCopyWithImpl<_AutoInvestQueueItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutoInvestQueueItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoInvestQueueItem&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ruleId,campaignId,status,createdAt);

@override
String toString() {
  return 'AutoInvestQueueItem(id: $id, ruleId: $ruleId, campaignId: $campaignId, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AutoInvestQueueItemCopyWith<$Res> implements $AutoInvestQueueItemCopyWith<$Res> {
  factory _$AutoInvestQueueItemCopyWith(_AutoInvestQueueItem value, $Res Function(_AutoInvestQueueItem) _then) = __$AutoInvestQueueItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String ruleId, String campaignId, QueueStatus status, DateTime createdAt
});




}
/// @nodoc
class __$AutoInvestQueueItemCopyWithImpl<$Res>
    implements _$AutoInvestQueueItemCopyWith<$Res> {
  __$AutoInvestQueueItemCopyWithImpl(this._self, this._then);

  final _AutoInvestQueueItem _self;
  final $Res Function(_AutoInvestQueueItem) _then;

/// Create a copy of AutoInvestQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ruleId = null,Object? campaignId = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_AutoInvestQueueItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QueueStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
