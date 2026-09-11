import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_prefs.freezed.dart';

/// Notification preferences chosen on the onboarding "Notification Settings"
/// step (horoscope / festivals / birthdays).
@freezed
abstract class NotificationPrefs with _$NotificationPrefs {
  const factory NotificationPrefs({
    @Default(true) bool horoscopeDaily,
    @Default(false) bool horoscopeMonthly,
    @Default(false) bool horoscopeYearly,

    /// Minutes since midnight (default 06:30).
    @Default(390) int horoscopeTimeMinutes,
    @Default(true) bool importantFestivals,
    @Default(true) bool commonFestivals,
    @Default(true) bool publicHolidays,
    @Default(1) int festivalRemindDaysBefore,
    @Default(390) int festivalTimeMinutes,
    @Default(true) bool birthdays,
    @Default(7) int birthdayRemindDaysBefore,
    @Default(390) int birthdayTimeMinutes,
  }) = _NotificationPrefs;
}
