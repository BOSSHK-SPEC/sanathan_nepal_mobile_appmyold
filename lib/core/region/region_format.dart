import 'package:intl/intl.dart';

import '../extensions/string_extensions.dart';
import 'region.dart';

/// Region-aware formatting helpers (currency, phone, digits).
abstract final class RegionFormat {
  /// "रु. १,२३,४५६" (Nepal, Nepali) · "Rs. 1,23,456" (Nepal, English) ·
  /// "₹1,23,456" (India).
  static String money(
    num amount, {
    required RegionConfig config,
    required String languageCode,
    int decimals = 0,
  }) {
    final grouped = _indianGrouping(amount, decimals);
    final digits = languageCode == 'ne' || languageCode == 'hi'
        ? grouped.toDevanagariDigits()
        : grouped;
    final symbol = config.symbolFor(languageCode);
    final space = symbol.endsWith('.') ? ' ' : '';
    return '$symbol$space$digits';
  }

  /// Lakh/crore grouping used in both Nepal and India (12,34,567).
  static String _indianGrouping(num amount, int decimals) {
    final fixed = amount.toStringAsFixed(decimals);
    final parts = fixed.split('.');
    var intPart = parts[0];
    final negative = intPart.startsWith('-');
    if (negative) intPart = intPart.substring(1);
    String grouped;
    if (intPart.length <= 3) {
      grouped = intPart;
    } else {
      final last3 = intPart.substring(intPart.length - 3);
      var rest = intPart.substring(0, intPart.length - 3);
      final buf = <String>[];
      while (rest.length > 2) {
        buf.insert(0, rest.substring(rest.length - 2));
        rest = rest.substring(0, rest.length - 2);
      }
      if (rest.isNotEmpty) buf.insert(0, rest);
      grouped = '${buf.join(',')},$last3';
    }
    final result = parts.length > 1 ? '$grouped.${parts[1]}' : grouped;
    return negative ? '-$result' : result;
  }

  /// "+977 98XXXXXXXX" / "+91 98XXXXXXXX".
  static String phone(String national, {required RegionConfig config}) =>
      '${config.phonePrefix} $national';

  /// Local time label, e.g. "02:27 PM NST".
  static String time(DateTime t, {required RegionConfig config}) =>
      '${DateFormat('hh:mm a').format(t)} ${config.timeZoneLabel}';
}
