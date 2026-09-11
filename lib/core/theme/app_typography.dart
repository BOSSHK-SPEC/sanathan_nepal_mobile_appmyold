import 'package:flutter/material.dart';

/// Typography scale derived from the Figma file (family: Mukta).
abstract final class AppTypography {
  static const String fontFamily = 'Mukta';

  static TextTheme textTheme(Color primary, Color secondary) {
    TextStyle s(double size, FontWeight w, {double? height, Color? c}) =>
        TextStyle(
          fontFamily: fontFamily,
          fontSize: size,
          fontWeight: w,
          height: height,
          color: c ?? primary,
        );
    return TextTheme(
      displayLarge: s(32, FontWeight.w700, height: 1.2),
      displayMedium: s(26, FontWeight.w700, height: 32 / 26),
      displaySmall: s(22, FontWeight.w700, height: 1.3),
      headlineLarge: s(20, FontWeight.w600, height: 1.3),
      headlineMedium: s(18, FontWeight.w600, height: 1.3),
      headlineSmall: s(16, FontWeight.w600, height: 1.3),
      titleLarge: s(18, FontWeight.w500, height: 1.3),
      titleMedium: s(16, FontWeight.w500, height: 1.3),
      titleSmall: s(14, FontWeight.w500, height: 1.3),
      bodyLarge: s(16, FontWeight.w400, height: 1.4),
      bodyMedium: s(14, FontWeight.w400, height: 1.4),
      bodySmall: s(12, FontWeight.w400, height: 1.3, c: secondary),
      labelLarge: s(15, FontWeight.w500, height: 1.0),
      labelMedium: s(12, FontWeight.w500, height: 14 / 12),
      labelSmall: s(10, FontWeight.w400, height: 1.2, c: secondary),
    );
  }
}
