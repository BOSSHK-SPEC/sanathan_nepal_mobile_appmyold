import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/auth_session_manager.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/token_store.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/permission.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_refresher.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/api_profile_data_sources.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_favourites_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/models/user_profile_model.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/session/profile_session_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/session/profile_session_sync.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/session/server_role_granter.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';

class _MockFavourites extends Mock implements FavouritesDataSource {}

class _CountingRefresher implements SessionRefresher {
  int calls = 0;

  @override
  Future<void> refresh() async => calls++;
}

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) => handler(options);

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

Map<String, dynamic> _account(String id, List<String> roles) => {
  'id': id,
  'name': 'User $id',
  'email': '',
  'phone': '+9779812345678',
  'avatarUrl': null,
  'region': 'NP',
  'verified': true,
  'roles': roles,
};

/// The console opens for approved astrologers only, and "approved" is what the
/// server says — never something the device decided on its own.
void main() {
  late InMemoryKeyValueStore store;
  late ProfileLocalDataSourceImpl local;
  late _CountingRefresher refresher;
  late Map<String, dynamic> server;
  late bool offline;

  ProfileRepositoryImpl repo() {
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = _StubAdapter(
        (_) async => offline ? _json(503, {'error': {}}) : _json(200, server),
      );
    return ProfileRepositoryImpl(
      local: local,
      favourites: _MockFavourites(),
      remote: ApiProfileDataSource(client),
      session: AuthSessionManager(InMemoryTokenStore()),
      sessionRefresher: refresher,
    );
  }

  Future<AppSession> session() => ProfileSessionSource(local).load();

  Future<void> cache(String id, Set<UserRole> roles) => local.write(
    UserProfileModel.fromEntity(
      UserProfile(id: id, name: 'User $id', email: '', roles: roles),
    ),
  );

  setUp(() {
    store = InMemoryKeyValueStore();
    local = ProfileLocalDataSourceImpl(
      store,
      const FixedRegionResolver(Region.nepal),
      seedWhenEmpty: false,
    );
    refresher = _CountingRefresher();
    offline = false;
  });

  group('the session follows the server', () {
    test('an approval opens the console on the next fetch', () async {
      await cache('u1', {UserRole.user});
      server = _account('u1', ['seeker', 'astrologer']);

      await repo().getProfile();

      expect(refresher.calls, 1, reason: 'the session must be rebuilt');
      expect((await session()).can(Permission.viewAstrologerConsole), isTrue);
    });

    test('a rejection closes it again', () async {
      await cache('u1', {UserRole.user, UserRole.astrologer});
      server = _account('u1', ['seeker']);

      await repo().getProfile();

      expect(refresher.calls, 1);
      expect((await session()).can(Permission.viewAstrologerConsole), isFalse);
    });

    test('an unchanged answer does not rebuild the session', () async {
      await cache('u1', {UserRole.user});
      server = _account('u1', ['seeker']);

      await repo().getProfile();

      expect(refresher.calls, 0);
    });
  });

  group('signing in', () {
    test('never inherits the previous account\'s roles', () async {
      // An approved astrologer used this phone; a new applicant signs in.
      await cache('astrologer-1', {UserRole.user, UserRole.astrologer});
      server = _account('applicant-2', ['seeker']);

      await ProfileSessionSync(
        profiles: repo(),
        local: local,
        refresher: refresher,
      ).adoptSignedInUser('applicant-2');

      expect(local.read().id, 'applicant-2');
      expect((await session()).can(Permission.viewAstrologerConsole), isFalse);
    });

    test('not even when the network is down at that moment', () async {
      await cache('astrologer-1', {UserRole.user, UserRole.astrologer});
      offline = true;

      await ProfileSessionSync(
        profiles: repo(),
        local: local,
        refresher: refresher,
      ).adoptSignedInUser('applicant-2');

      expect((await session()).can(Permission.viewAstrologerConsole), isFalse);
    });
  });

  test('the app cannot grant itself a role the server has not given', () async {
    // The application screen believes it saw "approved" — but the server has
    // not approved anything. Asking for the role must not produce it.
    await cache('u1', {UserRole.user});
    server = _account('u1', ['seeker']);
    final granter = ServerRoleGranter(
      ProfileSessionSync(profiles: repo(), local: local, refresher: refresher),
    );

    await granter.grant(AppRole.astrologer);

    expect(local.read().toEntity().roles, isNot(contains(UserRole.astrologer)));
    expect((await session()).can(Permission.viewAstrologerConsole), isFalse);
  });

  group('staff are not astrologers', () {
    test('an admin alone has no astrologer console', () {
      const admin = AppSession(
        roles: {AppRole.superAdmin},
        isAuthenticated: true,
      );
      for (final permission in Permission.astrologerWorkspace) {
        expect(admin.can(permission), isFalse, reason: '$permission');
      }
      // Everything administrative is still there.
      expect(admin.can(Permission.verifyAstrologer), isTrue);
      expect(admin.can(Permission.approveBusiness), isTrue);
      expect(admin.can(Permission.manageStaff), isTrue);
    });

    test(
      'an admin who is also an approved astrologer gets it from that role',
      () {
        const both = AppSession(
          roles: {AppRole.superAdmin, AppRole.astrologer},
          isAuthenticated: true,
        );
        expect(both.can(Permission.viewAstrologerConsole), isTrue);
      },
    );
  });
}
