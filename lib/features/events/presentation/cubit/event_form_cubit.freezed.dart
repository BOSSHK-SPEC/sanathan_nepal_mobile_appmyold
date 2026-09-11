// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventFormState {

 DateTime get date;/// `null` when creating a new event.
 String? get editingId; EventGroup get group; EventCategory get category; String get title; String get description; String get location; DateDisplayMode get dateMode; EventTime? get time; bool get repeats; EventRepeat get repeat; List<ChecklistItem> get checklist; bool get reminderEnabled; int get reminderDays; EventTime get reminderTime;/// `true` after a submit attempt with an empty title.
 bool get titleMissing;/// Persisting the form: `loading` while saving, `loaded` with the stored
/// event once done, `failed` when create / update failed.
 LoadState<Event> get saved;
/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventFormStateCopyWith<EventFormState> get copyWith => _$EventFormStateCopyWithImpl<EventFormState>(this as EventFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventFormState&&(identical(other.date, date) || other.date == date)&&(identical(other.editingId, editingId) || other.editingId == editingId)&&(identical(other.group, group) || other.group == group)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.dateMode, dateMode) || other.dateMode == dateMode)&&(identical(other.time, time) || other.time == time)&&(identical(other.repeats, repeats) || other.repeats == repeats)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&(identical(other.reminderEnabled, reminderEnabled) || other.reminderEnabled == reminderEnabled)&&(identical(other.reminderDays, reminderDays) || other.reminderDays == reminderDays)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.titleMissing, titleMissing) || other.titleMissing == titleMissing)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode => Object.hash(runtimeType,date,editingId,group,category,title,description,location,dateMode,time,repeats,repeat,const DeepCollectionEquality().hash(checklist),reminderEnabled,reminderDays,reminderTime,titleMissing,saved);

@override
String toString() {
  return 'EventFormState(date: $date, editingId: $editingId, group: $group, category: $category, title: $title, description: $description, location: $location, dateMode: $dateMode, time: $time, repeats: $repeats, repeat: $repeat, checklist: $checklist, reminderEnabled: $reminderEnabled, reminderDays: $reminderDays, reminderTime: $reminderTime, titleMissing: $titleMissing, saved: $saved)';
}


}

/// @nodoc
abstract mixin class $EventFormStateCopyWith<$Res>  {
  factory $EventFormStateCopyWith(EventFormState value, $Res Function(EventFormState) _then) = _$EventFormStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, String? editingId, EventGroup group, EventCategory category, String title, String description, String location, DateDisplayMode dateMode, EventTime? time, bool repeats, EventRepeat repeat, List<ChecklistItem> checklist, bool reminderEnabled, int reminderDays, EventTime reminderTime, bool titleMissing, LoadState<Event> saved
});


$EventTimeCopyWith<$Res>? get time;$EventTimeCopyWith<$Res> get reminderTime;$LoadStateCopyWith<Event, $Res> get saved;

}
/// @nodoc
class _$EventFormStateCopyWithImpl<$Res>
    implements $EventFormStateCopyWith<$Res> {
  _$EventFormStateCopyWithImpl(this._self, this._then);

  final EventFormState _self;
  final $Res Function(EventFormState) _then;

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? editingId = freezed,Object? group = null,Object? category = null,Object? title = null,Object? description = null,Object? location = null,Object? dateMode = null,Object? time = freezed,Object? repeats = null,Object? repeat = null,Object? checklist = null,Object? reminderEnabled = null,Object? reminderDays = null,Object? reminderTime = null,Object? titleMissing = null,Object? saved = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,editingId: freezed == editingId ? _self.editingId : editingId // ignore: cast_nullable_to_non_nullable
as String?,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as EventGroup,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dateMode: null == dateMode ? _self.dateMode : dateMode // ignore: cast_nullable_to_non_nullable
as DateDisplayMode,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTime?,repeats: null == repeats ? _self.repeats : repeats // ignore: cast_nullable_to_non_nullable
as bool,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as EventRepeat,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,reminderEnabled: null == reminderEnabled ? _self.reminderEnabled : reminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderDays: null == reminderDays ? _self.reminderDays : reminderDays // ignore: cast_nullable_to_non_nullable
as int,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as EventTime,titleMissing: null == titleMissing ? _self.titleMissing : titleMissing // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as LoadState<Event>,
  ));
}
/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeCopyWith<$Res>? get time {
    if (_self.time == null) {
    return null;
  }

  return $EventTimeCopyWith<$Res>(_self.time!, (value) {
    return _then(_self.copyWith(time: value));
  });
}/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeCopyWith<$Res> get reminderTime {
  
  return $EventTimeCopyWith<$Res>(_self.reminderTime, (value) {
    return _then(_self.copyWith(reminderTime: value));
  });
}/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Event, $Res> get saved {
  
  return $LoadStateCopyWith<Event, $Res>(_self.saved, (value) {
    return _then(_self.copyWith(saved: value));
  });
}
}



/// @nodoc


class _EventFormState extends EventFormState {
  const _EventFormState({required this.date, this.editingId, this.group = EventGroup.personal, this.category = EventCategory.personal, this.title = '', this.description = '', this.location = '', this.dateMode = DateDisplayMode.bs, this.time, this.repeats = false, this.repeat = EventRepeat.yearly, final  List<ChecklistItem> checklist = const [], this.reminderEnabled = true, this.reminderDays = 1, this.reminderTime = const EventTime(hour: 0, minute: 0), this.titleMissing = false, this.saved = const LoadState.idle()}): _checklist = checklist,super._();
  

@override final  DateTime date;
/// `null` when creating a new event.
@override final  String? editingId;
@override@JsonKey() final  EventGroup group;
@override@JsonKey() final  EventCategory category;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String location;
@override@JsonKey() final  DateDisplayMode dateMode;
@override final  EventTime? time;
@override@JsonKey() final  bool repeats;
@override@JsonKey() final  EventRepeat repeat;
 final  List<ChecklistItem> _checklist;
@override@JsonKey() List<ChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

@override@JsonKey() final  bool reminderEnabled;
@override@JsonKey() final  int reminderDays;
@override@JsonKey() final  EventTime reminderTime;
/// `true` after a submit attempt with an empty title.
@override@JsonKey() final  bool titleMissing;
/// Persisting the form: `loading` while saving, `loaded` with the stored
/// event once done, `failed` when create / update failed.
@override@JsonKey() final  LoadState<Event> saved;

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventFormStateCopyWith<_EventFormState> get copyWith => __$EventFormStateCopyWithImpl<_EventFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventFormState&&(identical(other.date, date) || other.date == date)&&(identical(other.editingId, editingId) || other.editingId == editingId)&&(identical(other.group, group) || other.group == group)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.dateMode, dateMode) || other.dateMode == dateMode)&&(identical(other.time, time) || other.time == time)&&(identical(other.repeats, repeats) || other.repeats == repeats)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&(identical(other.reminderEnabled, reminderEnabled) || other.reminderEnabled == reminderEnabled)&&(identical(other.reminderDays, reminderDays) || other.reminderDays == reminderDays)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.titleMissing, titleMissing) || other.titleMissing == titleMissing)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode => Object.hash(runtimeType,date,editingId,group,category,title,description,location,dateMode,time,repeats,repeat,const DeepCollectionEquality().hash(_checklist),reminderEnabled,reminderDays,reminderTime,titleMissing,saved);

@override
String toString() {
  return 'EventFormState(date: $date, editingId: $editingId, group: $group, category: $category, title: $title, description: $description, location: $location, dateMode: $dateMode, time: $time, repeats: $repeats, repeat: $repeat, checklist: $checklist, reminderEnabled: $reminderEnabled, reminderDays: $reminderDays, reminderTime: $reminderTime, titleMissing: $titleMissing, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$EventFormStateCopyWith<$Res> implements $EventFormStateCopyWith<$Res> {
  factory _$EventFormStateCopyWith(_EventFormState value, $Res Function(_EventFormState) _then) = __$EventFormStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String? editingId, EventGroup group, EventCategory category, String title, String description, String location, DateDisplayMode dateMode, EventTime? time, bool repeats, EventRepeat repeat, List<ChecklistItem> checklist, bool reminderEnabled, int reminderDays, EventTime reminderTime, bool titleMissing, LoadState<Event> saved
});


@override $EventTimeCopyWith<$Res>? get time;@override $EventTimeCopyWith<$Res> get reminderTime;@override $LoadStateCopyWith<Event, $Res> get saved;

}
/// @nodoc
class __$EventFormStateCopyWithImpl<$Res>
    implements _$EventFormStateCopyWith<$Res> {
  __$EventFormStateCopyWithImpl(this._self, this._then);

  final _EventFormState _self;
  final $Res Function(_EventFormState) _then;

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? editingId = freezed,Object? group = null,Object? category = null,Object? title = null,Object? description = null,Object? location = null,Object? dateMode = null,Object? time = freezed,Object? repeats = null,Object? repeat = null,Object? checklist = null,Object? reminderEnabled = null,Object? reminderDays = null,Object? reminderTime = null,Object? titleMissing = null,Object? saved = null,}) {
  return _then(_EventFormState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,editingId: freezed == editingId ? _self.editingId : editingId // ignore: cast_nullable_to_non_nullable
as String?,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as EventGroup,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,dateMode: null == dateMode ? _self.dateMode : dateMode // ignore: cast_nullable_to_non_nullable
as DateDisplayMode,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTime?,repeats: null == repeats ? _self.repeats : repeats // ignore: cast_nullable_to_non_nullable
as bool,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as EventRepeat,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,reminderEnabled: null == reminderEnabled ? _self.reminderEnabled : reminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderDays: null == reminderDays ? _self.reminderDays : reminderDays // ignore: cast_nullable_to_non_nullable
as int,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as EventTime,titleMissing: null == titleMissing ? _self.titleMissing : titleMissing // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as LoadState<Event>,
  ));
}

/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeCopyWith<$Res>? get time {
    if (_self.time == null) {
    return null;
  }

  return $EventTimeCopyWith<$Res>(_self.time!, (value) {
    return _then(_self.copyWith(time: value));
  });
}/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeCopyWith<$Res> get reminderTime {
  
  return $EventTimeCopyWith<$Res>(_self.reminderTime, (value) {
    return _then(_self.copyWith(reminderTime: value));
  });
}/// Create a copy of EventFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Event, $Res> get saved {
  
  return $LoadStateCopyWith<Event, $Res>(_self.saved, (value) {
    return _then(_self.copyWith(saved: value));
  });
}
}

// dart format on
