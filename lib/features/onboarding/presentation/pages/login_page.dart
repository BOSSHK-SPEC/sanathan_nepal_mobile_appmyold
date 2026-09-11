import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../cubit/auth_cubit.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/auth_flow_navigation.dart';
import '../widgets/phone_number_sheet.dart';
import '../widgets/social_login_button.dart';

/// SIGNUP / LOGIN (Figma 205:14 light · 667:1660 dark).
///
/// Light: gradient header with a white welcome card overlapping it, social
/// buttons below on the page. Dark: translucent header, gradient card that
/// contains the buttons. Both are driven purely by [AppColors] roles.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.cubit});

  /// Optional cubit override (tests); defaults to `sl<AuthCubit>()`.
  final AuthCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => cubit ?? sl<AuthCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  bool _sheetOpen = false;

  Future<void> _openPhoneSheet() async {
    final cubit = context.read<AuthCubit>();
    _sheetOpen = true;
    await PhoneNumberSheet.show(context);
    _sheetOpen = false;
    if (!mounted) return;
    if (cubit.state.challenge case Loaded(:final data)) {
      cubit.reset();
      await context.push(AppRoutes.otp, extra: data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDark;
    final headerHeight = (context.screenSize.height * 0.42).clamp(260.0, 400.0);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, n) =>
          p.session != n.session || p.challenge != n.challenge,
      listener: (context, state) {
        switch (state.session) {
          case Loaded(:final data):
            AuthFlowNavigation.onAuthenticated(context, data);
          case Failed(:final failure) when !_sheetOpen:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          default:
            if (state.challenge case Failed(:final failure) when !_sheetOpen) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Header (gradient in light, translucent tint in dark).
              Container(
                height: headerHeight,
                decoration: BoxDecoration(
                  gradient: isDark ? null : colors.headerGradient,
                  color: isDark ? colors.chipBackground : null,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: headerHeight - 100),
                child: Column(
                  children: [
                    _WelcomeCard(isDark: isDark, onPhoneTap: _openPhoneSheet),
                    if (!isDark) ...[
                      const SizedBox(height: AppSpacing.xl),
                      _SocialButtons(onPhoneTap: _openPhoneSheet),
                    ],
                    const SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.isDark, required this.onPhoneTap});
  final bool isDark;
  final VoidCallback onPhoneTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = OnboardingStrings.of(context);
    final textColor = isDark ? colors.onPrimary : colors.textPrimary;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 39),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: isDark ? null : colors.surface,
        gradient: isDark ? colors.primaryGradient : null,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            s.loginWelcome,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineLarge?.copyWith(
              fontSize: isDark ? 17 : 20,
              fontWeight: FontWeight.w700,
              color: textColor,
              height: 32 / 20,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            s.loginTitle,
            textAlign: TextAlign.center,
            style: context.textTheme.displayMedium?.copyWith(color: textColor),
          ),
          if (isDark) ...[
            const SizedBox(height: AppSpacing.xxl),
            _SocialButtons(horizontalPadding: 0, onPhoneTap: onPhoneTap),
          ],
        ],
      ),
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons({required this.onPhoneTap, this.horizontalPadding = 49});
  final VoidCallback onPhoneTap;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              SocialLoginButton(
                label: s.continueWithGoogle,
                icon: AppImage(
                  AppAssets.icon('onboarding/google_logo.svg'),
                  width: 23,
                  height: 23,
                ),
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : cubit.signInWithGoogle,
              ),
              const SizedBox(height: AppSpacing.md),
              SocialLoginButton(
                label: s.continueWithApple,
                icon: Icon(Icons.apple, size: 26, color: colors.textPrimary),
                onPressed: state.isLoading ? null : cubit.signInWithApple,
              ),
              const SizedBox(height: AppSpacing.md),
              SocialLoginButton(
                label: s.continueWithNumber,
                icon: AppImage(
                  AppAssets.icon('onboarding/phone.svg'),
                  width: 14,
                  height: 26,
                  fit: BoxFit.contain,
                ),
                onPressed: state.isLoading ? null : onPhoneTap,
              ),
            ],
          ),
        );
      },
    );
  }
}
