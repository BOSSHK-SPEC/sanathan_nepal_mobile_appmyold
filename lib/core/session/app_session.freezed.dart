// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSession {

 String? get userId; String get name; String? get avatarUrl;/// Every role this account holds. A user can be several at once.
 Set<AppRole> get roles;/// Which role's UI is being shown. Null means the default for [roles].
 AppRole? get activeRole; bool get isAuthenticated;
/// Create a copy of AppSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSessionCopyWith<AppSession> get copyWith => _$AppSessionCopyWithImpl<AppSession>(this as AppSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSession&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated));
}


@override
int get hashCode => Object.hash(runtimeType,userId,name,avatarUrl,const DeepCollectionEquality().hash(roles),activeRole,isAuthenticated);

@override
String toString() {
  return 'AppSession(userId: $userId, name: $name, avatarUrl: $avatarUrl, roles: $roles, activeRole: $activeRole, isAuthenticated: $isAuthenticated)';
}


}

/// @nodoc
abstract mixin class $AppSessionCopyWith<$Res>  {
  factory $AppSessionCopyWith(AppSession value, $Res Function(AppSession) _then) = _$AppSessionCopyWithImpl;
@useResult
$Res call({
 String? userId, String name, String? avatarUrl, Set<AppRole> roles, AppRole? activeRole, bool isAuthenticated
});




}
/// @nodoc
class _$AppSessionCopyWithImpl<$Res>
    implements $AppSessionCopyWith<$Res> {
  _$AppSessionCopyWithImpl(this._self, this._then);

  final AppSession _self;
  final $Res Function(AppSession) _then;

/// Create a copy of AppSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? name = null,Object? avatarUrl = freezed,Object? roles = null,Object? activeRole = freezed,Object? isAuthenticated = null,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as Set<AppRole>,activeRole: freezed == activeRole ? _self.activeRole : activeRole // ignore: cast_nullable_to_non_nullable
as AppRole?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _AppSession extends AppSession {
  const _AppSession({this.userId, this.name = '', this.avatarUrl, final  Set<AppRole> roles = const {AppRole.seeker}, this.activeRole, this.isAuthenticated = false}): _roles = roles,super._();
  

@override final  String? userId;
@override@JsonKey() final  String name;
@override final  String? avatarUrl;
/// Every role this account holds. A user can be several at once.
 final  Set<AppRole> _roles;
/// Every role this account holds. A user can be several at once.
@override@JsonKey() Set<AppRole> get roles {
  if (_roles is EqualUnmodifiableSetView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_roles);
}

/// Which role's UI is being shown. Null means the default for [roles].
@override final  AppRole? activeRole;
@override@JsonKey() final  bool isAuthenticated;

/// Create a copy of AppSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSessionCopyWith<_AppSession> get copyWith => __$AppSessionCopyWithImpl<_AppSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSession&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated));
}


@override
int get hashCode => Object.hash(runtimeType,userId,name,avatarUrl,const DeepCollectionEquality().hash(_roles),activeRole,isAuthenticated);

@override
String toString() {
  return 'AppSession(userId: $userId, name: $name, avatarUrl: $avatarUrl, roles: $roles, activeRole: $activeRole, isAuthenticated: $isAuthenticated)';
}


}

/// @nodoc
abstract mixin class _$AppSessionCopyWith<$Res> implements $AppSessionCopyWith<$Res> {
  factory _$AppSessionCopyWith(_AppSession value, $Res Function(_AppSession) _then) = __$AppSessionCopyWithImpl;
@override @useResult
$Res call({
 String? userId, String name, String? avatarUrl, Set<AppRole> roles, AppRole? activeRole, bool isAuthenticated
});




}
/// @nodoc
class __$AppSessionCopyWithImpl<$Res>
    implements _$AppSessionCopyWith<$Res> {
  __$AppSessionCopyWithImpl(this._self, this._then);

  final _AppSession _self;
  final $Res Function(_AppSession) _then;

/// Create a copy of AppSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? name = null,Object? avatarUrl = freezed,Object? roles = null,Object? activeRole = freezed,Object? isAuthenticated = null,}) {
  return _then(_AppSession(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as Set<AppRole>,activeRole: freezed == activeRole ? _self.activeRole : activeRole // ignore: cast_nullable_to_non_nullable
as AppRole?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
