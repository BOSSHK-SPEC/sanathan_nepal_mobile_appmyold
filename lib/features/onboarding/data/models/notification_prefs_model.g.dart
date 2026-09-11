// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_prefs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPrefsModel _$NotificationPrefsModelFromJson(
  Map<String, dynamic> json,
) => _NotificationPrefsModel(
  horoscopeDaily: json['horoscope_daily'] as bool? ?? true,
  horoscopeMonthly: json['horoscope_monthly'] as bool? ?? false,
  horoscopeYearly: json['horoscope_yearly'] as bool? ?? false,
  horoscopeTimeMinutes:
      (json['horoscope_time_minutes'] as num?)?.toInt() ?? 390,
  importantFestivals: json['important_festivals'] as bool? ?? true,
  commonFestivals: json['common_festivals'] as bool? ?? true,
  publicHolidays: json['public_holidays'] as bool? ?? true,
  festivalRemindDaysBefore:
      (json['festival_remind_days_before'] as num?)?.toInt() ?? 1,
  festivalTimeMinutes: (json['festival_time_minutes'] as num?)?.toInt() ?? 390,
  birthdays: json['birthdays'] as bool? ?? true,
  birthdayRemindDaysBefore:
      (json['birthday_remind_days_before'] as num?)?.toInt() ?? 7,
  birthdayTimeMinutes: (json['birthday_time_minutes'] as num?)?.toInt() ?? 390,
);

Map<String, dynamic> _$NotificationPrefsModelToJson(
  _NotificationPrefsModel instance,
) => <String, dynamic>{
  'horoscope_daily': instance.horoscopeDaily,
  'horoscope_monthly': instance.horoscopeMonthly,
  'horoscope_yearly': instance.horoscopeYearly,
  'horoscope_time_minutes': instance.horoscopeTimeMinutes,
  'important_festivals': instance.importantFestivals,
  'common_festivals': instance.commonFestivals,
  'public_holidays': instance.publicHolidays,
  'festival_remind_days_before': instance.festivalRemindDaysBefore,
  'festival_time_minutes': instance.festivalTimeMinutes,
  'birthdays': instance.birthdays,
  'birthday_remind_days_before': instance.birthdayRemindDaysBefore,
  'birthday_time_minutes': instance.birthdayTimeMinutes,
};
