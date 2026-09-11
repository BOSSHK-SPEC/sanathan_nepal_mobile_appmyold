import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/entities/app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';

void main() {
  late InMemoryKeyValueStore store;
  late AppPreferencesRepositoryImpl repo;

  AppSettingsCubit buildCubit() => AppSettingsCubit(
    getPreferences: GetAppPreferences(repo),
    savePreferences: SaveAppPreferences(repo),
  );

  setUp(() {
    store = InMemoryKeyValueStore();
    repo = AppPreferencesRepositoryImpl(
      AppPreferencesLocalDataSourceImpl(store),
    );
  });

  test('defaults to Nepali + light theme when nothing persisted', () async {
    final result = await repo.load();
    expect(result.valueOrNull, const AppPreferences());
  });

  blocTest<AppSettingsCubit, AppPreferences>(
    'setLanguage / setThemeMode emit and persist',
    build: buildCubit,
    act: (c) async {
      await c.setLanguage(AppLanguage.english);
      await c.setThemeMode(ThemeMode.dark);
    },
    expect: () => [
      const AppPreferences(language: AppLanguage.english),
      const AppPreferences(
        language: AppLanguage.english,
        themeMode: ThemeMode.dark,
      ),
    ],
    verify: (_) {
      expect(store.getString('prefs.language'), 'en');
      expect(store.getString('prefs.theme'), 'dark');
    },
  );

  blocTest<AppSettingsCubit, AppPreferences>(
    'load restores persisted values',
    build: buildCubit,
    setUp: () async {
      await store.setString('prefs.language', 'en');
      await store.setBool('prefs.onboarded', true);
    },
    act: (c) => c.load(),
    expect: () => [
      const AppPreferences(
        language: AppLanguage.english,
        onboardingCompleted: true,
      ),
    ],
  );

  blocTest<AppSettingsCubit, AppPreferences>(
    'setRegion(india) switches to a region language when Nepali is active',
    build: buildCubit,
    act: (c) => c.setRegion(Region.india),
    expect: () => [
      const AppPreferences(region: Region.india, language: AppLanguage.english),
    ],
    verify: (_) {
      expect(store.getString('prefs.region'), 'IN');
      expect(store.getString('prefs.language'), 'en');
    },
  );

  blocTest<AppSettingsCubit, AppPreferences>(
    'setRegion keeps English when it is offered in both regions',
    build: buildCubit,
    seed: () => const AppPreferences(language: AppLanguage.english),
    act: (c) => c.setRegion(Region.india),
    expect: () => [
      const AppPreferences(region: Region.india, language: AppLanguage.english),
    ],
  );

  test(
    'persisted region without language falls back to region default',
    () async {
      await store.setString('prefs.region', 'IN');
      final result = await repo.load();
      expect(result.valueOrNull?.language, AppLanguage.english);
      expect(result.valueOrNull?.region, Region.india);
    },
  );
}
