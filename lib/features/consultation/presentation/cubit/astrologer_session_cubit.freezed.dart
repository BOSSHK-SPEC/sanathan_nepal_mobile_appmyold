// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerSessionState {

 LoadState<Consultation> get session; LoadState<List<ChatMessage>> get messages; LoadState<Consultation> get ending; LoadState<SessionSummary> get savingNotes; int get tick; String get draft;/// Local call controls. No media stack yet, so these only drive the UI;
/// they are here rather than in the widget so state survives a rebuild
/// and a rotation mid-call.
 bool get muted; bool get speakerOn; bool get cameraOn; String get notes; List<Remedy> get remedies;
/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerSessionStateCopyWith<AstrologerSessionState> get copyWith => _$AstrologerSessionStateCopyWithImpl<AstrologerSessionState>(this as AstrologerSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerSessionState&&(identical(other.session, session) || other.session == session)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.ending, ending) || other.ending == ending)&&(identical(other.savingNotes, savingNotes) || other.savingNotes == savingNotes)&&(identical(other.tick, tick) || other.tick == tick)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.speakerOn, speakerOn) || other.speakerOn == speakerOn)&&(identical(other.cameraOn, cameraOn) || other.cameraOn == cameraOn)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.remedies, remedies));
}


@override
int get hashCode => Object.hash(runtimeType,session,messages,ending,savingNotes,tick,draft,muted,speakerOn,cameraOn,notes,const DeepCollectionEquality().hash(remedies));

@override
String toString() {
  return 'AstrologerSessionState(session: $session, messages: $messages, ending: $ending, savingNotes: $savingNotes, tick: $tick, draft: $draft, muted: $muted, speakerOn: $speakerOn, cameraOn: $cameraOn, notes: $notes, remedies: $remedies)';
}


}

/// @nodoc
abstract mixin class $AstrologerSessionStateCopyWith<$Res>  {
  factory $AstrologerSessionStateCopyWith(AstrologerSessionState value, $Res Function(AstrologerSessionState) _then) = _$AstrologerSessionStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Consultation> session, LoadState<List<ChatMessage>> messages, LoadState<Consultation> ending, LoadState<SessionSummary> savingNotes, int tick, String draft, bool muted, bool speakerOn, bool cameraOn, String notes, List<Remedy> remedies
});


$LoadStateCopyWith<Consultation, $Res> get session;$LoadStateCopyWith<List<ChatMessage>, $Res> get messages;$LoadStateCopyWith<Consultation, $Res> get ending;$LoadStateCopyWith<SessionSummary, $Res> get savingNotes;

}
/// @nodoc
class _$AstrologerSessionStateCopyWithImpl<$Res>
    implements $AstrologerSessionStateCopyWith<$Res> {
  _$AstrologerSessionStateCopyWithImpl(this._self, this._then);

  final AstrologerSessionState _self;
  final $Res Function(AstrologerSessionState) _then;

/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? messages = null,Object? ending = null,Object? savingNotes = null,Object? tick = null,Object? draft = null,Object? muted = null,Object? speakerOn = null,Object? cameraOn = null,Object? notes = null,Object? remedies = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as LoadState<List<ChatMessage>>,ending: null == ending ? _self.ending : ending // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,savingNotes: null == savingNotes ? _self.savingNotes : savingNotes // ignore: cast_nullable_to_non_nullable
as LoadState<SessionSummary>,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as String,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,speakerOn: null == speakerOn ? _self.speakerOn : speakerOn // ignore: cast_nullable_to_non_nullable
as bool,cameraOn: null == cameraOn ? _self.cameraOn : cameraOn // ignore: cast_nullable_to_non_nullable
as bool,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self.remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,
  ));
}
/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get session {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ChatMessage>, $Res> get messages {
  
  return $LoadStateCopyWith<List<ChatMessage>, $Res>(_self.messages, (value) {
    return _then(_self.copyWith(messages: value));
  });
}/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get ending {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.ending, (value) {
    return _then(_self.copyWith(ending: value));
  });
}/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SessionSummary, $Res> get savingNotes {
  
  return $LoadStateCopyWith<SessionSummary, $Res>(_self.savingNotes, (value) {
    return _then(_self.copyWith(savingNotes: value));
  });
}
}



/// @nodoc


class _AstrologerSessionState extends AstrologerSessionState {
  const _AstrologerSessionState({this.session = const LoadState.idle(), this.messages = const LoadState.idle(), this.ending = const LoadState.idle(), this.savingNotes = const LoadState.idle(), this.tick = 0, this.draft = '', this.muted = false, this.speakerOn = true, this.cameraOn = true, this.notes = '', final  List<Remedy> remedies = const <Remedy>[]}): _remedies = remedies,super._();
  

@override@JsonKey() final  LoadState<Consultation> session;
@override@JsonKey() final  LoadState<List<ChatMessage>> messages;
@override@JsonKey() final  LoadState<Consultation> ending;
@override@JsonKey() final  LoadState<SessionSummary> savingNotes;
@override@JsonKey() final  int tick;
@override@JsonKey() final  String draft;
/// Local call controls. No media stack yet, so these only drive the UI;
/// they are here rather than in the widget so state survives a rebuild
/// and a rotation mid-call.
@override@JsonKey() final  bool muted;
@override@JsonKey() final  bool speakerOn;
@override@JsonKey() final  bool cameraOn;
@override@JsonKey() final  String notes;
 final  List<Remedy> _remedies;
@override@JsonKey() List<Remedy> get remedies {
  if (_remedies is EqualUnmodifiableListView) return _remedies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_remedies);
}


/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerSessionStateCopyWith<_AstrologerSessionState> get copyWith => __$AstrologerSessionStateCopyWithImpl<_AstrologerSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerSessionState&&(identical(other.session, session) || other.session == session)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.ending, ending) || other.ending == ending)&&(identical(other.savingNotes, savingNotes) || other.savingNotes == savingNotes)&&(identical(other.tick, tick) || other.tick == tick)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.speakerOn, speakerOn) || other.speakerOn == speakerOn)&&(identical(other.cameraOn, cameraOn) || other.cameraOn == cameraOn)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._remedies, _remedies));
}


@override
int get hashCode => Object.hash(runtimeType,session,messages,ending,savingNotes,tick,draft,muted,speakerOn,cameraOn,notes,const DeepCollectionEquality().hash(_remedies));

@override
String toString() {
  return 'AstrologerSessionState(session: $session, messages: $messages, ending: $ending, savingNotes: $savingNotes, tick: $tick, draft: $draft, muted: $muted, speakerOn: $speakerOn, cameraOn: $cameraOn, notes: $notes, remedies: $remedies)';
}


}

/// @nodoc
abstract mixin class _$AstrologerSessionStateCopyWith<$Res> implements $AstrologerSessionStateCopyWith<$Res> {
  factory _$AstrologerSessionStateCopyWith(_AstrologerSessionState value, $Res Function(_AstrologerSessionState) _then) = __$AstrologerSessionStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Consultation> session, LoadState<List<ChatMessage>> messages, LoadState<Consultation> ending, LoadState<SessionSummary> savingNotes, int tick, String draft, bool muted, bool speakerOn, bool cameraOn, String notes, List<Remedy> remedies
});


@override $LoadStateCopyWith<Consultation, $Res> get session;@override $LoadStateCopyWith<List<ChatMessage>, $Res> get messages;@override $LoadStateCopyWith<Consultation, $Res> get ending;@override $LoadStateCopyWith<SessionSummary, $Res> get savingNotes;

}
/// @nodoc
class __$AstrologerSessionStateCopyWithImpl<$Res>
    implements _$AstrologerSessionStateCopyWith<$Res> {
  __$AstrologerSessionStateCopyWithImpl(this._self, this._then);

  final _AstrologerSessionState _self;
  final $Res Function(_AstrologerSessionState) _then;

/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? messages = null,Object? ending = null,Object? savingNotes = null,Object? tick = null,Object? draft = null,Object? muted = null,Object? speakerOn = null,Object? cameraOn = null,Object? notes = null,Object? remedies = null,}) {
  return _then(_AstrologerSessionState(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as LoadState<List<ChatMessage>>,ending: null == ending ? _self.ending : ending // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,savingNotes: null == savingNotes ? _self.savingNotes : savingNotes // ignore: cast_nullable_to_non_nullable
as LoadState<SessionSummary>,tick: null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as String,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,speakerOn: null == speakerOn ? _self.speakerOn : speakerOn // ignore: cast_nullable_to_non_nullable
as bool,cameraOn: null == cameraOn ? _self.cameraOn : cameraOn // ignore: cast_nullable_to_non_nullable
as bool,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self._remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,
  ));
}

/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get session {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ChatMessage>, $Res> get messages {
  
  return $LoadStateCopyWith<List<ChatMessage>, $Res>(_self.messages, (value) {
    return _then(_self.copyWith(messages: value));
  });
}/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get ending {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.ending, (value) {
    return _then(_self.copyWith(ending: value));
  });
}/// Create a copy of AstrologerSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SessionSummary, $Res> get savingNotes {
  
  return $LoadStateCopyWith<SessionSummary, $Res>(_self.savingNotes, (value) {
    return _then(_self.copyWith(savingNotes: value));
  });
}
}

// dart format on
