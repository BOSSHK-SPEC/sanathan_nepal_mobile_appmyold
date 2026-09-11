// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventDetailsState {

/// The event being shown.
 LoadState<Event> get event;/// Deletion of the shown event – `Loaded` once it is gone (page pops).
 LoadState<void> get deletion;/// Failure of the last checklist toggle (snackbar); reset by the next
/// successful toggle.
 Failure? get actionFailure;
/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailsStateCopyWith<EventDetailsState> get copyWith => _$EventDetailsStateCopyWithImpl<EventDetailsState>(this as EventDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailsState&&(identical(other.event, event) || other.event == event)&&(identical(other.deletion, deletion) || other.deletion == deletion)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,event,deletion,actionFailure);

@override
String toString() {
  return 'EventDetailsState(event: $event, deletion: $deletion, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class $EventDetailsStateCopyWith<$Res>  {
  factory $EventDetailsStateCopyWith(EventDetailsState value, $Res Function(EventDetailsState) _then) = _$EventDetailsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Event> event, LoadState<void> deletion, Failure? actionFailure
});


$LoadStateCopyWith<Event, $Res> get event;$LoadStateCopyWith<void, $Res> get deletion;$FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class _$EventDetailsStateCopyWithImpl<$Res>
    implements $EventDetailsStateCopyWith<$Res> {
  _$EventDetailsStateCopyWithImpl(this._self, this._then);

  final EventDetailsState _self;
  final $Res Function(EventDetailsState) _then;

/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? deletion = null,Object? actionFailure = freezed,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LoadState<Event>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<void>,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Event, $Res> get event {
  
  return $LoadStateCopyWith<Event, $Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get deletion {
  
  return $LoadStateCopyWith<void, $Res>(_self.deletion, (value) {
    return _then(_self.copyWith(deletion: value));
  });
}/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}
}



/// @nodoc


class _EventDetailsState extends EventDetailsState {
  const _EventDetailsState({this.event = const LoadState.idle(), this.deletion = const LoadState.idle(), this.actionFailure}): super._();
  

/// The event being shown.
@override@JsonKey() final  LoadState<Event> event;
/// Deletion of the shown event – `Loaded` once it is gone (page pops).
@override@JsonKey() final  LoadState<void> deletion;
/// Failure of the last checklist toggle (snackbar); reset by the next
/// successful toggle.
@override final  Failure? actionFailure;

/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDetailsStateCopyWith<_EventDetailsState> get copyWith => __$EventDetailsStateCopyWithImpl<_EventDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDetailsState&&(identical(other.event, event) || other.event == event)&&(identical(other.deletion, deletion) || other.deletion == deletion)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,event,deletion,actionFailure);

@override
String toString() {
  return 'EventDetailsState(event: $event, deletion: $deletion, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class _$EventDetailsStateCopyWith<$Res> implements $EventDetailsStateCopyWith<$Res> {
  factory _$EventDetailsStateCopyWith(_EventDetailsState value, $Res Function(_EventDetailsState) _then) = __$EventDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Event> event, LoadState<void> deletion, Failure? actionFailure
});


@override $LoadStateCopyWith<Event, $Res> get event;@override $LoadStateCopyWith<void, $Res> get deletion;@override $FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class __$EventDetailsStateCopyWithImpl<$Res>
    implements _$EventDetailsStateCopyWith<$Res> {
  __$EventDetailsStateCopyWithImpl(this._self, this._then);

  final _EventDetailsState _self;
  final $Res Function(_EventDetailsState) _then;

/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? deletion = null,Object? actionFailure = freezed,}) {
  return _then(_EventDetailsState(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LoadState<Event>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<void>,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Event, $Res> get event {
  
  return $LoadStateCopyWith<Event, $Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get deletion {
  
  return $LoadStateCopyWith<void, $Res>(_self.deletion, (value) {
    return _then(_self.copyWith(deletion: value));
  });
}/// Create a copy of EventDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}
}

// dart format on
