import '../../../../core/calendar/traditional_calendar.dart';
import '../../../../core/extensions/string_extensions.dart';

/// Small formatting helpers shared by the horoscope widgets.
///
/// `nepali:` = "render digits in Devanagari" – true for both Nepali and Hindi
/// (callers pass `context.usesDevanagariDigits`).
abstract final class HoroscopeFormat {
  /// `m:ss` (e.g. `5:07`), Devanagari digits when [nepali].
  static String clock(Duration d, {required bool nepali}) {
    final m = d.inMinutes;
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return localiseDigits('$m:$s', nepali: nepali);
  }

  /// Joins [values] with ", " and localises the digits.
  static String list(Iterable<Object> values, {required bool nepali}) =>
      localiseDigits(values.join(', '), nepali: nepali);

  static String localiseDigits(String text, {required bool nepali}) =>
      nepali ? text.toDevanagariDigits() : text;

  /// Digits for a language code (Devanagari for `ne`/`hi`).
  static String digitsFor(String text, String languageCode) => localiseDigits(
    text,
    nepali: TraditionalCalendar.devanagariDigits(languageCode),
  );

  static const List<String> _weekdaysNe = [
    'आइतबार',
    'सोमबार',
    'मंगलबार',
    'बुधबार',
    'बिहीबार',
    'शुक्रबार',
    'शनिबार',
  ];
  static const List<String> _weekdaysHi = [
    'रविवार',
    'सोमवार',
    'मंगलवार',
    'बुधवार',
    'गुरुवार',
    'शुक्रवार',
    'शनिवार',
  ];
  static const List<String> _weekdaysEn = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  /// Full weekday name of [date] for a language code.
  static String weekday(DateTime date, {required String languageCode}) {
    final i = date.weekday % 7; // 0 = Sunday
    return switch (languageCode) {
      'ne' => _weekdaysNe[i],
      'hi' => _weekdaysHi[i],
      _ => _weekdaysEn[i],
    };
  }
}
