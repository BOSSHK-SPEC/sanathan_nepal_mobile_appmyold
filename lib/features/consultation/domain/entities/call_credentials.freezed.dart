// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_credentials.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallCredentials {

/// The media server the device connects to, e.g. `wss://calls.example.com`.
 String get url; String get token; String get room;/// Who the other side sees us as — the signed-in user's id.
 String get identity; DateTime? get expiresAt;
/// Create a copy of CallCredentials
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallCredentialsCopyWith<CallCredentials> get copyWith => _$CallCredentialsCopyWithImpl<CallCredentials>(this as CallCredentials, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallCredentials&&(identical(other.url, url) || other.url == url)&&(identical(other.token, token) || other.token == token)&&(identical(other.room, room) || other.room == room)&&(identical(other.identity, identity) || other.identity == identity)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,url,token,room,identity,expiresAt);

@override
String toString() {
  return 'CallCredentials(url: $url, token: $token, room: $room, identity: $identity, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $CallCredentialsCopyWith<$Res>  {
  factory $CallCredentialsCopyWith(CallCredentials value, $Res Function(CallCredentials) _then) = _$CallCredentialsCopyWithImpl;
@useResult
$Res call({
 String url, String token, String room, String identity, DateTime? expiresAt
});




}
/// @nodoc
class _$CallCredentialsCopyWithImpl<$Res>
    implements $CallCredentialsCopyWith<$Res> {
  _$CallCredentialsCopyWithImpl(this._self, this._then);

  final CallCredentials _self;
  final $Res Function(CallCredentials) _then;

/// Create a copy of CallCredentials
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? token = null,Object? room = null,Object? identity = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String,identity: null == identity ? _self.identity : identity // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



/// @nodoc


class _CallCredentials extends CallCredentials {
  const _CallCredentials({required this.url, required this.token, required this.room, required this.identity, this.expiresAt}): super._();
  

/// The media server the device connects to, e.g. `wss://calls.example.com`.
@override final  String url;
@override final  String token;
@override final  String room;
/// Who the other side sees us as — the signed-in user's id.
@override final  String identity;
@override final  DateTime? expiresAt;

/// Create a copy of CallCredentials
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallCredentialsCopyWith<_CallCredentials> get copyWith => __$CallCredentialsCopyWithImpl<_CallCredentials>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallCredentials&&(identical(other.url, url) || other.url == url)&&(identical(other.token, token) || other.token == token)&&(identical(other.room, room) || other.room == room)&&(identical(other.identity, identity) || other.identity == identity)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,url,token,room,identity,expiresAt);

@override
String toString() {
  return 'CallCredentials(url: $url, token: $token, room: $room, identity: $identity, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$CallCredentialsCopyWith<$Res> implements $CallCredentialsCopyWith<$Res> {
  factory _$CallCredentialsCopyWith(_CallCredentials value, $Res Function(_CallCredentials) _then) = __$CallCredentialsCopyWithImpl;
@override @useResult
$Res call({
 String url, String token, String room, String identity, DateTime? expiresAt
});




}
/// @nodoc
class __$CallCredentialsCopyWithImpl<$Res>
    implements _$CallCredentialsCopyWith<$Res> {
  __$CallCredentialsCopyWithImpl(this._self, this._then);

  final _CallCredentials _self;
  final $Res Function(_CallCredentials) _then;

/// Create a copy of CallCredentials
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? token = null,Object? room = null,Object? identity = null,Object? expiresAt = freezed,}) {
  return _then(_CallCredentials(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,room: null == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String,identity: null == identity ? _self.identity : identity // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
