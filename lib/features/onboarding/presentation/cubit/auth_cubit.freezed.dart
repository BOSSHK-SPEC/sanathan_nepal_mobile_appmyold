// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 LoadState<OtpChallenge> get challenge; LoadState<AuthSession> get session;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,challenge,session);

@override
String toString() {
  return 'AuthState(challenge: $challenge, session: $session)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 LoadState<OtpChallenge> challenge, LoadState<AuthSession> session
});


$LoadStateCopyWith<OtpChallenge, $Res> get challenge;$LoadStateCopyWith<AuthSession, $Res> get session;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? challenge = null,Object? session = null,}) {
  return _then(_self.copyWith(
challenge: null == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as LoadState<OtpChallenge>,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<AuthSession>,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<OtpChallenge, $Res> get challenge {
  
  return $LoadStateCopyWith<OtpChallenge, $Res>(_self.challenge, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AuthSession, $Res> get session {
  
  return $LoadStateCopyWith<AuthSession, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}



/// @nodoc


class _AuthState extends AuthState {
  const _AuthState({this.challenge = const LoadState.idle(), this.session = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<OtpChallenge> challenge;
@override@JsonKey() final  LoadState<AuthSession> session;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,challenge,session);

@override
String toString() {
  return 'AuthState(challenge: $challenge, session: $session)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<OtpChallenge> challenge, LoadState<AuthSession> session
});


@override $LoadStateCopyWith<OtpChallenge, $Res> get challenge;@override $LoadStateCopyWith<AuthSession, $Res> get session;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? challenge = null,Object? session = null,}) {
  return _then(_AuthState(
challenge: null == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as LoadState<OtpChallenge>,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<AuthSession>,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<OtpChallenge, $Res> get challenge {
  
  return $LoadStateCopyWith<OtpChallenge, $Res>(_self.challenge, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AuthSession, $Res> get session {
  
  return $LoadStateCopyWith<AuthSession, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
