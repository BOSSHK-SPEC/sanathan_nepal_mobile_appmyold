import 'dart:math' as math;

import '../entities/lunar_day.dart';

/// Mean-synodic-month tithi approximation.
///
/// This is deliberately simple (no ephemeris) – it yields a deterministic,
/// roughly ±1-day-accurate lunar day that is good enough for calendar
/// decoration until a real Panchanga service is wired in.
abstract final class LunarCalculator {
  /// Reference new moon: 2000-01-06 18:14 UTC.
  static final DateTime _referenceNewMoon = DateTime.utc(2000, 1, 6, 18, 14);
  static const double synodicMonthDays = 29.530588853;

  /// Sunrise in Nepal (UTC+05:45) is roughly 06:00 local → 00:15 UTC.
  static const Duration _sunriseUtc = Duration(minutes: 15);

  /// Moon age in days (0 ≤ age < synodic month) at Nepali sunrise on [date].
  static double moonAge(DateTime date) {
    final sunrise = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ).add(_sunriseUtc);
    final elapsed = sunrise.difference(_referenceNewMoon).inMinutes / (60 * 24);
    var age = elapsed % synodicMonthDays;
    if (age < 0) age += synodicMonthDays;
    return age;
  }

  /// Lunar day at sunrise on the given civil [date] (Nepal time).
  static LunarDay forDate(DateTime date) {
    final tithi30 = (moonAge(date) / synodicMonthDays * 30).floor() + 1;
    if (tithi30 <= 15) {
      return LunarDay(tithiIndex: tithi30, paksha: Paksha.shukla);
    }
    return LunarDay(tithiIndex: tithi30 - 15, paksha: Paksha.krishna);
  }

  /// Fraction of the moon's face illuminated (0..1).
  static double illumination(DateTime date) {
    final phase = moonAge(date) / synodicMonthDays;
    return (1 - math.cos(2 * math.pi * phase)) / 2;
  }
}
