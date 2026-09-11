// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTimeModel {

 int get hour; int get minute;
/// Create a copy of NotificationTimeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTimeModelCopyWith<NotificationTimeModel> get copyWith => _$NotificationTimeModelCopyWithImpl<NotificationTimeModel>(this as NotificationTimeModel, _$identity);

  /// Serializes this NotificationTimeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTimeModel&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'NotificationTimeModel(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class $NotificationTimeModelCopyWith<$Res>  {
  factory $NotificationTimeModelCopyWith(NotificationTimeModel value, $Res Function(NotificationTimeModel) _then) = _$NotificationTimeModelCopyWithImpl;
@useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class _$NotificationTimeModelCopyWithImpl<$Res>
    implements $NotificationTimeModelCopyWith<$Res> {
  _$NotificationTimeModelCopyWithImpl(this._self, this._then);

  final NotificationTimeModel _self;
  final $Res Function(NotificationTimeModel) _then;

/// Create a copy of NotificationTimeModel
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

class _NotificationTimeModel extends NotificationTimeModel {
  const _NotificationTimeModel({this.hour = 0, this.minute = 0}): super._();
  factory _NotificationTimeModel.fromJson(Map<String, dynamic> json) => _$NotificationTimeModelFromJson(json);

@override@JsonKey() final  int hour;
@override@JsonKey() final  int minute;

/// Create a copy of NotificationTimeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTimeModelCopyWith<_NotificationTimeModel> get copyWith => __$NotificationTimeModelCopyWithImpl<_NotificationTimeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTimeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTimeModel&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,minute);

@override
String toString() {
  return 'NotificationTimeModel(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$NotificationTimeModelCopyWith<$Res> implements $NotificationTimeModelCopyWith<$Res> {
  factory _$NotificationTimeModelCopyWith(_NotificationTimeModel value, $Res Function(_NotificationTimeModel) _then) = __$NotificationTimeModelCopyWithImpl;
@override @useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class __$NotificationTimeModelCopyWithImpl<$Res>
    implements _$NotificationTimeModelCopyWith<$Res> {
  __$NotificationTimeModelCopyWithImpl(this._self, this._then);

  final _NotificationTimeModel _self;
  final $Res Function(_NotificationTimeModel) _then;

/// Create a copy of NotificationTimeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_NotificationTimeModel(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$NotificationSettingsModel {

 bool get horoscopeEnabled; bool get horoscopeDaily; bool get horoscopeMonthly; bool get horoscopeYearly; NotificationTimeModel get horoscopeTime; bool get importantHinduFestivals; bool get commonFestivals; bool get publicHolidays; int get festivalRemindDays; NotificationTimeModel get festivalRemindTime; bool get birthdayEnabled; int get birthdayRemindDays; NotificationTimeModel get birthdayRemindTime;
/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsModelCopyWith<NotificationSettingsModel> get copyWith => _$NotificationSettingsModelCopyWithImpl<NotificationSettingsModel>(this as NotificationSettingsModel, _$identity);

  /// Serializes this NotificationSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsModel&&(identical(other.horoscopeEnabled, horoscopeEnabled) || other.horoscopeEnabled == horoscopeEnabled)&&(identical(other.horoscopeDaily, horoscopeDaily) || other.horoscopeDaily == horoscopeDaily)&&(identical(other.horoscopeMonthly, horoscopeMonthly) || other.horoscopeMonthly == horoscopeMonthly)&&(identical(other.horoscopeYearly, horoscopeYearly) || other.horoscopeYearly == horoscopeYearly)&&(identical(other.horoscopeTime, horoscopeTime) || other.horoscopeTime == horoscopeTime)&&(identical(other.importantHinduFestivals, importantHinduFestivals) || other.importantHinduFestivals == importantHinduFestivals)&&(identical(other.commonFestivals, commonFestivals) || other.commonFestivals == commonFestivals)&&(identical(other.publicHolidays, publicHolidays) || other.publicHolidays == publicHolidays)&&(identical(other.festivalRemindDays, festivalRemindDays) || other.festivalRemindDays == festivalRemindDays)&&(identical(other.festivalRemindTime, festivalRemindTime) || other.festivalRemindTime == festivalRemindTime)&&(identical(other.birthdayEnabled, birthdayEnabled) || other.birthdayEnabled == birthdayEnabled)&&(identical(other.birthdayRemindDays, birthdayRemindDays) || other.birthdayRemindDays == birthdayRemindDays)&&(identical(other.birthdayRemindTime, birthdayRemindTime) || other.birthdayRemindTime == birthdayRemindTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,horoscopeEnabled,horoscopeDaily,horoscopeMonthly,horoscopeYearly,horoscopeTime,importantHinduFestivals,commonFestivals,publicHolidays,festivalRemindDays,festivalRemindTime,birthdayEnabled,birthdayRemindDays,birthdayRemindTime);

@override
String toString() {
  return 'NotificationSettingsModel(horoscopeEnabled: $horoscopeEnabled, horoscopeDaily: $horoscopeDaily, horoscopeMonthly: $horoscopeMonthly, horoscopeYearly: $horoscopeYearly, horoscopeTime: $horoscopeTime, importantHinduFestivals: $importantHinduFestivals, commonFestivals: $commonFestivals, publicHolidays: $publicHolidays, festivalRemindDays: $festivalRemindDays, festivalRemindTime: $festivalRemindTime, birthdayEnabled: $birthdayEnabled, birthdayRemindDays: $birthdayRemindDays, birthdayRemindTime: $birthdayRemindTime)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsModelCopyWith<$Res>  {
  factory $NotificationSettingsModelCopyWith(NotificationSettingsModel value, $Res Function(NotificationSettingsModel) _then) = _$NotificationSettingsModelCopyWithImpl;
@useResult
$Res call({
 bool horoscopeEnabled, bool horoscopeDaily, bool horoscopeMonthly, bool horoscopeYearly, NotificationTimeModel horoscopeTime, bool importantHinduFestivals, bool commonFestivals, bool publicHolidays, int festivalRemindDays, NotificationTimeModel festivalRemindTime, bool birthdayEnabled, int birthdayRemindDays, NotificationTimeModel birthdayRemindTime
});


$NotificationTimeModelCopyWith<$Res> get horoscopeTime;$NotificationTimeModelCopyWith<$Res> get festivalRemindTime;$NotificationTimeModelCopyWith<$Res> get birthdayRemindTime;

}
/// @nodoc
class _$NotificationSettingsModelCopyWithImpl<$Res>
    implements $NotificationSettingsModelCopyWith<$Res> {
  _$NotificationSettingsModelCopyWithImpl(this._self, this._then);

  final NotificationSettingsModel _self;
  final $Res Function(NotificationSettingsModel) _then;

/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? horoscopeEnabled = null,Object? horoscopeDaily = null,Object? horoscopeMonthly = null,Object? horoscopeYearly = null,Object? horoscopeTime = null,Object? importantHinduFestivals = null,Object? commonFestivals = null,Object? publicHolidays = null,Object? festivalRemindDays = null,Object? festivalRemindTime = null,Object? birthdayEnabled = null,Object? birthdayRemindDays = null,Object? birthdayRemindTime = null,}) {
  return _then(_self.copyWith(
horoscopeEnabled: null == horoscopeEnabled ? _self.horoscopeEnabled : horoscopeEnabled // ignore: cast_nullable_to_non_nullable
as bool,horoscopeDaily: null == horoscopeDaily ? _self.horoscopeDaily : horoscopeDaily // ignore: cast_nullable_to_non_nullable
as bool,horoscopeMonthly: null == horoscopeMonthly ? _self.horoscopeMonthly : horoscopeMonthly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeYearly: null == horoscopeYearly ? _self.horoscopeYearly : horoscopeYearly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeTime: null == horoscopeTime ? _self.horoscopeTime : horoscopeTime // ignore: cast_nullable_to_non_nullable
as NotificationTimeModel,importantHinduFestivals: null == importantHinduFestivals ? _self.importantHinduFestivals : importantHinduFestivals // ignore: cast_nullable_to_non_nullable
as bool,commonFestivals: null == commonFestivals ? _self.commonFestivals : commonFestivals // ignore: cast_nullable_to_non_nullable
as bool,publicHolidays: null == publicHolidays ? _self.publicHolidays : publicHolidays // ignore: cast_nullable_to_non_nullable
as bool,festivalRemindDays: null == festivalRemindDays ? _self.festivalRemindDays : festivalRemindDays // ignore: cast_nullable_to_non_nullable
as int,festivalRemindTime: null == festivalRemindTime ? _self.festivalRemindTime : festivalRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTimeModel,birthdayEnabled: null == birthdayEnabled ? _self.birthdayEnabled : birthdayEnabled // ignore: cast_nullable_to_non_nullable
as bool,birthdayRemindDays: null == birthdayRemindDays ? _self.birthdayRemindDays : birthdayRemindDays // ignore: cast_nullable_to_non_nullable
as int,birthdayRemindTime: null == birthdayRemindTime ? _self.birthdayRemindTime : birthdayRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTimeModel,
  ));
}
/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeModelCopyWith<$Res> get horoscopeTime {
  
  return $NotificationTimeModelCopyWith<$Res>(_self.horoscopeTime, (value) {
    return _then(_self.copyWith(horoscopeTime: value));
  });
}/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeModelCopyWith<$Res> get festivalRemindTime {
  
  return $NotificationTimeModelCopyWith<$Res>(_self.festivalRemindTime, (value) {
    return _then(_self.copyWith(festivalRemindTime: value));
  });
}/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeModelCopyWith<$Res> get birthdayRemindTime {
  
  return $NotificationTimeModelCopyWith<$Res>(_self.birthdayRemindTime, (value) {
    return _then(_self.copyWith(birthdayRemindTime: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _NotificationSettingsModel extends NotificationSettingsModel {
  const _NotificationSettingsModel({this.horoscopeEnabled = true, this.horoscopeDaily = true, this.horoscopeMonthly = false, this.horoscopeYearly = true, this.horoscopeTime = const NotificationTimeModel(hour: 6, minute: 30), this.importantHinduFestivals = true, this.commonFestivals = false, this.publicHolidays = true, this.festivalRemindDays = 1, this.festivalRemindTime = const NotificationTimeModel(), this.birthdayEnabled = true, this.birthdayRemindDays = 7, this.birthdayRemindTime = const NotificationTimeModel()}): super._();
  factory _NotificationSettingsModel.fromJson(Map<String, dynamic> json) => _$NotificationSettingsModelFromJson(json);

@override@JsonKey() final  bool horoscopeEnabled;
@override@JsonKey() final  bool horoscopeDaily;
@override@JsonKey() final  bool horoscopeMonthly;
@override@JsonKey() final  bool horoscopeYearly;
@override@JsonKey() final  NotificationTimeModel horoscopeTime;
@override@JsonKey() final  bool importantHinduFestivals;
@override@JsonKey() final  bool commonFestivals;
@override@JsonKey() final  bool publicHolidays;
@override@JsonKey() final  int festivalRemindDays;
@override@JsonKey() final  NotificationTimeModel festivalRemindTime;
@override@JsonKey() final  bool birthdayEnabled;
@override@JsonKey() final  int birthdayRemindDays;
@override@JsonKey() final  NotificationTimeModel birthdayRemindTime;

/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsModelCopyWith<_NotificationSettingsModel> get copyWith => __$NotificationSettingsModelCopyWithImpl<_NotificationSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsModel&&(identical(other.horoscopeEnabled, horoscopeEnabled) || other.horoscopeEnabled == horoscopeEnabled)&&(identical(other.horoscopeDaily, horoscopeDaily) || other.horoscopeDaily == horoscopeDaily)&&(identical(other.horoscopeMonthly, horoscopeMonthly) || other.horoscopeMonthly == horoscopeMonthly)&&(identical(other.horoscopeYearly, horoscopeYearly) || other.horoscopeYearly == horoscopeYearly)&&(identical(other.horoscopeTime, horoscopeTime) || other.horoscopeTime == horoscopeTime)&&(identical(other.importantHinduFestivals, importantHinduFestivals) || other.importantHinduFestivals == importantHinduFestivals)&&(identical(other.commonFestivals, commonFestivals) || other.commonFestivals == commonFestivals)&&(identical(other.publicHolidays, publicHolidays) || other.publicHolidays == publicHolidays)&&(identical(other.festivalRemindDays, festivalRemindDays) || other.festivalRemindDays == festivalRemindDays)&&(identical(other.festivalRemindTime, festivalRemindTime) || other.festivalRemindTime == festivalRemindTime)&&(identical(other.birthdayEnabled, birthdayEnabled) || other.birthdayEnabled == birthdayEnabled)&&(identical(other.birthdayRemindDays, birthdayRemindDays) || other.birthdayRemindDays == birthdayRemindDays)&&(identical(other.birthdayRemindTime, birthdayRemindTime) || other.birthdayRemindTime == birthdayRemindTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,horoscopeEnabled,horoscopeDaily,horoscopeMonthly,horoscopeYearly,horoscopeTime,importantHinduFestivals,commonFestivals,publicHolidays,festivalRemindDays,festivalRemindTime,birthdayEnabled,birthdayRemindDays,birthdayRemindTime);

@override
String toString() {
  return 'NotificationSettingsModel(horoscopeEnabled: $horoscopeEnabled, horoscopeDaily: $horoscopeDaily, horoscopeMonthly: $horoscopeMonthly, horoscopeYearly: $horoscopeYearly, horoscopeTime: $horoscopeTime, importantHinduFestivals: $importantHinduFestivals, commonFestivals: $commonFestivals, publicHolidays: $publicHolidays, festivalRemindDays: $festivalRemindDays, festivalRemindTime: $festivalRemindTime, birthdayEnabled: $birthdayEnabled, birthdayRemindDays: $birthdayRemindDays, birthdayRemindTime: $birthdayRemindTime)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsModelCopyWith<$Res> implements $NotificationSettingsModelCopyWith<$Res> {
  factory _$NotificationSettingsModelCopyWith(_NotificationSettingsModel value, $Res Function(_NotificationSettingsModel) _then) = __$NotificationSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 bool horoscopeEnabled, bool horoscopeDaily, bool horoscopeMonthly, bool horoscopeYearly, NotificationTimeModel horoscopeTime, bool importantHinduFestivals, bool commonFestivals, bool publicHolidays, int festivalRemindDays, NotificationTimeModel festivalRemindTime, bool birthdayEnabled, int birthdayRemindDays, NotificationTimeModel birthdayRemindTime
});


@override $NotificationTimeModelCopyWith<$Res> get horoscopeTime;@override $NotificationTimeModelCopyWith<$Res> get festivalRemindTime;@override $NotificationTimeModelCopyWith<$Res> get birthdayRemindTime;

}
/// @nodoc
class __$NotificationSettingsModelCopyWithImpl<$Res>
    implements _$NotificationSettingsModelCopyWith<$Res> {
  __$NotificationSettingsModelCopyWithImpl(this._self, this._then);

  final _NotificationSettingsModel _self;
  final $Res Function(_NotificationSettingsModel) _then;

/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? horoscopeEnabled = null,Object? horoscopeDaily = null,Object? horoscopeMonthly = null,Object? horoscopeYearly = null,Object? horoscopeTime = null,Object? importantHinduFestivals = null,Object? commonFestivals = null,Object? publicHolidays = null,Object? festivalRemindDays = null,Object? festivalRemindTime = null,Object? birthdayEnabled = null,Object? birthdayRemindDays = null,Object? birthdayRemindTime = null,}) {
  return _then(_NotificationSettingsModel(
horoscopeEnabled: null == horoscopeEnabled ? _self.horoscopeEnabled : horoscopeEnabled // ignore: cast_nullable_to_non_nullable
as bool,horoscopeDaily: null == horoscopeDaily ? _self.horoscopeDaily : horoscopeDaily // ignore: cast_nullable_to_non_nullable
as bool,horoscopeMonthly: null == horoscopeMonthly ? _self.horoscopeMonthly : horoscopeMonthly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeYearly: null == horoscopeYearly ? _self.horoscopeYearly : horoscopeYearly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeTime: null == horoscopeTime ? _self.horoscopeTime : horoscopeTime // ignore: cast_nullable_to_non_nullable
as NotificationTimeModel,importantHinduFestivals: null == importantHinduFestivals ? _self.importantHinduFestivals : importantHinduFestivals // ignore: cast_nullable_to_non_nullable
as bool,commonFestivals: null == commonFestivals ? _self.commonFestivals : commonFestivals // ignore: cast_nullable_to_non_nullable
as bool,publicHolidays: null == publicHolidays ? _self.publicHolidays : publicHolidays // ignore: cast_nullable_to_non_nullable
as bool,festivalRemindDays: null == festivalRemindDays ? _self.festivalRemindDays : festivalRemindDays // ignore: cast_nullable_to_non_nullable
as int,festivalRemindTime: null == festivalRemindTime ? _self.festivalRemindTime : festivalRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTimeModel,birthdayEnabled: null == birthdayEnabled ? _self.birthdayEnabled : birthdayEnabled // ignore: cast_nullable_to_non_nullable
as bool,birthdayRemindDays: null == birthdayRemindDays ? _self.birthdayRemindDays : birthdayRemindDays // ignore: cast_nullable_to_non_nullable
as int,birthdayRemindTime: null == birthdayRemindTime ? _self.birthdayRemindTime : birthdayRemindTime // ignore: cast_nullable_to_non_nullable
as NotificationTimeModel,
  ));
}

/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeModelCopyWith<$Res> get horoscopeTime {
  
  return $NotificationTimeModelCopyWith<$Res>(_self.horoscopeTime, (value) {
    return _then(_self.copyWith(horoscopeTime: value));
  });
}/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeModelCopyWith<$Res> get festivalRemindTime {
  
  return $NotificationTimeModelCopyWith<$Res>(_self.festivalRemindTime, (value) {
    return _then(_self.copyWith(festivalRemindTime: value));
  });
}/// Create a copy of NotificationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationTimeModelCopyWith<$Res> get birthdayRemindTime {
  
  return $NotificationTimeModelCopyWith<$Res>(_self.birthdayRemindTime, (value) {
    return _then(_self.copyWith(birthdayRemindTime: value));
  });
}
}

// dart format on
