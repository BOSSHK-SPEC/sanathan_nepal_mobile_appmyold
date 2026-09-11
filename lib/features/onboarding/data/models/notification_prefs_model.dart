import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notification_prefs.dart';

part 'notification_prefs_model.freezed.dart';
part 'notification_prefs_model.g.dart';

/// JSON-serialisable [NotificationPrefs].
@freezed
abstract class NotificationPrefsModel with _$NotificationPrefsModel {
  const NotificationPrefsModel._();

  const factory NotificationPrefsModel({
    @Default(true) bool horoscopeDaily,
    @Default(false) bool horoscopeMonthly,
    @Default(false) bool horoscopeYearly,
    @Default(390) int horoscopeTimeMinutes,
    @Default(true) bool importantFestivals,
    @Default(true) bool commonFestivals,
    @Default(true) bool publicHolidays,
    @Default(1) int festivalRemindDaysBefore,
    @Default(390) int festivalTimeMinutes,
    @Default(true) bool birthdays,
    @Default(7) int birthdayRemindDaysBefore,
    @Default(390) int birthdayTimeMinutes,
  }) = _NotificationPrefsModel;

  factory NotificationPrefsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPrefsModelFromJson(json);

  factory NotificationPrefsModel.fromEntity(NotificationPrefs e) =>
      NotificationPrefsModel(
        horoscopeDaily: e.horoscopeDaily,
        horoscopeMonthly: e.horoscopeMonthly,
        horoscopeYearly: e.horoscopeYearly,
        horoscopeTimeMinutes: e.horoscopeTimeMinutes,
        importantFestivals: e.importantFestivals,
        commonFestivals: e.commonFestivals,
        publicHolidays: e.publicHolidays,
        festivalRemindDaysBefore: e.festivalRemindDaysBefore,
        festivalTimeMinutes: e.festivalTimeMinutes,
        birthdays: e.birthdays,
        birthdayRemindDaysBefore: e.birthdayRemindDaysBefore,
        birthdayTimeMinutes: e.birthdayTimeMinutes,
      );

  NotificationPrefs toEntity() => NotificationPrefs(
    horoscopeDaily: horoscopeDaily,
    horoscopeMonthly: horoscopeMonthly,
    horoscopeYearly: horoscopeYearly,
    horoscopeTimeMinutes: horoscopeTimeMinutes,
    importantFestivals: importantFestivals,
    commonFestivals: commonFestivals,
    publicHolidays: publicHolidays,
    festivalRemindDaysBefore: festivalRemindDaysBefore,
    festivalTimeMinutes: festivalTimeMinutes,
    birthdays: birthdays,
    birthdayRemindDaysBefore: birthdayRemindDaysBefore,
    birthdayTimeMinutes: birthdayTimeMinutes,
  );
}
