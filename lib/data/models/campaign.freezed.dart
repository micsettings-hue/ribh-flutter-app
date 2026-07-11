// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Campaign {

 String get id; String? get businessId; String get contract; String get sector; int get pool; int get raised; int get profitPerLac; double get share; int get tenure; String get risk; CampaignStatus get status; DateTime get createdAt;
/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignCopyWith<Campaign> get copyWith => _$CampaignCopyWithImpl<Campaign>(this as Campaign, _$identity);

  /// Serializes this Campaign to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Campaign&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.contract, contract) || other.contract == contract)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.raised, raised) || other.raised == raised)&&(identical(other.profitPerLac, profitPerLac) || other.profitPerLac == profitPerLac)&&(identical(other.share, share) || other.share == share)&&(identical(other.tenure, tenure) || other.tenure == tenure)&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,contract,sector,pool,raised,profitPerLac,share,tenure,risk,status,createdAt);

@override
String toString() {
  return 'Campaign(id: $id, businessId: $businessId, contract: $contract, sector: $sector, pool: $pool, raised: $raised, profitPerLac: $profitPerLac, share: $share, tenure: $tenure, risk: $risk, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CampaignCopyWith<$Res>  {
  factory $CampaignCopyWith(Campaign value, $Res Function(Campaign) _then) = _$CampaignCopyWithImpl;
@useResult
$Res call({
 String id, String? businessId, String contract, String sector, int pool, int raised, int profitPerLac, double share, int tenure, String risk, CampaignStatus status, DateTime createdAt
});




}
/// @nodoc
class _$CampaignCopyWithImpl<$Res>
    implements $CampaignCopyWith<$Res> {
  _$CampaignCopyWithImpl(this._self, this._then);

  final Campaign _self;
  final $Res Function(Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? businessId = freezed,Object? contract = null,Object? sector = null,Object? pool = null,Object? raised = null,Object? profitPerLac = null,Object? share = null,Object? tenure = null,Object? risk = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: freezed == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String?,contract: null == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as int,raised: null == raised ? _self.raised : raised // ignore: cast_nullable_to_non_nullable
as int,profitPerLac: null == profitPerLac ? _self.profitPerLac : profitPerLac // ignore: cast_nullable_to_non_nullable
as int,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as double,tenure: null == tenure ? _self.tenure : tenure // ignore: cast_nullable_to_non_nullable
as int,risk: null == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Campaign].
extension CampaignPatterns on Campaign {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Campaign value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Campaign value)  $default,){
final _that = this;
switch (_that) {
case _Campaign():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Campaign value)?  $default,){
final _that = this;
switch (_that) {
case _Campaign() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? businessId,  String contract,  String sector,  int pool,  int raised,  int profitPerLac,  double share,  int tenure,  String risk,  CampaignStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.businessId,_that.contract,_that.sector,_that.pool,_that.raised,_that.profitPerLac,_that.share,_that.tenure,_that.risk,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? businessId,  String contract,  String sector,  int pool,  int raised,  int profitPerLac,  double share,  int tenure,  String risk,  CampaignStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Campaign():
return $default(_that.id,_that.businessId,_that.contract,_that.sector,_that.pool,_that.raised,_that.profitPerLac,_that.share,_that.tenure,_that.risk,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? businessId,  String contract,  String sector,  int pool,  int raised,  int profitPerLac,  double share,  int tenure,  String risk,  CampaignStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Campaign() when $default != null:
return $default(_that.id,_that.businessId,_that.contract,_that.sector,_that.pool,_that.raised,_that.profitPerLac,_that.share,_that.tenure,_that.risk,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Campaign extends Campaign {
  const _Campaign({required this.id, this.businessId, required this.contract, required this.sector, required this.pool, required this.raised, required this.profitPerLac, required this.share, required this.tenure, required this.risk, required this.status, required this.createdAt}): super._();
  factory _Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);

@override final  String id;
@override final  String? businessId;
@override final  String contract;
@override final  String sector;
@override final  int pool;
@override final  int raised;
@override final  int profitPerLac;
@override final  double share;
@override final  int tenure;
@override final  String risk;
@override final  CampaignStatus status;
@override final  DateTime createdAt;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignCopyWith<_Campaign> get copyWith => __$CampaignCopyWithImpl<_Campaign>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampaignToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Campaign&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.contract, contract) || other.contract == contract)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.pool, pool) || other.pool == pool)&&(identical(other.raised, raised) || other.raised == raised)&&(identical(other.profitPerLac, profitPerLac) || other.profitPerLac == profitPerLac)&&(identical(other.share, share) || other.share == share)&&(identical(other.tenure, tenure) || other.tenure == tenure)&&(identical(other.risk, risk) || other.risk == risk)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,contract,sector,pool,raised,profitPerLac,share,tenure,risk,status,createdAt);

@override
String toString() {
  return 'Campaign(id: $id, businessId: $businessId, contract: $contract, sector: $sector, pool: $pool, raised: $raised, profitPerLac: $profitPerLac, share: $share, tenure: $tenure, risk: $risk, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CampaignCopyWith<$Res> implements $CampaignCopyWith<$Res> {
  factory _$CampaignCopyWith(_Campaign value, $Res Function(_Campaign) _then) = __$CampaignCopyWithImpl;
@override @useResult
$Res call({
 String id, String? businessId, String contract, String sector, int pool, int raised, int profitPerLac, double share, int tenure, String risk, CampaignStatus status, DateTime createdAt
});




}
/// @nodoc
class __$CampaignCopyWithImpl<$Res>
    implements _$CampaignCopyWith<$Res> {
  __$CampaignCopyWithImpl(this._self, this._then);

  final _Campaign _self;
  final $Res Function(_Campaign) _then;

/// Create a copy of Campaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? businessId = freezed,Object? contract = null,Object? sector = null,Object? pool = null,Object? raised = null,Object? profitPerLac = null,Object? share = null,Object? tenure = null,Object? risk = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_Campaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: freezed == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String?,contract: null == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as int,raised: null == raised ? _self.raised : raised // ignore: cast_nullable_to_non_nullable
as int,profitPerLac: null == profitPerLac ? _self.profitPerLac : profitPerLac // ignore: cast_nullable_to_non_nullable
as int,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as double,tenure: null == tenure ? _self.tenure : tenure // ignore: cast_nullable_to_non_nullable
as int,risk: null == risk ? _self.risk : risk // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
