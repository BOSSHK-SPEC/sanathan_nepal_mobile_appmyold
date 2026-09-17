/// Birth date and time as the profile API speaks them.
///
/// The server validates `dobAd` as `YYYY-MM-DD` and `birthTime` as 24-hour
/// `HH:mm`; `UserProfile` keeps the display forms `YYYY/MM/DD` and
/// `h:mm:ss AM`. Sending the display strings as they were failed every save
/// that touched either field with a 400, and reading the server's forms back
/// left the traditional-calendar date blank. Converting here — once, at the
/// boundary — keeps each side in its own format.
///
/// Both directions accept either form, so a value cached before this existed
/// still converts. Anything that is not a real date or time comes back null:
/// the field is left out of the request rather than failing the whole save.
abstract final class ProfileWireFormat {
  static final RegExp _date = RegExp(r'^(\d{4})[/-](\d{1,2})[/-](\d{1,2})$');
  static final RegExp _time = RegExp(
    r'^(\d{1,2}):(\d{2})(?::\d{2})?\s*([AaPp][Mm])?$',
  );

  /// `YYYY/MM/DD` → `YYYY-MM-DD`.
  static String? dateToWire(String? raw) => _formatDate(raw, '-');

  /// `YYYY-MM-DD` → `YYYY/MM/DD`.
  static String? dateFromWire(String? raw) => _formatDate(raw, '/');

  /// `4:12:00 PM` → `16:12`.
  static String? timeToWire(String? raw) {
    final time = _parseTime(raw);
    if (time == null) return null;
    final (hour, minute) = time;
    return '${_two(hour)}:${_two(minute)}';
  }

  /// `16:12` → `4:12:00 PM`, the form the edit screen's time picker writes.
  static String? timeFromWire(String? raw) {
    final time = _parseTime(raw);
    if (time == null) return null;
    final (hour, minute) = time;
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12:${_two(minute)}:00 ${hour < 12 ? 'AM' : 'PM'}';
  }

  static String? _formatDate(String? raw, String separator) {
    final match = _date.firstMatch(raw?.trim() ?? '');
    if (match == null) return null;
    final year = int.parse(match[1]!);
    final month = int.parse(match[2]!);
    final day = int.parse(match[3]!);
    // DateTime rolls 2006/02/30 over into March — not the date that was typed.
    final date = DateTime.utc(year, month, day);
    if (date.month != month || date.day != day) return null;
    return '${match[1]}$separator${_two(month)}$separator${_two(day)}';
  }

  /// Hour (0–23) and minute, from either a 12- or a 24-hour clock.
  static (int, int)? _parseTime(String? raw) {
    final match = _time.firstMatch(raw?.trim() ?? '');
    if (match == null) return null;
    var hour = int.parse(match[1]!);
    final minute = int.parse(match[2]!);
    final meridiem = match[3]?.toUpperCase();
    if (meridiem != null) {
      if (hour < 1 || hour > 12) return null;
      hour = hour % 12 + (meridiem == 'PM' ? 12 : 0);
    }
    if (hour > 23 || minute > 59) return null;
    return (hour, minute);
  }

  static String _two(int n) => n.toString().padLeft(2, '0');
}
