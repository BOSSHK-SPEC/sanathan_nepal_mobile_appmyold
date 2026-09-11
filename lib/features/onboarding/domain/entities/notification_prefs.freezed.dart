// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_prefs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationPrefs {

 bool get horoscopeDaily; bool get horoscopeMonthly; bool get horoscopeYearly;/// Minutes since midnight (default 06:30).
 int get horoscopeTimeMinutes; bool get importantFestivals; bool get commonFestivals; bool get publicHolidays; int get festivalRemindDaysBefore; int get festivalTimeMinutes; bool get birthdays; int get birthdayRemindDaysBefore; int get birthdayTimeMinutes;
/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<NotificationPrefs> get copyWith => _$NotificationPrefsCopyWithImpl<NotificationPrefs>(this as NotificationPrefs, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPrefs&&(identical(other.horoscopeDaily, horoscopeDaily) || other.horoscopeDaily == horoscopeDaily)&&(identical(other.horoscopeMonthly, horoscopeMonthly) || other.horoscopeMonthly == horoscopeMonthly)&&(identical(other.horoscopeYearly, horoscopeYearly) || other.horoscopeYearly == horoscopeYearly)&&(identical(other.horoscopeTimeMinutes, horoscopeTimeMinutes) || other.horoscopeTimeMinutes == horoscopeTimeMinutes)&&(identical(other.importantFestivals, importantFestivals) || other.importantFestivals == importantFestivals)&&(identical(other.commonFestivals, commonFestivals) || other.commonFestivals == commonFestivals)&&(identical(other.publicHolidays, publicHolidays) || other.publicHolidays == publicHolidays)&&(identical(other.festivalRemindDaysBefore, festivalRemindDaysBefore) || other.festivalRemindDaysBefore == festivalRemindDaysBefore)&&(identical(other.festivalTimeMinutes, festivalTimeMinutes) || other.festivalTimeMinutes == festivalTimeMinutes)&&(identical(other.birthdays, birthdays) || other.birthdays == birthdays)&&(identical(other.birthdayRemindDaysBefore, birthdayRemindDaysBefore) || other.birthdayRemindDaysBefore == birthdayRemindDaysBefore)&&(identical(other.birthdayTimeMinutes, birthdayTimeMinutes) || other.birthdayTimeMinutes == birthdayTimeMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,horoscopeDaily,horoscopeMonthly,horoscopeYearly,horoscopeTimeMinutes,importantFestivals,commonFestivals,publicHolidays,festivalRemindDaysBefore,festivalTimeMinutes,birthdays,birthdayRemindDaysBefore,birthdayTimeMinutes);

@override
String toString() {
  return 'NotificationPrefs(horoscopeDaily: $horoscopeDaily, horoscopeMonthly: $horoscopeMonthly, horoscopeYearly: $horoscopeYearly, horoscopeTimeMinutes: $horoscopeTimeMinutes, importantFestivals: $importantFestivals, commonFestivals: $commonFestivals, publicHolidays: $publicHolidays, festivalRemindDaysBefore: $festivalRemindDaysBefore, festivalTimeMinutes: $festivalTimeMinutes, birthdays: $birthdays, birthdayRemindDaysBefore: $birthdayRemindDaysBefore, birthdayTimeMinutes: $birthdayTimeMinutes)';
}


}

/// @nodoc
abstract mixin class $NotificationPrefsCopyWith<$Res>  {
  factory $NotificationPrefsCopyWith(NotificationPrefs value, $Res Function(NotificationPrefs) _then) = _$NotificationPrefsCopyWithImpl;
@useResult
$Res call({
 bool horoscopeDaily, bool horoscopeMonthly, bool horoscopeYearly, int horoscopeTimeMinutes, bool importantFestivals, bool commonFestivals, bool publicHolidays, int festivalRemindDaysBefore, int festivalTimeMinutes, bool birthdays, int birthdayRemindDaysBefore, int birthdayTimeMinutes
});




}
/// @nodoc
class _$NotificationPrefsCopyWithImpl<$Res>
    implements $NotificationPrefsCopyWith<$Res> {
  _$NotificationPrefsCopyWithImpl(this._self, this._then);

  final NotificationPrefs _self;
  final $Res Function(NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? horoscopeDaily = null,Object? horoscopeMonthly = null,Object? horoscopeYearly = null,Object? horoscopeTimeMinutes = null,Object? importantFestivals = null,Object? commonFestivals = null,Object? publicHolidays = null,Object? festivalRemindDaysBefore = null,Object? festivalTimeMinutes = null,Object? birthdays = null,Object? birthdayRemindDaysBefore = null,Object? birthdayTimeMinutes = null,}) {
  return _then(_self.copyWith(
horoscopeDaily: null == horoscopeDaily ? _self.horoscopeDaily : horoscopeDaily // ignore: cast_nullable_to_non_nullable
as bool,horoscopeMonthly: null == horoscopeMonthly ? _self.horoscopeMonthly : horoscopeMonthly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeYearly: null == horoscopeYearly ? _self.horoscopeYearly : horoscopeYearly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeTimeMinutes: null == horoscopeTimeMinutes ? _self.horoscopeTimeMinutes : horoscopeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,importantFestivals: null == importantFestivals ? _self.importantFestivals : importantFestivals // ignore: cast_nullable_to_non_nullable
as bool,commonFestivals: null == commonFestivals ? _self.commonFestivals : commonFestivals // ignore: cast_nullable_to_non_nullable
as bool,publicHolidays: null == publicHolidays ? _self.publicHolidays : publicHolidays // ignore: cast_nullable_to_non_nullable
as bool,festivalRemindDaysBefore: null == festivalRemindDaysBefore ? _self.festivalRemindDaysBefore : festivalRemindDaysBefore // ignore: cast_nullable_to_non_nullable
as int,festivalTimeMinutes: null == festivalTimeMinutes ? _self.festivalTimeMinutes : festivalTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,birthdays: null == birthdays ? _self.birthdays : birthdays // ignore: cast_nullable_to_non_nullable
as bool,birthdayRemindDaysBefore: null == birthdayRemindDaysBefore ? _self.birthdayRemindDaysBefore : birthdayRemindDaysBefore // ignore: cast_nullable_to_non_nullable
as int,birthdayTimeMinutes: null == birthdayTimeMinutes ? _self.birthdayTimeMinutes : birthdayTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _NotificationPrefs implements NotificationPrefs {
  const _NotificationPrefs({this.horoscopeDaily = true, this.horoscopeMonthly = false, this.horoscopeYearly = false, this.horoscopeTimeMinutes = 390, this.importantFestivals = true, this.commonFestivals = true, this.publicHolidays = true, this.festivalRemindDaysBefore = 1, this.festivalTimeMinutes = 390, this.birthdays = true, this.birthdayRemindDaysBefore = 7, this.birthdayTimeMinutes = 390});
  

@override@JsonKey() final  bool horoscopeDaily;
@override@JsonKey() final  bool horoscopeMonthly;
@override@JsonKey() final  bool horoscopeYearly;
/// Minutes since midnight (default 06:30).
@override@JsonKey() final  int horoscopeTimeMinutes;
@override@JsonKey() final  bool importantFestivals;
@override@JsonKey() final  bool commonFestivals;
@override@JsonKey() final  bool publicHolidays;
@override@JsonKey() final  int festivalRemindDaysBefore;
@override@JsonKey() final  int festivalTimeMinutes;
@override@JsonKey() final  bool birthdays;
@override@JsonKey() final  int birthdayRemindDaysBefore;
@override@JsonKey() final  int birthdayTimeMinutes;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPrefsCopyWith<_NotificationPrefs> get copyWith => __$NotificationPrefsCopyWithImpl<_NotificationPrefs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPrefs&&(identical(other.horoscopeDaily, horoscopeDaily) || other.horoscopeDaily == horoscopeDaily)&&(identical(other.horoscopeMonthly, horoscopeMonthly) || other.horoscopeMonthly == horoscopeMonthly)&&(identical(other.horoscopeYearly, horoscopeYearly) || other.horoscopeYearly == horoscopeYearly)&&(identical(other.horoscopeTimeMinutes, horoscopeTimeMinutes) || other.horoscopeTimeMinutes == horoscopeTimeMinutes)&&(identical(other.importantFestivals, importantFestivals) || other.importantFestivals == importantFestivals)&&(identical(other.commonFestivals, commonFestivals) || other.commonFestivals == commonFestivals)&&(identical(other.publicHolidays, publicHolidays) || other.publicHolidays == publicHolidays)&&(identical(other.festivalRemindDaysBefore, festivalRemindDaysBefore) || other.festivalRemindDaysBefore == festivalRemindDaysBefore)&&(identical(other.festivalTimeMinutes, festivalTimeMinutes) || other.festivalTimeMinutes == festivalTimeMinutes)&&(identical(other.birthdays, birthdays) || other.birthdays == birthdays)&&(identical(other.birthdayRemindDaysBefore, birthdayRemindDaysBefore) || other.birthdayRemindDaysBefore == birthdayRemindDaysBefore)&&(identical(other.birthdayTimeMinutes, birthdayTimeMinutes) || other.birthdayTimeMinutes == birthdayTimeMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,horoscopeDaily,horoscopeMonthly,horoscopeYearly,horoscopeTimeMinutes,importantFestivals,commonFestivals,publicHolidays,festivalRemindDaysBefore,festivalTimeMinutes,birthdays,birthdayRemindDaysBefore,birthdayTimeMinutes);

@override
String toString() {
  return 'NotificationPrefs(horoscopeDaily: $horoscopeDaily, horoscopeMonthly: $horoscopeMonthly, horoscopeYearly: $horoscopeYearly, horoscopeTimeMinutes: $horoscopeTimeMinutes, importantFestivals: $importantFestivals, commonFestivals: $commonFestivals, publicHolidays: $publicHolidays, festivalRemindDaysBefore: $festivalRemindDaysBefore, festivalTimeMinutes: $festivalTimeMinutes, birthdays: $birthdays, birthdayRemindDaysBefore: $birthdayRemindDaysBefore, birthdayTimeMinutes: $birthdayTimeMinutes)';
}


}

/// @nodoc
abstract mixin class _$NotificationPrefsCopyWith<$Res> implements $NotificationPrefsCopyWith<$Res> {
  factory _$NotificationPrefsCopyWith(_NotificationPrefs value, $Res Function(_NotificationPrefs) _then) = __$NotificationPrefsCopyWithImpl;
@override @useResult
$Res call({
 bool horoscopeDaily, bool horoscopeMonthly, bool horoscopeYearly, int horoscopeTimeMinutes, bool importantFestivals, bool commonFestivals, bool publicHolidays, int festivalRemindDaysBefore, int festivalTimeMinutes, bool birthdays, int birthdayRemindDaysBefore, int birthdayTimeMinutes
});




}
/// @nodoc
class __$NotificationPrefsCopyWithImpl<$Res>
    implements _$NotificationPrefsCopyWith<$Res> {
  __$NotificationPrefsCopyWithImpl(this._self, this._then);

  final _NotificationPrefs _self;
  final $Res Function(_NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? horoscopeDaily = null,Object? horoscopeMonthly = null,Object? horoscopeYearly = null,Object? horoscopeTimeMinutes = null,Object? importantFestivals = null,Object? commonFestivals = null,Object? publicHolidays = null,Object? festivalRemindDaysBefore = null,Object? festivalTimeMinutes = null,Object? birthdays = null,Object? birthdayRemindDaysBefore = null,Object? birthdayTimeMinutes = null,}) {
  return _then(_NotificationPrefs(
horoscopeDaily: null == horoscopeDaily ? _self.horoscopeDaily : horoscopeDaily // ignore: cast_nullable_to_non_nullable
as bool,horoscopeMonthly: null == horoscopeMonthly ? _self.horoscopeMonthly : horoscopeMonthly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeYearly: null == horoscopeYearly ? _self.horoscopeYearly : horoscopeYearly // ignore: cast_nullable_to_non_nullable
as bool,horoscopeTimeMinutes: null == horoscopeTimeMinutes ? _self.horoscopeTimeMinutes : horoscopeTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,importantFestivals: null == importantFestivals ? _self.importantFestivals : importantFestivals // ignore: cast_nullable_to_non_nullable
as bool,commonFestivals: null == commonFestivals ? _self.commonFestivals : commonFestivals // ignore: cast_nullable_to_non_nullable
as bool,publicHolidays: null == publicHolidays ? _self.publicHolidays : publicHolidays // ignore: cast_nullable_to_non_nullable
as bool,festivalRemindDaysBefore: null == festivalRemindDaysBefore ? _self.festivalRemindDaysBefore : festivalRemindDaysBefore // ignore: cast_nullable_to_non_nullable
as int,festivalTimeMinutes: null == festivalTimeMinutes ? _self.festivalTimeMinutes : festivalTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,birthdays: null == birthdays ? _self.birthdays : birthdays // ignore: cast_nullable_to_non_nullable
as bool,birthdayRemindDaysBefore: null == birthdayRemindDaysBefore ? _self.birthdayRemindDaysBefore : birthdayRemindDaysBefore // ignore: cast_nullable_to_non_nullable
as int,birthdayTimeMinutes: null == birthdayTimeMinutes ? _self.birthdayTimeMinutes : birthdayTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
