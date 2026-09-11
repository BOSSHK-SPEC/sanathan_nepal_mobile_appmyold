import 'package:flutter/material.dart';

import '../../../../core/region/region.dart';
import '../../domain/entities/app_preferences.dart';
import '../../domain/usecases/get_app_preferences.dart';
import '../../domain/usecases/save_app_preferences.dart';
import '../../../../core/state/app_cubit.dart';

/// Global app settings (region / language / theme / silent mode / onboarding).
///
/// State is the [AppPreferences] entity itself – kept intentionally simple.
class AppSettingsCubit extends AppCubit<AppPreferences> {
  AppSettingsCubit({
    required GetAppPreferences getPreferences,
    required SaveAppPreferences savePreferences,
  }) : _get = getPreferences,
       _save = savePreferences,
       super(const AppPreferences());

  final GetAppPreferences _get;
  final SaveAppPreferences _save;

  Future<void> load() async {
    final result = await _get();
    result.fold((_) {}, emit);
  }

  /// Switches region. If the current language is not offered in the new
  /// region, the region's default language is applied too.
  Future<void> setRegion(Region region) {
    final offered = AppLanguage.forRegion(region);
    final language = offered.contains(state.language)
        ? state.language
        : AppLanguage.fromCode(region.config.defaultLanguageCode);
    return _update(state.copyWith(region: region, language: language));
  }

  Future<void> setLanguage(AppLanguage language) =>
      _update(state.copyWith(language: language));

  Future<void> setThemeMode(ThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));

  Future<void> toggleTheme() => setThemeMode(
    state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
  );

  Future<void> setSilentMode(bool enabled) =>
      _update(state.copyWith(silentMode: enabled));

  Future<void> completeOnboarding() =>
      _update(state.copyWith(onboardingCompleted: true));

  Future<void> _update(AppPreferences next) async {
    emit(next);
    await _save(next);
  }
}
