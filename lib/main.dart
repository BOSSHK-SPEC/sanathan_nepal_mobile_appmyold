import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'app/di/injection.dart';
import 'core/auth/auth_session_manager.dart';
import 'core/push/push_coordinator.dart';
import 'core/session/session_sync.dart';
import 'features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'features/session/presentation/cubit/session_cubit.dart';
import 'features/system/presentation/cubit/system_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initializeDateFormatting(), configureDependencies()]);
  await Future.wait([
    sl<AppSettingsCubit>().load(),
    sl<SessionCubit>().load(),
    sl<SystemCubit>().start(),
  ]);
  runApp(const SanatanNepalApp());

  // Roles are re-read from the server on every launch. The session above was
  // built from the cached profile so the first frame is instant; this checks
  // that what it believes is still true — an approval granted, or a role
  // withdrawn, while the app was closed. Not awaited: a slow network must not
  // hold the splash, and the session reloads itself when the answer lands.
  if (sl<AuthSessionManager>().hasSession) {
    unawaited(sl<SessionSync>().syncFromServer());
    // Started here rather than before `runApp` for the same reason: it asks
    // for notification permission and registers this device with the server,
    // and neither a system dialog nor a slow network should hold the splash.
    unawaited(sl<PushCoordinator>().start());
  }
}
