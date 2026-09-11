/// Timestamps as the API sends them.
///
/// The server speaks UTC (`2026-09-07T10:00:00.000Z`). `DateTime.parse` keeps
/// that value in UTC, and every widget that formats it then prints UTC: an
/// appointment at 3:30 PM in Kathmandu showed as 10:00 AM, and anything after
/// 6:15 PM showed the wrong day. Converting at the boundary — here, once —
/// keeps the rest of the app in the user's own clock.
///
/// Two kinds of value need two functions, because they are not the same thing:
///
///  * [instant] — a moment (`startsAt`, `createdAt`, `expiresAt`). Converted
///    to the device's zone.
///  * [date] — a calendar date (a birth date, a festival, a forex quote day).
///    Shifting one by a zone offset can move it to another day, and a birthday
///    is the same date everywhere; the year, month and day are taken as sent.
abstract final class ApiTime {
  /// A moment, in the device's zone; null when [raw] is missing or unparsable.
  static DateTime? instant(Object? raw) {
    final parsed = _parse(raw);
    return parsed?.toLocal();
  }

  /// [instant], with a fallback for the fields the app treats as required.
  static DateTime instantOr(Object? raw, DateTime fallback) =>
      instant(raw) ?? fallback;

  /// A calendar date at local midnight, keeping the year/month/day the server
  /// sent rather than the one the offset lands on.
  static DateTime? date(Object? raw) {
    final parsed = _parse(raw);
    if (parsed == null) return null;
    return DateTime(parsed.year, parsed.month, parsed.day);
  }

  /// [date], with a fallback.
  static DateTime dateOr(Object? raw, DateTime fallback) =>
      date(raw) ?? fallback;

  static DateTime? _parse(Object? raw) {
    if (raw is DateTime) return raw;
    if (raw is! String || raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }
}
