import '../entities/time_window.dart';

/// The seven hora lords in Chaldean order — the sequence the planetary hours
/// run in, slowest apparent motion first.
enum HoraLord {
  shani('शनि', 'Shani', ChoghadiyaQuality.bad),
  guru('गुरु', 'Guru', ChoghadiyaQuality.good),
  mangal('मङ्गल', 'Mangal', ChoghadiyaQuality.bad),
  surya('सूर्य', 'Surya', ChoghadiyaQuality.neutral),
  shukra('शुक्र', 'Shukra', ChoghadiyaQuality.good),
  budha('बुध', 'Budha', ChoghadiyaQuality.good),
  chandra('चन्द्र', 'Chandra', ChoghadiyaQuality.good);

  const HoraLord(this.nameNe, this.nameEn, this.quality);

  final String nameNe;
  final String nameEn;
  final ChoghadiyaQuality quality;

  /// Lord of the weekday itself (0 = Sunday), which also rules the first hora
  /// after that day's sunrise — the rule the weekday names come from.
  static HoraLord ofWeekday(int weekday) =>
      _weekdayLords[weekday % 7];

  static const List<HoraLord> _weekdayLords = [
    surya, // Sunday
    chandra,
    mangal,
    budha,
    guru,
    shukra,
    shani, // Saturday
  ];
}

/// Day-length divisions that need more than the sunrise and sunset of one day:
/// the planetary hours, and the Choghadiya of the night.
///
/// Pure arithmetic over boundaries someone else measured — pass the sunrise and
/// sunset actually being shown (the server's, when there is one) so the periods
/// can never disagree with the times printed above them.
abstract final class DayPeriods {
  /// Night Choghadiya starts at a different segment from the day's, and steps
  /// backwards through the same seven names. Index into [_names], 0 = Sunday.
  static const List<int> _nightStart = [5, 1, 4, 0, 3, 6, 2];
  static const int _nightStep = 5; // ≡ −2 (mod 7)

  static const List<String> _namesNe = [
    'उद्वेग',
    'चर',
    'लाभ',
    'अमृत',
    'काल',
    'शुभ',
    'रोग',
  ];
  static const List<String> _namesEn = [
    'Udveg',
    'Char',
    'Labh',
    'Amrit',
    'Kaal',
    'Shubh',
    'Rog',
  ];
  static const List<ChoghadiyaQuality> _quality = [
    ChoghadiyaQuality.bad,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.bad,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.bad,
  ];

  /// The eight Choghadiya of the night, sunset to the next sunrise.
  ///
  /// [weekday] is the weekday the night *begins* on (0 = Sunday), because the
  /// night belongs to the day it started, not to the calendar date after
  /// midnight.
  static List<TimeWindow> nightChoghadiya(
    int weekday,
    DateTime sunset,
    DateTime nextSunrise,
  ) {
    if (!nextSunrise.isAfter(sunset)) return const [];
    final start = _nightStart[weekday % 7];
    return _split(sunset, nextSunrise, 8, (i, from, to) {
      final idx = (start + i * _nightStep) % 7;
      return TimeWindow(
        kind: TimeWindowKind.choghadiya,
        start: from,
        end: to,
        nameNe: _namesNe[idx],
        nameEn: _namesEn[idx],
        quality: _quality[idx],
      );
    });
  }

  /// The 24 horas of the day, sunrise to the next sunrise: twelve equal parts
  /// of the daylight, then twelve of the night. The first is ruled by the
  /// weekday's own lord and each one after it takes the next lord in Chaldean
  /// order, so the 25th would again be the next day's lord.
  ///
  /// Day and night horas are not the same length — only at an equinox do they
  /// meet at sixty minutes.
  static List<TimeWindow> horas(
    int weekday,
    DateTime sunrise,
    DateTime sunset,
    DateTime nextSunrise,
  ) {
    if (!sunset.isAfter(sunrise) || !nextSunrise.isAfter(sunset)) {
      return const [];
    }
    final first = HoraLord.ofWeekday(weekday).index;
    TimeWindow hora(int i, DateTime from, DateTime to) {
      final lord = HoraLord.values[(first + i) % HoraLord.values.length];
      return TimeWindow(
        kind: TimeWindowKind.hora,
        start: from,
        end: to,
        nameNe: lord.nameNe,
        nameEn: lord.nameEn,
        quality: lord.quality,
      );
    }

    return [
      ..._split(sunrise, sunset, 12, hora),
      ..._split(sunset, nextSunrise, 12, (i, from, to) => hora(12 + i, from, to)),
    ];
  }

  /// The window [now] falls in, or null outside the span. Windows are
  /// half-open, so a boundary instant belongs to the window starting on it and
  /// exactly one window can ever match.
  static TimeWindow? current(List<TimeWindow> windows, DateTime now) {
    for (final w in windows) {
      if (w.contains(now)) return w;
    }
    return null;
  }

  /// Splits [from]–[to] into [count] equal parts. The last part ends on [to]
  /// exactly: integer division loses up to [count] seconds, and a gap before
  /// sunrise is a visible bug on a screen that claims to cover the whole day.
  static List<TimeWindow> _split(
    DateTime from,
    DateTime to,
    int count,
    TimeWindow Function(int index, DateTime start, DateTime end) build,
  ) {
    final span = to.difference(from);
    final part = Duration(microseconds: span.inMicroseconds ~/ count);
    return [
      for (var i = 0; i < count; i++)
        build(
          i,
          from.add(part * i),
          i == count - 1 ? to : from.add(part * (i + 1)),
        ),
    ];
  }
}
