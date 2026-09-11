import 'dart:math';

/// Generates ULIDs the backend will accept.
///
/// The server validates ids against `^[0-7][0-9A-HJKMNP-TV-Z]{25}$` — 26
/// characters of Crockford base32, whose alphabet omits I, L, O and U so a
/// hand-copied id cannot be misread. The leading character is 0-7 because the
/// 48-bit timestamp only fills three bits of the first symbol.
///
/// The app needs these because some ids are client-supplied: a chat message
/// carries its own id so a retry after a dropped connection collapses onto one
/// row rather than posting twice.
abstract final class Ulid {
  const Ulid._();

  static const String _alphabet = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
  static final Random _random = Random.secure();

  /// A new ULID: 10 characters of timestamp, then 16 of randomness.
  ///
  /// The timestamp comes first and is written most-significant symbol first,
  /// which is what makes ULIDs sort by creation time as plain strings.
  static String generate([DateTime? now]) {
    final millis = (now ?? DateTime.now()).millisecondsSinceEpoch;
    final buffer = StringBuffer();

    for (var shift = 45; shift >= 0; shift -= 5) {
      buffer.write(_alphabet[(millis >> shift) & 0x1F]);
    }
    for (var i = 0; i < 16; i++) {
      buffer.write(_alphabet[_random.nextInt(32)]);
    }
    return buffer.toString();
  }
}
