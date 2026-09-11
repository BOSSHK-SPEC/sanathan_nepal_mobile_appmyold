import 'package:intl/intl.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region_all.dart';

/// Number / date formatting shared by forex widgets. Digits are rendered in
/// Devanagari when [devanagari] is true (Nepali and Hindi).
abstract final class ForexFormat {
  static String digits(String s, {required bool devanagari}) =>
      devanagari ? s.toDevanagariDigits() : s;

  /// `130.85`
  static String rate(double v, {required bool devanagari}) =>
      digits(v.toStringAsFixed(2), devanagari: devanagari);

  /// Compact amount: drops trailing `.00`, keeps up to 2 decimals.
  static String amount(double v, {required bool devanagari}) {
    final fixed = v.toStringAsFixed(2);
    final trimmed = fixed.endsWith('.00')
        ? fixed.substring(0, fixed.length - 3)
        : fixed;
    return digits(trimmed, devanagari: devanagari);
  }

  /// `फागुन १५, २०७९ (27 February, 2023)` – traditional-calendar date first
  /// (Bikram Sambat for Nepal, Saka for India), Gregorian in brackets.
  static String publishedDate(
    DateTime d, {
    required TraditionalCalendar calendar,
    required String languageCode,
  }) {
    final td = calendar.fromGregorian(d);
    final devanagari = TraditionalCalendar.devanagariDigits(languageCode);
    final month = calendar.monthName(td.month, languageCode: languageCode);
    final local = digits(
      '$month ${td.day}, ${td.year}',
      devanagari: devanagari,
    );
    final ad = DateFormat('d MMMM, yyyy').format(d);
    return '$local ($ad)';
  }

  /// Short axis label: `Mar 1` for ≤ 30-day ranges, `Mar` for a year.
  static String axisDate(
    DateTime d, {
    required bool devanagari,
    bool monthOnly = false,
  }) {
    final s = DateFormat(monthOnly ? 'MMM' : 'MMM d').format(d);
    return digits(s, devanagari: devanagari);
  }

  /// Local-currency label used in the trend title: the Figma legacy `NRS`
  /// for Nepal, otherwise the ISO code (`INR`).
  static String localLabel(RegionConfig config) =>
      config.currencyCode == 'NPR' ? 'NRS' : config.currencyCode;

  /// Chart axis currency symbol without the trailing dot: `Rs` / `रु` / `₹`.
  static String axisSymbol(
    RegionConfig config, {
    required String languageCode,
  }) {
    final symbol = config.symbolFor(languageCode);
    return symbol.endsWith('.')
        ? symbol.substring(0, symbol.length - 1)
        : symbol;
  }
}
