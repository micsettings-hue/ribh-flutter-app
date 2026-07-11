// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KycSubmission {

 String get id; String get profileId; String get nidHash; KycSource get sourceOfFunds; bool get selfieCaptured; KycStatus get status; DateTime get createdAt;
/// Create a copy of KycSubmission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycSubmissionCopyWith<KycSubmission> get copyWith => _$KycSubmissionCopyWithImpl<KycSubmission>(this as KycSubmission, _$identity);

  /// Serializes this KycSubmission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycSubmission&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.nidHash, nidHash) || other.nidHash == nidHash)&&(identical(other.sourceOfFunds, sourceOfFunds) || other.sourceOfFunds == sourceOfFunds)&&(identical(other.selfieCaptured, selfieCaptured) || other.selfieCaptured == selfieCaptured)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,nidHash,sourceOfFunds,selfieCaptured,status,createdAt);

@override
String toString() {
  return 'KycSubmission(id: $id, profileId: $profileId, nidHash: $nidHash, sourceOfFunds: $sourceOfFunds, selfieCaptured: $selfieCaptured, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $KycSubmissionCopyWith<$Res>  {
  factory $KycSubmissionCopyWith(KycSubmission value, $Res Function(KycSubmission) _then) = _$KycSubmissionCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String nidHash, KycSource sourceOfFunds, bool selfieCaptured, KycStatus status, DateTime createdAt
});




}
/// @nodoc
class _$KycSubmissionCopyWithImpl<$Res>
    implements $KycSubmissionCopyWith<$Res> {
  _$KycSubmissionCopyWithImpl(this._self, this._then);

  final KycSubmission _self;
  final $Res Function(KycSubmission) _then;

/// Create a copy of KycSubmission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? nidHash = null,Object? sourceOfFunds = null,Object? selfieCaptured = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,nidHash: null == nidHash ? _self.nidHash : nidHash // ignore: cast_nullable_to_non_nullable
as String,sourceOfFunds: null == sourceOfFunds ? _self.sourceOfFunds : sourceOfFunds // ignore: cast_nullable_to_non_nullable
as KycSource,selfieCaptured: null == selfieCaptured ? _self.selfieCaptured : selfieCaptured // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KycStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [KycSubmission].
extension KycSubmissionPatterns on KycSubmission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycSubmission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycSubmission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycSubmission value)  $default,){
final _that = this;
switch (_that) {
case _KycSubmission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycSubmission value)?  $default,){
final _that = this;
switch (_that) {
case _KycSubmission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String nidHash,  KycSource sourceOfFunds,  bool selfieCaptured,  KycStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycSubmission() when $default != null:
return $default(_that.id,_that.profileId,_that.nidHash,_that.sourceOfFunds,_that.selfieCaptured,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String nidHash,  KycSource sourceOfFunds,  bool selfieCaptured,  KycStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _KycSubmission():
return $default(_that.id,_that.profileId,_that.nidHash,_that.sourceOfFunds,_that.selfieCaptured,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String nidHash,  KycSource sourceOfFunds,  bool selfieCaptured,  KycStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _KycSubmission() when $default != null:
return $default(_that.id,_that.profileId,_that.nidHash,_that.sourceOfFunds,_that.selfieCaptured,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KycSubmission implements KycSubmission {
  const _KycSubmission({required this.id, required this.profileId, required this.nidHash, required this.sourceOfFunds, required this.selfieCaptured, required this.status, required this.createdAt});
  factory _KycSubmission.fromJson(Map<String, dynamic> json) => _$KycSubmissionFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String nidHash;
@override final  KycSource sourceOfFunds;
@override final  bool selfieCaptured;
@override final  KycStatus status;
@override final  DateTime createdAt;

/// Create a copy of KycSubmission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycSubmissionCopyWith<_KycSubmission> get copyWith => __$KycSubmissionCopyWithImpl<_KycSubmission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KycSubmissionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycSubmission&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.nidHash, nidHash) || other.nidHash == nidHash)&&(identical(other.sourceOfFunds, sourceOfFunds) || other.sourceOfFunds == sourceOfFunds)&&(identical(other.selfieCaptured, selfieCaptured) || other.selfieCaptured == selfieCaptured)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,nidHash,sourceOfFunds,selfieCaptured,status,createdAt);

@override
String toString() {
  return 'KycSubmission(id: $id, profileId: $profileId, nidHash: $nidHash, sourceOfFunds: $sourceOfFunds, selfieCaptured: $selfieCaptured, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$KycSubmissionCopyWith<$Res> implements $KycSubmissionCopyWith<$Res> {
  factory _$KycSubmissionCopyWith(_KycSubmission value, $Res Function(_KycSubmission) _then) = __$KycSubmissionCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String nidHash, KycSource sourceOfFunds, bool selfieCaptured, KycStatus status, DateTime createdAt
});




}
/// @nodoc
class __$KycSubmissionCopyWithImpl<$Res>
    implements _$KycSubmissionCopyWith<$Res> {
  __$KycSubmissionCopyWithImpl(this._self, this._then);

  final _KycSubmission _self;
  final $Res Function(_KycSubmission) _then;

/// Create a copy of KycSubmission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? nidHash = null,Object? sourceOfFunds = null,Object? selfieCaptured = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_KycSubmission(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,nidHash: null == nidHash ? _self.nidHash : nidHash // ignore: cast_nullable_to_non_nullable
as String,sourceOfFunds: null == sourceOfFunds ? _self.sourceOfFunds : sourceOfFunds // ignore: cast_nullable_to_non_nullable
as KycSource,selfieCaptured: null == selfieCaptured ? _self.selfieCaptured : selfieCaptured // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as KycStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
