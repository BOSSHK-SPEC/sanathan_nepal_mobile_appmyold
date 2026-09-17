import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'admin/admin_app.dart';
import 'admin/di/admin_injection.dart';
import 'admin/platform/landing_site.dart';

/// Entry point for the **staff console** web app.
///
/// Built separately from `lib/main.dart`:
///
/// ```bash
/// npm --prefix landing ci && npm --prefix landing run build   # → web/welcome/
/// flutter build web -t lib/main_admin.dart \
///   --dart-define-from-file=config/admin.json \
///   --output build/admin
/// ```
///
/// Separate targets rather than one app with an "admin mode": the moderation
/// queue, the payout screen and the audit log have no business being compiled
/// into the APK that ships to users, however well a runtime check hides them.
Future<void> main() async {
  // Real paths (/sign-in, /console/payouts), not /#/…: the bare `/` is the
  // static landing site, and a hash route would never reach the console.
  // Old /#/… bookmarks are forwarded by landing/src/pages/home.ts.
  usePathUrlStrategy();

  // `/`, `/privacy` and `/delete-account` are the static public site, not
  // console routes. Hand them over before the app starts, so nobody opening
  // one of them lands on sign-in.
  final publicPage = landingTargetFor(Uri.base);
  if (publicPage != null && openLandingSite(publicPage)) return;

  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initializeDateFormatting(), configureAdminDependencies()]);
  runApp(const SanatanAdminApp());
}
