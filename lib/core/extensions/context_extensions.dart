import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../calendar/traditional_calendar.dart';
import '../region/region.dart';
import '../region/region_scope.dart';
import '../theme/app_colors.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  AppColors get colors => theme.extension<AppColors>() ?? AppColors.light;
  bool get isDark => theme.brightness == Brightness.dark;
  AppLocalizations get l10n => AppLocalizations.of(this);
  Locale get locale => Localizations.localeOf(this);
  bool get isNepali => locale.languageCode == 'ne';
  bool get isHindi => locale.languageCode == 'hi';
  String get languageCode => locale.languageCode;

  /// True for Nepali and Hindi – digits render in Devanagari.
  bool get usesDevanagariDigits =>
      TraditionalCalendar.devanagariDigits(locale.languageCode);

  /// Active region (Nepal / India) and its configuration.
  Region get region => RegionScope.of(this);
  RegionConfig get regionConfig => region.config;
  TraditionalCalendar get traditionalCalendar => regionConfig.calendar;
  Size get screenSize => MediaQuery.sizeOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Chooses a string for the active locale. Hindi falls back to [hi] when
  /// given, otherwise to English.
  String tr({required String ne, required String en, String? hi}) =>
      isNepali ? ne : (isHindi && hi != null ? hi : en);
}
