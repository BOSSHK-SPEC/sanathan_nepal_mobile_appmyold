import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/auth_session_manager.dart';
import 'package:sanathan_nepal_mobile_app/core/auth/token_store.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/api_profile_data_sources.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_favourites_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/update_user_profile.dart';

class _MockFavourites extends Mock implements FavouritesDataSource {}

class _MockRepository extends Mock implements ProfileRepository {}

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<Object?> bodies = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    bodies.add(options.data);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Object body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Map<String, dynamic> _server({Object? zodiacSign}) => {
  'id': '01JAAAAAAAAAAAAAAAAAAAAAAA',
  'name': 'Sita Sharma',
  'email': '',
  'phone': '+9779812345678',
  'avatarUrl': null,
  'region': 'NP',
  'verified': false,
  'roles': ['seeker'],
  'zodiacSign': zodiacSign,
};

void main() {
  late _StubAdapter adapter;
  late Map<String, dynamic> server;

  setUpAll(
    () => registerFallbackValue(const UserProfile(id: '', name: '', email: '')),
  );

  ProfileRepositoryImpl repo() {
    adapter = _StubAdapter((_) async => _json(server));
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
    return ProfileRepositoryImpl(
      local: ProfileLocalDataSourceImpl(
        InMemoryKeyValueStore(),
        const FixedRegionResolver(Region.nepal),
        seedWhenEmpty: false,
      ),
      favourites: _MockFavourites(),
      remote: ApiProfileDataSource(client),
      session: AuthSessionManager(InMemoryTokenStore()),
    );
  }

  group('horoscope sign', () {
    test('the sign chosen at registration shows on the profile', () async {
      // It used to be picked on the details form and dropped on the way to
      // the server — the profile always said "not set".
      server = _server(zodiacSign: 'leo');
      final profile = (await repo().getProfile()).valueOrNull!;
      expect(profile.zodiacSign, ProfileZodiac.leo);
    });

    test('an unknown sign reads as not set, not as an error', () async {
      server = _server(zodiacSign: 'ophiuchus');
      final result = await repo().getProfile();
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull!.zodiacSign, isNull);
    });

    test('saving the profile saves the sign, and null clears it', () async {
      server = _server(zodiacSign: 'leo');
      final repository = repo();
      final profile = (await repository.getProfile()).valueOrNull!;

      await repository.updateProfile(
        profile.copyWith(zodiacSign: ProfileZodiac.pisces),
      );
      expect((adapter.bodies.last as Map)['zodiacSign'], 'pisces');

      await repository.updateProfile(profile.copyWith(zodiacSign: null));
      final cleared = adapter.bodies.last as Map;
      expect(
        cleared.containsKey('zodiacSign'),
        isTrue,
        reason: 'null must be sent to clear it',
      );
      expect(cleared['zodiacSign'], isNull);
    });
  });

  group('email is optional', () {
    late _MockRepository repository;
    late UpdateUserProfile update;
    const base = UserProfile(id: 'u1', name: 'Sita Sharma', email: '');

    setUp(() {
      repository = _MockRepository();
      when(() => repository.updateProfile(any())).thenAnswer(
        (invocation) async =>
            Result.success(invocation.positionalArguments.first as UserProfile),
      );
      update = UpdateUserProfile(repository);
    });

    test('a blank email saves — phone-first accounts have none', () async {
      expect((await update(base)).isSuccess, isTrue);
      expect((await update(base.copyWith(email: '   '))).isSuccess, isTrue);
    });

    test('a typed email must still be a real address', () async {
      final result = await update(base.copyWith(email: 'nope'));
      expect(result.failureOrNull, isA<ValidationFailure>());
      verifyNever(() => repository.updateProfile(any()));
    });
  });
}
