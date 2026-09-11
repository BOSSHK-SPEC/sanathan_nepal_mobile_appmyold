// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationTimeModel _$NotificationTimeModelFromJson(
  Map<String, dynamic> json,
) => _NotificationTimeModel(
  hour: (json['hour'] as num?)?.toInt() ?? 0,
  minute: (json['minute'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$NotificationTimeModelToJson(
  _NotificationTimeModel instance,
) => <String, dynamic>{'hour': instance.hour, 'minute': instance.minute};

_NotificationSettingsModel _$NotificationSettingsModelFromJson(
  Map<String, dynamic> json,
) => _NotificationSettingsModel(
  horoscopeEnabled: json['horoscope_enabled'] as bool? ?? true,
  horoscopeDaily: json['horoscope_daily'] as bool? ?? true,
  horoscopeMonthly: json['horoscope_monthly'] as bool? ?? false,
  horoscopeYearly: json['horoscope_yearly'] as bool? ?? true,
  horoscopeTime: json['horoscope_time'] == null
      ? const NotificationTimeModel(hour: 6, minute: 30)
      : NotificationTimeModel.fromJson(
          json['horoscope_time'] as Map<String, dynamic>,
        ),
  importantHinduFestivals: json['important_hindu_festivals'] as bool? ?? true,
  commonFestivals: json['common_festivals'] as bool? ?? false,
  publicHolidays: json['public_holidays'] as bool? ?? true,
  festivalRemindDays: (json['festival_remind_days'] as num?)?.toInt() ?? 1,
  festivalRemindTime: json['festival_remind_time'] == null
      ? const NotificationTimeModel()
      : NotificationTimeModel.fromJson(
          json['festival_remind_time'] as Map<String, dynamic>,
        ),
  birthdayEnabled: json['birthday_enabled'] as bool? ?? true,
  birthdayRemindDays: (json['birthday_remind_days'] as num?)?.toInt() ?? 7,
  birthdayRemindTime: json['birthday_remind_time'] == null
      ? const NotificationTimeModel()
      : NotificationTimeModel.fromJson(
          json['birthday_remind_time'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$NotificationSettingsModelToJson(
  _NotificationSettingsModel instance,
) => <String, dynamic>{
  'horoscope_enabled': instance.horoscopeEnabled,
  'horoscope_daily': instance.horoscopeDaily,
  'horoscope_monthly': instance.horoscopeMonthly,
  'horoscope_yearly': instance.horoscopeYearly,
  'horoscope_time': instance.horoscopeTime.toJson(),
  'important_hindu_festivals': instance.importantHinduFestivals,
  'common_festivals': instance.commonFestivals,
  'public_holidays': instance.publicHolidays,
  'festival_remind_days': instance.festivalRemindDays,
  'festival_remind_time': instance.festivalRemindTime.toJson(),
  'birthday_enabled': instance.birthdayEnabled,
  'birthday_remind_days': instance.birthdayRemindDays,
  'birthday_remind_time': instance.birthdayRemindTime.toJson(),
};
