// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalizedText {

 String get ne; String get en; String get hi;
/// Create a copy of LocalizedText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<LocalizedText> get copyWith => _$LocalizedTextCopyWithImpl<LocalizedText>(this as LocalizedText, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizedText&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LocalizedText(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $LocalizedTextCopyWith<$Res>  {
  factory $LocalizedTextCopyWith(LocalizedText value, $Res Function(LocalizedText) _then) = _$LocalizedTextCopyWithImpl;
@useResult
$Res call({
 String ne, String en, String hi
});




}
/// @nodoc
class _$LocalizedTextCopyWithImpl<$Res>
    implements $LocalizedTextCopyWith<$Res> {
  _$LocalizedTextCopyWithImpl(this._self, this._then);

  final LocalizedText _self;
  final $Res Function(LocalizedText) _then;

/// Create a copy of LocalizedText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ne = null,Object? en = null,Object? hi = null,}) {
  return _then(_self.copyWith(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: null == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _LocalizedText extends LocalizedText {
  const _LocalizedText({required this.ne, required this.en, this.hi = ''}): super._();
  

@override final  String ne;
@override final  String en;
@override@JsonKey() final  String hi;

/// Create a copy of LocalizedText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizedTextCopyWith<_LocalizedText> get copyWith => __$LocalizedTextCopyWithImpl<_LocalizedText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizedText&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LocalizedText(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$LocalizedTextCopyWith<$Res> implements $LocalizedTextCopyWith<$Res> {
  factory _$LocalizedTextCopyWith(_LocalizedText value, $Res Function(_LocalizedText) _then) = __$LocalizedTextCopyWithImpl;
@override @useResult
$Res call({
 String ne, String en, String hi
});




}
/// @nodoc
class __$LocalizedTextCopyWithImpl<$Res>
    implements _$LocalizedTextCopyWith<$Res> {
  __$LocalizedTextCopyWithImpl(this._self, this._then);

  final _LocalizedText _self;
  final $Res Function(_LocalizedText) _then;

/// Create a copy of LocalizedText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ne = null,Object? en = null,Object? hi = null,}) {
  return _then(_LocalizedText(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: null == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$EventTime {

 int get hour; int get minute;
/// Create a copy of EventTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTimeCopyWith<EventTime> get copyWith => _$EventTimeCopyWithImpl<EventTime>(this as EventTime, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'EventTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class $EventTimeCopyWith<$Res>  {
  factory $EventTimeCopyWith(EventTime value, $Res Function(EventTime) _then) = _$EventTimeCopyWithImpl;
@useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class _$EventTimeCopyWithImpl<$Res>
    implements $EventTimeCopyWith<$Res> {
  _$EventTimeCopyWithImpl(this._self, this._then);

  final EventTime _self;
  final $Res Function(EventTime) _then;

/// Create a copy of EventTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_self.copyWith(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _EventTime extends EventTime {
  const _EventTime({required this.hour, required this.minute}): super._();
  

@override final  int hour;
@override final  int minute;

/// Create a copy of EventTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventTimeCopyWith<_EventTime> get copyWith => __$EventTimeCopyWithImpl<_EventTime>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'EventTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$EventTimeCopyWith<$Res> implements $EventTimeCopyWith<$Res> {
  factory _$EventTimeCopyWith(_EventTime value, $Res Function(_EventTime) _then) = __$EventTimeCopyWithImpl;
@override @useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class __$EventTimeCopyWithImpl<$Res>
    implements _$EventTimeCopyWith<$Res> {
  __$EventTimeCopyWithImpl(this._self, this._then);

  final _EventTime _self;
  final $Res Function(_EventTime) _then;

/// Create a copy of EventTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_EventTime(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$EventReminder {

 int get daysBefore; EventTime get time;
/// Create a copy of EventReminder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventReminderCopyWith<EventReminder> get copyWith => _$EventReminderCopyWithImpl<EventReminder>(this as EventReminder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventReminder&&(identical(other.daysBefore, daysBefore) || other.daysBefore == daysBefore)&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,daysBefore,time);

@override
String toString() {
  return 'EventReminder(daysBefore: $daysBefore, time: $time)';
}


}

/// @nodoc
abstract mixin class $EventReminderCopyWith<$Res>  {
  factory $EventReminderCopyWith(EventReminder value, $Res Function(EventReminder) _then) = _$EventReminderCopyWithImpl;
@useResult
$Res call({
 int daysBefore, EventTime time
});


$EventTimeCopyWith<$Res> get time;

}
/// @nodoc
class _$EventReminderCopyWithImpl<$Res>
    implements $EventReminderCopyWith<$Res> {
  _$EventReminderCopyWithImpl(this._self, this._then);

  final EventReminder _self;
  final $Res Function(EventReminder) _then;

/// Create a copy of EventReminder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? daysBefore = null,Object? time = null,}) {
  return _then(_self.copyWith(
daysBefore: null == daysBefore ? _self.daysBefore : daysBefore // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTime,
  ));
}
/// Create a copy of EventReminder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeCopyWith<$Res> get time {
  
  return $EventTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}



/// @nodoc


class _EventReminder implements EventReminder {
  const _EventReminder({required this.daysBefore, required this.time});
  

@override final  int daysBefore;
@override final  EventTime time;

/// Create a copy of EventReminder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventReminderCopyWith<_EventReminder> get copyWith => __$EventReminderCopyWithImpl<_EventReminder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventReminder&&(identical(other.daysBefore, daysBefore) || other.daysBefore == daysBefore)&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,daysBefore,time);

@override
String toString() {
  return 'EventReminder(daysBefore: $daysBefore, time: $time)';
}


}

/// @nodoc
abstract mixin class _$EventReminderCopyWith<$Res> implements $EventReminderCopyWith<$Res> {
  factory _$EventReminderCopyWith(_EventReminder value, $Res Function(_EventReminder) _then) = __$EventReminderCopyWithImpl;
@override @useResult
$Res call({
 int daysBefore, EventTime time
});


@override $EventTimeCopyWith<$Res> get time;

}
/// @nodoc
class __$EventReminderCopyWithImpl<$Res>
    implements _$EventReminderCopyWith<$Res> {
  __$EventReminderCopyWithImpl(this._self, this._then);

  final _EventReminder _self;
  final $Res Function(_EventReminder) _then;

/// Create a copy of EventReminder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? daysBefore = null,Object? time = null,}) {
  return _then(_EventReminder(
daysBefore: null == daysBefore ? _self.daysBefore : daysBefore // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTime,
  ));
}

/// Create a copy of EventReminder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeCopyWith<$Res> get time {
  
  return $EventTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

/// @nodoc
mixin _$ChecklistItem {

 String get id; String get label; bool get isDone;
/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChecklistItemCopyWith<ChecklistItem> get copyWith => _$ChecklistItemCopyWithImpl<ChecklistItem>(this as ChecklistItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChecklistItem&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,isDone);

@override
String toString() {
  return 'ChecklistItem(id: $id, label: $label, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class $ChecklistItemCopyWith<$Res>  {
  factory $ChecklistItemCopyWith(ChecklistItem value, $Res Function(ChecklistItem) _then) = _$ChecklistItemCopyWithImpl;
@useResult
$Res call({
 String id, String label, bool isDone
});




}
/// @nodoc
class _$ChecklistItemCopyWithImpl<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._self, this._then);

  final ChecklistItem _self;
  final $Res Function(ChecklistItem) _then;

/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? isDone = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _ChecklistItem implements ChecklistItem {
  const _ChecklistItem({required this.id, required this.label, this.isDone = false});
  

@override final  String id;
@override final  String label;
@override@JsonKey() final  bool isDone;

/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChecklistItemCopyWith<_ChecklistItem> get copyWith => __$ChecklistItemCopyWithImpl<_ChecklistItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChecklistItem&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,isDone);

@override
String toString() {
  return 'ChecklistItem(id: $id, label: $label, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class _$ChecklistItemCopyWith<$Res> implements $ChecklistItemCopyWith<$Res> {
  factory _$ChecklistItemCopyWith(_ChecklistItem value, $Res Function(_ChecklistItem) _then) = __$ChecklistItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, bool isDone
});




}
/// @nodoc
class __$ChecklistItemCopyWithImpl<$Res>
    implements _$ChecklistItemCopyWith<$Res> {
  __$ChecklistItemCopyWithImpl(this._self, this._then);

  final _ChecklistItem _self;
  final $Res Function(_ChecklistItem) _then;

/// Create a copy of ChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? isDone = null,}) {
  return _then(_ChecklistItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Event {

 String get id; LocalizedText get title;/// Gregorian (AD) date at midnight – the source of truth. Use
/// [traditionalDate] for the region's calendar (BS in Nepal, Saka in
/// India).
 DateTime get date; EventCategory get category; LocalizedText get description; EventTime? get time; bool get isHoliday; bool get isVrat; bool get isImportant; String? get imagePath; LocalizedText get location; LocalizedText get tithi; LocalizedText get howToCelebrate; LocalizedText get attractionPlaces; String? get videoUrl; List<ChecklistItem> get checklist; EventReminder? get reminder; EventRepeat get repeat;/// Whether a yearly event recurs on its *traditional* date.
///
/// A birthday recorded in Bikram Sambat comes round on its B.S. date,
/// which lands on a different Gregorian day each year. Stored by the
/// server and, until now, dropped on the way back — so a B.S. birthday
/// silently recurred on the Gregorian date instead.
 bool get useTraditionalDate;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.time, time) || other.time == time)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.isVrat, isVrat) || other.isVrat == isVrat)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.location, location) || other.location == location)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.howToCelebrate, howToCelebrate) || other.howToCelebrate == howToCelebrate)&&(identical(other.attractionPlaces, attractionPlaces) || other.attractionPlaces == attractionPlaces)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&(identical(other.reminder, reminder) || other.reminder == reminder)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.useTraditionalDate, useTraditionalDate) || other.useTraditionalDate == useTraditionalDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,date,category,description,time,isHoliday,isVrat,isImportant,imagePath,location,tithi,howToCelebrate,attractionPlaces,videoUrl,const DeepCollectionEquality().hash(checklist),reminder,repeat,useTraditionalDate]);

@override
String toString() {
  return 'Event(id: $id, title: $title, date: $date, category: $category, description: $description, time: $time, isHoliday: $isHoliday, isVrat: $isVrat, isImportant: $isImportant, imagePath: $imagePath, location: $location, tithi: $tithi, howToCelebrate: $howToCelebrate, attractionPlaces: $attractionPlaces, videoUrl: $videoUrl, checklist: $checklist, reminder: $reminder, repeat: $repeat, useTraditionalDate: $useTraditionalDate)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText title, DateTime date, EventCategory category, LocalizedText description, EventTime? time, bool isHoliday, bool isVrat, bool isImportant, String? imagePath, LocalizedText location, LocalizedText tithi, LocalizedText howToCelebrate, LocalizedText attractionPlaces, String? videoUrl, List<ChecklistItem> checklist, EventReminder? reminder, EventRepeat repeat, bool useTraditionalDate
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get description;$EventTimeCopyWith<$Res>? get time;$LocalizedTextCopyWith<$Res> get location;$LocalizedTextCopyWith<$Res> get tithi;$LocalizedTextCopyWith<$Res> get howToCelebrate;$LocalizedTextCopyWith<$Res> get attractionPlaces;$EventReminderCopyWith<$Res>? get reminder;

}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? date = null,Object? category = null,Object? description = null,Object? time = freezed,Object? isHoliday = null,Object? isVrat = null,Object? isImportant = null,Object? imagePath = freezed,Object? location = null,Object? tithi = null,Object? howToCelebrate = null,Object? attractionPlaces = null,Object? videoUrl = freezed,Object? checklist = null,Object? reminder = freezed,Object? repeat = null,Object? useTraditionalDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTime?,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,isVrat: null == isVrat ? _self.isVrat : isVrat // ignore: cast_nullable_to_non_nullable
as bool,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedText,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as LocalizedText,howToCelebrate: null == howToCelebrate ? _self.howToCelebrate : howToCelebrate // ignore: cast_nullable_to_non_nullable
as LocalizedText,attractionPlaces: null == attractionPlaces ? _self.attractionPlaces : attractionPlaces // ignore: cast_nullable_to_non_nullable
as LocalizedText,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as EventReminder?,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as EventRepeat,useTraditionalDate: null == useTraditionalDate ? _self.useTraditionalDate : useTraditionalDate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get description {
  
  return $LocalizedTextCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of Event
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
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get location {
  
  return $LocalizedTextCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get tithi {
  
  return $LocalizedTextCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get howToCelebrate {
  
  return $LocalizedTextCopyWith<$Res>(_self.howToCelebrate, (value) {
    return _then(_self.copyWith(howToCelebrate: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get attractionPlaces {
  
  return $LocalizedTextCopyWith<$Res>(_self.attractionPlaces, (value) {
    return _then(_self.copyWith(attractionPlaces: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventReminderCopyWith<$Res>? get reminder {
    if (_self.reminder == null) {
    return null;
  }

  return $EventReminderCopyWith<$Res>(_self.reminder!, (value) {
    return _then(_self.copyWith(reminder: value));
  });
}
}



/// @nodoc


class _Event extends Event {
  const _Event({required this.id, required this.title, required this.date, required this.category, this.description = LocalizedText.empty, this.time, this.isHoliday = false, this.isVrat = false, this.isImportant = false, this.imagePath, this.location = LocalizedText.empty, this.tithi = LocalizedText.empty, this.howToCelebrate = LocalizedText.empty, this.attractionPlaces = LocalizedText.empty, this.videoUrl, final  List<ChecklistItem> checklist = const [], this.reminder, this.repeat = EventRepeat.none, this.useTraditionalDate = false}): _checklist = checklist,super._();
  

@override final  String id;
@override final  LocalizedText title;
/// Gregorian (AD) date at midnight – the source of truth. Use
/// [traditionalDate] for the region's calendar (BS in Nepal, Saka in
/// India).
@override final  DateTime date;
@override final  EventCategory category;
@override@JsonKey() final  LocalizedText description;
@override final  EventTime? time;
@override@JsonKey() final  bool isHoliday;
@override@JsonKey() final  bool isVrat;
@override@JsonKey() final  bool isImportant;
@override final  String? imagePath;
@override@JsonKey() final  LocalizedText location;
@override@JsonKey() final  LocalizedText tithi;
@override@JsonKey() final  LocalizedText howToCelebrate;
@override@JsonKey() final  LocalizedText attractionPlaces;
@override final  String? videoUrl;
 final  List<ChecklistItem> _checklist;
@override@JsonKey() List<ChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

@override final  EventReminder? reminder;
@override@JsonKey() final  EventRepeat repeat;
/// Whether a yearly event recurs on its *traditional* date.
///
/// A birthday recorded in Bikram Sambat comes round on its B.S. date,
/// which lands on a different Gregorian day each year. Stored by the
/// server and, until now, dropped on the way back — so a B.S. birthday
/// silently recurred on the Gregorian date instead.
@override@JsonKey() final  bool useTraditionalDate;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.time, time) || other.time == time)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.isVrat, isVrat) || other.isVrat == isVrat)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.location, location) || other.location == location)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.howToCelebrate, howToCelebrate) || other.howToCelebrate == howToCelebrate)&&(identical(other.attractionPlaces, attractionPlaces) || other.attractionPlaces == attractionPlaces)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&(identical(other.reminder, reminder) || other.reminder == reminder)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.useTraditionalDate, useTraditionalDate) || other.useTraditionalDate == useTraditionalDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,date,category,description,time,isHoliday,isVrat,isImportant,imagePath,location,tithi,howToCelebrate,attractionPlaces,videoUrl,const DeepCollectionEquality().hash(_checklist),reminder,repeat,useTraditionalDate]);

@override
String toString() {
  return 'Event(id: $id, title: $title, date: $date, category: $category, description: $description, time: $time, isHoliday: $isHoliday, isVrat: $isVrat, isImportant: $isImportant, imagePath: $imagePath, location: $location, tithi: $tithi, howToCelebrate: $howToCelebrate, attractionPlaces: $attractionPlaces, videoUrl: $videoUrl, checklist: $checklist, reminder: $reminder, repeat: $repeat, useTraditionalDate: $useTraditionalDate)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText title, DateTime date, EventCategory category, LocalizedText description, EventTime? time, bool isHoliday, bool isVrat, bool isImportant, String? imagePath, LocalizedText location, LocalizedText tithi, LocalizedText howToCelebrate, LocalizedText attractionPlaces, String? videoUrl, List<ChecklistItem> checklist, EventReminder? reminder, EventRepeat repeat, bool useTraditionalDate
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get description;@override $EventTimeCopyWith<$Res>? get time;@override $LocalizedTextCopyWith<$Res> get location;@override $LocalizedTextCopyWith<$Res> get tithi;@override $LocalizedTextCopyWith<$Res> get howToCelebrate;@override $LocalizedTextCopyWith<$Res> get attractionPlaces;@override $EventReminderCopyWith<$Res>? get reminder;

}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? date = null,Object? category = null,Object? description = null,Object? time = freezed,Object? isHoliday = null,Object? isVrat = null,Object? isImportant = null,Object? imagePath = freezed,Object? location = null,Object? tithi = null,Object? howToCelebrate = null,Object? attractionPlaces = null,Object? videoUrl = freezed,Object? checklist = null,Object? reminder = freezed,Object? repeat = null,Object? useTraditionalDate = null,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTime?,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,isVrat: null == isVrat ? _self.isVrat : isVrat // ignore: cast_nullable_to_non_nullable
as bool,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedText,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as LocalizedText,howToCelebrate: null == howToCelebrate ? _self.howToCelebrate : howToCelebrate // ignore: cast_nullable_to_non_nullable
as LocalizedText,attractionPlaces: null == attractionPlaces ? _self.attractionPlaces : attractionPlaces // ignore: cast_nullable_to_non_nullable
as LocalizedText,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as EventReminder?,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as EventRepeat,useTraditionalDate: null == useTraditionalDate ? _self.useTraditionalDate : useTraditionalDate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get description {
  
  return $LocalizedTextCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of Event
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
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get location {
  
  return $LocalizedTextCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get tithi {
  
  return $LocalizedTextCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get howToCelebrate {
  
  return $LocalizedTextCopyWith<$Res>(_self.howToCelebrate, (value) {
    return _then(_self.copyWith(howToCelebrate: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get attractionPlaces {
  
  return $LocalizedTextCopyWith<$Res>(_self.attractionPlaces, (value) {
    return _then(_self.copyWith(attractionPlaces: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventReminderCopyWith<$Res>? get reminder {
    if (_self.reminder == null) {
    return null;
  }

  return $EventReminderCopyWith<$Res>(_self.reminder!, (value) {
    return _then(_self.copyWith(reminder: value));
  });
}
}

// dart format on
