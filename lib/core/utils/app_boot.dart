import 'package:flutter/foundation.dart';

/// How long the app has been starting, and how much of the splash is left.
///
/// The launch is two screens that must read as one: the Android launch screen
/// the OS paints from `@drawable/launch_background` while the process starts,
/// then [SplashPage] with the same mark on the same colour. If the splash
/// always ran its full length, a cold start on an old phone would show the
/// brand for the OS splash *plus* another 1.5 s. Instead the splash shows
/// whatever is left of [_total], with a floor so the draw-in never turns into
/// a flicker.
abstract final class AppBoot {
  static DateTime? _startedAt;

  /// Wall clock the splash is measured against: it covers everything after
  /// this, whether the wait was dependency injection, a cold disk, or nothing.
  @visibleForTesting
  static const Duration total = Duration(milliseconds: 1500);

  /// Below this the reveal reads as a glitch rather than an intro, so a fast
  /// start still gets a short, complete one.
  @visibleForTesting
  static const Duration floor = Duration(milliseconds: 650);

  /// Called first thing in `main()`.
  static void markStarted([DateTime? now]) => _startedAt ??= now ?? DateTime.now();

  @visibleForTesting
  static void reset() => _startedAt = null;

  /// What is left of the launch. [now] is for tests.
  static Duration splashRemainder({DateTime? now}) {
    final startedAt = _startedAt;
    if (startedAt == null) return total;
    final spent = (now ?? DateTime.now()).difference(startedAt);
    final left = total - spent;
    return left < floor ? floor : left;
  }
}
