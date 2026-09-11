// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventsListState {

/// Events matching [filter].
 LoadState<List<Event>> get events; EventGroup get group;/// Selected chip; `null` = "All".
 EventCategory? get category; bool get onlyImportant; bool get onlyHolidays; bool get onlyVrat;/// To-Do tab: chip that narrows the list to one to-do (`null` = "All").
 String? get focusedEventId;/// Failure of the last delete / checklist toggle (shown as a snackbar);
/// reset by the next successful action.
 Failure? get actionFailure;
/// Create a copy of EventsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventsListStateCopyWith<EventsListState> get copyWith => _$EventsListStateCopyWithImpl<EventsListState>(this as EventsListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventsListState&&(identical(other.events, events) || other.events == events)&&(identical(other.group, group) || other.group == group)&&(identical(other.category, category) || other.category == category)&&(identical(other.onlyImportant, onlyImportant) || other.onlyImportant == onlyImportant)&&(identical(other.onlyHolidays, onlyHolidays) || other.onlyHolidays == onlyHolidays)&&(identical(other.onlyVrat, onlyVrat) || other.onlyVrat == onlyVrat)&&(identical(other.focusedEventId, focusedEventId) || other.focusedEventId == focusedEventId)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,events,group,category,onlyImportant,onlyHolidays,onlyVrat,focusedEventId,actionFailure);

@override
String toString() {
  return 'EventsListState(events: $events, group: $group, category: $category, onlyImportant: $onlyImportant, onlyHolidays: $onlyHolidays, onlyVrat: $onlyVrat, focusedEventId: $focusedEventId, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class $EventsListStateCopyWith<$Res>  {
  factory $EventsListStateCopyWith(EventsListState value, $Res Function(EventsListState) _then) = _$EventsListStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<Event>> events, EventGroup group, EventCategory? category, bool onlyImportant, bool onlyHolidays, bool onlyVrat, String? focusedEventId, Failure? actionFailure
});


$LoadStateCopyWith<List<Event>, $Res> get events;$FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class _$EventsListStateCopyWithImpl<$Res>
    implements $EventsListStateCopyWith<$Res> {
  _$EventsListStateCopyWithImpl(this._self, this._then);

  final EventsListState _self;
  final $Res Function(EventsListState) _then;

/// Create a copy of EventsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,Object? group = null,Object? category = freezed,Object? onlyImportant = null,Object? onlyHolidays = null,Object? onlyVrat = null,Object? focusedEventId = freezed,Object? actionFailure = freezed,}) {
  return _then(_self.copyWith(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as LoadState<List<Event>>,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as EventGroup,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory?,onlyImportant: null == onlyImportant ? _self.onlyImportant : onlyImportant // ignore: cast_nullable_to_non_nullable
as bool,onlyHolidays: null == onlyHolidays ? _self.onlyHolidays : onlyHolidays // ignore: cast_nullable_to_non_nullable
as bool,onlyVrat: null == onlyVrat ? _self.onlyVrat : onlyVrat // ignore: cast_nullable_to_non_nullable
as bool,focusedEventId: freezed == focusedEventId ? _self.focusedEventId : focusedEventId // ignore: cast_nullable_to_non_nullable
as String?,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of EventsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Event>, $Res> get events {
  
  return $LoadStateCopyWith<List<Event>, $Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}/// Create a copy of EventsListState
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


class _EventsListState extends EventsListState {
  const _EventsListState({this.events = const LoadState.idle(), this.group = EventGroup.festival, this.category, this.onlyImportant = false, this.onlyHolidays = false, this.onlyVrat = false, this.focusedEventId, this.actionFailure}): super._();
  

/// Events matching [filter].
@override@JsonKey() final  LoadState<List<Event>> events;
@override@JsonKey() final  EventGroup group;
/// Selected chip; `null` = "All".
@override final  EventCategory? category;
@override@JsonKey() final  bool onlyImportant;
@override@JsonKey() final  bool onlyHolidays;
@override@JsonKey() final  bool onlyVrat;
/// To-Do tab: chip that narrows the list to one to-do (`null` = "All").
@override final  String? focusedEventId;
/// Failure of the last delete / checklist toggle (shown as a snackbar);
/// reset by the next successful action.
@override final  Failure? actionFailure;

/// Create a copy of EventsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventsListStateCopyWith<_EventsListState> get copyWith => __$EventsListStateCopyWithImpl<_EventsListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventsListState&&(identical(other.events, events) || other.events == events)&&(identical(other.group, group) || other.group == group)&&(identical(other.category, category) || other.category == category)&&(identical(other.onlyImportant, onlyImportant) || other.onlyImportant == onlyImportant)&&(identical(other.onlyHolidays, onlyHolidays) || other.onlyHolidays == onlyHolidays)&&(identical(other.onlyVrat, onlyVrat) || other.onlyVrat == onlyVrat)&&(identical(other.focusedEventId, focusedEventId) || other.focusedEventId == focusedEventId)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,events,group,category,onlyImportant,onlyHolidays,onlyVrat,focusedEventId,actionFailure);

@override
String toString() {
  return 'EventsListState(events: $events, group: $group, category: $category, onlyImportant: $onlyImportant, onlyHolidays: $onlyHolidays, onlyVrat: $onlyVrat, focusedEventId: $focusedEventId, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class _$EventsListStateCopyWith<$Res> implements $EventsListStateCopyWith<$Res> {
  factory _$EventsListStateCopyWith(_EventsListState value, $Res Function(_EventsListState) _then) = __$EventsListStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<Event>> events, EventGroup group, EventCategory? category, bool onlyImportant, bool onlyHolidays, bool onlyVrat, String? focusedEventId, Failure? actionFailure
});


@override $LoadStateCopyWith<List<Event>, $Res> get events;@override $FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class __$EventsListStateCopyWithImpl<$Res>
    implements _$EventsListStateCopyWith<$Res> {
  __$EventsListStateCopyWithImpl(this._self, this._then);

  final _EventsListState _self;
  final $Res Function(_EventsListState) _then;

/// Create a copy of EventsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,Object? group = null,Object? category = freezed,Object? onlyImportant = null,Object? onlyHolidays = null,Object? onlyVrat = null,Object? focusedEventId = freezed,Object? actionFailure = freezed,}) {
  return _then(_EventsListState(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as LoadState<List<Event>>,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as EventGroup,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory?,onlyImportant: null == onlyImportant ? _self.onlyImportant : onlyImportant // ignore: cast_nullable_to_non_nullable
as bool,onlyHolidays: null == onlyHolidays ? _self.onlyHolidays : onlyHolidays // ignore: cast_nullable_to_non_nullable
as bool,onlyVrat: null == onlyVrat ? _self.onlyVrat : onlyVrat // ignore: cast_nullable_to_non_nullable
as bool,focusedEventId: freezed == focusedEventId ? _self.focusedEventId : focusedEventId // ignore: cast_nullable_to_non_nullable
as String?,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of EventsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Event>, $Res> get events {
  
  return $LoadStateCopyWith<List<Event>, $Res>(_self.events, (value) {
    return _then(_self.copyWith(events: value));
  });
}/// Create a copy of EventsListState
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
