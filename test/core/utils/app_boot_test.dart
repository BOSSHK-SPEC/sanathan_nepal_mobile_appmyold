import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/app_boot.dart';

/// The launch is one continuous brand moment split over two screens (the OS
/// launch window, then SplashPage). This is the arithmetic that keeps the whole
/// thing the same length however slow the start was.
void main() {
  setUp(AppBoot.reset);
  tearDown(AppBoot.reset);

  final start = DateTime(2026, 9, 18, 9);

  test('before main() marks the start, the splash runs its full length', () {
    expect(AppBoot.splashRemainder(), AppBoot.total);
  });

  test('time already spent starting comes off the splash', () {
    AppBoot.markStarted(start);
    expect(
      AppBoot.splashRemainder(now: start.add(const Duration(milliseconds: 400))),
      AppBoot.total - const Duration(milliseconds: 400),
    );
  });

  test('a slow start is absorbed, never added to', () {
    AppBoot.markStarted(start);
    // Eight seconds of cold start: the splash does not then sit for another
    // 1.5 s on top of it.
    expect(
      AppBoot.splashRemainder(now: start.add(const Duration(seconds: 8))),
      AppBoot.floor,
    );
  });

  test('a start that used up nearly all of it still gets a full intro', () {
    AppBoot.markStarted(start);
    expect(
      AppBoot.splashRemainder(now: start.add(const Duration(milliseconds: 1400))),
      AppBoot.floor,
    );
  });

  test('the clock is only started once, at the real launch', () {
    AppBoot.markStarted(start);
    AppBoot.markStarted(start.add(const Duration(seconds: 5)));
    expect(
      AppBoot.splashRemainder(now: start.add(const Duration(milliseconds: 500))),
      AppBoot.total - const Duration(milliseconds: 500),
    );
  });
}
