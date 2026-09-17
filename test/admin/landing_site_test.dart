import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/admin/platform/landing_site.dart';

/// `/`, `/privacy` and `/delete-account` belong to the static public site;
/// everything else is the console's.
void main() {
  const host = 'https://console.yashwanthhk.com';
  String? target(String url) => landingTargetFor(Uri.parse(url));

  test(
    'the bare domain opens the landing page, with or without query/fragment',
    () {
      for (final url in [
        '$host/',
        host,
        'http://localhost:5173/?utm_source=x',
        '$host/#/console/payouts',
      ]) {
        expect(target(url), landingSitePath, reason: url);
      }
    },
  );

  test('the privacy and delete-account URLs open their static pages', () {
    expect(target('$host/privacy'), '/welcome/privacy/index.html');
    expect(target('$host/privacy/'), '/welcome/privacy/index.html');
    expect(
      target('$host/delete-account'),
      '/welcome/delete-account/index.html',
    );
    expect(
      target('$host/delete-account/?x=1'),
      '/welcome/delete-account/index.html',
    );
  });

  test('folder URLs of the static site resolve to their index.html', () {
    expect(target('$host/welcome/kn/'), '/welcome/kn/index.html');
    expect(
      target('$host/welcome/kn/privacy/'),
      '/welcome/kn/privacy/index.html',
    );
    expect(
      target('$host/welcome/ta/delete-account'),
      '/welcome/ta/delete-account/index.html',
    );
  });

  test(
    'console routes, real files and already-resolved pages are left alone',
    () {
      for (final path in [
        '/sign-in',
        '/console',
        '/console/payouts',
        '/privacy-settings',
        landingSitePath,
        '/welcome/kn/index.html',
        '/welcome/assets/index-abc123.js',
      ]) {
        expect(target('$host$path'), isNull, reason: path);
      }
    },
  );

  test('outside a browser there is no page to replace', () {
    expect(openLandingSite(landingSitePath), isFalse);
  });

  test('the static site URL does not shadow a project folder', () {
    // `flutter run` serves the project root before web/, so a top-level
    // folder with this name would replace the built page with its sources.
    final folder = Uri.parse(landingSitePath).pathSegments.first;
    expect(Directory(folder).existsSync(), isFalse, reason: folder);
    expect(Directory('web').existsSync(), isTrue);
  });
}
