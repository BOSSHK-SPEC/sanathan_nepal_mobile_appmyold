import 'package:intl/intl.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region.dart';

/// Date formatting helpers shared by the events widgets.
///
/// Region-neutral: the traditional calendar comes from `RegionConfig.calendar`
/// (Bikram Sambat in Nepal, Saka in India) and `languageCode` picks month /
/// weekday names and Devanagari digits (`ne`, `hi`).
abstract final class EventDateFormat {
  static const List<String> _weekdaysShortEn = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  static bool _devanagari(String languageCode) =>
      TraditionalCalendar.devanagariDigits(languageCode);

  /// Traditional date, e.g. `चैत १६, २०७९` / `Chaitra 16, 2079` (BS) or
  /// `चैत्र ९, १९४५` / `Chaitra 9, 1945` (Saka).
  static String traditional(
    DateTime date, {
    required TraditionalCalendar calendar,
    required String languageCode,
  }) {
    final t = calendar.fromGregorian(date);
    final month = calendar.monthName(t.month, languageCode: languageCode);
    return digits(
      '$month ${t.day}, ${t.year}',
      devanagari: _devanagari(languageCode),
    );
  }

  /// Traditional date with era for the region: Nepal shows the plain BS date
  /// (era implied by the design); India shows Saka + the Vikram Samvat year,
  /// e.g. `Chaitra 9, 1945 Saka · VS 2080` / `चैत्र ९, १९४५ शक · वि.सं. २०८०`.
  static String traditionalLine(
    DateTime date, {
    required RegionConfig config,
    required String languageCode,
  }) {
    final base = traditional(
      date,
      calendar: config.calendar,
      languageCode: languageCode,
    );
    if (!config.isIndia) return base;
    final dev = _devanagari(languageCode);
    final era = config.calendar.eraLabel(languageCode: languageCode);
    final vs = digits('${VikramSamvat.yearFor(date)}', devanagari: dev);
    final vsLabel = dev ? 'वि.सं.' : 'VS';
    return '$base $era · $vsLabel $vs';
  }

  /// e.g. `30 Mar, 2023` / `March 29, 2023`.
  static String ad(DateTime date, {bool long = false}) =>
      DateFormat(long ? 'MMMM d, yyyy' : 'd MMM, yyyy').format(date);

  /// `Mar 29, 2023` – narrow date columns.
  static String adMedium(DateTime date) =>
      DateFormat('MMM d, yyyy').format(date);

  /// Full weekday name from [weekdays] (index 0 = Sunday) – pass
  /// `EventsStrings.weekdays` for the active language.
  static String weekday(DateTime date, {required List<String> weekdays}) =>
      weekdays[date.weekday % 7];

  /// Figma list line. Nepal: `चैत १६, २०७९, बिहीवार - 30 Mar, 2023, Thu`;
  /// India (Gregorian-primary): `30 Mar, 2023, Thu - Chaitra 9, 1945 Saka · VS 2080`.
  static String listLine(
    DateTime date, {
    required RegionConfig config,
    required String languageCode,
    required List<String> weekdays,
  }) {
    final trad = traditionalLine(
      date,
      config: config,
      languageCode: languageCode,
    );
    final wd = weekday(date, weekdays: weekdays);
    final adPart = '${ad(date)}, ${_weekdaysShortEn[date.weekday % 7]}';
    return config.isIndia ? '${ad(date)}, $wd - $trad' : '$trad, $wd - $adPart';
  }

  /// Figma details line: `चैत १६, २०७९, बिहीवार | 30 March, 2023, Wed | तिथि`
  /// (Nepal) or `March 30, 2023, Thursday | Chaitra 9, 1945 Saka · VS 2080 | Tithi`
  /// (India).
  static String detailsLine(
    DateTime date, {
    required RegionConfig config,
    required String languageCode,
    required List<String> weekdays,
    String? tithi,
  }) {
    final trad = traditionalLine(
      date,
      config: config,
      languageCode: languageCode,
    );
    final wd = weekday(date, weekdays: weekdays);
    final parts = config.isIndia
        ? [
            '${ad(date, long: true)}, $wd',
            trad,
            if (tithi != null && tithi.isNotEmpty) tithi,
          ]
        : [
            '$trad, $wd',
            '${ad(date, long: true)}, ${_weekdaysShortEn[date.weekday % 7]}',
            if (tithi != null && tithi.isNotEmpty) tithi,
          ];
    return parts.join(' | ');
  }

  /// `2079-12-02` / `२०७९-१२-०२` in the traditional calendar.
  static String traditionalIso(
    DateTime date, {
    required TraditionalCalendar calendar,
    required bool devanagari,
  }) {
    final d = calendar.fromGregorian(date);
    final s =
        '${d.year}-${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
    return digits(s, devanagari: devanagari);
  }

  /// `2023-03-30`.
  static String adIso(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  /// 24-hour clock `6:26` / `१८:०६` (sunrise / sunset in the header card).
  static String time(DateTime t, {required bool devanagari}) => digits(
    '${t.hour}:${t.minute.toString().padLeft(2, '0')}',
    devanagari: devanagari,
  );

  /// Month + year of [date] in the region's primary calendar, e.g.
  /// `फागुन,२०७९` (Nepal) or `February, 2023` (India).
  static String primaryMonthYear(
    DateTime date, {
    required RegionConfig config,
    required String languageCode,
  }) {
    if (config.isIndia) return DateFormat('MMMM, yyyy').format(date);
    final t = config.calendar.fromGregorian(date);
    return digits(
      '${config.calendar.monthName(t.month, languageCode: languageCode)},'
      '${t.year}',
      devanagari: _devanagari(languageCode),
    );
  }

  /// Devanagari digits for Nepali / Hindi UIs, ASCII otherwise.
  static String digits(String s, {required bool devanagari}) =>
      devanagari ? s.toDevanagariDigits() : s;
}
