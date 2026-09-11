import 'package:flutter/widgets.dart';

/// Spacing & radius tokens (4-pt grid) matching the Figma layout.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Horizontal page gutter used across all screens (Figma: 16–20).
  static const double pageGutter = 16;

  static const EdgeInsets page = EdgeInsets.symmetric(horizontal: pageGutter);
  static const EdgeInsets card = EdgeInsets.all(md);
}

abstract final class AppRadius {
  static const double xs = 2;
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double pill = 100;

  static BorderRadius get card => BorderRadius.circular(lg);
  static BorderRadius get button => BorderRadius.circular(pill);
  static BorderRadius get input => BorderRadius.circular(md);
}
