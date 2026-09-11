// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveSessionState {

 LoadState<Consultation> get session; LoadState<List<ChatMessage>> get messages; LoadState<Consultation> get ending;/// Spendable wallet balance, refreshed when the session loads.
 double get balance;/// Incremented once a second while active, purely to drive the meter's
/// rebuild — the elapsed time itself is derived from timestamps.
 int get tick; String get draft; bool get muted; bool get speakerOn; bool get cameraOn;
/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveSessionStateCopyWith<LiveSessionState> get copyWith => _$LiveSessionStateCopyWithImpl<LiveSessionState>(this as LiveSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveSessionState&&(identical(other.session, session) || other.session == session)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.ending, ending) || other.ending == ending)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.tick, tick) || other.tick == tick)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.speakerOn, speakerOn) || other.speakerOn == speakerOn)&&(identical(other.cameraOn, cameraOn) || other.cameraOn == cameraOn));
}


@override
int get hashCode => Object.hash(runtimeType,session,messages,ending,balance,tick,draft,muted,speakerOn,cameraOn);

@override
String toString() {
  return 'LiveSessionState(session: $session, messages: $messages, ending: $ending, balance: $balance, tick: $tick, draft: $draft, muted: $muted, speakerOn: $speakerOn, cameraOn: $cameraOn)';
}


}

/// @nodoc
abstract mixin class $LiveSessionStateCopyWith<$Res>  {
  factory $LiveSessionStateCopyWith(LiveSessionState value, $Res Function(LiveSessionState) _then) = _$LiveSessionStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Consultation> session, LoadState<List<ChatMessage>> messages, LoadState<Consultation> ending, double balance, int tick, String draft, bool muted, bool speakerOn, bool cameraOn
});


$LoadStateCopyWith<Consultation, $Res> get session;$LoadStateCopyWith<List<ChatMessage>, $Res> get messages;$LoadStateCopyWith<Consultation, $Res> get ending;

}
/// @nodoc
class _$LiveSessionStateCopyWithImpl<$Res>
    implements $LiveSessionStateCopyWith<$Res> {
  _$LiveSessionStateCopyWithImpl(this._self, this._then);

  final LiveSessionState _self;
  final $Res Function(LiveSessionState) _then;

/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? messages = null,Object? ending = null,Object? balance = null,Object? tick = null,Object? draft = null,Object? muted = null,Object? speakerOn = null,Object? cameraOn = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as LoadState<List<ChatMessage>>,ending: null == ending ? _self.ending : ending // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as String,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,speakerOn: null == speakerOn ? _self.speakerOn : speakerOn // ignore: cast_nullable_to_non_nullable
as bool,cameraOn: null == cameraOn ? _self.cameraOn : cameraOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get session {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ChatMessage>, $Res> get messages {
  
  return $LoadStateCopyWith<List<ChatMessage>, $Res>(_self.messages, (value) {
    return _then(_self.copyWith(messages: value));
  });
}/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get ending {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.ending, (value) {
    return _then(_self.copyWith(ending: value));
  });
}
}



/// @nodoc


class _LiveSessionState extends LiveSessionState {
  const _LiveSessionState({this.session = const LoadState.idle(), this.messages = const LoadState.idle(), this.ending = const LoadState.idle(), this.balance = 0, this.tick = 0, this.draft = '', this.muted = false, this.speakerOn = true, this.cameraOn = true}): super._();
  

@override@JsonKey() final  LoadState<Consultation> session;
@override@JsonKey() final  LoadState<List<ChatMessage>> messages;
@override@JsonKey() final  LoadState<Consultation> ending;
/// Spendable wallet balance, refreshed when the session loads.
@override@JsonKey() final  double balance;
/// Incremented once a second while active, purely to drive the meter's
/// rebuild — the elapsed time itself is derived from timestamps.
@override@JsonKey() final  int tick;
@override@JsonKey() final  String draft;
@override@JsonKey() final  bool muted;
@override@JsonKey() final  bool speakerOn;
@override@JsonKey() final  bool cameraOn;

/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveSessionStateCopyWith<_LiveSessionState> get copyWith => __$LiveSessionStateCopyWithImpl<_LiveSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveSessionState&&(identical(other.session, session) || other.session == session)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.ending, ending) || other.ending == ending)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.tick, tick) || other.tick == tick)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.speakerOn, speakerOn) || other.speakerOn == speakerOn)&&(identical(other.cameraOn, cameraOn) || other.cameraOn == cameraOn));
}


@override
int get hashCode => Object.hash(runtimeType,session,messages,ending,balance,tick,draft,muted,speakerOn,cameraOn);

@override
String toString() {
  return 'LiveSessionState(session: $session, messages: $messages, ending: $ending, balance: $balance, tick: $tick, draft: $draft, muted: $muted, speakerOn: $speakerOn, cameraOn: $cameraOn)';
}


}

/// @nodoc
abstract mixin class _$LiveSessionStateCopyWith<$Res> implements $LiveSessionStateCopyWith<$Res> {
  factory _$LiveSessionStateCopyWith(_LiveSessionState value, $Res Function(_LiveSessionState) _then) = __$LiveSessionStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Consultation> session, LoadState<List<ChatMessage>> messages, LoadState<Consultation> ending, double balance, int tick, String draft, bool muted, bool speakerOn, bool cameraOn
});


@override $LoadStateCopyWith<Consultation, $Res> get session;@override $LoadStateCopyWith<List<ChatMessage>, $Res> get messages;@override $LoadStateCopyWith<Consultation, $Res> get ending;

}
/// @nodoc
class __$LiveSessionStateCopyWithImpl<$Res>
    implements _$LiveSessionStateCopyWith<$Res> {
  __$LiveSessionStateCopyWithImpl(this._self, this._then);

  final _LiveSessionState _self;
  final $Res Function(_LiveSessionState) _then;

/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? messages = null,Object? ending = null,Object? balance = null,Object? tick = null,Object? draft = null,Object? muted = null,Object? speakerOn = null,Object? cameraOn = null,}) {
  return _then(_LiveSessionState(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as LoadState<List<ChatMessage>>,ending: null == ending ? _self.ending : ending // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as String,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,speakerOn: null == speakerOn ? _self.speakerOn : speakerOn // ignore: cast_nullable_to_non_nullable
as bool,cameraOn: null == cameraOn ? _self.cameraOn : cameraOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get session {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ChatMessage>, $Res> get messages {
  
  return $LoadStateCopyWith<List<ChatMessage>, $Res>(_self.messages, (value) {
    return _then(_self.copyWith(messages: value));
  });
}/// Create a copy of LiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get ending {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.ending, (value) {
    return _then(_self.copyWith(ending: value));
  });
}
}

// dart format on
