import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region.dart';

/// Number/date formatting helpers for the panchanga widgets.
///
/// `devanagari` = render digits in Devanagari (Nepali & Hindi UI).
abstract final class PanchangaFormat {
  static String digits(String text, {required bool devanagari}) =>
      devanagari ? text.toDevanagariDigits() : text;

  static String _two(int v) => v.toString().padLeft(2, '0');

  /// `HH:mm:ss`, localised digits.
  static String time(DateTime t, {required bool devanagari}) => digits(
    '${_two(t.hour)}:${_two(t.minute)}:${_two(t.second)}',
    devanagari: devanagari,
  );

  /// `HH:mm`, localised digits.
  static String hm(DateTime t, {required bool devanagari}) =>
      digits('${_two(t.hour)}:${_two(t.minute)}', devanagari: devanagari);

  /// `HH:mm – HH:mm`, localised digits.
  static String range(DateTime a, DateTime b, {required bool devanagari}) =>
      '${hm(a, devanagari: devanagari)} – ${hm(b, devanagari: devanagari)}';

  /// Fixed-point number, localised digits.
  static String number(
    double v, {
    required bool devanagari,
    int decimals = 6,
  }) => digits(v.toStringAsFixed(decimals), devanagari: devanagari);

  /// Date in the region's traditional calendar, e.g. "फागुन ११, २०७९" /
  /// "Falgun 11, 2079" (Nepal) or "श्रावण २७, १९४८" / "Shravana 27, 1948"
  /// (India).
  static String traditionalDate(
    DateTime d, {
    required TraditionalCalendar calendar,
    required String languageCode,
  }) {
    final t = calendar.fromGregorian(d);
    final month = calendar.monthName(t.month, languageCode: languageCode);
    return digits(
      '$month ${t.day}, ${t.year}',
      devanagari: TraditionalCalendar.devanagariDigits(languageCode),
    );
  }

  static const _monthsEn = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// e.g. "23 Feb, 2023" (English digits – ई.सं. is shown that way in the
  /// design), or Devanagari digits when [devanagari].
  static String adDate(DateTime d, {required bool devanagari}) => digits(
    '${d.day} ${_monthsEn[d.month - 1]}, ${d.year}',
    devanagari: devanagari,
  );

  /// Short Gregorian date without year, e.g. "23 Feb".
  static String adShort(DateTime d, {required bool devanagari}) =>
      digits('${d.day} ${_monthsEn[d.month - 1]}', devanagari: devanagari);

  /// Date chip of a suva sait / muhurat: Nepal shows the Bikram Sambat date,
  /// India shows Gregorian + Saka ("27 Aug, 2026 · Shravana 5, 1948").
  static String saitDate(
    DateTime d, {
    required RegionConfig config,
    required String languageCode,
  }) {
    final traditional = traditionalDate(
      d,
      calendar: config.calendar,
      languageCode: languageCode,
    );
    if (!config.isIndia) return traditional;
    final devanagari = TraditionalCalendar.devanagariDigits(languageCode);
    return '${adDate(d, devanagari: devanagari)} · $traditional';
  }
}
