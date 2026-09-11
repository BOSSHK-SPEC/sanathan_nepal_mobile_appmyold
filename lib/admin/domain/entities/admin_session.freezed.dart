// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminSession {

 String get userId; Set<AppRole> get roles; String get region; String? get displayName; String? get phone;
/// Create a copy of AdminSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminSessionCopyWith<AdminSession> get copyWith => _$AdminSessionCopyWithImpl<AdminSession>(this as AdminSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminSession&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.region, region) || other.region == region)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(roles),region,displayName,phone);

@override
String toString() {
  return 'AdminSession(userId: $userId, roles: $roles, region: $region, displayName: $displayName, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $AdminSessionCopyWith<$Res>  {
  factory $AdminSessionCopyWith(AdminSession value, $Res Function(AdminSession) _then) = _$AdminSessionCopyWithImpl;
@useResult
$Res call({
 String userId, Set<AppRole> roles, String region, String? displayName, String? phone
});




}
/// @nodoc
class _$AdminSessionCopyWithImpl<$Res>
    implements $AdminSessionCopyWith<$Res> {
  _$AdminSessionCopyWithImpl(this._self, this._then);

  final AdminSession _self;
  final $Res Function(AdminSession) _then;

/// Create a copy of AdminSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? roles = null,Object? region = null,Object? displayName = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as Set<AppRole>,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _AdminSession extends AdminSession {
  const _AdminSession({required this.userId, required final  Set<AppRole> roles, this.region = '', this.displayName, this.phone}): _roles = roles,super._();
  

@override final  String userId;
 final  Set<AppRole> _roles;
@override Set<AppRole> get roles {
  if (_roles is EqualUnmodifiableSetView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_roles);
}

@override@JsonKey() final  String region;
@override final  String? displayName;
@override final  String? phone;

/// Create a copy of AdminSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminSessionCopyWith<_AdminSession> get copyWith => __$AdminSessionCopyWithImpl<_AdminSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminSession&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.region, region) || other.region == region)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_roles),region,displayName,phone);

@override
String toString() {
  return 'AdminSession(userId: $userId, roles: $roles, region: $region, displayName: $displayName, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$AdminSessionCopyWith<$Res> implements $AdminSessionCopyWith<$Res> {
  factory _$AdminSessionCopyWith(_AdminSession value, $Res Function(_AdminSession) _then) = __$AdminSessionCopyWithImpl;
@override @useResult
$Res call({
 String userId, Set<AppRole> roles, String region, String? displayName, String? phone
});




}
/// @nodoc
class __$AdminSessionCopyWithImpl<$Res>
    implements _$AdminSessionCopyWith<$Res> {
  __$AdminSessionCopyWithImpl(this._self, this._then);

  final _AdminSession _self;
  final $Res Function(_AdminSession) _then;

/// Create a copy of AdminSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? roles = null,Object? region = null,Object? displayName = freezed,Object? phone = freezed,}) {
  return _then(_AdminSession(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as Set<AppRole>,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
