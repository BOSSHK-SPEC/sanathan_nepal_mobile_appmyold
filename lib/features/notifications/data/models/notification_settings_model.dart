import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notification_settings.dart';

part 'notification_settings_model.freezed.dart';
part 'notification_settings_model.g.dart';

/// JSON shape of [NotificationTime].
@freezed
abstract class NotificationTimeModel with _$NotificationTimeModel {
  const NotificationTimeModel._();

  const factory NotificationTimeModel({
    @Default(0) int hour,
    @Default(0) int minute,
  }) = _NotificationTimeModel;

  factory NotificationTimeModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationTimeModelFromJson(json);

  factory NotificationTimeModel.fromEntity(NotificationTime t) =>
      NotificationTimeModel(hour: t.hour, minute: t.minute);

  NotificationTime toEntity() => NotificationTime(hour: hour, minute: minute);
}

/// JSON-serializable [NotificationSettings] (persisted as one string).
@freezed
abstract class NotificationSettingsModel with _$NotificationSettingsModel {
  const NotificationSettingsModel._();

  const factory NotificationSettingsModel({
    @Default(true) bool horoscopeEnabled,
    @Default(true) bool horoscopeDaily,
    @Default(false) bool horoscopeMonthly,
    @Default(true) bool horoscopeYearly,
    @Default(NotificationTimeModel(hour: 6, minute: 30))
    NotificationTimeModel horoscopeTime,
    @Default(true) bool importantHinduFestivals,
    @Default(false) bool commonFestivals,
    @Default(true) bool publicHolidays,
    @Default(1) int festivalRemindDays,
    @Default(NotificationTimeModel()) NotificationTimeModel festivalRemindTime,
    @Default(true) bool birthdayEnabled,
    @Default(7) int birthdayRemindDays,
    @Default(NotificationTimeModel()) NotificationTimeModel birthdayRemindTime,
  }) = _NotificationSettingsModel;

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  factory NotificationSettingsModel.fromEntity(
    NotificationSettings s,
  ) => NotificationSettingsModel(
    horoscopeEnabled: s.horoscopeEnabled,
    horoscopeDaily: s.horoscopeDaily,
    horoscopeMonthly: s.horoscopeMonthly,
    horoscopeYearly: s.horoscopeYearly,
    horoscopeTime: NotificationTimeModel.fromEntity(s.horoscopeTime),
    importantHinduFestivals: s.importantHinduFestivals,
    commonFestivals: s.commonFestivals,
    publicHolidays: s.publicHolidays,
    festivalRemindDays: s.festivalRemindDays,
    festivalRemindTime: NotificationTimeModel.fromEntity(s.festivalRemindTime),
    birthdayEnabled: s.birthdayEnabled,
    birthdayRemindDays: s.birthdayRemindDays,
    birthdayRemindTime: NotificationTimeModel.fromEntity(s.birthdayRemindTime),
  );

  /// Parses the JSON string written by [encode]; defaults on bad input.
  factory NotificationSettingsModel.decode(String? raw) {
    if (raw == null || raw.isEmpty) return const NotificationSettingsModel();
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      return const NotificationSettingsModel();
    }
    return NotificationSettingsModel.fromJson(decoded);
  }

  String encode() => jsonEncode(toJson());

  NotificationSettings toEntity() => NotificationSettings(
    horoscopeEnabled: horoscopeEnabled,
    horoscopeDaily: horoscopeDaily,
    horoscopeMonthly: horoscopeMonthly,
    horoscopeYearly: horoscopeYearly,
    horoscopeTime: horoscopeTime.toEntity(),
    importantHinduFestivals: importantHinduFestivals,
    commonFestivals: commonFestivals,
    publicHolidays: publicHolidays,
    festivalRemindDays: festivalRemindDays,
    festivalRemindTime: festivalRemindTime.toEntity(),
    birthdayEnabled: birthdayEnabled,
    birthdayRemindDays: birthdayRemindDays,
    birthdayRemindTime: birthdayRemindTime.toEntity(),
  );
}
