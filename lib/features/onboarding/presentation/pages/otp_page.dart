import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/otp_challenge.dart';
import '../cubit/auth_cubit.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/auth_flow_navigation.dart';
import '../widgets/auth_popup_card.dart';
import '../widgets/otp_code_input.dart';

/// OTP popup (Figma 605:1850 / 645:1878 registered · 610:896 / 645:1904 new).
///
/// Presented as a dialog at [AppRoutes.otp]; the [OtpChallenge] arrives via
/// `GoRouterState.extra`. Registered users are greeted by name and log in,
/// new users continue to the Details Input page.
class OtpPage extends StatelessWidget {
  const OtpPage({required this.challenge, super.key, this.cubit});

  final OtpChallenge? challenge;

  /// Optional cubit override (tests); defaults to `sl<AuthCubit>()`.
  final AuthCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final c = challenge;
    if (c == null) return const _MissingChallenge();
    return BlocProvider<AuthCubit>(
      create: (_) => cubit ?? sl<AuthCubit>(),
      child: _OtpView(challenge: c),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView({required this.challenge});
  final OtpChallenge challenge;

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  String _code = '';
  String? _error;

  OtpChallenge get _challenge =>
      context.read<AuthCubit>().state.challenge.dataOrNull ?? widget.challenge;

  void _verify() {
    final s = OnboardingStrings.of(context);
    if (_code.length < _challenge.codeLength) {
      setState(() => _error = s.invalidOtp);
      return;
    }
    setState(() => _error = null);
    context.read<AuthCubit>().verifyOtp(
      _code,
      phoneNumber: _challenge.phoneNumber,
    );
  }

  void _close() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    final challenge = _challenge;
    // "+977 98XXXXXXXX" / "+91 98XXXXXXXX", Devanagari digits for ne/hi.
    final formattedPhone = RegionFormat.phone(
      challenge.phoneNumber,
      config: context.regionConfig,
    );
    final phone = context.usesDevanagariDigits
        ? formattedPhone.toDevanagariDigits()
        : formattedPhone;

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (p, n) =>
          p.session != n.session || p.challenge != n.challenge,
      listener: (context, state) {
        switch (state.session) {
          case Loaded(:final data):
            AuthFlowNavigation.onAuthenticated(context, data);
          case Failed(:final failure):
            setState(() => _error = failure.message);
          default:
            if (state.challenge case Failed(:final failure)) {
              setState(() => _error = failure.message);
            }
        }
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: AuthPopupCard(
              onBack: _close,
              onClose: _close,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    challenge.isRegistered ? s.existingUser : s.newUser,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    s.enterOtp,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    challenge.isRegistered && challenge.displayName != null
                        ? challenge.displayName!
                        : s.otpSentTo(phone),
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: colors.accent,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  OtpCodeInput(
                    length: challenge.codeLength,
                    enabled: !state.isLoading,
                    hasError: _error != null,
                    onChanged: (v) => setState(() {
                      _code = v;
                      _error = null;
                    }),
                    onCompleted: (_) => _verify(),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: challenge.isRegistered ? s.login : s.verify,
                    height: 44,
                    radius: AppRadius.sm,
                    isLoading: state.isLoading,
                    onPressed: _verify,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          s.notReceived,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: state.isLoading
                            ? null
                            : () => context.read<AuthCubit>().requestOtp(
                                challenge.phoneNumber,
                              ),
                        child: Text(s.resend),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Shown when the route is opened without an [OtpChallenge] (deep link).
class _MissingChallenge extends StatelessWidget {
  const _MissingChallenge();

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    return Center(
      child: AuthPopupCard(
        onClose: () => context.go(AppRoutes.login),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(s.enterMobile, style: context.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: s.login,
              radius: AppRadius.sm,
              onPressed: () => context.go(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}
