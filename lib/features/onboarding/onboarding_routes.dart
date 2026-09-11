import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import 'domain/entities/otp_challenge.dart';
import 'presentation/pages/details_input_page.dart';
import 'presentation/pages/language_theme_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/notification_settings_onboarding_page.dart';
import 'presentation/pages/otp_page.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/widgets/dialog_page.dart';

/// Routes pushed on top of the shell for the onboarding feature.
final List<RouteBase> onboardingRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.splash,
    name: 'splash',
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: AppRoutes.languageTheme,
    name: 'languageTheme',
    builder: (context, state) => const LanguageThemePage(),
  ),
  GoRoute(
    path: AppRoutes.login,
    name: 'login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: AppRoutes.otp,
    name: 'otp',
    // The OTP step is a 300×344 popup in Figma → presented as a dialog.
    pageBuilder: (context, state) => DialogPage<void>(
      key: state.pageKey,
      name: 'otp',
      barrierDismissible: false,
      builder: (_) => OtpPage(challenge: state.extra as OtpChallenge?),
    ),
  ),
  GoRoute(
    path: AppRoutes.detailsInput,
    name: 'detailsInput',
    builder: (context, state) => const DetailsInputPage(),
  ),
  GoRoute(
    path: AppRoutes.notificationSettingsOnboarding,
    name: 'notificationSettingsOnboarding',
    builder: (context, state) => const NotificationSettingsOnboardingPage(),
  ),
];
