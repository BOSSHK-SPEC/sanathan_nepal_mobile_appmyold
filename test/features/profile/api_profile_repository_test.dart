import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/auth_session_manager.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/token_store.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/api_profile_data_sources.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_favourites_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';

class _MockFavourites extends Mock implements FavouritesDataSource {}

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> seen = [];

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

ResponseBody _json(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Map<String, dynamic> _serverProfile({String name = 'Ram Bahadur'}) => {
  'id': '01JAAAAAAAAAAAAAAAAAAAAAAA',
  'name': name,
  'email': 'ram@example.com',
  'phone': '+9779812345678',
  'avatarUrl': null,
  'gender': 'male',
  'dobAd': '1998-04-02',
  'birthTime': '16:12',
  'birthPlace': 'Hetauda',
  'address': 'Kathmandu',
  'bio': null,
  'religion': 'Hindu',
  'language': 'ne',
  'region': 'NP',
  'verified': true,
  'roles': ['seeker'],
};

void main() {
  late InMemoryKeyValueStore store;
  late _MockFavourites favourites;
  late AuthSessionManager session;

  /// Live wiring: the local source is a cache with no seed, exactly as
  /// `registerProfileFeature` builds it against a real backend.
  ProfileRepositoryImpl repoWith(_StubAdapter adapter) {
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
    return ProfileRepositoryImpl(
      local: ProfileLocalDataSourceImpl(
        store,
        const FixedRegionResolver(Region.nepal),
        seedWhenEmpty: false,
      ),
      favourites: favourites,
      remote: ApiProfileDataSource(client),
      session: session,
    );
  }

  setUp(() {
    store = InMemoryKeyValueStore();
    favourites = _MockFavourites();
    session = AuthSessionManager(InMemoryTokenStore());
  });

  test('the profile shown is the server\'s, not a seeded stranger', () async {
    final repo = repoWith(
      _StubAdapter((_) async => _json(200, _serverProfile())),
    );

    final result = await repo.getProfile();

    expect(result.valueOrNull?.name, 'Ram Bahadur');
    expect(result.valueOrNull?.phone, '+9779812345678');
    // The demo seed is a real risk here: it ships a fictional person *and*
    // an admin role, so leaking it into a live build would hand staff screens
    // to whoever installed the app.
    expect(result.valueOrNull?.name, isNot('Kritika Paudel'));
    expect(result.valueOrNull?.roles, {UserRole.user});
  });

  test('a fetched profile is cached for the next launch', () async {
    final adapter = _StubAdapter((_) async => _json(200, _serverProfile()));
    await repoWith(adapter).getProfile();

    // Offline now: the cached copy is still this user's profile.
    final offline = repoWith(
      _StubAdapter(
        (options) async => throw DioException.connectionError(
          requestOptions: options,
          reason: 'offline',
        ),
      ),
    );

    expect((await offline.getProfile()).valueOrNull?.name, 'Ram Bahadur');
  });

  test('with nothing cached, a failed fetch is reported', () async {
    final repo = repoWith(
      _StubAdapter(
        (options) async => throw DioException.connectionError(
          requestOptions: options,
          reason: 'offline',
        ),
      ),
    );

    // Rendering a blank profile would look like an account with no details,
    // which is a different and much more alarming thing than "we could not
    // reach the server".
    expect((await repo.getProfile()).failureOrNull, isNotNull);
  });

  test('an edit is saved server-side before it is cached', () async {
    var patched = false;
    final adapter = _StubAdapter((options) async {
      if (options.method == 'PATCH') {
        patched = true;
        return _json(200, _serverProfile(name: 'Sita Devi'));
      }
      return _json(200, _serverProfile());
    });
    final repo = repoWith(adapter);

    final saved = await repo.updateProfile(
      const UserProfile(id: 'x', name: 'Sita Devi', email: 'x@y.z'),
    );

    expect(patched, isTrue);
    expect(saved.valueOrNull?.name, 'Sita Devi');
    // Cached only after the server accepted it.
    expect(store.getString(ProfileStorageKeys.profile), contains('Sita Devi'));
  });

  test('a rejected edit is not cached', () async {
    final repo = repoWith(
      _StubAdapter((options) async {
        if (options.method == 'PATCH') {
          return _json(400, {
            'error': {
              'kind': 'validation',
              'code': 'VALIDATION_ERROR',
              'message': 'no',
            },
          });
        }
        return _json(200, _serverProfile());
      }),
    );

    final result = await repo.updateProfile(
      const UserProfile(id: 'x', name: 'Rejected', email: 'x@y.z'),
    );

    expect(result.failureOrNull, isNotNull);
    expect(store.getString(ProfileStorageKeys.profile), isNull);
  });

  test('an edit sends birth date and time in the server\'s format', () async {
    Object? sent;
    final repo = repoWith(
      _StubAdapter((options) async {
        if (options.method == 'PATCH') sent = options.data;
        return _json(200, _serverProfile());
      }),
    );

    await repo.updateProfile(
      const UserProfile(
        id: 'x',
        name: 'Yashwanth',
        email: '',
        dobAd: '2006/01/01',
        birthTime: '12:00:00 PM',
      ),
    );

    // The form's display strings were sent as-is and the API refused the
    // whole save: it takes `YYYY-MM-DD` and 24-hour `HH:mm`.
    expect(sent, isA<Map<String, dynamic>>());
    final body = sent! as Map<String, dynamic>;
    expect(body['dobAd'], '2006-01-01');
    expect(body['birthTime'], '12:00');
  });

  test('a fetched profile reads back in the app\'s format', () async {
    final repo = repoWith(
      _StubAdapter((_) async => _json(200, _serverProfile())),
    );

    final profile = (await repo.getProfile()).valueOrNull;

    // `YYYY/MM/DD` is what the B.S. / Saka conversion parses.
    expect(profile?.dobAd, '1998/04/02');
    expect(profile?.birthTime, '4:12:00 PM');
  });

  test('religion is saved and read back; emptying it clears it', () async {
    final sent = <Object?>[];
    final repo = repoWith(
      _StubAdapter((options) async {
        if (options.method == 'PATCH') sent.add(options.data);
        return _json(200, _serverProfile());
      }),
    );

    final saved = await repo.updateProfile(
      const UserProfile(id: 'x', name: 'Sita', email: '', religion: ' Hindu '),
    );
    await repo.updateProfile(
      const UserProfile(id: 'x', name: 'Sita', email: '', religion: ''),
    );

    // It used to be left out of the request, so it vanished on every save.
    expect((sent[0]! as Map<String, dynamic>)['religion'], 'Hindu');
    expect(saved.valueOrNull?.religion, 'Hindu');
    // Left out, the server would keep the old value; blank says "clear it".
    expect((sent[1]! as Map<String, dynamic>)['religion'], '');
  });

  group('signing out', () {
    test('revokes the session and forgets the user', () async {
      await session.rotate(accessToken: 'a', refreshToken: 'r');
      var loggedOut = false;
      final repo = repoWith(
        _StubAdapter((options) async {
          if (options.path.endsWith('/profile/logout')) {
            loggedOut = true;
            return _json(204, {});
          }
          return _json(200, _serverProfile());
        }),
      );
      await repo.getProfile();

      await repo.logout();

      expect(loggedOut, isTrue, reason: 'the server must revoke the session');
      expect(session.hasSession, isFalse);
      // The next person to sign in on this device must not see the last
      // person's name, phone number or roles.
      expect(store.getString(ProfileStorageKeys.profile), isNull);
    });

    test(
      'still signs out on this device when the server is unreachable',
      () async {
        await session.rotate(accessToken: 'a', refreshToken: 'r');
        final repo = repoWith(
          _StubAdapter(
            (options) async => throw DioException.connectionError(
              requestOptions: options,
              reason: 'offline',
            ),
          ),
        );

        final result = await repo.logout();

        // Tapping sign out has to work on a train with no signal.
        expect(result.isSuccess, isTrue);
        expect(session.hasSession, isFalse);
      },
    );
  });

  test(
    'deleting an account that the server refused keeps the session',
    () async {
      await session.rotate(accessToken: 'a', refreshToken: 'r');
      final repo = repoWith(
        _StubAdapter(
          (options) async => options.method == 'DELETE'
              ? _json(500, {
                  'error': {
                    'kind': 'server',
                    'code': 'SERVER_ERROR',
                    'message': 'no',
                  },
                })
              : _json(200, _serverProfile()),
        ),
      );

      final result = await repo.deleteAccount();

      // Signing the user out here would tell them their account is gone when it
      // is not.
      expect(result.failureOrNull, isNotNull);
      expect(session.hasSession, isTrue);
    },
  );
}
