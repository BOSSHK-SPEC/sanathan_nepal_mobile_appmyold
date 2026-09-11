import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings.freezed.dart';

/// Wall-clock time (Flutter-free) used by the notification settings.
@freezed
abstract class NotificationTime with _$NotificationTime {
  const NotificationTime._();

  const factory NotificationTime({required int hour, required int minute}) =
      _NotificationTime;

  int get minutesOfDay => hour * 60 + minute;

  /// `6:30 AM`
  String format12h() {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    return '$h:${minute.toString().padLeft(2, '0')} ${hour < 12 ? 'AM' : 'PM'}';
  }
}

/// User preferences shown on the "Notification Settings" tab
/// (horoscope / festivals / birthday sections of the Figma profile page).
@freezed
abstract class NotificationSettings with _$NotificationSettings {
  const NotificationSettings._();

  const factory NotificationSettings({
    @Default(true) bool horoscopeEnabled,
    @Default(true) bool horoscopeDaily,
    @Default(false) bool horoscopeMonthly,
    @Default(true) bool horoscopeYearly,
    @Default(NotificationTime(hour: 6, minute: 30))
    NotificationTime horoscopeTime,
    @Default(true) bool importantHinduFestivals,
    @Default(false) bool commonFestivals,
    @Default(true) bool publicHolidays,
    @Default(1) int festivalRemindDays,
    @Default(NotificationTime(hour: 0, minute: 0))
    NotificationTime festivalRemindTime,
    @Default(true) bool birthdayEnabled,
    @Default(7) int birthdayRemindDays,
    @Default(NotificationTime(hour: 0, minute: 0))
    NotificationTime birthdayRemindTime,
  }) = _NotificationSettings;

  /// Festivals section header toggle = any festival option enabled.
  bool get festivalsEnabled =>
      importantHinduFestivals || commonFestivals || publicHolidays;
}
