import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/auth_session_manager.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/token_store.dart';
import 'package:sanathan_nepal_mobile_app/core/network/interceptors/auth_interceptor.dart';

/// A stand-in transport so the interceptor can be driven without a server.
///
/// Records every request it sees, which is how the single-flight assertion is
/// made: the test counts refreshes rather than trusting that only one happened.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> seen = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    seen.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Map<String, dynamic> body, int status) =>
    ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

/// The server's error envelope, as the interceptor expects to find it.
Map<String, dynamic> _error(String code) => {
  'error': {'kind': 'permission', 'code': code, 'message': 'nope'},
};

void main() {
  late AuthSessionManager session;

  setUp(() async {
    session = AuthSessionManager(InMemoryTokenStore());
    await session.adopt(
      accessToken: 'expired-access',
      refreshToken: 'refresh-1',
    );
  });

  Dio buildClient(_FakeAdapter adapter) {
    final refreshClient = Dio(BaseOptions(baseUrl: 'https://api.test'))
      ..httpClientAdapter = adapter;
    final dio =
        Dio(
            BaseOptions(
              baseUrl: 'https://api.test',
              validateStatus: (s) => s != null && s < 400,
            ),
          )
          ..httpClientAdapter = adapter
          ..interceptors.add(
            AuthInterceptor(session: session, refreshClient: refreshClient),
          );
    return dio;
  }

  test('attaches the access token to protected requests', () async {
    final adapter = _FakeAdapter((options) async => _json({'ok': true}, 200));
    await buildClient(adapter).get<dynamic>('/profile');

    expect(
      adapter.seen.single.headers['Authorization'],
      'Bearer expired-access',
    );
  });

  test('does not attach a token to anonymous endpoints', () async {
    final adapter = _FakeAdapter((options) async => _json({'ok': true}, 200));
    await buildClient(adapter).post<dynamic>('/auth/phone/start', data: {});

    expect(adapter.seen.single.headers.containsKey('Authorization'), isFalse);
  });

  test('refreshes once and retries when the token has expired', () async {
    var refreshes = 0;
    var protectedCalls = 0;

    final adapter = _FakeAdapter((options) async {
      if (options.path.endsWith('/auth/refresh')) {
        refreshes += 1;
        return _json({
          'accessToken': 'fresh-access',
          'refreshToken': 'refresh-2',
        }, 200);
      }
      protectedCalls += 1;
      // Expired on the first attempt, accepted once the token is fresh.
      if (options.headers['Authorization'] == 'Bearer fresh-access') {
        return _json({'ok': true}, 200);
      }
      return _json(_error('TOKEN_EXPIRED'), 403);
    });

    final response = await buildClient(adapter).get<dynamic>('/profile');

    expect(response.statusCode, 200);
    expect(refreshes, 1);
    expect(protectedCalls, 2, reason: 'original attempt plus one retry');
    expect(session.accessToken, 'fresh-access');
    expect(session.refreshToken, 'refresh-2', reason: 'rotation persisted');
  });

  test('concurrent 401s trigger exactly one refresh', () async {
    var refreshes = 0;

    final adapter = _FakeAdapter((options) async {
      if (options.path.endsWith('/auth/refresh')) {
        refreshes += 1;
        // A slow refresh is what makes the race observable.
        await Future<void>.delayed(const Duration(milliseconds: 50));
        return _json({
          'accessToken': 'fresh-access',
          'refreshToken': 'refresh-2',
        }, 200);
      }
      if (options.headers['Authorization'] == 'Bearer fresh-access') {
        return _json({'ok': true}, 200);
      }
      return _json(_error('TOKEN_EXPIRED'), 403);
    });

    final dio = buildClient(adapter);
    final responses = await Future.wait([
      dio.get<dynamic>('/profile'),
      dio.get<dynamic>('/wallet/balance'),
      dio.get<dynamic>('/orders'),
    ]);

    expect(responses.every((r) => r.statusCode == 200), isTrue);
    // Without single-flight this would be 3 — and the 2nd and 3rd would
    // replay a rotated token, which the server treats as theft and answers
    // by revoking the whole session family.
    expect(refreshes, 1);
  });

  test('signs out when the refresh token is rejected', () async {
    final reasons = <SignOutReason>[];
    final subscription = session.onSignOut.listen(reasons.add);

    final adapter = _FakeAdapter((options) async {
      if (options.path.endsWith('/auth/refresh')) {
        return _json(_error('REFRESH_INVALID'), 403);
      }
      return _json(_error('TOKEN_EXPIRED'), 403);
    });

    await expectLater(
      buildClient(adapter).get<dynamic>('/profile'),
      throwsA(isA<DioException>()),
    );
    await Future<void>.delayed(Duration.zero);

    expect(reasons, [SignOutReason.sessionExpired]);
    expect(session.hasSession, isFalse);
    expect(session.accessToken, isNull);

    await subscription.cancel();
  });

  test('does not loop when the retry also fails', () async {
    var protectedCalls = 0;

    final adapter = _FakeAdapter((options) async {
      if (options.path.endsWith('/auth/refresh')) {
        return _json({
          'accessToken': 'fresh-access',
          'refreshToken': 'refresh-2',
        }, 200);
      }
      protectedCalls += 1;
      return _json(_error('TOKEN_EXPIRED'), 403);
    });

    await expectLater(
      buildClient(adapter).get<dynamic>('/profile'),
      throwsA(isA<DioException>()),
    );

    expect(protectedCalls, 2, reason: 'one retry, then give up');
  });

  test(
    'a role granted server-side is picked up without waiting for expiry',
    () async {
      var refreshes = 0;
      var protectedCalls = 0;

      final adapter = _FakeAdapter((options) async {
        if (options.path.endsWith('/auth/refresh')) {
          refreshes += 1;
          return _json({
            'accessToken': 'merchant-access',
            'refreshToken': 'refresh-2',
          }, 200);
        }
        protectedCalls += 1;
        // The seller's business was just approved, so the server has granted
        // them `manageProducts` — but their access token still says seeker.
        if (options.headers['Authorization'] == 'Bearer merchant-access') {
          return _json({'ok': true}, 200);
        }
        return _json(_error('PERMISSION_MANAGE_PRODUCTS'), 403);
      });

      final response = await buildClient(
        adapter,
      ).post<dynamic>('/marketplace/products', data: {});

      // Without this the seller cannot publish anything until their token
      // happens to expire, which looks exactly like the feature being broken.
      expect(refreshes, 1);
      expect(protectedCalls, 2);
      expect(response.statusCode, 200);
    },
  );

  test(
    'a denial that a fresh token cannot lift is retried only once',
    () async {
      var refreshes = 0;
      var protectedCalls = 0;

      final adapter = _FakeAdapter((options) async {
        if (options.path.endsWith('/auth/refresh')) {
          refreshes += 1;
          return _json({
            'accessToken': 'still-a-seeker',
            'refreshToken': 'refresh-2',
          }, 200);
        }
        protectedCalls += 1;
        return _json(_error('PERMISSION_APPROVE_BUSINESS'), 403);
      });

      await expectLater(
        buildClient(adapter).get<dynamic>('/admin/businesses'),
        throwsA(isA<DioException>()),
      );

      // One retry, then the refusal stands — a genuine denial must not loop.
      expect(refreshes, 1);
      expect(protectedCalls, 2);
      expect(session.hasSession, isTrue);
    },
  );
}
