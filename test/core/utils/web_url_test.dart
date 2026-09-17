import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/web_url.dart';

/// A seller typed `yashwanthhk.com` and the listing was refused by the server
/// with "Request validation failed" — no field named, nothing to correct. The
/// address is now completed here, and anything genuinely unusable is caught
/// while the field is still on screen.
void main() {
  group('normalizing', () {
    test('completes an address typed without a scheme', () {
      expect(WebUrl.normalize('yashwanthhk.com'), 'https://yashwanthhk.com');
      expect(
        WebUrl.normalize('www.gadgethub.com.np'),
        'https://www.gadgethub.com.np',
      );
      expect(WebUrl.normalize('  example.com  '), 'https://example.com');
    });

    test('leaves a complete address as it is', () {
      expect(WebUrl.normalize('https://example.com'), 'https://example.com');
      // Plenty of small shops still have no TLS; http is a real address.
      expect(WebUrl.normalize('http://shop.example.in/x'), 'http://shop.example.in/x');
    });

    test('refuses a link that would run code on the buyer\'s phone', () {
      // The listing renders this as tappable, which is what makes these
      // schemes dangerous rather than merely wrong.
      expect(WebUrl.normalize('javascript:alert(1)'), isNull);
      expect(WebUrl.normalize('data:text/html,<script>'), isNull);
      expect(WebUrl.normalize('file:///etc/passwd'), isNull);
    });

    test('refuses what cannot be a public site', () {
      expect(WebUrl.normalize('localhost'), isNull);
      expect(WebUrl.normalize('not a url'), isNull);
      expect(WebUrl.normalize(''), isNull);
      expect(WebUrl.normalize(null), isNull);
      expect(WebUrl.normalize('example.com/${'x' * 600}'), isNull);
    });
  });

  group('acceptable to submit', () {
    test('an empty website is fine — the field is optional', () {
      expect(WebUrl.isAcceptable(null), isTrue);
      expect(WebUrl.isAcceptable(''), isTrue);
      expect(WebUrl.isAcceptable('   '), isTrue);
    });

    test('a typed address must be a real one', () {
      expect(WebUrl.isAcceptable('example.com'), isTrue);
      expect(WebUrl.isAcceptable('javascript:alert(1)'), isFalse);
      expect(WebUrl.isAcceptable('not a url'), isFalse);
    });
  });
}
