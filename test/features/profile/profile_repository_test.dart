import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_business_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_favourites_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/business_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_businesses.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/update_user_profile.dart';

class MockFavouritesSource extends Mock implements FavouritesDataSource {}

void main() {
  late InMemoryKeyValueStore store;
  late ProfileRepositoryImpl repo;
  late MockFavouritesSource favourites;

  setUp(() {
    store = InMemoryKeyValueStore();
    favourites = MockFavouritesSource();
    repo = ProfileRepositoryImpl(
      local: ProfileLocalDataSourceImpl(
        store,
        const FixedRegionResolver(Region.nepal),
      ),
      favourites: favourites,
    );
  });

  test(
    'getProfile returns the seed "Kritika Paudel" when nothing stored',
    () async {
      final result = await repo.getProfile();
      expect(result.valueOrNull?.name, 'Kritika Paudel');
      expect(result.valueOrNull?.zodiacSign, ProfileZodiac.taurus);
    },
  );

  test('updateProfile persists JSON and getProfile reads it back', () async {
    final seed = (await repo.getProfile()).valueOrNull!;
    final updated = seed.copyWith(name: 'Sita Sharma', birthPlace: 'Pokhara');
    final saved = await repo.updateProfile(updated);
    expect(saved.isSuccess, isTrue);
    expect(
      store.getString(ProfileStorageKeys.profile),
      contains('Sita Sharma'),
    );

    final reloaded = (await repo.getProfile()).valueOrNull!;
    expect(reloaded.name, 'Sita Sharma');
    expect(reloaded.birthPlace, 'Pokhara');
    expect(reloaded, updated);
  });

  test('logout clears the login flag', () async {
    await store.setBool(ProfileStorageKeys.loggedIn, true);
    final result = await repo.logout();
    expect(result.isSuccess, isTrue);
    expect(store.getBool(ProfileStorageKeys.loggedIn), isFalse);
  });

  test('getFavourites maps data-source exceptions to failures', () async {
    when(favourites.getFavourites).thenThrow(Exception('boom'));
    final result = await repo.getFavourites();
    expect(result.failureOrNull, isA<UnknownFailure>());
  });

  test('UpdateUserProfile rejects empty name / invalid email', () async {
    final useCase = UpdateUserProfile(repo);
    final seed = (await repo.getProfile()).valueOrNull!;
    final r1 = await useCase(seed.copyWith(name: '  '));
    expect(r1.failureOrNull, isA<ValidationFailure>());
    final r2 = await useCase(seed.copyWith(email: 'nope'));
    expect(r2.failureOrNull, isA<ValidationFailure>());
    final r3 = await useCase(seed);
    expect(r3.isSuccess, isTrue);
  });

  test('profileCompletion reflects filled fields', () {
    const empty = UserProfile(id: '1', name: 'A', email: 'a@b.c');
    expect(empty.profileCompletion, 20);
    expect(ProfileLocalDataSourceImpl.seed.profileCompletion, 90);
  });

  test('seed profile is an admin (demo of the approvals flow)', () async {
    final profile = (await repo.getProfile()).valueOrNull!;
    expect(profile.roles, {UserRole.admin});
    expect(profile.isAdmin, isTrue);
    // Roles survive a JSON round trip.
    await repo.updateProfile(profile.copyWith(roles: {UserRole.seller}));
    expect((await repo.getProfile()).valueOrNull?.roles, {UserRole.seller});
  });

  test('holding several roles keeps all of them', () async {
    final profile = (await repo.getProfile()).valueOrNull!;
    await repo.updateProfile(
      profile.copyWith(roles: {UserRole.admin, UserRole.astrologer}),
    );
    final reloaded = (await repo.getProfile()).valueOrNull!;
    expect(reloaded.isAdmin, isTrue);
    expect(reloaded.isAstrologer, isTrue);
    // Gaining a role must not strip the others.
    expect(reloaded.roles, {UserRole.admin, UserRole.astrologer});
  });

  group('BusinessRepositoryImpl', () {
    late BusinessRepositoryImpl bizRepo;
    setUp(() {
      bizRepo = BusinessRepositoryImpl(
        MockBusinessDataSource(store, const FixedRegionResolver(Region.nepal)),
      );
    });

    test('getBusinesses lists seeds and filters by status', () async {
      final all = (await bizRepo.getBusinesses()).valueOrNull!;
      expect(all.map((b) => b.id), containsAll(['biz-1', 'biz-2']));
      final pending = (await GetBusinesses(bizRepo)(
        BusinessStatus.pending,
      )).valueOrNull!;
      expect(pending.map((b) => b.id), ['biz-2']);
    });

    test(
      'setStatus stores the moderation note and user businesses appear',
      () async {
        final rejected = (await bizRepo.setStatus(
          'biz-2',
          BusinessStatus.rejected,
          note: 'Missing PAN certificate',
        )).valueOrNull!;
        expect(rejected.status, BusinessStatus.rejected);
        expect(rejected.moderationNote, 'Missing PAN certificate');
        // The overridden seed keeps its position; a new listing is appended.
        await bizRepo.upsertBusiness(
          const BusinessProfile(
            id: MockBusinessDataSource.myBusinessId,
            name: 'Mine',
            category: 'Test',
          ),
        );
        final all = (await bizRepo.getBusinesses()).valueOrNull!;
        expect(all.map((b) => b.id), [
          'biz-1',
          'biz-2',
          MockBusinessDataSource.myBusinessId,
        ]);
        expect(
          all.firstWhere((b) => b.id == 'biz-2').moderationNote,
          'Missing PAN certificate',
        );
        final rejectedOnly = (await bizRepo.getBusinesses(
          status: BusinessStatus.rejected,
        )).valueOrNull!;
        expect(rejectedOnly.map((b) => b.id), ['biz-2']);
      },
    );
  });
}
