import 'package:nepali_utils/nepali_utils.dart';

extension StringX on String {
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

extension NumNepaliX on num {
  /// Formats digits in Devanagari (e.g. 2079 → २०७९).
  String toNepaliDigits() => NepaliUnicode.convert(toString());
}

extension IntDevanagariX on String {
  /// Converts ASCII digits inside this string into Devanagari digits.
  String toDevanagariDigits() {
    const map = {
      '0': '०',
      '1': '१',
      '2': '२',
      '3': '३',
      '4': '४',
      '5': '५',
      '6': '६',
      '7': '७',
      '8': '८',
      '9': '९',
    };
    return split('').map((ch) => map[ch] ?? ch).join();
  }
}
