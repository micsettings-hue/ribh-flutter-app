// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'distribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Distribution {

 String get id; String get campaignId; int get gross; int get ribhFee; int get investorShare; DateTime get createdAt;
/// Create a copy of Distribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistributionCopyWith<Distribution> get copyWith => _$DistributionCopyWithImpl<Distribution>(this as Distribution, _$identity);

  /// Serializes this Distribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Distribution&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.gross, gross) || other.gross == gross)&&(identical(other.ribhFee, ribhFee) || other.ribhFee == ribhFee)&&(identical(other.investorShare, investorShare) || other.investorShare == investorShare)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,gross,ribhFee,investorShare,createdAt);

@override
String toString() {
  return 'Distribution(id: $id, campaignId: $campaignId, gross: $gross, ribhFee: $ribhFee, investorShare: $investorShare, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DistributionCopyWith<$Res>  {
  factory $DistributionCopyWith(Distribution value, $Res Function(Distribution) _then) = _$DistributionCopyWithImpl;
@useResult
$Res call({
 String id, String campaignId, int gross, int ribhFee, int investorShare, DateTime createdAt
});




}
/// @nodoc
class _$DistributionCopyWithImpl<$Res>
    implements $DistributionCopyWith<$Res> {
  _$DistributionCopyWithImpl(this._self, this._then);

  final Distribution _self;
  final $Res Function(Distribution) _then;

/// Create a copy of Distribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? campaignId = null,Object? gross = null,Object? ribhFee = null,Object? investorShare = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,gross: null == gross ? _self.gross : gross // ignore: cast_nullable_to_non_nullable
as int,ribhFee: null == ribhFee ? _self.ribhFee : ribhFee // ignore: cast_nullable_to_non_nullable
as int,investorShare: null == investorShare ? _self.investorShare : investorShare // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Distribution].
extension DistributionPatterns on Distribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Distribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Distribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Distribution value)  $default,){
final _that = this;
switch (_that) {
case _Distribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Distribution value)?  $default,){
final _that = this;
switch (_that) {
case _Distribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String campaignId,  int gross,  int ribhFee,  int investorShare,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Distribution() when $default != null:
return $default(_that.id,_that.campaignId,_that.gross,_that.ribhFee,_that.investorShare,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String campaignId,  int gross,  int ribhFee,  int investorShare,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Distribution():
return $default(_that.id,_that.campaignId,_that.gross,_that.ribhFee,_that.investorShare,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String campaignId,  int gross,  int ribhFee,  int investorShare,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Distribution() when $default != null:
return $default(_that.id,_that.campaignId,_that.gross,_that.ribhFee,_that.investorShare,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Distribution implements Distribution {
  const _Distribution({required this.id, required this.campaignId, required this.gross, required this.ribhFee, required this.investorShare, required this.createdAt});
  factory _Distribution.fromJson(Map<String, dynamic> json) => _$DistributionFromJson(json);

@override final  String id;
@override final  String campaignId;
@override final  int gross;
@override final  int ribhFee;
@override final  int investorShare;
@override final  DateTime createdAt;

/// Create a copy of Distribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistributionCopyWith<_Distribution> get copyWith => __$DistributionCopyWithImpl<_Distribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DistributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Distribution&&(identical(other.id, id) || other.id == id)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.gross, gross) || other.gross == gross)&&(identical(other.ribhFee, ribhFee) || other.ribhFee == ribhFee)&&(identical(other.investorShare, investorShare) || other.investorShare == investorShare)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,campaignId,gross,ribhFee,investorShare,createdAt);

@override
String toString() {
  return 'Distribution(id: $id, campaignId: $campaignId, gross: $gross, ribhFee: $ribhFee, investorShare: $investorShare, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DistributionCopyWith<$Res> implements $DistributionCopyWith<$Res> {
  factory _$DistributionCopyWith(_Distribution value, $Res Function(_Distribution) _then) = __$DistributionCopyWithImpl;
@override @useResult
$Res call({
 String id, String campaignId, int gross, int ribhFee, int investorShare, DateTime createdAt
});




}
/// @nodoc
class __$DistributionCopyWithImpl<$Res>
    implements _$DistributionCopyWith<$Res> {
  __$DistributionCopyWithImpl(this._self, this._then);

  final _Distribution _self;
  final $Res Function(_Distribution) _then;

/// Create a copy of Distribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? campaignId = null,Object? gross = null,Object? ribhFee = null,Object? investorShare = null,Object? createdAt = null,}) {
  return _then(_Distribution(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,gross: null == gross ? _self.gross : gross // ignore: cast_nullable_to_non_nullable
as int,ribhFee: null == ribhFee ? _self.ribhFee : ribhFee // ignore: cast_nullable_to_non_nullable
as int,investorShare: null == investorShare ? _self.investorShare : investorShare // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
