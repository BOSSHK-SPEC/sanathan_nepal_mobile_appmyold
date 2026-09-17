import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../app_settings/presentation/cubit/app_settings_cubit.dart';
import '../../domain/entities/onboarding_step.dart';
import '../../domain/repositories/auth_presence.dart';
import '../../domain/repositories/onboarding_progress_repository.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/auth_flow_navigation.dart';

/// Loading screen (Figma 205:2). Shows the brand mark on the primary
/// gradient, then routes to the app — or back into onboarding at the step the
/// person had reached, if they closed the app part-way through.
class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    this.delay = const Duration(milliseconds: 1500),
    this.progress,
    this.presence,
  });

  final Duration delay;

  /// Overrides for tests; default to the registered implementations.
  final OnboardingProgressRepository? progress;
  final AuthPresence? presence;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, _next);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _next() {
    if (!mounted) return;
    final prefs = context.read<AppSettingsCubit>().state;
    final progress = widget.progress ?? sl<OnboardingProgressRepository>();
    final presence = widget.presence ?? sl<AuthPresence>();
    final signedIn = presence.isSignedIn;
    if (prefs.onboardingCompleted) {
      // Finishing onboarding once does not mean signed in for good. After a
      // sign-out this flag is still set, and it used to open Home for nobody.
      // A returning user goes straight to sign-in; language and theme were
      // chosen already.
      context.go(signedIn ? AppRoutes.home : AppRoutes.login);
      return;
    }
    AuthFlowNavigation.openStep(
      context,
      OnboardingStep.resume(saved: progress.step, signedIn: signedIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = OnboardingStrings.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: colors.primaryGradient),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.onPrimary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'ॐ',
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 56,
                      height: 1.2,
                      color: colors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  s.appName,
                  style: context.textTheme.displayMedium?.copyWith(
                    color: colors.onPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  s.tagline,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
