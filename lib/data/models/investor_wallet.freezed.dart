// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'investor_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvestorWallet {

 String get id; String get profileId; DateTime get createdAt;
/// Create a copy of InvestorWallet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvestorWalletCopyWith<InvestorWallet> get copyWith => _$InvestorWalletCopyWithImpl<InvestorWallet>(this as InvestorWallet, _$identity);

  /// Serializes this InvestorWallet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvestorWallet&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,createdAt);

@override
String toString() {
  return 'InvestorWallet(id: $id, profileId: $profileId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InvestorWalletCopyWith<$Res>  {
  factory $InvestorWalletCopyWith(InvestorWallet value, $Res Function(InvestorWallet) _then) = _$InvestorWalletCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, DateTime createdAt
});




}
/// @nodoc
class _$InvestorWalletCopyWithImpl<$Res>
    implements $InvestorWalletCopyWith<$Res> {
  _$InvestorWalletCopyWithImpl(this._self, this._then);

  final InvestorWallet _self;
  final $Res Function(InvestorWallet) _then;

/// Create a copy of InvestorWallet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InvestorWallet].
extension InvestorWalletPatterns on InvestorWallet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvestorWallet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvestorWallet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvestorWallet value)  $default,){
final _that = this;
switch (_that) {
case _InvestorWallet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvestorWallet value)?  $default,){
final _that = this;
switch (_that) {
case _InvestorWallet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvestorWallet() when $default != null:
return $default(_that.id,_that.profileId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _InvestorWallet():
return $default(_that.id,_that.profileId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InvestorWallet() when $default != null:
return $default(_that.id,_that.profileId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvestorWallet implements InvestorWallet {
  const _InvestorWallet({required this.id, required this.profileId, required this.createdAt});
  factory _InvestorWallet.fromJson(Map<String, dynamic> json) => _$InvestorWalletFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  DateTime createdAt;

/// Create a copy of InvestorWallet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvestorWalletCopyWith<_InvestorWallet> get copyWith => __$InvestorWalletCopyWithImpl<_InvestorWallet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvestorWalletToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvestorWallet&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,createdAt);

@override
String toString() {
  return 'InvestorWallet(id: $id, profileId: $profileId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InvestorWalletCopyWith<$Res> implements $InvestorWalletCopyWith<$Res> {
  factory _$InvestorWalletCopyWith(_InvestorWallet value, $Res Function(_InvestorWallet) _then) = __$InvestorWalletCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, DateTime createdAt
});




}
/// @nodoc
class __$InvestorWalletCopyWithImpl<$Res>
    implements _$InvestorWalletCopyWith<$Res> {
  __$InvestorWalletCopyWithImpl(this._self, this._then);

  final _InvestorWallet _self;
  final $Res Function(_InvestorWallet) _then;

/// Create a copy of InvestorWallet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? createdAt = null,}) {
  return _then(_InvestorWallet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
