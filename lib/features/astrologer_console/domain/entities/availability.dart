import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/consult_channel.dart';

part 'availability.freezed.dart';

/// A working window on one weekday.
@freezed
abstract class AvailabilityWindow with _$AvailabilityWindow {
  const AvailabilityWindow._();

  const factory AvailabilityWindow({
    /// 1 = Monday … 7 = Sunday, matching `DateTime.weekday`.
    required int weekday,

    /// Minutes from midnight, local time.
    required int startMinute,
    required int endMinute,

    /// Channels offered in this window; empty means all of them.
    @Default(<ConsultChannel>{}) Set<ConsultChannel> channels,
  }) = _AvailabilityWindow;

  Duration get length => Duration(minutes: endMinute - startMinute);

  bool get isValid => endMinute > startMinute;

  bool overlaps(AvailabilityWindow other) =>
      weekday == other.weekday &&
      startMinute < other.endMinute &&
      other.startMinute < endMinute;
}

/// A day the astrologer is unavailable regardless of the weekly pattern.
@freezed
abstract class BlackoutDate with _$BlackoutDate {
  const factory BlackoutDate({
    required DateTime date,
    @Default('') String reason,
  }) = _BlackoutDate;
}

/// The whole schedule.
@freezed
abstract class Availability with _$Availability {
  const Availability._();

  const factory Availability({
    @Default(<AvailabilityWindow>[]) List<AvailabilityWindow> windows,
    @Default(<BlackoutDate>[]) List<BlackoutDate> blackouts,

    /// Manual online switch. Being scheduled and being online are different:
    /// a scheduled astrologer who has not gone online is not taking calls.
    @Default(false) bool isOnline,

    /// Minutes of breathing room booked between sessions.
    @Default(5) int bufferMinutes,
  }) = _Availability;

  List<AvailabilityWindow> windowsOn(int weekday) =>
      windows.where((w) => w.weekday == weekday).toList()
        ..sort((a, b) => a.startMinute.compareTo(b.startMinute));

  bool isBlackedOut(DateTime day) => blackouts.any(
    (b) =>
        b.date.year == day.year &&
        b.date.month == day.month &&
        b.date.day == day.day,
  );

  /// Total scheduled hours in a week — the headline number on the schedule
  /// screen, since it predicts earning capacity.
  double get weeklyHours =>
      windows.fold<int>(0, (sum, w) => sum + w.length.inMinutes) / 60;

  bool get hasSchedule => windows.isNotEmpty;
}
