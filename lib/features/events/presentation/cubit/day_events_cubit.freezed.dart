// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_events_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DayEventsState {

/// Civil day (local midnight) the list belongs to.
 DateTime get date; LoadState<List<Event>> get events;/// Failure of the last checklist toggle (shown as a snackbar).
 Failure? get actionFailure;
/// Create a copy of DayEventsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayEventsStateCopyWith<DayEventsState> get copyWith => _$DayEventsStateCopyWithImpl<DayEventsState>(this as DayEventsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayEventsState&&(identical(other.date, date) || other.date == date)&&(identical(other.events, events) || other.events == events)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,date,events,actionFailure);

@override
String toString() {
  return 'DayEventsState(date: $date, events: $events, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class $DayEventsStateCopyWith<$Res>  {
  factory $DayEventsStateCopyWith(DayEventsState value, $Res Function(DayEventsState) _then) = _$DayEventsStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, LoadState<List<Event>> events, Failure? actionFailure
});


$LoadStateCopyWith<List<Event>, $Res> get events;$FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class _$DayEventsStateCopyWithImpl<$Res>
    implements $DayEventsStateCopyWith<$Res> {
  _$DayEventsStateCopyWithImpl(this._self, this._then);

  final DayEventsState _self;
  final $Res Function(DayEventsState) _then;

/// Create a copy of DayEventsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? events = null,Object? actionFailure = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as LoadState<List<Event>>,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of DayEventsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Event>, $Res> get events {
  
  return $LoadStateCopyWith<List<Event>, $Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}/// Create a copy of DayEventsState
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


class _DayEventsState extends DayEventsState {
  const _DayEventsState({required this.date, this.events = const LoadState.idle(), this.actionFailure}): super._();
  

/// Civil day (local midnight) the list belongs to.
@override final  DateTime date;
@override@JsonKey() final  LoadState<List<Event>> events;
/// Failure of the last checklist toggle (shown as a snackbar).
@override final  Failure? actionFailure;

/// Create a copy of DayEventsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayEventsStateCopyWith<_DayEventsState> get copyWith => __$DayEventsStateCopyWithImpl<_DayEventsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayEventsState&&(identical(other.date, date) || other.date == date)&&(identical(other.events, events) || other.events == events)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,date,events,actionFailure);

@override
String toString() {
  return 'DayEventsState(date: $date, events: $events, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class _$DayEventsStateCopyWith<$Res> implements $DayEventsStateCopyWith<$Res> {
  factory _$DayEventsStateCopyWith(_DayEventsState value, $Res Function(_DayEventsState) _then) = __$DayEventsStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, LoadState<List<Event>> events, Failure? actionFailure
});


@override $LoadStateCopyWith<List<Event>, $Res> get events;@override $FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class __$DayEventsStateCopyWithImpl<$Res>
    implements _$DayEventsStateCopyWith<$Res> {
  __$DayEventsStateCopyWithImpl(this._self, this._then);

  final _DayEventsState _self;
  final $Res Function(_DayEventsState) _then;

/// Create a copy of DayEventsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? events = null,Object? actionFailure = freezed,}) {
  return _then(_DayEventsState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as LoadState<List<Event>>,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of DayEventsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Event>, $Res> get events {
  
  return $LoadStateCopyWith<List<Event>, $Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}/// Create a copy of DayEventsState
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
