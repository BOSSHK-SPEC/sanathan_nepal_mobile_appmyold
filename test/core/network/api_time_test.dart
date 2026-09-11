import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_time.dart';

void main() {
  test('a UTC moment becomes the device\'s own clock', () {
    final parsed = ApiTime.instant('2026-09-07T10:00:00.000Z')!;

    expect(parsed.isUtc, isFalse);
    // 10:00 UTC is 15:30 in India and 15:45 in Nepal; the app used to print
    // "10:00 AM" on the profile card for an appointment its own details page
    // called 3:30 PM.
    expect(parsed, DateTime.utc(2026, 9, 7, 10).toLocal());
  });

  test('a calendar date keeps the day the server sent', () {
    // Midnight UTC is the previous evening west of Greenwich; a birth date is
    // the same date everywhere, so the day is taken as written.
    final date = ApiTime.date('2026-09-07T00:00:00.000Z')!;

    expect((date.year, date.month, date.day), (2026, 9, 7));
    expect(date.hour, 0);
    expect(date.isUtc, isFalse);
  });

  test('a bare date string is read as that date', () {
    final date = ApiTime.date('1995-01-01')!;
    expect((date.year, date.month, date.day), (1995, 1, 1));
  });

  test('missing and malformed values are null, not now', () {
    expect(ApiTime.instant(null), isNull);
    expect(ApiTime.instant(''), isNull);
    expect(ApiTime.instant('not a date'), isNull);
    expect(ApiTime.date(42), isNull);
  });

  test('the Or variants fall back only when there is nothing to read', () {
    final fallback = DateTime(2020);
    expect(ApiTime.instantOr(null, fallback), fallback);
    expect(
      ApiTime.instantOr('2026-09-07T10:00:00.000Z', fallback),
      DateTime.utc(2026, 9, 7, 10).toLocal(),
    );
  });
}
