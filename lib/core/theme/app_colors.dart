import 'package:flutter/material.dart';

/// Raw brand palette extracted from the Figma file
/// (Sanatan Nepal Mobile App). Do NOT use these directly in widgets –
/// go through [AppColors] (a [ThemeExtension]) so light/dark resolve
/// automatically.
abstract final class AppPalette {
  // Light brand
  static const Color orange = Color(0xFFF37335);
  static const Color yellow = Color(0xFFFDC830);
  static const Color accentOrange = Color(0xFFF95A00);
  static const Color peach = Color(0xFFFFE7D6);
  static const Color cream = Color(0xFFFFF7F0);

  // Dark brand
  static const Color deepIndigo = Color(0xFF1F1F42);
  static const Color indigo = Color(0xFF343454);
  static const Color indigoCard = Color(0xFF2A2A4E);
  static const Color violet = Color(0xFF8937FF);
  static const Color magenta = Color(0xFFE85BFF);

  // Neutrals
  static const Color ink = Color(0xFF222222);
  static const Color ink2 = Color(0xFF3B3B3B);
  static const Color grey = Color(0xFF7A7A7A);
  static const Color grey2 = Color(0xFFBDBDBD);
  static const Color grey3 = Color(0xFFDADADA);
  static const Color grey4 = Color(0xFFF2F2F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Semantic
  static const Color success = Color(0xFF3DB44B);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFF9A825);
  static const Color info = Color(0xFF1E88E5);
  static const Color todayGreen = Color(0xFF3AB54A);
  static const Color holidayRed = Color(0xFFE53935);
}

/// Semantic colour roles for the app. Access via `context.colors`.
///
/// Every screen must use these roles instead of hard-coded hex values so a
/// single source of truth drives both the light (orange) and dark (purple)
/// designs from Figma.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.surfaceElevated,
    required this.primary,
    required this.primaryVariant,
    required this.accent,
    required this.onPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.divider,
    required this.border,
    required this.icon,
    required this.iconMuted,
    required this.chipBackground,
    required this.chipSelected,
    required this.onChipSelected,
    required this.today,
    required this.holiday,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.primaryGradient,
    required this.headerGradient,
    required this.cardGradient,
    required this.navBar,
    required this.navSelected,
    required this.navUnselected,
    required this.adBanner,
    required this.shimmer,
  });

  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color surfaceElevated;
  final Color primary;
  final Color primaryVariant;
  final Color accent;
  final Color onPrimary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color divider;
  final Color border;
  final Color icon;
  final Color iconMuted;
  final Color chipBackground;
  final Color chipSelected;
  final Color onChipSelected;
  final Color today;
  final Color holiday;
  final Color success;
  final Color error;
  final Color warning;
  final Color info;
  final LinearGradient primaryGradient;
  final LinearGradient headerGradient;
  final LinearGradient cardGradient;
  final Color navBar;
  final Color navSelected;
  final Color navUnselected;
  final Color adBanner;
  final Color shimmer;

  static const AppColors light = AppColors(
    background: AppPalette.white,
    surface: AppPalette.white,
    surfaceVariant: AppPalette.grey4,
    surfaceElevated: AppPalette.white,
    primary: AppPalette.orange,
    primaryVariant: AppPalette.yellow,
    accent: AppPalette.accentOrange,
    onPrimary: AppPalette.white,
    textPrimary: AppPalette.ink,
    textSecondary: AppPalette.ink2,
    textMuted: AppPalette.grey,
    divider: Color(0x66D9D9D9),
    border: AppPalette.grey3,
    icon: AppPalette.ink,
    iconMuted: AppPalette.grey,
    chipBackground: AppPalette.grey4,
    chipSelected: AppPalette.accentOrange,
    onChipSelected: AppPalette.white,
    today: AppPalette.todayGreen,
    holiday: AppPalette.holidayRed,
    success: AppPalette.success,
    error: AppPalette.error,
    warning: AppPalette.warning,
    info: AppPalette.info,
    primaryGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppPalette.orange, AppPalette.yellow],
    ),
    headerGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppPalette.orange, Color(0xFFF8D894)],
    ),
    cardGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFF7F3F4), Color(0xFFF7F3F4)],
    ),
    navBar: AppPalette.white,
    navSelected: AppPalette.accentOrange,
    navUnselected: AppPalette.grey,
    adBanner: Color(0xFFD9D9D9),
    shimmer: Color(0xFFEDEDED),
  );

  static const AppColors dark = AppColors(
    background: AppPalette.deepIndigo,
    surface: AppPalette.indigo,
    surfaceVariant: AppPalette.indigoCard,
    surfaceElevated: Color(0xFF3D3D63),
    primary: AppPalette.violet,
    primaryVariant: AppPalette.magenta,
    accent: AppPalette.magenta,
    onPrimary: AppPalette.white,
    textPrimary: AppPalette.white,
    textSecondary: Color(0xCCFFFFFF),
    textMuted: Color(0x99FFFFFF),
    divider: Color(0x33FFFFFF),
    border: Color(0x33FFFFFF),
    icon: AppPalette.white,
    iconMuted: Color(0x99FFFFFF),
    chipBackground: Color(0x1AFFFFFF),
    chipSelected: AppPalette.magenta,
    onChipSelected: AppPalette.white,
    today: AppPalette.todayGreen,
    holiday: Color(0xFFFF6B6B),
    success: AppPalette.success,
    error: Color(0xFFFF6B6B),
    warning: AppPalette.warning,
    info: Color(0xFF64B5F6),
    primaryGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppPalette.violet, AppPalette.magenta],
    ),
    headerGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFB47AF8), AppPalette.magenta],
    ),
    cardGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0x40E85BFF), Color(0x408937FF)],
    ),
    navBar: AppPalette.indigo,
    navSelected: AppPalette.magenta,
    navUnselected: Color(0xB3FFFFFF),
    adBanner: Color(0x33D9D9D9),
    shimmer: Color(0xFF3D3D63),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? surfaceElevated,
    Color? primary,
    Color? primaryVariant,
    Color? accent,
    Color? onPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? divider,
    Color? border,
    Color? icon,
    Color? iconMuted,
    Color? chipBackground,
    Color? chipSelected,
    Color? onChipSelected,
    Color? today,
    Color? holiday,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    LinearGradient? primaryGradient,
    LinearGradient? headerGradient,
    LinearGradient? cardGradient,
    Color? navBar,
    Color? navSelected,
    Color? navUnselected,
    Color? adBanner,
    Color? shimmer,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      primary: primary ?? this.primary,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      accent: accent ?? this.accent,
      onPrimary: onPrimary ?? this.onPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      divider: divider ?? this.divider,
      border: border ?? this.border,
      icon: icon ?? this.icon,
      iconMuted: iconMuted ?? this.iconMuted,
      chipBackground: chipBackground ?? this.chipBackground,
      chipSelected: chipSelected ?? this.chipSelected,
      onChipSelected: onChipSelected ?? this.onChipSelected,
      today: today ?? this.today,
      holiday: holiday ?? this.holiday,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      headerGradient: headerGradient ?? this.headerGradient,
      cardGradient: cardGradient ?? this.cardGradient,
      navBar: navBar ?? this.navBar,
      navSelected: navSelected ?? this.navSelected,
      navUnselected: navUnselected ?? this.navUnselected,
      adBanner: adBanner ?? this.adBanner,
      shimmer: shimmer ?? this.shimmer,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      border: Color.lerp(border, other.border, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      chipSelected: Color.lerp(chipSelected, other.chipSelected, t)!,
      onChipSelected: Color.lerp(onChipSelected, other.onChipSelected, t)!,
      today: Color.lerp(today, other.today, t)!,
      holiday: Color.lerp(holiday, other.holiday, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      primaryGradient: LinearGradient.lerp(
        primaryGradient,
        other.primaryGradient,
        t,
      )!,
      headerGradient: LinearGradient.lerp(
        headerGradient,
        other.headerGradient,
        t,
      )!,
      cardGradient: LinearGradient.lerp(cardGradient, other.cardGradient, t)!,
      navBar: Color.lerp(navBar, other.navBar, t)!,
      navSelected: Color.lerp(navSelected, other.navSelected, t)!,
      navUnselected: Color.lerp(navUnselected, other.navUnselected, t)!,
      adBanner: Color.lerp(adBanner, other.adBanner, t)!,
      shimmer: Color.lerp(shimmer, other.shimmer, t)!,
    );
  }
}
