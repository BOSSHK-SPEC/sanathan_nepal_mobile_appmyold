// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationTime {

 int get hour; int get minute;
/// Create a copy of NotificationTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<NotificationTime> get copyWith => _$NotificationTimeCopyWithImpl<NotificationTime>(this as NotificationTime, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'NotificationTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class $NotificationTimeCopyWith<$Res>  {
  factory $NotificationTimeCopyWith(NotificationTime value, $Res Function(NotificationTime) _then) = _$NotificationTimeCopyWithImpl;
@useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class _$NotificationTimeCopyWithImpl<$Res>
    implements $NotificationTimeCopyWith<$Res> {
  _$NotificationTimeCopyWithImpl(this._self, this._then);

  final NotificationTime _self;
  final $Res Function(NotificationTime) _then;

/// Create a copy of NotificationTime
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


class _NotificationTime extends NotificationTime {
  const _NotificationTime({required this.hour, required this.minute}): super._();
  

@override final  int hour;
@override final  int minute;

/// Create a copy of NotificationTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTimeCopyWith<_NotificationTime> get copyWith => __$NotificationTimeCopyWithImpl<_NotificationTime>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'NotificationTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$NotificationTimeCopyWith<$Res> implements $NotificationTimeCopyWith<$Res> {
  factory _$NotificationTimeCopyWith(_NotificationTime value, $Res Function(_NotificationTime) _then) = __$NotificationTimeCopyWithImpl;
@override @useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class __$NotificationTimeCopyWithImpl<$Res>
    implements _$NotificationTimeCopyWith<$Res> {
  __$NotificationTimeCopyWithImpl(this._self, this._then);

  final _NotificationTime _self;
  final $Res Function(_NotificationTime) _then;

/// Create a copy of NotificationTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_NotificationTime(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$NotificationSettings {

 bool get horoscopeEnabled; bool get horoscopeDaily; bool get horoscopeMonthly; bool get horoscopeYearly; NotificationTime get horoscopeTime; bool get importantHinduFestivals; bool get commonFestivals; bool get publicHolidays; int get festivalRemindDays; NotificationTime get festivalRemindTime; bool get birthdayEnabled; int get birthdayRemindDays; NotificationTime get birthdayRemindTime;
/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsCopyWith<NotificationSettings> get copyWith => _$NotificationSettingsCopyWithImpl<NotificationSettings>(this as NotificationSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettings&&(identical(other.horoscopeEnabled, horoscopeEnabled) || other.horoscopeEnabled == horoscopeEnabled)&&(identical(other.horoscopeDaily, horoscopeDaily) || other.horoscopeDaily == horoscopeDaily)&&(identical(other.horoscopeMonthly, horoscopeMonthly) || other.horoscopeMonthly == horoscopeMonthly)&&(identical(other.horoscopeYearly, horoscopeYearly) || other.horoscopeYearly == horoscopeYearly)&&(identical(other.horoscopeTime, horoscopeTime) || other.horoscopeTime == horoscopeTime)&&(identical(other.importantHinduFestivals, importantHinduFestivals) || other.importantHinduFestivals == importantHinduFestivals)&&(identical(other.commonFestivals, commonFestivals) || other.commonFestivals == commonFestivals)&&(identical(other.publicHolidays, publicHolidays) || other.publicHolidays == publicHolidays)&&(identical(other.festivalRemindDays, festivalRemindDays) || other.festivalRemindDays == festivalRemindDays)&&(identical(other.festivalRemindTime, festivalRemindTime) || other.festivalRemindTime == festivalRemindTime)&&(identical(other.birthdayEnabled, birthdayEnabled) || other.birthdayEnabled == birthdayEnabled)&&(identical(other.birthdayRemindDays, birthdayRemindDays) || other.birthdayRemindDays == birthdayRemindDays)&&(identical(other.birthdayRemindTime, birthdayRemindTime) || other.birthdayRemindTime == birthdayRemindTime));
}


@override
int get hashCode => Object.hash(runtimeType,horoscopeEnabled,horoscopeDaily,horoscopeMonthly,horoscopeYearly,horoscopeTime,importantHinduFestivals,commonFestivals,publicHolidays,festivalRemindDays,festivalRemindTime,birthdayEnabled,birthdayRemindDays,birthdayRemindTime);

@override
String toString() {
  return 'NotificationSettings(horoscopeEnabled: $horoscopeEnabled, horoscopeDaily: $horoscopeDaily, horoscopeMonthly: $horoscopeMonthly, horoscopeYearly: $horoscopeYearly, horoscopeTime: $horoscopeTime, importantHinduFestivals: $importantHinduFestivals, commonFestivals: $commonFestivals, publicHolidays: $publicHolidays, festivalRemindDays: $festivalRemindDays, festivalRemindTime: $festivalRemindTime, birthdayEnabled: $birthdayEnabled, birthdayRemindDays: $birthdayRemindDays, birthdayRemindTime: $birthdayRemindTime)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsCopyWith<$Res>  {
  factory $NotificationSettingsCopyWith(NotificationSettings value, $Res Function(NotificationSettings) _then) = _$NotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool horoscopeEnabled, bool horoscopeDaily, bool horoscopeMonthly, bool horoscopeYearly, NotificationTime horoscopeTime, bool importantHinduFestivals, bool commonFestivals, bool publicHolidays, int festivalRemindDays, NotificationTime festivalRemindTime, bool birthdayEnabled, int birthdayRemindDays, NotificationTime birthdayRemindTime
});


$NotificationTimeCopyWith<$Res> get horoscopeTime;$NotificationTimeCopyWith<$Res> get festivalRemindTime;$NotificationTimeCopyWith<$Res> get birthdayRemindTime;

}
/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._self, this._then);

  final NotificationSettings _self;
  final $Res Function(NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? horoscopeEnabled = null,Object? horoscopeDaily = null,Object? horoscopeMonthly = null,Object? horoscopeYearly = null,Object? horoscopeTime = null,Object? importantHinduFestivals = null,Object? commonFestivals = null,Object? publicHolidays = null,Object? festivalRemindDays = null,Object? festivalRemindTime = null,Object? birthdayEnabled = null,Object? birthdayRemindDays = null,Object? birthdayRemindTime = null,}) {
  return _then(_self.copyWith(
horoscopeEnabled: null == horoscopeEnabled ? _self.horoscopeEnabled : horoscopeEnabled // ignore: cast_nullable_to_non_nullable
as bool,horoscopeDaily: null == horoscopeDaily ? _self.horoscopeDaily : horoscopeDaily // ignore: cast_nullable_to_non_nullable
as bool,horoscopeMonthly: null == horoscopeMonthly ? _self.horoscopeMonthly : horoscopeMonthly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeYearly: null == horoscopeYearly ? _self.horoscopeYearly : horoscopeYearly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeTime: null == horoscopeTime ? _self.horoscopeTime : horoscopeTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,importantHinduFestivals: null == importantHinduFestivals ? _self.importantHinduFestivals : importantHinduFestivals // ignore: cast_nullable_to_non_nullable
as bool,commonFestivals: null == commonFestivals ? _self.commonFestivals : commonFestivals // ignore: cast_nullable_to_non_nullable
as bool,publicHolidays: null == publicHolidays ? _self.publicHolidays : publicHolidays // ignore: cast_nullable_to_non_nullable
as bool,festivalRemindDays: null == festivalRemindDays ? _self.festivalRemindDays : festivalRemindDays // ignore: cast_nullable_to_non_nullable
as int,festivalRemindTime: null == festivalRemindTime ? _self.festivalRemindTime : festivalRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,birthdayEnabled: null == birthdayEnabled ? _self.birthdayEnabled : birthdayEnabled // ignore: cast_nullable_to_non_nullable
as bool,birthdayRemindDays: null == birthdayRemindDays ? _self.birthdayRemindDays : birthdayRemindDays // ignore: cast_nullable_to_non_nullable
as int,birthdayRemindTime: null == birthdayRemindTime ? _self.birthdayRemindTime : birthdayRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,
  ));
}
/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get horoscopeTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.horoscopeTime, (value) {
    return _then(_self.copyWith(horoscopeTime: value));
  });
}/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get festivalRemindTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.festivalRemindTime, (value) {
    return _then(_self.copyWith(festivalRemindTime: value));
  });
}/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get birthdayRemindTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.birthdayRemindTime, (value) {
    return _then(_self.copyWith(birthdayRemindTime: value));
  });
}
}



/// @nodoc


class _NotificationSettings extends NotificationSettings {
  const _NotificationSettings({this.horoscopeEnabled = true, this.horoscopeDaily = true, this.horoscopeMonthly = false, this.horoscopeYearly = true, this.horoscopeTime = const NotificationTime(hour: 6, minute: 30), this.importantHinduFestivals = true, this.commonFestivals = false, this.publicHolidays = true, this.festivalRemindDays = 1, this.festivalRemindTime = const NotificationTime(hour: 0, minute: 0), this.birthdayEnabled = true, this.birthdayRemindDays = 7, this.birthdayRemindTime = const NotificationTime(hour: 0, minute: 0)}): super._();
  

@override@JsonKey() final  bool horoscopeEnabled;
@override@JsonKey() final  bool horoscopeDaily;
@override@JsonKey() final  bool horoscopeMonthly;
@override@JsonKey() final  bool horoscopeYearly;
@override@JsonKey() final  NotificationTime horoscopeTime;
@override@JsonKey() final  bool importantHinduFestivals;
@override@JsonKey() final  bool commonFestivals;
@override@JsonKey() final  bool publicHolidays;
@override@JsonKey() final  int festivalRemindDays;
@override@JsonKey() final  NotificationTime festivalRemindTime;
@override@JsonKey() final  bool birthdayEnabled;
@override@JsonKey() final  int birthdayRemindDays;
@override@JsonKey() final  NotificationTime birthdayRemindTime;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsCopyWith<_NotificationSettings> get copyWith => __$NotificationSettingsCopyWithImpl<_NotificationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettings&&(identical(other.horoscopeEnabled, horoscopeEnabled) || other.horoscopeEnabled == horoscopeEnabled)&&(identical(other.horoscopeDaily, horoscopeDaily) || other.horoscopeDaily == horoscopeDaily)&&(identical(other.horoscopeMonthly, horoscopeMonthly) || other.horoscopeMonthly == horoscopeMonthly)&&(identical(other.horoscopeYearly, horoscopeYearly) || other.horoscopeYearly == horoscopeYearly)&&(identical(other.horoscopeTime, horoscopeTime) || other.horoscopeTime == horoscopeTime)&&(identical(other.importantHinduFestivals, importantHinduFestivals) || other.importantHinduFestivals == importantHinduFestivals)&&(identical(other.commonFestivals, commonFestivals) || other.commonFestivals == commonFestivals)&&(identical(other.publicHolidays, publicHolidays) || other.publicHolidays == publicHolidays)&&(identical(other.festivalRemindDays, festivalRemindDays) || other.festivalRemindDays == festivalRemindDays)&&(identical(other.festivalRemindTime, festivalRemindTime) || other.festivalRemindTime == festivalRemindTime)&&(identical(other.birthdayEnabled, birthdayEnabled) || other.birthdayEnabled == birthdayEnabled)&&(identical(other.birthdayRemindDays, birthdayRemindDays) || other.birthdayRemindDays == birthdayRemindDays)&&(identical(other.birthdayRemindTime, birthdayRemindTime) || other.birthdayRemindTime == birthdayRemindTime));
}


@override
int get hashCode => Object.hash(runtimeType,horoscopeEnabled,horoscopeDaily,horoscopeMonthly,horoscopeYearly,horoscopeTime,importantHinduFestivals,commonFestivals,publicHolidays,festivalRemindDays,festivalRemindTime,birthdayEnabled,birthdayRemindDays,birthdayRemindTime);

@override
String toString() {
  return 'NotificationSettings(horoscopeEnabled: $horoscopeEnabled, horoscopeDaily: $horoscopeDaily, horoscopeMonthly: $horoscopeMonthly, horoscopeYearly: $horoscopeYearly, horoscopeTime: $horoscopeTime, importantHinduFestivals: $importantHinduFestivals, commonFestivals: $commonFestivals, publicHolidays: $publicHolidays, festivalRemindDays: $festivalRemindDays, festivalRemindTime: $festivalRemindTime, birthdayEnabled: $birthdayEnabled, birthdayRemindDays: $birthdayRemindDays, birthdayRemindTime: $birthdayRemindTime)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsCopyWith<$Res> implements $NotificationSettingsCopyWith<$Res> {
  factory _$NotificationSettingsCopyWith(_NotificationSettings value, $Res Function(_NotificationSettings) _then) = __$NotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool horoscopeEnabled, bool horoscopeDaily, bool horoscopeMonthly, bool horoscopeYearly, NotificationTime horoscopeTime, bool importantHinduFestivals, bool commonFestivals, bool publicHolidays, int festivalRemindDays, NotificationTime festivalRemindTime, bool birthdayEnabled, int birthdayRemindDays, NotificationTime birthdayRemindTime
});


@override $NotificationTimeCopyWith<$Res> get horoscopeTime;@override $NotificationTimeCopyWith<$Res> get festivalRemindTime;@override $NotificationTimeCopyWith<$Res> get birthdayRemindTime;

}
/// @nodoc
class __$NotificationSettingsCopyWithImpl<$Res>
    implements _$NotificationSettingsCopyWith<$Res> {
  __$NotificationSettingsCopyWithImpl(this._self, this._then);

  final _NotificationSettings _self;
  final $Res Function(_NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? horoscopeEnabled = null,Object? horoscopeDaily = null,Object? horoscopeMonthly = null,Object? horoscopeYearly = null,Object? horoscopeTime = null,Object? importantHinduFestivals = null,Object? commonFestivals = null,Object? publicHolidays = null,Object? festivalRemindDays = null,Object? festivalRemindTime = null,Object? birthdayEnabled = null,Object? birthdayRemindDays = null,Object? birthdayRemindTime = null,}) {
  return _then(_NotificationSettings(
horoscopeEnabled: null == horoscopeEnabled ? _self.horoscopeEnabled : horoscopeEnabled // ignore: cast_nullable_to_non_nullable
as bool,horoscopeDaily: null == horoscopeDaily ? _self.horoscopeDaily : horoscopeDaily // ignore: cast_nullable_to_non_nullable
as bool,horoscopeMonthly: null == horoscopeMonthly ? _self.horoscopeMonthly : horoscopeMonthly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeYearly: null == horoscopeYearly ? _self.horoscopeYearly : horoscopeYearly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeTime: null == horoscopeTime ? _self.horoscopeTime : horoscopeTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,importantHinduFestivals: null == importantHinduFestivals ? _self.importantHinduFestivals : importantHinduFestivals // ignore: cast_nullable_to_non_nullable
as bool,commonFestivals: null == commonFestivals ? _self.commonFestivals : commonFestivals // ignore: cast_nullable_to_non_nullable
as bool,publicHolidays: null == publicHolidays ? _self.publicHolidays : publicHolidays // ignore: cast_nullable_to_non_nullable
as bool,festivalRemindDays: null == festivalRemindDays ? _self.festivalRemindDays : festivalRemindDays // ignore: cast_nullable_to_non_nullable
as int,festivalRemindTime: null == festivalRemindTime ? _self.festivalRemindTime : festivalRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,birthdayEnabled: null == birthdayEnabled ? _self.birthdayEnabled : birthdayEnabled // ignore: cast_nullable_to_non_nullable
as bool,birthdayRemindDays: null == birthdayRemindDays ? _self.birthdayRemindDays : birthdayRemindDays // ignore: cast_nullable_to_non_nullable
as int,birthdayRemindTime: null == birthdayRemindTime ? _self.birthdayRemindTime : birthdayRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTime,
  ));
}

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get horoscopeTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.horoscopeTime, (value) {
    return _then(_self.copyWith(horoscopeTime: value));
  });
}/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get festivalRemindTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.festivalRemindTime, (value) {
    return _then(_self.copyWith(festivalRemindTime: value));
  });
}/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeCopyWith<$Res> get birthdayRemindTime {
  
  return $NotificationTimeCopyWith<$Res>(_self.birthdayRemindTime, (value) {
    return _then(_self.copyWith(birthdayRemindTime: value));
  });
}
}

// dart format on
