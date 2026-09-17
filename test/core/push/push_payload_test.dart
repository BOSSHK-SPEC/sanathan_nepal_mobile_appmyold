import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/push/push_payload.dart';

void main() {
  group('reading a push payload', () {
    test('keeps the kind, route and extras', () {
      final payload = PushPayload.fromData({
        'kind': 'message',
        'route': '/messages/01JAAAAAAAAAAAAAAAAAAAAAAA',
        'threadId': '01JAAAAAAAAAAAAAAAAAAAAAAA',
      });

      expect(payload.kind, 'message');
      expect(payload.route, '/messages/01JAAAAAAAAAAAAAAAAAAAAAAA');
      expect(payload.threadId, '01JAAAAAAAAAAAAAAAAAAAAAAA');
    });

    test('falls back to a general notification with no route', () {
      final payload = PushPayload.fromData({});
      expect(payload.kind, 'general');
      expect(payload.route, isNull);
    });

    test('stringifies whatever the transport delivered', () {
      // FCM data values are strings, but the platform channel hands them over
      // as dynamic — a number here used to blow up on cast.
      final payload = PushPayload.fromData({'kind': 'order', 'count': 3});
      expect(payload.data['count'], '3');
    });
  });

  group('validating the deep link', () {
    test('accepts an in-app path', () {
      expect(PushPayload.safeRoute('/messages/01J'), '/messages/01J');
      expect(PushPayload.safeRoute('  /wallet  '), '/wallet');
    });

    test('refuses anything that could leave the app', () {
      // A notification is input from the network: an external URL here would
      // turn a tap into "open whatever the sender wants".
      expect(PushPayload.safeRoute('https://evil.example'), isNull);
      expect(PushPayload.safeRoute('//evil.example'), isNull);
      expect(PushPayload.safeRoute('intent://x'), isNull);
      expect(PushPayload.safeRoute('messages/01J'), isNull);
      expect(PushPayload.safeRoute('/../../secret'), isNull);
      expect(PushPayload.safeRoute(''), isNull);
      expect(PushPayload.safeRoute(null), isNull);
      expect(PushPayload.safeRoute('/${'x' * 400}'), isNull);
    });
  });
}
