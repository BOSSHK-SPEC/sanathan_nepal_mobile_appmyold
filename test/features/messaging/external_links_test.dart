import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/system/external_links.dart';

void main() {
  group('phone normalisation', () {
    test('a number as a shop owner types it still dials', () {
      // `tel:+977 98-41…` silently fails to open the dialler on Android, and
      // every seeded and user-entered number in this app has separators in it.
      expect(ExternalLinks.normalisePhone('+977-9841234567'), '+9779841234567');
      expect(
        ExternalLinks.normalisePhone('+977 (984) 123 4567'),
        '+9779841234567',
      );
      expect(ExternalLinks.normalisePhone('01-4444444'), '014444444');
    });

    test('a plus is only kept where it means something', () {
      expect(ExternalLinks.normalisePhone('977+984'), '977984');
    });

    test('a number with no digits is not dialled at all', () {
      expect(ExternalLinks.normalisePhone('—'), '');
      expect(ExternalLinks.normalisePhone(''), '');
      expect(ExternalLinks.normalisePhone('+'), '');
    });
  });

  group('hand-offs refuse to launch nothing', () {
    test('an empty number, address or url opens no app', () async {
      expect(await ExternalLinks.call(''), isFalse);
      expect(await ExternalLinks.whatsapp('n/a'), isFalse);
      expect(await ExternalLinks.email(''), isFalse);
      expect(await ExternalLinks.website('  '), isFalse);
    });
  });
}
