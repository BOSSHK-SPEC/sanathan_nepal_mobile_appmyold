import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';

part 'app_preferences.freezed.dart';

enum AppLanguage {
  nepali('ne'),
  english('en'),
  hindi('hi');

  const AppLanguage(this.code);
  final String code;

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String? code) => AppLanguage.values.firstWhere(
    (l) => l.code == code,
    orElse: () => nepali,
  );

  /// Languages offered for [region] (from its [RegionConfig]).
  static List<AppLanguage> forRegion(Region region) =>
      region.config.languageCodes.map(AppLanguage.fromCode).toList();
}

@freezed
abstract class AppPreferences with _$AppPreferences {
  const factory AppPreferences({
    @Default(Region.nepal) Region region,
    @Default(AppLanguage.nepali) AppLanguage language,
    @Default(ThemeMode.light) ThemeMode themeMode,
    @Default(false) bool silentMode,
    @Default(false) bool onboardingCompleted,
  }) = _AppPreferences;
}
