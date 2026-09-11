import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import '../../domain/entities/app_preferences.dart';

part 'app_preferences_model.freezed.dart';
part 'app_preferences_model.g.dart';

/// Persistence shape of [AppPreferences] (raw string codes).
@freezed
abstract class AppPreferencesModel with _$AppPreferencesModel {
  const AppPreferencesModel._();

  const factory AppPreferencesModel({
    String? region,
    String? language,
    String? theme,
    bool? silent,
    bool? onboarded,
  }) = _AppPreferencesModel;

  factory AppPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$AppPreferencesModelFromJson(json);

  factory AppPreferencesModel.fromEntity(AppPreferences e) =>
      AppPreferencesModel(
        region: e.region.code,
        language: e.language.code,
        theme: e.themeMode.name,
        silent: e.silentMode,
        onboarded: e.onboardingCompleted,
      );

  AppPreferences toEntity() {
    final r = Region.fromCode(region);
    return AppPreferences(
      region: r,
      language: language == null
          ? AppLanguage.fromCode(r.config.defaultLanguageCode)
          : AppLanguage.fromCode(language),
      themeMode: ThemeMode.values.firstWhere(
        (m) => m.name == theme,
        orElse: () => ThemeMode.light,
      ),
      silentMode: silent ?? false,
      onboardingCompleted: onboarded ?? false,
    );
  }
}
