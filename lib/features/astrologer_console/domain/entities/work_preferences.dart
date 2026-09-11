import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/consult_channel.dart';

part 'work_preferences.freezed.dart';

/// How and when an astrologer wants to be interrupted by work.
///
/// Separate from the seeker's notification settings, which are about content
/// (horoscopes, festivals). These decide whether a phone rings at 2 a.m. and
/// which requests are even offered — closer to a shift policy than a
/// preference, so it lives with the console rather than notifications.
@freezed
abstract class WorkPreferences with _$WorkPreferences {
  const WorkPreferences._();

  const factory WorkPreferences({
    // --- Alerts ---------------------------------------------------------
    @Default(true) bool newRequestAlerts,
    @Default(true) bool alertSound,

    /// Keeps ringing until answered or expired. Off means one alert.
    @Default(true) bool ringUntilAnswered,
    @Default(true) bool scheduleReminders,
    @Default(true) bool payoutAlerts,
    @Default(true) bool reviewAlerts,
    @Default(false) bool marketingAlerts,

    // --- Quiet hours ----------------------------------------------------
    @Default(false) bool quietHoursEnabled,

    /// Minutes from midnight. A window may wrap past midnight (22:00 → 07:00),
    /// which is the normal case for sleep, so start > end is valid.
    @Default(22 * 60) int quietStartMinute,
    @Default(7 * 60) int quietEndMinute,

    // --- Which requests to offer ----------------------------------------
    @Default(<ConsultChannel>{}) Set<ConsultChannel> acceptedChannels,

    /// Requests beyond this many people already waiting are not offered.
    /// 0 means no cap.
    @Default(0) int maxQueueLength,

    /// Seconds an offer stays on screen before it is auto-declined. Short
    /// enough that a seeker is not left waiting, long enough to answer.
    @Default(30) int autoDeclineAfterSeconds,

    /// Auto-accepts requests from clients already consulted. Repeat clients
    /// are the profitable ones and the astrologer already knows the case.
    @Default(false) bool autoAcceptRepeatClients,
  }) = _WorkPreferences;

  /// Empty [acceptedChannels] means every channel — the same convention as
  /// [AvailabilityWindow.channels], so the two read alike.
  bool acceptsChannel(ConsultChannel channel) =>
      acceptedChannels.isEmpty || acceptedChannels.contains(channel);

  bool get isValid =>
      autoDeclineAfterSeconds >= 15 &&
      autoDeclineAfterSeconds <= 120 &&
      maxQueueLength >= 0 &&
      (!quietHoursEnabled || quietStartMinute != quietEndMinute);

  /// Whether [minuteOfDay] falls inside the quiet window, handling the
  /// wrap-past-midnight case.
  bool isQuietAt(int minuteOfDay) {
    if (!quietHoursEnabled) return false;
    return quietStartMinute <= quietEndMinute
        ? minuteOfDay >= quietStartMinute && minuteOfDay < quietEndMinute
        : minuteOfDay >= quietStartMinute || minuteOfDay < quietEndMinute;
  }
}
