// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'investment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Investment {

 String get id; String get profileId; String get campaignId; int get amount;@JsonKey(name: 'risk_ack_1') bool get riskAck1;@JsonKey(name: 'risk_ack_2') bool get riskAck2; String get source; DateTime get createdAt;
/// Create a copy of Investment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvestmentCopyWith<Investment> get copyWith => _$InvestmentCopyWithImpl<Investment>(this as Investment, _$identity);

  /// Serializes this Investment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Investment&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.riskAck1, riskAck1) || other.riskAck1 == riskAck1)&&(identical(other.riskAck2, riskAck2) || other.riskAck2 == riskAck2)&&(identical(other.source, source) || other.source == source)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,campaignId,amount,riskAck1,riskAck2,source,createdAt);

@override
String toString() {
  return 'Investment(id: $id, profileId: $profileId, campaignId: $campaignId, amount: $amount, riskAck1: $riskAck1, riskAck2: $riskAck2, source: $source, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InvestmentCopyWith<$Res>  {
  factory $InvestmentCopyWith(Investment value, $Res Function(Investment) _then) = _$InvestmentCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String campaignId, int amount,@JsonKey(name: 'risk_ack_1') bool riskAck1,@JsonKey(name: 'risk_ack_2') bool riskAck2, String source, DateTime createdAt
});




}
/// @nodoc
class _$InvestmentCopyWithImpl<$Res>
    implements $InvestmentCopyWith<$Res> {
  _$InvestmentCopyWithImpl(this._self, this._then);

  final Investment _self;
  final $Res Function(Investment) _then;

/// Create a copy of Investment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? campaignId = null,Object? amount = null,Object? riskAck1 = null,Object? riskAck2 = null,Object? source = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,riskAck1: null == riskAck1 ? _self.riskAck1 : riskAck1 // ignore: cast_nullable_to_non_nullable
as bool,riskAck2: null == riskAck2 ? _self.riskAck2 : riskAck2 // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Investment].
extension InvestmentPatterns on Investment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Investment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Investment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Investment value)  $default,){
final _that = this;
switch (_that) {
case _Investment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Investment value)?  $default,){
final _that = this;
switch (_that) {
case _Investment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String campaignId,  int amount, @JsonKey(name: 'risk_ack_1')  bool riskAck1, @JsonKey(name: 'risk_ack_2')  bool riskAck2,  String source,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Investment() when $default != null:
return $default(_that.id,_that.profileId,_that.campaignId,_that.amount,_that.riskAck1,_that.riskAck2,_that.source,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String campaignId,  int amount, @JsonKey(name: 'risk_ack_1')  bool riskAck1, @JsonKey(name: 'risk_ack_2')  bool riskAck2,  String source,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Investment():
return $default(_that.id,_that.profileId,_that.campaignId,_that.amount,_that.riskAck1,_that.riskAck2,_that.source,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String campaignId,  int amount, @JsonKey(name: 'risk_ack_1')  bool riskAck1, @JsonKey(name: 'risk_ack_2')  bool riskAck2,  String source,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Investment() when $default != null:
return $default(_that.id,_that.profileId,_that.campaignId,_that.amount,_that.riskAck1,_that.riskAck2,_that.source,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Investment implements Investment {
  const _Investment({required this.id, required this.profileId, required this.campaignId, required this.amount, @JsonKey(name: 'risk_ack_1') required this.riskAck1, @JsonKey(name: 'risk_ack_2') required this.riskAck2, required this.source, required this.createdAt});
  factory _Investment.fromJson(Map<String, dynamic> json) => _$InvestmentFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String campaignId;
@override final  int amount;
@override@JsonKey(name: 'risk_ack_1') final  bool riskAck1;
@override@JsonKey(name: 'risk_ack_2') final  bool riskAck2;
@override final  String source;
@override final  DateTime createdAt;

/// Create a copy of Investment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvestmentCopyWith<_Investment> get copyWith => __$InvestmentCopyWithImpl<_Investment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvestmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Investment&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.campaignId, campaignId) || other.campaignId == campaignId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.riskAck1, riskAck1) || other.riskAck1 == riskAck1)&&(identical(other.riskAck2, riskAck2) || other.riskAck2 == riskAck2)&&(identical(other.source, source) || other.source == source)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,campaignId,amount,riskAck1,riskAck2,source,createdAt);

@override
String toString() {
  return 'Investment(id: $id, profileId: $profileId, campaignId: $campaignId, amount: $amount, riskAck1: $riskAck1, riskAck2: $riskAck2, source: $source, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InvestmentCopyWith<$Res> implements $InvestmentCopyWith<$Res> {
  factory _$InvestmentCopyWith(_Investment value, $Res Function(_Investment) _then) = __$InvestmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String campaignId, int amount,@JsonKey(name: 'risk_ack_1') bool riskAck1,@JsonKey(name: 'risk_ack_2') bool riskAck2, String source, DateTime createdAt
});




}
/// @nodoc
class __$InvestmentCopyWithImpl<$Res>
    implements _$InvestmentCopyWith<$Res> {
  __$InvestmentCopyWithImpl(this._self, this._then);

  final _Investment _self;
  final $Res Function(_Investment) _then;

/// Create a copy of Investment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? campaignId = null,Object? amount = null,Object? riskAck1 = null,Object? riskAck2 = null,Object? source = null,Object? createdAt = null,}) {
  return _then(_Investment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,campaignId: null == campaignId ? _self.campaignId : campaignId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,riskAck1: null == riskAck1 ? _self.riskAck1 : riskAck1 // ignore: cast_nullable_to_non_nullable
as bool,riskAck2: null == riskAck2 ? _self.riskAck2 : riskAck2 // ignore: cast_nullable_to_non_nullable
as bool,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
