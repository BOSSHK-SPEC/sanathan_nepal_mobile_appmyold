import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/ulid.dart';

void main() {
  /// The exact pattern the server validates ids against.
  final serverPattern = RegExp(r'^[0-7][0-9A-HJKMNP-TV-Z]{25}$');

  test('matches the pattern the server accepts', () {
    for (var i = 0; i < 500; i++) {
      final id = Ulid.generate();
      expect(id.length, 26);
      expect(
        serverPattern.hasMatch(id),
        isTrue,
        reason: 'server would reject "$id"',
      );
    }
  });

  test('never uses the ambiguous letters Crockford omits', () {
    final ids = List.generate(200, (_) => Ulid.generate()).join();
    for (final letter in ['I', 'L', 'O', 'U']) {
      expect(
        ids.contains(letter),
        isFalse,
        reason: '"$letter" is not in the alphabet',
      );
    }
  });

  test('sorts by creation time as a plain string', () {
    final earlier = Ulid.generate(DateTime.utc(2026, 1, 1));
    final later = Ulid.generate(DateTime.utc(2026, 6, 1));
    // This is the whole reason for ULIDs over UUIDv4: lexical order is
    // chronological order, so they index well and work as a cursor.
    expect(earlier.compareTo(later), lessThan(0));
  });

  test('is unique across a burst', () {
    final ids = List.generate(2000, (_) => Ulid.generate()).toSet();
    expect(ids, hasLength(2000));
  });
}
