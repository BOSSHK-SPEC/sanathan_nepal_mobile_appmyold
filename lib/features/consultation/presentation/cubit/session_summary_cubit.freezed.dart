// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_summary_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionSummaryState {

 LoadState<Consultation> get session; LoadState<SessionSummary> get summary;
/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSummaryStateCopyWith<SessionSummaryState> get copyWith => _$SessionSummaryStateCopyWithImpl<SessionSummaryState>(this as SessionSummaryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSummaryState&&(identical(other.session, session) || other.session == session)&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,session,summary);

@override
String toString() {
  return 'SessionSummaryState(session: $session, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $SessionSummaryStateCopyWith<$Res>  {
  factory $SessionSummaryStateCopyWith(SessionSummaryState value, $Res Function(SessionSummaryState) _then) = _$SessionSummaryStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Consultation> session, LoadState<SessionSummary> summary
});


$LoadStateCopyWith<Consultation, $Res> get session;$LoadStateCopyWith<SessionSummary, $Res> get summary;

}
/// @nodoc
class _$SessionSummaryStateCopyWithImpl<$Res>
    implements $SessionSummaryStateCopyWith<$Res> {
  _$SessionSummaryStateCopyWithImpl(this._self, this._then);

  final SessionSummaryState _self;
  final $Res Function(SessionSummaryState) _then;

/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? summary = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LoadState<SessionSummary>,
  ));
}
/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get session {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SessionSummary, $Res> get summary {
  
  return $LoadStateCopyWith<SessionSummary, $Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}



/// @nodoc


class _SessionSummaryState extends SessionSummaryState {
  const _SessionSummaryState({this.session = const LoadState.idle(), this.summary = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<Consultation> session;
@override@JsonKey() final  LoadState<SessionSummary> summary;

/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionSummaryStateCopyWith<_SessionSummaryState> get copyWith => __$SessionSummaryStateCopyWithImpl<_SessionSummaryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionSummaryState&&(identical(other.session, session) || other.session == session)&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,session,summary);

@override
String toString() {
  return 'SessionSummaryState(session: $session, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$SessionSummaryStateCopyWith<$Res> implements $SessionSummaryStateCopyWith<$Res> {
  factory _$SessionSummaryStateCopyWith(_SessionSummaryState value, $Res Function(_SessionSummaryState) _then) = __$SessionSummaryStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Consultation> session, LoadState<SessionSummary> summary
});


@override $LoadStateCopyWith<Consultation, $Res> get session;@override $LoadStateCopyWith<SessionSummary, $Res> get summary;

}
/// @nodoc
class __$SessionSummaryStateCopyWithImpl<$Res>
    implements _$SessionSummaryStateCopyWith<$Res> {
  __$SessionSummaryStateCopyWithImpl(this._self, this._then);

  final _SessionSummaryState _self;
  final $Res Function(_SessionSummaryState) _then;

/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? summary = null,}) {
  return _then(_SessionSummaryState(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LoadState<SessionSummary>,
  ));
}

/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get session {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of SessionSummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SessionSummary, $Res> get summary {
  
  return $LoadStateCopyWith<SessionSummary, $Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
