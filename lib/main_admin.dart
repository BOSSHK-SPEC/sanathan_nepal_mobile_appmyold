import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'admin/admin_app.dart';
import 'admin/di/admin_injection.dart';

/// Entry point for the **staff console** web app.
///
/// Built separately from `lib/main.dart`:
///
/// ```bash
/// flutter build web -t lib/main_admin.dart \
///   --dart-define-from-file=config/admin.json \
///   --output build/admin
/// ```
///
/// Separate targets rather than one app with an "admin mode": the moderation
/// queue, the payout screen and the audit log have no business being compiled
/// into the APK that ships to users, however well a runtime check hides them.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initializeDateFormatting(), configureAdminDependencies()]);
  runApp(const SanatanAdminApp());
}
