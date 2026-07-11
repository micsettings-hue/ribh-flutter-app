// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Profile {

 String get id; UserRole get role; int get kycTier; String? get nidHash; String? get riskTier; String get lang; String get theme; bool get twofaEnabled; String? get nomineeId; DateTime get createdAt;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.kycTier, kycTier) || other.kycTier == kycTier)&&(identical(other.nidHash, nidHash) || other.nidHash == nidHash)&&(identical(other.riskTier, riskTier) || other.riskTier == riskTier)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.twofaEnabled, twofaEnabled) || other.twofaEnabled == twofaEnabled)&&(identical(other.nomineeId, nomineeId) || other.nomineeId == nomineeId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,kycTier,nidHash,riskTier,lang,theme,twofaEnabled,nomineeId,createdAt);

@override
String toString() {
  return 'Profile(id: $id, role: $role, kycTier: $kycTier, nidHash: $nidHash, riskTier: $riskTier, lang: $lang, theme: $theme, twofaEnabled: $twofaEnabled, nomineeId: $nomineeId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String id, UserRole role, int kycTier, String? nidHash, String? riskTier, String lang, String theme, bool twofaEnabled, String? nomineeId, DateTime createdAt
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? kycTier = null,Object? nidHash = freezed,Object? riskTier = freezed,Object? lang = null,Object? theme = null,Object? twofaEnabled = null,Object? nomineeId = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,kycTier: null == kycTier ? _self.kycTier : kycTier // ignore: cast_nullable_to_non_nullable
as int,nidHash: freezed == nidHash ? _self.nidHash : nidHash // ignore: cast_nullable_to_non_nullable
as String?,riskTier: freezed == riskTier ? _self.riskTier : riskTier // ignore: cast_nullable_to_non_nullable
as String?,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,twofaEnabled: null == twofaEnabled ? _self.twofaEnabled : twofaEnabled // ignore: cast_nullable_to_non_nullable
as bool,nomineeId: freezed == nomineeId ? _self.nomineeId : nomineeId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UserRole role,  int kycTier,  String? nidHash,  String? riskTier,  String lang,  String theme,  bool twofaEnabled,  String? nomineeId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.role,_that.kycTier,_that.nidHash,_that.riskTier,_that.lang,_that.theme,_that.twofaEnabled,_that.nomineeId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UserRole role,  int kycTier,  String? nidHash,  String? riskTier,  String lang,  String theme,  bool twofaEnabled,  String? nomineeId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.id,_that.role,_that.kycTier,_that.nidHash,_that.riskTier,_that.lang,_that.theme,_that.twofaEnabled,_that.nomineeId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UserRole role,  int kycTier,  String? nidHash,  String? riskTier,  String lang,  String theme,  bool twofaEnabled,  String? nomineeId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.id,_that.role,_that.kycTier,_that.nidHash,_that.riskTier,_that.lang,_that.theme,_that.twofaEnabled,_that.nomineeId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.id, required this.role, required this.kycTier, this.nidHash, this.riskTier, required this.lang, required this.theme, required this.twofaEnabled, this.nomineeId, required this.createdAt});
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  String id;
@override final  UserRole role;
@override final  int kycTier;
@override final  String? nidHash;
@override final  String? riskTier;
@override final  String lang;
@override final  String theme;
@override final  bool twofaEnabled;
@override final  String? nomineeId;
@override final  DateTime createdAt;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.kycTier, kycTier) || other.kycTier == kycTier)&&(identical(other.nidHash, nidHash) || other.nidHash == nidHash)&&(identical(other.riskTier, riskTier) || other.riskTier == riskTier)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.twofaEnabled, twofaEnabled) || other.twofaEnabled == twofaEnabled)&&(identical(other.nomineeId, nomineeId) || other.nomineeId == nomineeId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,kycTier,nidHash,riskTier,lang,theme,twofaEnabled,nomineeId,createdAt);

@override
String toString() {
  return 'Profile(id: $id, role: $role, kycTier: $kycTier, nidHash: $nidHash, riskTier: $riskTier, lang: $lang, theme: $theme, twofaEnabled: $twofaEnabled, nomineeId: $nomineeId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, UserRole role, int kycTier, String? nidHash, String? riskTier, String lang, String theme, bool twofaEnabled, String? nomineeId, DateTime createdAt
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? kycTier = null,Object? nidHash = freezed,Object? riskTier = freezed,Object? lang = null,Object? theme = null,Object? twofaEnabled = null,Object? nomineeId = freezed,Object? createdAt = null,}) {
  return _then(_Profile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,kycTier: null == kycTier ? _self.kycTier : kycTier // ignore: cast_nullable_to_non_nullable
as int,nidHash: freezed == nidHash ? _self.nidHash : nidHash // ignore: cast_nullable_to_non_nullable
as String?,riskTier: freezed == riskTier ? _self.riskTier : riskTier // ignore: cast_nullable_to_non_nullable
as String?,lang: null == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,twofaEnabled: null == twofaEnabled ? _self.twofaEnabled : twofaEnabled // ignore: cast_nullable_to_non_nullable
as bool,nomineeId: freezed == nomineeId ? _self.nomineeId : nomineeId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
