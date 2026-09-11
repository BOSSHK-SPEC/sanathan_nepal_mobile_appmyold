import 'traditional_calendar.dart';
import 'traditional_date.dart';

/// Indian national calendar (Saka era, शक संवत्) as standardised by the
/// Calendar Reform Committee (1957) – exact, rule-based:
///
/// * Chaitra 1 = 22 March (21 March in Gregorian leap years).
/// * Chaitra has 30 days (31 in leap years); Vaishakha–Bhadra 31 days;
///   Ashwin–Phalguna 30 days.
/// * Saka year = Gregorian year − 78 on/after Chaitra 1, else − 79.
class SakaCalendar implements TraditionalCalendar {
  const SakaCalendar();

  static const List<String> _en = [
    'Chaitra',
    'Vaishakha',
    'Jyeshtha',
    'Ashadha',
    'Shravana',
    'Bhadrapada',
    'Ashwin',
    'Kartika',
    'Agrahayana',
    'Pausha',
    'Magha',
    'Phalguna',
  ];
  static const List<String> _hi = [
    'चैत्र',
    'वैशाख',
    'ज्येष्ठ',
    'आषाढ़',
    'श्रावण',
    'भाद्रपद',
    'आश्विन',
    'कार्तिक',
    'अग्रहायण',
    'पौष',
    'माघ',
    'फाल्गुन',
  ];

  @override
  String get id => 'saka';

  @override
  int get minYear => 1800;

  @override
  int get maxYear => 2100;

  @override
  List<int> get weekendWeekdays => const [0];

  @override
  String eraLabel({required String languageCode}) => switch (languageCode) {
    'hi' || 'ne' => 'शक',
    _ => 'Saka',
  };

  @override
  String displayName({required String languageCode}) => switch (languageCode) {
    'hi' => 'भारतीय राष्ट्रीय पंचांग (शक संवत्)',
    'ne' => 'भारतीय राष्ट्रिय पात्रो (शक संवत्)',
    _ => 'Indian National Calendar (Saka)',
  };

  static bool _isGregorianLeap(int y) =>
      (y % 4 == 0 && y % 100 != 0) || y % 400 == 0;

  /// Gregorian date of Chaitra 1 for the Gregorian year [gy].
  static DateTime _chaitra1(int gy) =>
      DateTime(gy, 3, _isGregorianLeap(gy) ? 21 : 22);

  /// Saka [year] is leap when Gregorian year (year + 78) is leap.
  static bool isLeapYear(int year) => _isGregorianLeap(year + 78);

  @override
  int daysInMonth(int year, int month) {
    if (month == 1) return isLeapYear(year) ? 31 : 30;
    if (month <= 6) return 31;
    return 30;
  }

  @override
  TraditionalDate fromGregorian(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    var year = d.year - 78;
    var start = _chaitra1(d.year);
    if (d.isBefore(start)) {
      year = d.year - 79;
      start = _chaitra1(d.year - 1);
    }
    var dayOfYear = d.difference(start).inDays + 1;
    var month = 1;
    while (dayOfYear > daysInMonth(year, month)) {
      dayOfYear -= daysInMonth(year, month);
      month++;
    }
    return TraditionalDate(year, month, dayOfYear);
  }

  @override
  DateTime toGregorian(TraditionalDate date) {
    var offset = date.day - 1;
    for (var m = 1; m < date.month; m++) {
      offset += daysInMonth(date.year, m);
    }
    return _chaitra1(date.year + 78).add(Duration(days: offset));
  }

  @override
  List<String> monthNames({required String languageCode}) =>
      languageCode == 'hi' || languageCode == 'ne' ? _hi : _en;

  @override
  String monthName(int month, {required String languageCode}) =>
      monthNames(languageCode: languageCode)[month - 1];
}

/// Vikram Samvat (विक्रम संवत्) year as used across North India: the year
/// number advances on Chaitra Shukla Pratipada (Mar/Apr). We approximate the
/// boundary with Saka Chaitra 1 (22 March), which is within a couple of weeks
/// of the lunar new year – adequate for header display.
abstract final class VikramSamvat {
  static int yearFor(DateTime date) {
    final saka = const SakaCalendar().fromGregorian(date);
    return saka.year + 135; // Vikram = Saka + 135
  }
}
