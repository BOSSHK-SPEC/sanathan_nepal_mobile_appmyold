import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/repositories/auth_repository.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/repositories/notification_prefs_repository.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/sign_in_with_phone.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/submit_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/verify_otp.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockNotificationPrefsRepository extends Mock
    implements NotificationPrefsRepository {}

class MockSignInWithPhone extends Mock implements SignInWithPhone {}

class MockVerifyOtp extends Mock implements VerifyOtp {}

class MockSubmitProfile extends Mock implements SubmitProfile {}

/// Real [AppSettingsCubit] backed by an in-memory store.
AppSettingsCubit buildAppSettingsCubit() {
  final repo = AppPreferencesRepositoryImpl(
    AppPreferencesLocalDataSourceImpl(InMemoryKeyValueStore()),
  );
  return AppSettingsCubit(
    getPreferences: GetAppPreferences(repo),
    savePreferences: SaveAppPreferences(repo),
  );
}

/// Wraps [child] with theme, localisation, a [RegionScope] (above the
/// navigator so sheets/dialogs see it too) and an [AppSettingsCubit].
Widget wrapApp(
  Widget child, {
  AppSettingsCubit? settings,
  Locale locale = const Locale('en'),
  bool dark = false,
  Region region = Region.nepal,
}) => BlocProvider<AppSettingsCubit>.value(
  value: settings ?? buildAppSettingsCubit(),
  child: RegionScope(
    region: region,
    child: MaterialApp(
      theme: dark ? AppTheme.dark() : AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  ),
);

/// Loads the bundled Mukta font so text metrics match the real app
/// (the default test font is much wider and causes false overflows).
Future<void> loadAppFonts() async {
  final loader = FontLoader('Mukta');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    final file = File('assets/fonts/Mukta-$weight.ttf');
    if (!file.existsSync()) continue;
    final bytes = await file.readAsBytes();
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));
  }
  await loader.load();
}

/// Uses a phone-sized surface so layouts match the Figma frame.
Future<void> setPhoneSurface(WidgetTester tester) async {
  tester.view.physicalSize = const Size(375 * 3, 812 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}
