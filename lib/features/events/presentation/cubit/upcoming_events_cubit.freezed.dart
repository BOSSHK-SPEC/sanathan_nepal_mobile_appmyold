// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upcoming_events_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpcomingEventsState {

/// Next few events for [scope] + chips.
 LoadState<List<Event>> get events; UpcomingScope get scope; bool get onlyHolidays; bool get onlyVrat;
/// Create a copy of UpcomingEventsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingEventsStateCopyWith<UpcomingEventsState> get copyWith => _$UpcomingEventsStateCopyWithImpl<UpcomingEventsState>(this as UpcomingEventsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingEventsState&&(identical(other.events, events) || other.events == events)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.onlyHolidays, onlyHolidays) || other.onlyHolidays == onlyHolidays)&&(identical(other.onlyVrat, onlyVrat) || other.onlyVrat == onlyVrat));
}


@override
int get hashCode => Object.hash(runtimeType,events,scope,onlyHolidays,onlyVrat);

@override
String toString() {
  return 'UpcomingEventsState(events: $events, scope: $scope, onlyHolidays: $onlyHolidays, onlyVrat: $onlyVrat)';
}


}

/// @nodoc
abstract mixin class $UpcomingEventsStateCopyWith<$Res>  {
  factory $UpcomingEventsStateCopyWith(UpcomingEventsState value, $Res Function(UpcomingEventsState) _then) = _$UpcomingEventsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<Event>> events, UpcomingScope scope, bool onlyHolidays, bool onlyVrat
});


$LoadStateCopyWith<List<Event>, $Res> get events;

}
/// @nodoc
class _$UpcomingEventsStateCopyWithImpl<$Res>
    implements $UpcomingEventsStateCopyWith<$Res> {
  _$UpcomingEventsStateCopyWithImpl(this._self, this._then);

  final UpcomingEventsState _self;
  final $Res Function(UpcomingEventsState) _then;

/// Create a copy of UpcomingEventsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,Object? scope = null,Object? onlyHolidays = null,Object? onlyVrat = null,}) {
  return _then(_self.copyWith(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as LoadState<List<Event>>,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as UpcomingScope,onlyHolidays: null == onlyHolidays ? _self.onlyHolidays : onlyHolidays // ignore: cast_nullable_to_non_nullable
as bool,onlyVrat: null == onlyVrat ? _self.onlyVrat : onlyVrat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of UpcomingEventsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Event>, $Res> get events {
  
  return $LoadStateCopyWith<List<Event>, $Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}
}



/// @nodoc


class _UpcomingEventsState extends UpcomingEventsState {
  const _UpcomingEventsState({this.events = const LoadState.idle(), this.scope = UpcomingScope.all, this.onlyHolidays = false, this.onlyVrat = false}): super._();
  

/// Next few events for [scope] + chips.
@override@JsonKey() final  LoadState<List<Event>> events;
@override@JsonKey() final  UpcomingScope scope;
@override@JsonKey() final  bool onlyHolidays;
@override@JsonKey() final  bool onlyVrat;

/// Create a copy of UpcomingEventsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingEventsStateCopyWith<_UpcomingEventsState> get copyWith => __$UpcomingEventsStateCopyWithImpl<_UpcomingEventsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingEventsState&&(identical(other.events, events) || other.events == events)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.onlyHolidays, onlyHolidays) || other.onlyHolidays == onlyHolidays)&&(identical(other.onlyVrat, onlyVrat) || other.onlyVrat == onlyVrat));
}


@override
int get hashCode => Object.hash(runtimeType,events,scope,onlyHolidays,onlyVrat);

@override
String toString() {
  return 'UpcomingEventsState(events: $events, scope: $scope, onlyHolidays: $onlyHolidays, onlyVrat: $onlyVrat)';
}


}

/// @nodoc
abstract mixin class _$UpcomingEventsStateCopyWith<$Res> implements $UpcomingEventsStateCopyWith<$Res> {
  factory _$UpcomingEventsStateCopyWith(_UpcomingEventsState value, $Res Function(_UpcomingEventsState) _then) = __$UpcomingEventsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<Event>> events, UpcomingScope scope, bool onlyHolidays, bool onlyVrat
});


@override $LoadStateCopyWith<List<Event>, $Res> get events;

}
/// @nodoc
class __$UpcomingEventsStateCopyWithImpl<$Res>
    implements _$UpcomingEventsStateCopyWith<$Res> {
  __$UpcomingEventsStateCopyWithImpl(this._self, this._then);

  final _UpcomingEventsState _self;
  final $Res Function(_UpcomingEventsState) _then;

/// Create a copy of UpcomingEventsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,Object? scope = null,Object? onlyHolidays = null,Object? onlyVrat = null,}) {
  return _then(_UpcomingEventsState(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as LoadState<List<Event>>,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as UpcomingScope,onlyHolidays: null == onlyHolidays ? _self.onlyHolidays : onlyHolidays // ignore: cast_nullable_to_non_nullable
as bool,onlyVrat: null == onlyVrat ? _self.onlyVrat : onlyVrat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of UpcomingEventsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Event>, $Res> get events {
  
  return $LoadStateCopyWith<List<Event>, $Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}
}

// dart format on
