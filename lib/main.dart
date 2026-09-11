import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'app/di/injection.dart';
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
}
