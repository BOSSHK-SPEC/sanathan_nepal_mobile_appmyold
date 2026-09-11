// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalizedTextModel {

 String get ne; String get en; String get hi;
/// Create a copy of LocalizedTextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<LocalizedTextModel> get copyWith => _$LocalizedTextModelCopyWithImpl<LocalizedTextModel>(this as LocalizedTextModel, _$identity);

  /// Serializes this LocalizedTextModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizedTextModel&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LocalizedTextModel(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $LocalizedTextModelCopyWith<$Res>  {
  factory $LocalizedTextModelCopyWith(LocalizedTextModel value, $Res Function(LocalizedTextModel) _then) = _$LocalizedTextModelCopyWithImpl;
@useResult
$Res call({
 String ne, String en, String hi
});




}
/// @nodoc
class _$LocalizedTextModelCopyWithImpl<$Res>
    implements $LocalizedTextModelCopyWith<$Res> {
  _$LocalizedTextModelCopyWithImpl(this._self, this._then);

  final LocalizedTextModel _self;
  final $Res Function(LocalizedTextModel) _then;

/// Create a copy of LocalizedTextModel
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
@JsonSerializable()

class _LocalizedTextModel extends LocalizedTextModel {
  const _LocalizedTextModel({this.ne = '', this.en = '', this.hi = ''}): super._();
  factory _LocalizedTextModel.fromJson(Map<String, dynamic> json) => _$LocalizedTextModelFromJson(json);

@override@JsonKey() final  String ne;
@override@JsonKey() final  String en;
@override@JsonKey() final  String hi;

/// Create a copy of LocalizedTextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizedTextModelCopyWith<_LocalizedTextModel> get copyWith => __$LocalizedTextModelCopyWithImpl<_LocalizedTextModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalizedTextModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizedTextModel&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LocalizedTextModel(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$LocalizedTextModelCopyWith<$Res> implements $LocalizedTextModelCopyWith<$Res> {
  factory _$LocalizedTextModelCopyWith(_LocalizedTextModel value, $Res Function(_LocalizedTextModel) _then) = __$LocalizedTextModelCopyWithImpl;
@override @useResult
$Res call({
 String ne, String en, String hi
});




}
/// @nodoc
class __$LocalizedTextModelCopyWithImpl<$Res>
    implements _$LocalizedTextModelCopyWith<$Res> {
  __$LocalizedTextModelCopyWithImpl(this._self, this._then);

  final _LocalizedTextModel _self;
  final $Res Function(_LocalizedTextModel) _then;

/// Create a copy of LocalizedTextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ne = null,Object? en = null,Object? hi = null,}) {
  return _then(_LocalizedTextModel(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: null == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EventTimeModel {

 int get hour; int get minute;
/// Create a copy of EventTimeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTimeModelCopyWith<EventTimeModel> get copyWith => _$EventTimeModelCopyWithImpl<EventTimeModel>(this as EventTimeModel, _$identity);

  /// Serializes this EventTimeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTimeModel&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'EventTimeModel(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class $EventTimeModelCopyWith<$Res>  {
  factory $EventTimeModelCopyWith(EventTimeModel value, $Res Function(EventTimeModel) _then) = _$EventTimeModelCopyWithImpl;
@useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class _$EventTimeModelCopyWithImpl<$Res>
    implements $EventTimeModelCopyWith<$Res> {
  _$EventTimeModelCopyWithImpl(this._self, this._then);

  final EventTimeModel _self;
  final $Res Function(EventTimeModel) _then;

/// Create a copy of EventTimeModel
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
@JsonSerializable()

class _EventTimeModel extends EventTimeModel {
  const _EventTimeModel({this.hour = 0, this.minute = 0}): super._();
  factory _EventTimeModel.fromJson(Map<String, dynamic> json) => _$EventTimeModelFromJson(json);

@override@JsonKey() final  int hour;
@override@JsonKey() final  int minute;

/// Create a copy of EventTimeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventTimeModelCopyWith<_EventTimeModel> get copyWith => __$EventTimeModelCopyWithImpl<_EventTimeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventTimeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTimeModel&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'EventTimeModel(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$EventTimeModelCopyWith<$Res> implements $EventTimeModelCopyWith<$Res> {
  factory _$EventTimeModelCopyWith(_EventTimeModel value, $Res Function(_EventTimeModel) _then) = __$EventTimeModelCopyWithImpl;
@override @useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class __$EventTimeModelCopyWithImpl<$Res>
    implements _$EventTimeModelCopyWith<$Res> {
  __$EventTimeModelCopyWithImpl(this._self, this._then);

  final _EventTimeModel _self;
  final $Res Function(_EventTimeModel) _then;

/// Create a copy of EventTimeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_EventTimeModel(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EventReminderModel {

 int get daysBefore; EventTimeModel get time;
/// Create a copy of EventReminderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventReminderModelCopyWith<EventReminderModel> get copyWith => _$EventReminderModelCopyWithImpl<EventReminderModel>(this as EventReminderModel, _$identity);

  /// Serializes this EventReminderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventReminderModel&&(identical(other.daysBefore, daysBefore) || other.daysBefore == daysBefore)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,daysBefore,time);

@override
String toString() {
  return 'EventReminderModel(daysBefore: $daysBefore, time: $time)';
}


}

/// @nodoc
abstract mixin class $EventReminderModelCopyWith<$Res>  {
  factory $EventReminderModelCopyWith(EventReminderModel value, $Res Function(EventReminderModel) _then) = _$EventReminderModelCopyWithImpl;
@useResult
$Res call({
 int daysBefore, EventTimeModel time
});


$EventTimeModelCopyWith<$Res> get time;

}
/// @nodoc
class _$EventReminderModelCopyWithImpl<$Res>
    implements $EventReminderModelCopyWith<$Res> {
  _$EventReminderModelCopyWithImpl(this._self, this._then);

  final EventReminderModel _self;
  final $Res Function(EventReminderModel) _then;

/// Create a copy of EventReminderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? daysBefore = null,Object? time = null,}) {
  return _then(_self.copyWith(
daysBefore: null == daysBefore ? _self.daysBefore : daysBefore // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTimeModel,
  ));
}
/// Create a copy of EventReminderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeModelCopyWith<$Res> get time {
  
  return $EventTimeModelCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _EventReminderModel extends EventReminderModel {
  const _EventReminderModel({this.daysBefore = 1, this.time = const EventTimeModel()}): super._();
  factory _EventReminderModel.fromJson(Map<String, dynamic> json) => _$EventReminderModelFromJson(json);

@override@JsonKey() final  int daysBefore;
@override@JsonKey() final  EventTimeModel time;

/// Create a copy of EventReminderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventReminderModelCopyWith<_EventReminderModel> get copyWith => __$EventReminderModelCopyWithImpl<_EventReminderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventReminderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventReminderModel&&(identical(other.daysBefore, daysBefore) || other.daysBefore == daysBefore)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,daysBefore,time);

@override
String toString() {
  return 'EventReminderModel(daysBefore: $daysBefore, time: $time)';
}


}

/// @nodoc
abstract mixin class _$EventReminderModelCopyWith<$Res> implements $EventReminderModelCopyWith<$Res> {
  factory _$EventReminderModelCopyWith(_EventReminderModel value, $Res Function(_EventReminderModel) _then) = __$EventReminderModelCopyWithImpl;
@override @useResult
$Res call({
 int daysBefore, EventTimeModel time
});


@override $EventTimeModelCopyWith<$Res> get time;

}
/// @nodoc
class __$EventReminderModelCopyWithImpl<$Res>
    implements _$EventReminderModelCopyWith<$Res> {
  __$EventReminderModelCopyWithImpl(this._self, this._then);

  final _EventReminderModel _self;
  final $Res Function(_EventReminderModel) _then;

/// Create a copy of EventReminderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? daysBefore = null,Object? time = null,}) {
  return _then(_EventReminderModel(
daysBefore: null == daysBefore ? _self.daysBefore : daysBefore // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTimeModel,
  ));
}

/// Create a copy of EventReminderModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeModelCopyWith<$Res> get time {
  
  return $EventTimeModelCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}


/// @nodoc
mixin _$ChecklistItemModel {

 String get id; String get label; bool get isDone;
/// Create a copy of ChecklistItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChecklistItemModelCopyWith<ChecklistItemModel> get copyWith => _$ChecklistItemModelCopyWithImpl<ChecklistItemModel>(this as ChecklistItemModel, _$identity);

  /// Serializes this ChecklistItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChecklistItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,isDone);

@override
String toString() {
  return 'ChecklistItemModel(id: $id, label: $label, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class $ChecklistItemModelCopyWith<$Res>  {
  factory $ChecklistItemModelCopyWith(ChecklistItemModel value, $Res Function(ChecklistItemModel) _then) = _$ChecklistItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String label, bool isDone
});




}
/// @nodoc
class _$ChecklistItemModelCopyWithImpl<$Res>
    implements $ChecklistItemModelCopyWith<$Res> {
  _$ChecklistItemModelCopyWithImpl(this._self, this._then);

  final ChecklistItemModel _self;
  final $Res Function(ChecklistItemModel) _then;

/// Create a copy of ChecklistItemModel
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
@JsonSerializable()

class _ChecklistItemModel extends ChecklistItemModel {
  const _ChecklistItemModel({required this.id, required this.label, this.isDone = false}): super._();
  factory _ChecklistItemModel.fromJson(Map<String, dynamic> json) => _$ChecklistItemModelFromJson(json);

@override final  String id;
@override final  String label;
@override@JsonKey() final  bool isDone;

/// Create a copy of ChecklistItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChecklistItemModelCopyWith<_ChecklistItemModel> get copyWith => __$ChecklistItemModelCopyWithImpl<_ChecklistItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChecklistItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChecklistItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isDone, isDone) || other.isDone == isDone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,isDone);

@override
String toString() {
  return 'ChecklistItemModel(id: $id, label: $label, isDone: $isDone)';
}


}

/// @nodoc
abstract mixin class _$ChecklistItemModelCopyWith<$Res> implements $ChecklistItemModelCopyWith<$Res> {
  factory _$ChecklistItemModelCopyWith(_ChecklistItemModel value, $Res Function(_ChecklistItemModel) _then) = __$ChecklistItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, bool isDone
});




}
/// @nodoc
class __$ChecklistItemModelCopyWithImpl<$Res>
    implements _$ChecklistItemModelCopyWith<$Res> {
  __$ChecklistItemModelCopyWithImpl(this._self, this._then);

  final _ChecklistItemModel _self;
  final $Res Function(_ChecklistItemModel) _then;

/// Create a copy of ChecklistItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? isDone = null,}) {
  return _then(_ChecklistItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EventModel {

 String get id; LocalizedTextModel get title; DateTime get date;@JsonKey(unknownEnumValue: EventCategory.personal) EventCategory get category; LocalizedTextModel get description; EventTimeModel? get time; bool get isHoliday; bool get isVrat; bool get isImportant; String? get imagePath; LocalizedTextModel get location; LocalizedTextModel get tithi; LocalizedTextModel get howToCelebrate; LocalizedTextModel get attractionPlaces; String? get videoUrl; List<ChecklistItemModel> get checklist; EventReminderModel? get reminder;@JsonKey(unknownEnumValue: EventRepeat.none) EventRepeat get repeat;
/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventModelCopyWith<EventModel> get copyWith => _$EventModelCopyWithImpl<EventModel>(this as EventModel, _$identity);

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.time, time) || other.time == time)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.isVrat, isVrat) || other.isVrat == isVrat)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.location, location) || other.location == location)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.howToCelebrate, howToCelebrate) || other.howToCelebrate == howToCelebrate)&&(identical(other.attractionPlaces, attractionPlaces) || other.attractionPlaces == attractionPlaces)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&(identical(other.reminder, reminder) || other.reminder == reminder)&&(identical(other.repeat, repeat) || other.repeat == repeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,category,description,time,isHoliday,isVrat,isImportant,imagePath,location,tithi,howToCelebrate,attractionPlaces,videoUrl,const DeepCollectionEquality().hash(checklist),reminder,repeat);

@override
String toString() {
  return 'EventModel(id: $id, title: $title, date: $date, category: $category, description: $description, time: $time, isHoliday: $isHoliday, isVrat: $isVrat, isImportant: $isImportant, imagePath: $imagePath, location: $location, tithi: $tithi, howToCelebrate: $howToCelebrate, attractionPlaces: $attractionPlaces, videoUrl: $videoUrl, checklist: $checklist, reminder: $reminder, repeat: $repeat)';
}


}

/// @nodoc
abstract mixin class $EventModelCopyWith<$Res>  {
  factory $EventModelCopyWith(EventModel value, $Res Function(EventModel) _then) = _$EventModelCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextModel title, DateTime date,@JsonKey(unknownEnumValue: EventCategory.personal) EventCategory category, LocalizedTextModel description, EventTimeModel? time, bool isHoliday, bool isVrat, bool isImportant, String? imagePath, LocalizedTextModel location, LocalizedTextModel tithi, LocalizedTextModel howToCelebrate, LocalizedTextModel attractionPlaces, String? videoUrl, List<ChecklistItemModel> checklist, EventReminderModel? reminder,@JsonKey(unknownEnumValue: EventRepeat.none) EventRepeat repeat
});


$LocalizedTextModelCopyWith<$Res> get title;$LocalizedTextModelCopyWith<$Res> get description;$EventTimeModelCopyWith<$Res>? get time;$LocalizedTextModelCopyWith<$Res> get location;$LocalizedTextModelCopyWith<$Res> get tithi;$LocalizedTextModelCopyWith<$Res> get howToCelebrate;$LocalizedTextModelCopyWith<$Res> get attractionPlaces;$EventReminderModelCopyWith<$Res>? get reminder;

}
/// @nodoc
class _$EventModelCopyWithImpl<$Res>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._self, this._then);

  final EventModel _self;
  final $Res Function(EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? date = null,Object? category = null,Object? description = null,Object? time = freezed,Object? isHoliday = null,Object? isVrat = null,Object? isImportant = null,Object? imagePath = freezed,Object? location = null,Object? tithi = null,Object? howToCelebrate = null,Object? attractionPlaces = null,Object? videoUrl = freezed,Object? checklist = null,Object? reminder = freezed,Object? repeat = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTimeModel?,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,isVrat: null == isVrat ? _self.isVrat : isVrat // ignore: cast_nullable_to_non_nullable
as bool,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,howToCelebrate: null == howToCelebrate ? _self.howToCelebrate : howToCelebrate // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,attractionPlaces: null == attractionPlaces ? _self.attractionPlaces : attractionPlaces // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItemModel>,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as EventReminderModel?,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as EventRepeat,
  ));
}
/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get title {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get description {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeModelCopyWith<$Res>? get time {
    if (_self.time == null) {
    return null;
  }

  return $EventTimeModelCopyWith<$Res>(_self.time!, (value) {
    return _then(_self.copyWith(time: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get location {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get tithi {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get howToCelebrate {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.howToCelebrate, (value) {
    return _then(_self.copyWith(howToCelebrate: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get attractionPlaces {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.attractionPlaces, (value) {
    return _then(_self.copyWith(attractionPlaces: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventReminderModelCopyWith<$Res>? get reminder {
    if (_self.reminder == null) {
    return null;
  }

  return $EventReminderModelCopyWith<$Res>(_self.reminder!, (value) {
    return _then(_self.copyWith(reminder: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _EventModel extends EventModel {
  const _EventModel({required this.id, required this.title, required this.date, @JsonKey(unknownEnumValue: EventCategory.personal) required this.category, this.description = const LocalizedTextModel(), this.time, this.isHoliday = false, this.isVrat = false, this.isImportant = false, this.imagePath, this.location = const LocalizedTextModel(), this.tithi = const LocalizedTextModel(), this.howToCelebrate = const LocalizedTextModel(), this.attractionPlaces = const LocalizedTextModel(), this.videoUrl, final  List<ChecklistItemModel> checklist = const [], this.reminder, @JsonKey(unknownEnumValue: EventRepeat.none) this.repeat = EventRepeat.none}): _checklist = checklist,super._();
  factory _EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

@override final  String id;
@override final  LocalizedTextModel title;
@override final  DateTime date;
@override@JsonKey(unknownEnumValue: EventCategory.personal) final  EventCategory category;
@override@JsonKey() final  LocalizedTextModel description;
@override final  EventTimeModel? time;
@override@JsonKey() final  bool isHoliday;
@override@JsonKey() final  bool isVrat;
@override@JsonKey() final  bool isImportant;
@override final  String? imagePath;
@override@JsonKey() final  LocalizedTextModel location;
@override@JsonKey() final  LocalizedTextModel tithi;
@override@JsonKey() final  LocalizedTextModel howToCelebrate;
@override@JsonKey() final  LocalizedTextModel attractionPlaces;
@override final  String? videoUrl;
 final  List<ChecklistItemModel> _checklist;
@override@JsonKey() List<ChecklistItemModel> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

@override final  EventReminderModel? reminder;
@override@JsonKey(unknownEnumValue: EventRepeat.none) final  EventRepeat repeat;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventModelCopyWith<_EventModel> get copyWith => __$EventModelCopyWithImpl<_EventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.time, time) || other.time == time)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.isVrat, isVrat) || other.isVrat == isVrat)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.location, location) || other.location == location)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.howToCelebrate, howToCelebrate) || other.howToCelebrate == howToCelebrate)&&(identical(other.attractionPlaces, attractionPlaces) || other.attractionPlaces == attractionPlaces)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&(identical(other.reminder, reminder) || other.reminder == reminder)&&(identical(other.repeat, repeat) || other.repeat == repeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,category,description,time,isHoliday,isVrat,isImportant,imagePath,location,tithi,howToCelebrate,attractionPlaces,videoUrl,const DeepCollectionEquality().hash(_checklist),reminder,repeat);

@override
String toString() {
  return 'EventModel(id: $id, title: $title, date: $date, category: $category, description: $description, time: $time, isHoliday: $isHoliday, isVrat: $isVrat, isImportant: $isImportant, imagePath: $imagePath, location: $location, tithi: $tithi, howToCelebrate: $howToCelebrate, attractionPlaces: $attractionPlaces, videoUrl: $videoUrl, checklist: $checklist, reminder: $reminder, repeat: $repeat)';
}


}

/// @nodoc
abstract mixin class _$EventModelCopyWith<$Res> implements $EventModelCopyWith<$Res> {
  factory _$EventModelCopyWith(_EventModel value, $Res Function(_EventModel) _then) = __$EventModelCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextModel title, DateTime date,@JsonKey(unknownEnumValue: EventCategory.personal) EventCategory category, LocalizedTextModel description, EventTimeModel? time, bool isHoliday, bool isVrat, bool isImportant, String? imagePath, LocalizedTextModel location, LocalizedTextModel tithi, LocalizedTextModel howToCelebrate, LocalizedTextModel attractionPlaces, String? videoUrl, List<ChecklistItemModel> checklist, EventReminderModel? reminder,@JsonKey(unknownEnumValue: EventRepeat.none) EventRepeat repeat
});


@override $LocalizedTextModelCopyWith<$Res> get title;@override $LocalizedTextModelCopyWith<$Res> get description;@override $EventTimeModelCopyWith<$Res>? get time;@override $LocalizedTextModelCopyWith<$Res> get location;@override $LocalizedTextModelCopyWith<$Res> get tithi;@override $LocalizedTextModelCopyWith<$Res> get howToCelebrate;@override $LocalizedTextModelCopyWith<$Res> get attractionPlaces;@override $EventReminderModelCopyWith<$Res>? get reminder;

}
/// @nodoc
class __$EventModelCopyWithImpl<$Res>
    implements _$EventModelCopyWith<$Res> {
  __$EventModelCopyWithImpl(this._self, this._then);

  final _EventModel _self;
  final $Res Function(_EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? date = null,Object? category = null,Object? description = null,Object? time = freezed,Object? isHoliday = null,Object? isVrat = null,Object? isImportant = null,Object? imagePath = freezed,Object? location = null,Object? tithi = null,Object? howToCelebrate = null,Object? attractionPlaces = null,Object? videoUrl = freezed,Object? checklist = null,Object? reminder = freezed,Object? repeat = null,}) {
  return _then(_EventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as EventTimeModel?,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,isVrat: null == isVrat ? _self.isVrat : isVrat // ignore: cast_nullable_to_non_nullable
as bool,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,howToCelebrate: null == howToCelebrate ? _self.howToCelebrate : howToCelebrate // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,attractionPlaces: null == attractionPlaces ? _self.attractionPlaces : attractionPlaces // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<ChecklistItemModel>,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as EventReminderModel?,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as EventRepeat,
  ));
}

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get title {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get description {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventTimeModelCopyWith<$Res>? get time {
    if (_self.time == null) {
    return null;
  }

  return $EventTimeModelCopyWith<$Res>(_self.time!, (value) {
    return _then(_self.copyWith(time: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get location {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get tithi {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get howToCelebrate {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.howToCelebrate, (value) {
    return _then(_self.copyWith(howToCelebrate: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get attractionPlaces {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.attractionPlaces, (value) {
    return _then(_self.copyWith(attractionPlaces: value));
  });
}/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventReminderModelCopyWith<$Res>? get reminder {
    if (_self.reminder == null) {
    return null;
  }

  return $EventReminderModelCopyWith<$Res>(_self.reminder!, (value) {
    return _then(_self.copyWith(reminder: value));
  });
}
}

// dart format on
