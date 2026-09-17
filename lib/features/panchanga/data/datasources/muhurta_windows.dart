import '../../domain/entities/time_window.dart';

/// Muhurta windows derived from a day's sunrise and sunset.
///
/// Shared by the on-device calculation and the server overlay, so the windows
/// always follow whichever sunrise is being shown — an accurate server sunrise
/// moves Rahu Kaal and the Choghadiya with it.
abstract final class MuhurtaWindows {
  /// 1-based eighth of the daylight per weekday (0 = Sunday).
  static const List<int> _rahuSegment = [8, 2, 7, 5, 6, 4, 3];
  static const List<int> _yamaSegment = [5, 4, 3, 2, 1, 7, 6];
  static const List<int> _gulikaSegment = [7, 6, 5, 4, 3, 2, 1];

  static const List<String> _choghadiyaNe = [
    'उद्वेग',
    'चर',
    'लाभ',
    'अमृत',
    'काल',
    'शुभ',
    'रोग',
  ];
  static const List<String> _choghadiyaEn = [
    'Udveg',
    'Char',
    'Labh',
    'Amrit',
    'Kaal',
    'Shubh',
    'Rog',
  ];
  static const List<ChoghadiyaQuality> _choghadiyaQuality = [
    ChoghadiyaQuality.bad,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.bad,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.bad,
  ];
  static const List<int> _choghadiyaStart = [0, 3, 6, 2, 5, 1, 4];

  /// Rahu Kaal, Yamaganda or Gulika Kaal: one eighth of the daylight at a
  /// weekday-fixed position.
  static TimeWindow kaal(
    TimeWindowKind kind,
    int weekday,
    DateTime sunrise,
    DateTime sunset,
  ) {
    final table = switch (kind) {
      TimeWindowKind.rahuKaal => _rahuSegment,
      TimeWindowKind.yamaganda => _yamaSegment,
      _ => _gulikaSegment,
    };
    final segment = Duration(
      seconds: sunset.difference(sunrise).inSeconds ~/ 8,
    );
    final start = sunrise.add(segment * (table[weekday % 7] - 1));
    return TimeWindow(kind: kind, start: start, end: start.add(segment));
  }

  /// Abhijit: the 8th of the day's 15 muhurtas.
  ///
  /// It was placed at solar noon ± 24 minutes, which is not how published
  /// panchangs place it; the muhurta rule matches Drik Panchang to the minute.
  static TimeWindow abhijit(DateTime sunrise, DateTime sunset) {
    final muhurta = Duration(
      seconds: sunset.difference(sunrise).inSeconds ~/ 15,
    );
    final start = sunrise.add(muhurta * 7);
    return TimeWindow(
      kind: TimeWindowKind.abhijit,
      start: start,
      end: start.add(muhurta),
      nameNe: 'अभिजित',
      nameEn: 'Abhijit',
      quality: ChoghadiyaQuality.good,
    );
  }

  /// The eight daytime Choghadiya segments, sunrise to sunset.
  static List<TimeWindow> choghadiya(
    int weekday,
    DateTime sunrise,
    DateTime sunset,
  ) {
    final segment = Duration(
      seconds: sunset.difference(sunrise).inSeconds ~/ 8,
    );
    return [
      for (var i = 0; i < 8; i++)
        () {
          final idx = (_choghadiyaStart[weekday % 7] + i) % 7;
          final start = sunrise.add(segment * i);
          return TimeWindow(
            kind: TimeWindowKind.choghadiya,
            start: start,
            end: i == 7 ? sunset : start.add(segment),
            nameNe: _choghadiyaNe[idx],
            nameEn: _choghadiyaEn[idx],
            quality: _choghadiyaQuality[idx],
          );
        }(),
    ];
  }
}
