import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/auth_session_manager.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/token_store.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/api_auth_data_source.dart';

/// The regions the server's `regionSchema` accepts. It does not reject
/// anything else outright — `RegionOf` falls back to Nepal — so sending the
/// wrong string is silently wrong rather than loudly broken.
const _serverAcceptsRegions = {'NP', 'IN'};

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> seen = [];
  final List<Object?> bodies = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    seen.add(options);
    bodies.add(options.data);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Map<String, dynamic> _sessionPayload() => {
  'accessToken': 'access-1',
  'refreshToken': 'refresh-1',
  'expiresInSeconds': 900,
  'user': {
    'id': '01JAAAAAAAAAAAAAAAAAAAAAAA',
    'region': 'NP',
    'roles': ['user'],
    'isNewUser': true,
  },
};

void main() {
  late _StubAdapter adapter;
  late ApiClient client;
  late InMemoryKeyValueStore store;

  ApiAuthDataSource sourceFor(Region region) => ApiAuthDataSource(
    client: client,
    session: AuthSessionManager(InMemoryTokenStore()),
    regions: FixedRegionResolver(region),
    store: store,
  );

  setUp(() {
    store = InMemoryKeyValueStore();
    adapter = _StubAdapter((options) async {
      if (options.path.endsWith('/auth/phone/start')) {
        return _json(200, {'challengeId': 'ch-1', 'expiresInSeconds': 300});
      }
      return _json(200, _sessionPayload());
    });
    client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
  });

  group('region on the wire', () {
    test('verify sends a region code the server accepts', () async {
      for (final region in Region.values) {
        final source = sourceFor(region);
        await source.requestOtp('+9779812345678');
        await source.verifyOtp(phoneNumber: '+9779812345678', code: '123456');

        final body = adapter.bodies.last as Map<String, dynamic>;
        expect(
          _serverAcceptsRegions,
          contains(body['region']),
          reason: '${region.name} sent "${body['region']}"',
        );
        expect(body['region'], region.code);
      }
    });

    test('social sign-in sends the same code', () async {
      await sourceFor(Region.india).signInWithGoogle();

      final body = adapter.bodies.last as Map<String, dynamic>;
      expect(body['region'], 'IN');
      expect(body['provider'], 'google');
    });
  });

  group('the OTP challenge', () {
    test('is held across the two calls, then cleared', () async {
      final source = sourceFor(Region.nepal);
      await source.requestOtp('+9779812345678');

      // The id is persisted rather than kept in memory: the app is most likely
      // to be killed exactly while the user is reading the SMS.
      expect(store.getString('auth.otp.challenge_id'), 'ch-1');

      await source.verifyOtp(phoneNumber: '+9779812345678', code: '123456');
      expect(store.getString('auth.otp.challenge_id'), isNull);
      expect(store.getString('auth.otp.phone'), isNull);
    });

    test(
      'verifying a number we hold no challenge for asks for a new code',
      () async {
        final source = sourceFor(Region.nepal);
        await source.requestOtp('+9779812345678');

        await expectLater(
          source.verifyOtp(phoneNumber: '+9779800000000', code: '123456'),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test(
      'the code goes up with the challenge id, never the phone number',
      () async {
        final source = sourceFor(Region.nepal);
        await source.requestOtp('+9779812345678');
        await source.verifyOtp(phoneNumber: '+9779812345678', code: '123456');

        final body = adapter.bodies.last as Map<String, dynamic>;
        expect(body['challengeId'], 'ch-1');
        expect(body['code'], '123456');
        // The server ties the code to the challenge; a phone number here would
        // be a second, unauthenticated way to name the account being verified.
        expect(body.containsKey('phone'), isFalse);
      },
    );
  });
}
