import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../app_settings/presentation/cubit/app_settings_cubit.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/onboarding_step.dart';
import '../../domain/repositories/onboarding_progress_repository.dart';

/// Moves a person through onboarding, recording each step as it is reached
/// so an app closed part-way reopens at the same place (see `SplashPage`).
///
/// The step is saved *before* navigating: if the app dies between the two,
/// reopening lands on the new step rather than repeating the old one.
abstract final class AuthFlowNavigation {
  static OnboardingProgressRepository get _progress =>
      sl<OnboardingProgressRepository>();

  /// Language and theme chosen → sign in.
  static Future<void> startSignIn(BuildContext context) async {
    await _progress.saveStep(OnboardingStep.signIn);
    if (context.mounted) unawaited(context.push<void>(AppRoutes.login));
  }

  /// Whether this person still owes their profile details.
  ///
  /// `isNewUser` alone is not enough: it is true only on the sign-in that
  /// created the account. Someone who closed the app on the details form and
  /// signed in again — or reinstalled — is no longer "new", and used to skip
  /// the form for good. The server names a phone account "Guest" until the
  /// form is submitted, so that name means the same thing.
  static bool needsDetails(AuthSession session) {
    if (session.isNewUser) return true;
    final name = session.displayName?.trim() ?? '';
    return name.isEmpty || name.toLowerCase() == 'guest';
  }

  /// Where to go once a user is authenticated (shared by login page & OTP).
  static Future<void> onAuthenticated(
    BuildContext context,
    AuthSession session,
  ) async {
    if (needsDetails(session)) {
      await _progress.saveStep(OnboardingStep.profileDetails);
      if (context.mounted) context.go(AppRoutes.detailsInput);
      return;
    }
    await finishOnboarding(context);
  }

  /// Details accepted by the server → notification preferences.
  static Future<void> onDetailsSubmitted(BuildContext context) async {
    await _progress.saveStep(OnboardingStep.notifications);
    if (context.mounted) context.go(AppRoutes.notificationSettingsOnboarding);
  }

  /// Marks onboarding complete, forgets the saved progress, enters the app.
  static Future<void> finishOnboarding(BuildContext context) async {
    await context.read<AppSettingsCubit>().completeOnboarding();
    await _progress.clear();
    if (context.mounted) context.go(AppRoutes.home);
  }

  /// Opens [step] as the screen to resume on.
  ///
  /// Sign-in is pushed on top of the language step rather than gone to
  /// directly, so Back on the login screen returns to language and theme as
  /// it does on a first run — instead of falling through to Home, which is
  /// what the top bar does when there is nothing to pop.
  static void openStep(BuildContext context, OnboardingStep step) {
    final router = GoRouter.of(context);
    switch (step) {
      case OnboardingStep.languageTheme:
        router.go(AppRoutes.languageTheme);
      case OnboardingStep.signIn:
        router.go(AppRoutes.languageTheme);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => unawaited(router.push<void>(AppRoutes.login)),
        );
      case OnboardingStep.profileDetails:
        router.go(AppRoutes.detailsInput);
      case OnboardingStep.notifications:
        router.go(AppRoutes.notificationSettingsOnboarding);
    }
  }
}
