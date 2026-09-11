// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consultation_history_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsultationHistoryState {

 LoadState<List<Consultation>> get sessions;
/// Create a copy of ConsultationHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsultationHistoryStateCopyWith<ConsultationHistoryState> get copyWith => _$ConsultationHistoryStateCopyWithImpl<ConsultationHistoryState>(this as ConsultationHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsultationHistoryState&&(identical(other.sessions, sessions) || other.sessions == sessions));
}


@override
int get hashCode => Object.hash(runtimeType,sessions);

@override
String toString() {
  return 'ConsultationHistoryState(sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class $ConsultationHistoryStateCopyWith<$Res>  {
  factory $ConsultationHistoryStateCopyWith(ConsultationHistoryState value, $Res Function(ConsultationHistoryState) _then) = _$ConsultationHistoryStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<Consultation>> sessions
});


$LoadStateCopyWith<List<Consultation>, $Res> get sessions;

}
/// @nodoc
class _$ConsultationHistoryStateCopyWithImpl<$Res>
    implements $ConsultationHistoryStateCopyWith<$Res> {
  _$ConsultationHistoryStateCopyWithImpl(this._self, this._then);

  final ConsultationHistoryState _self;
  final $Res Function(ConsultationHistoryState) _then;

/// Create a copy of ConsultationHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessions = null,}) {
  return _then(_self.copyWith(
sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as LoadState<List<Consultation>>,
  ));
}
/// Create a copy of ConsultationHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Consultation>, $Res> get sessions {
  
  return $LoadStateCopyWith<List<Consultation>, $Res>(_self.sessions, (value) {
    return _then(_self.copyWith(sessions: value));
  });
}
}



/// @nodoc


class _ConsultationHistoryState extends ConsultationHistoryState {
  const _ConsultationHistoryState({this.sessions = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<Consultation>> sessions;

/// Create a copy of ConsultationHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsultationHistoryStateCopyWith<_ConsultationHistoryState> get copyWith => __$ConsultationHistoryStateCopyWithImpl<_ConsultationHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsultationHistoryState&&(identical(other.sessions, sessions) || other.sessions == sessions));
}


@override
int get hashCode => Object.hash(runtimeType,sessions);

@override
String toString() {
  return 'ConsultationHistoryState(sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class _$ConsultationHistoryStateCopyWith<$Res> implements $ConsultationHistoryStateCopyWith<$Res> {
  factory _$ConsultationHistoryStateCopyWith(_ConsultationHistoryState value, $Res Function(_ConsultationHistoryState) _then) = __$ConsultationHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<Consultation>> sessions
});


@override $LoadStateCopyWith<List<Consultation>, $Res> get sessions;

}
/// @nodoc
class __$ConsultationHistoryStateCopyWithImpl<$Res>
    implements _$ConsultationHistoryStateCopyWith<$Res> {
  __$ConsultationHistoryStateCopyWithImpl(this._self, this._then);

  final _ConsultationHistoryState _self;
  final $Res Function(_ConsultationHistoryState) _then;

/// Create a copy of ConsultationHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessions = null,}) {
  return _then(_ConsultationHistoryState(
sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as LoadState<List<Consultation>>,
  ));
}

/// Create a copy of ConsultationHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Consultation>, $Res> get sessions {
  
  return $LoadStateCopyWith<List<Consultation>, $Res>(_self.sessions, (value) {
    return _then(_self.copyWith(sessions: value));
  });
}
}

// dart format on
