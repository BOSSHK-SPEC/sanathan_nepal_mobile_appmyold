// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminAuthState {

 String get phone; String get region;/// The live challenge id once a code has been sent.
 LoadState<String> get challenge; LoadState<AdminSession> get session;
/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAuthStateCopyWith<AdminAuthState> get copyWith => _$AdminAuthStateCopyWithImpl<AdminAuthState>(this as AdminAuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAuthState&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.region, region) || other.region == region)&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,phone,region,challenge,session);

@override
String toString() {
  return 'AdminAuthState(phone: $phone, region: $region, challenge: $challenge, session: $session)';
}


}

/// @nodoc
abstract mixin class $AdminAuthStateCopyWith<$Res>  {
  factory $AdminAuthStateCopyWith(AdminAuthState value, $Res Function(AdminAuthState) _then) = _$AdminAuthStateCopyWithImpl;
@useResult
$Res call({
 String phone, String region, LoadState<String> challenge, LoadState<AdminSession> session
});


$LoadStateCopyWith<String, $Res> get challenge;$LoadStateCopyWith<AdminSession, $Res> get session;

}
/// @nodoc
class _$AdminAuthStateCopyWithImpl<$Res>
    implements $AdminAuthStateCopyWith<$Res> {
  _$AdminAuthStateCopyWithImpl(this._self, this._then);

  final AdminAuthState _self;
  final $Res Function(AdminAuthState) _then;

/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? region = null,Object? challenge = null,Object? session = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,challenge: null == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as LoadState<String>,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<AdminSession>,
  ));
}
/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<String, $Res> get challenge {
  
  return $LoadStateCopyWith<String, $Res>(_self.challenge, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AdminSession, $Res> get session {
  
  return $LoadStateCopyWith<AdminSession, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}



/// @nodoc


class _AdminAuthState extends AdminAuthState {
  const _AdminAuthState({this.phone = '', this.region = 'NP', this.challenge = const LoadState<String>.idle(), this.session = const LoadState<AdminSession>.idle()}): super._();
  

@override@JsonKey() final  String phone;
@override@JsonKey() final  String region;
/// The live challenge id once a code has been sent.
@override@JsonKey() final  LoadState<String> challenge;
@override@JsonKey() final  LoadState<AdminSession> session;

/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminAuthStateCopyWith<_AdminAuthState> get copyWith => __$AdminAuthStateCopyWithImpl<_AdminAuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminAuthState&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.region, region) || other.region == region)&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,phone,region,challenge,session);

@override
String toString() {
  return 'AdminAuthState(phone: $phone, region: $region, challenge: $challenge, session: $session)';
}


}

/// @nodoc
abstract mixin class _$AdminAuthStateCopyWith<$Res> implements $AdminAuthStateCopyWith<$Res> {
  factory _$AdminAuthStateCopyWith(_AdminAuthState value, $Res Function(_AdminAuthState) _then) = __$AdminAuthStateCopyWithImpl;
@override @useResult
$Res call({
 String phone, String region, LoadState<String> challenge, LoadState<AdminSession> session
});


@override $LoadStateCopyWith<String, $Res> get challenge;@override $LoadStateCopyWith<AdminSession, $Res> get session;

}
/// @nodoc
class __$AdminAuthStateCopyWithImpl<$Res>
    implements _$AdminAuthStateCopyWith<$Res> {
  __$AdminAuthStateCopyWithImpl(this._self, this._then);

  final _AdminAuthState _self;
  final $Res Function(_AdminAuthState) _then;

/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? region = null,Object? challenge = null,Object? session = null,}) {
  return _then(_AdminAuthState(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,challenge: null == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as LoadState<String>,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<AdminSession>,
  ));
}

/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<String, $Res> get challenge {
  
  return $LoadStateCopyWith<String, $Res>(_self.challenge, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of AdminAuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AdminSession, $Res> get session {
  
  return $LoadStateCopyWith<AdminSession, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
