import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/auth_flow_navigation.dart';
import '../widgets/phone_number_sheet.dart';

/// SIGNUP / LOGIN.
///
/// Sign-in is by mobile number and a one-time code only. Google and Apple were
/// removed: neither SDK was ever wired, production refuses social sign-in, and
/// a button that can only fail is worse than no button.
///
/// Layout: a brand hero on the theme's primary gradient (the same Om mark as
/// the splash, so the hand-off feels continuous) and a sign-in panel rising
/// over it with one primary action. Every colour is an [AppColors] role, so
/// the light (orange) and dark (indigo/violet) themes need no branching.
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
  /// How far the panel rises over the hero.
  static const double _overlap = 28;

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

  void _showFailure(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, n) =>
          p.session != n.session || p.challenge != n.challenge,
      listener: (context, state) {
        switch (state.session) {
          case Loaded(:final data):
            AuthFlowNavigation.onAuthenticated(context, data);
          case Failed(:final failure) when !_sheetOpen:
            _showFailure(failure.message);
          default:
            // While the sheet is open it shows the error itself.
            if (state.challenge case Failed(:final failure) when !_sheetOpen) {
              _showFailure(failure.message);
            }
        }
      },
      child: Scaffold(
        backgroundColor: colors.background,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final heroHeight = (constraints.maxHeight * 0.42).clamp(
              260.0,
              380.0,
            );
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Stack(
                  children: [
                    _BrandHero(height: heroHeight),
                    Padding(
                      padding: EdgeInsets.only(top: heroHeight - _overlap),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight:
                              constraints.maxHeight - heroHeight + _overlap,
                        ),
                        // Bounded to its content so the panel's Spacer has a
                        // finite height to fill.
                        child: IntrinsicHeight(
                          child: _SignInPanel(onPhoneTap: _openPhoneSheet),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Primary-gradient header with the brand mark, name and tagline. The soft
/// rings echo a mandala without needing an image asset.
class _BrandHero extends StatelessWidget {
  const _BrandHero({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = OnboardingStrings.of(context);
    final ring = colors.onPrimary.withValues(alpha: 0.14);
    return Container(
      height: height,
      decoration: BoxDecoration(gradient: colors.primaryGradient),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(top: -70, right: -60, child: _Ring(220, ring)),
          Positioned(top: 40, right: 30, child: _Ring(70, ring)),
          Positioned(bottom: -40, left: -70, child: _Ring(200, ring)),
          SafeArea(
            bottom: false,
            child: Center(
              child: Padding(
                // Keeps the content centred in the visible part of the hero,
                // not behind the panel that overlaps its bottom edge.
                padding: const EdgeInsets.only(
                  bottom: _LoginViewState._overlap,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _OmMark(color: colors.primary),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      s.appName,
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Padding(
                      padding: AppSpacing.page,
                      child: Text(
                        s.tagline,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimary.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OmMark extends StatelessWidget {
  const _OmMark({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 92,
      height: 92,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.onPrimary,
        border: Border.all(
          color: colors.onPrimary.withValues(alpha: 0.45),
          width: 6,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ExcludeSemantics(
        child: Text(
          'ॐ',
          style: context.textTheme.displayLarge?.copyWith(
            fontSize: 46,
            height: 1.2,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring(this.size, this.color);
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: color, width: 1.5),
    ),
  );
}

/// The sheet-like panel: greeting, one action, reassurance and legal links.
class _SignInPanel extends StatelessWidget {
  const _SignInPanel({required this.onPhoneTap});
  final VoidCallback onPhoneTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = OnboardingStrings.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        AppSpacing.xxxl,
        AppSpacing.xxl,
        AppSpacing.lg,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              s.loginWelcome,
              style: context.textTheme.titleMedium?.copyWith(
                color: colors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              s.loginTitle,
              style: context.textTheme.displayMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              s.loginSubtitle,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textMuted,
                height: 1.45,
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (p, n) => p.isLoading != n.isLoading,
              builder: (context, state) => PrimaryButton(
                label: s.continueWithNumber,
                height: 52,
                radius: AppRadius.lg,
                isLoading: state.isLoading,
                icon: Icon(
                  Icons.phone_iphone_rounded,
                  size: 20,
                  color: colors.onPrimary,
                ),
                onPressed: onPhoneTap,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _SecureNote(text: s.loginSecureNote),
            // Pins the legal line to the bottom on tall screens; on short
            // ones the page scrolls and this collapses to the minimum gap.
            const Spacer(),
            const SizedBox(height: AppSpacing.xxxl),
            const _LegalLinks(),
          ],
        ),
      ),
    );
  }
}

class _SecureNote extends StatelessWidget {
  const _SecureNote({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.chipBackground,
        borderRadius: AppRadius.card,
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline_rounded, size: 18, color: colors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "By continuing, you agree to our Terms and Privacy Policy." Both pages are
/// public routes, so they open before sign-in.
class _LegalLinks extends StatelessWidget {
  const _LegalLinks();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = OnboardingStrings.of(context);
    final base = context.textTheme.bodySmall?.copyWith(color: colors.textMuted);
    final link = base?.copyWith(
      color: colors.accent,
      fontWeight: FontWeight.w600,
    );
    Widget linkTo(String label, String route) => InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(AppRadius.xs),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
        child: Text(label, style: link),
      ),
    );
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.xs,
      children: [
        Text(s.legalPrefix, style: base),
        linkTo(s.termsLink, AppRoutes.termsConditions),
        Text(s.legalAnd, style: base),
        linkTo(s.privacyLink, AppRoutes.privacyPolicy),
        if (s.legalSuffix.isNotEmpty) Text(s.legalSuffix, style: base),
      ],
    );
  }
}
