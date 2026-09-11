import '../../../../core/extensions/string_extensions.dart';

/// Small formatting helpers shared by weather widgets. Digits are converted
/// to Devanagari when [devanagari] is true (Nepali and Hindi).
abstract final class WeatherFormat {
  static String digits(String s, {required bool devanagari}) =>
      devanagari ? s.toDevanagariDigits() : s;

  /// `26°` (rounded).
  static String degrees(double value, {required bool devanagari}) =>
      digits('${value.round()}°', devanagari: devanagari);

  /// `26°C` (rounded).
  static String celsius(double value, {required bool devanagari}) =>
      digits('${value.round()}°C', devanagari: devanagari);

  /// `90%`
  static String percent(int value, {required bool devanagari}) =>
      digits('$value%', devanagari: devanagari);

  /// `6:45` – 12-hour clock without AM/PM (Figma hourly strip style).
  static String clock(DateTime t, {required bool devanagari}) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    return digits('$h:$m', devanagari: devanagari);
  }

  /// `15.00` – 24-hour clock in the "Today" card style.
  static String clock24(DateTime t, {required bool devanagari}) {
    final m = t.minute.toString().padLeft(2, '0');
    return digits('${t.hour}.$m', devanagari: devanagari);
  }
}
