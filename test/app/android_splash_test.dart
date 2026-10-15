import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_colors.dart';

/// The Android launch screen is XML the Dart code cannot reach, so nothing at
/// runtime notices when it drifts from the theme. These tests are that notice:
/// a flat launch colour that no longer matches the gradient SplashPage opens on
/// shows up as a flash of the wrong colour on every cold start.
void main() {
  String res(String path) =>
      File('android/app/src/main/res/$path').readAsStringSync();

  String colour(String xml, String name) {
    final m = RegExp('<color name="$name">(#[0-9A-Fa-f]{6,8})</color>')
        .firstMatch(xml);
    expect(m, isNotNull, reason: 'no colour named $name');
    return m!.group(1)!.toUpperCase();
  }

  String hex(Color c) =>
      '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

  group('launch colours', () {
    test('the background is the one SplashPage opens on', () {
      expect(
        colour(res('values/colors.xml'), 'splash_background'),
        hex(AppColors.launchBackground),
      );
    });

    test('the mark is drawn in the ink SplashPage uses for it', () {
      expect(
        colour(res('values/colors.xml'), 'splash_mark'),
        hex(AppColors.launchMark),
      );
    });

    test('night does not get a colour of its own', () {
      // The app's theme is its own setting and defaults to light, so a
      // system-dark launch colour would be wrong on most dark phones.
      expect(File('android/app/src/main/res/values-night/colors.xml').existsSync(), isFalse);
    });
  });

  group('launch theme', () {
    test('Android 11 and below get the mark over the brand colour', () {
      final xml = res('drawable/launch_background.xml');
      expect(xml, contains('@color/splash_background'));
      expect(xml, contains('@drawable/splash_mark'));
      expect(xml, contains('android:gravity="center"'));
      expect(xml, isNot(contains('@android:color/white')));
    });

    test('Android 12+ uses the SplashScreen API, in both ui modes', () {
      // Night beats platform version when Android resolves a resource folder,
      // so values-night needs its own v31 twin or dark launches lose the icon.
      for (final dir in ['values-v31', 'values-night-v31']) {
        final xml = res('$dir/styles.xml');
        expect(xml, contains('android:windowSplashScreenBackground">@color/splash_background'));
        expect(xml, contains('android:windowSplashScreenAnimatedIcon">@drawable/splash_mark'));
        expect(xml, contains('<style name="NormalTheme"'));
      }
    });

    test('the launcher activity still opens on LaunchTheme', () {
      final manifest =
          File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      expect(manifest, contains('android:theme="@style/LaunchTheme"'));
      // What replaces the splash window once the process is up. The platform
      // has no postSplashScreenTheme attribute — Flutter reads this instead,
      // and without it the launch colour stays behind the app.
      expect(manifest, contains('io.flutter.embedding.android.NormalTheme'));
      expect(manifest, contains('@style/NormalTheme'));
    });
  });

  group('splash_mark.xml', () {
    final xml = res('drawable/splash_mark.xml');
    final paths = RegExp('android:pathData="([^"]+)"')
        .allMatches(xml)
        .map((m) => m.group(1)!)
        .toList();

    test('is authored on the 240dp splash-icon canvas', () {
      expect(xml, contains('android:viewportWidth="240"'));
      expect(xml, contains('android:viewportHeight="240"'));
      expect(paths, hasLength(greaterThanOrEqualTo(12))); // 2 rings, 8 petals, 2 triangles…
    });

    test('stays inside the circle Android masks the icon with', () {
      // The system shows only the inner 160dp of the 240dp canvas. Anything
      // beyond r=80 of the centre is cut off on Android 12+.
      const centre = Offset(120, 120);
      for (final data in paths) {
        final double reach;
        if (data.contains('a')) {
          // Circle form: M(cx-r),cy a r,r …
          reach = double.parse(
            RegExp(r'a(-?[\d.]+),').firstMatch(data)!.group(1)!,
          );
        } else {
          reach = RegExp(r'(-?[\d.]+),(-?[\d.]+)')
              .allMatches(data)
              .map((m) => (Offset(double.parse(m.group(1)!),
                      double.parse(m.group(2)!)) -
                  centre))
              .map((o) => o.distance)
              .reduce(math.max);
        }
        expect(reach, lessThanOrEqualTo(80),
            reason: 'path reaches $reach: $data');
      }
    });

    test('every stroke uses the themed colour, never a literal', () {
      expect(xml, isNot(contains(RegExp('Color="#'))));
      expect(xml, contains('@color/splash_mark'));
    });
  });
}
