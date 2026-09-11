import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// Which backend this build talks to.
enum AppFlavor { development, staging, production }

/// Build-time configuration.
///
/// Everything here comes from `--dart-define`, never from a checked-in file:
/// a base URL baked into source is how a debug build ends up pointing at
/// production. Defaults target the local dev stack so `flutter run` works with
/// no flags.
///
/// ```
/// flutter run \
///   --dart-define=API_BASE_URL=https://api.sanatan.app \
///   --dart-define=FLAVOR=production
/// ```
abstract final class AppEnvironment {
  const AppEnvironment._();

  static const String _flavorName = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'development',
  );

  /// Empty when the build passed no `--dart-define=API_BASE_URL`, which is
  /// what lets [apiBaseUrl] fall back per platform below.
  static const String _configuredBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
  );

  /// Port the local dev stack listens on.
  static const int _devPort = 3100;

  static AppFlavor get flavor => switch (_flavorName) {
    'production' => AppFlavor.production,
    'staging' => AppFlavor.staging,
    _ => AppFlavor.development,
  };

  static bool get isProduction => flavor == AppFlavor.production;
  static bool get isDevelopment => flavor == AppFlavor.development;

  /// Root of the API, without a trailing slash and without `/api/v1`.
  ///
  /// With no `API_BASE_URL` define this points at the local dev stack, and the
  /// host depends on where the code is running: inside the Android emulator
  /// `localhost` is the emulated phone itself, and the machine running the
  /// server is reachable at `10.0.2.2` — the single most common reason a
  /// working backend looks like "no internet connection" on device.
  ///
  /// A **physical** phone is on neither of those: pass the machine's LAN
  /// address explicitly, e.g.
  /// `flutter run --dart-define=API_BASE_URL=http://192.168.1.11:3100`.
  static String get apiBaseUrl {
    final configured = _configuredBaseUrl.isEmpty
        ? 'http://$_devHost:$_devPort'
        : _configuredBaseUrl;
    return configured.endsWith('/')
        ? configured.substring(0, configured.length - 1)
        : configured;
  }

  /// The host the dev stack is reachable at from wherever this build runs.
  static String get _devHost {
    // The iOS simulator, macOS, web and desktop all share the host's network
    // stack, so localhost is genuinely the machine. Only Android is emulated
    // behind its own NAT.
    if (kIsWeb) return 'localhost';
    return Platform.isAndroid ? '10.0.2.2' : 'localhost';
  }

  /// Versioned prefix every business endpoint sits under.
  static String get apiRoot => '$apiBaseUrl/api/v1';

  /// Request bodies and responses are only ever logged in a debug build of a
  /// development flavour — they contain tokens, addresses and birth details.
  static bool get logNetworkBodies => kDebugMode && isDevelopment;

  /// True while running under `flutter test`.
  ///
  /// `Platform.environment` is unavailable on web, where tests do not use this
  /// path anyway — hence the guard.
  static bool get isUnderTest {
    if (kIsWeb) return false;
    return Platform.environment.containsKey('FLUTTER_TEST');
  }

  /// Whether features talk to the backend or to their bundled mock data.
  ///
  /// A single switch so the app still runs — and demos — with the server down,
  /// and so features can be moved over one at a time rather than in a big bang.
  ///
  /// Two rules are absolute:
  ///
  /// * a **production** build is always live — mocks cannot ship;
  /// * a **test** always uses mocks, so a unit or widget test never opens a
  ///   socket. A suite that depends on a running server is a suite that goes
  ///   red for reasons unrelated to the change under test. Contract tests that
  ///   genuinely need the backend live in `test/live` and construct their own
  ///   client.
  static bool get useMockData {
    if (isProduction) return false;
    if (isUnderTest) return true;
    return const bool.fromEnvironment('USE_MOCK_DATA');
  }

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
