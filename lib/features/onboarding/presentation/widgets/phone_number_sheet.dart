import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/usecases/sign_in_with_phone.dart';
import '../cubit/auth_cubit.dart';
import '../l10n/onboarding_strings.dart';

/// "SIGNUP WITH NUMBER" bottom sheet (Figma 645:1866): mobile-number field
/// (with the region's dialling prefix, +977 / +91), gradient NEXT button and a
/// reassurance note. Requires an [AuthCubit] above.
class PhoneNumberSheet extends StatefulWidget {
  const PhoneNumberSheet({super.key});

  /// Opens the sheet re-using the [AuthCubit] from [context].
  static Future<void> show(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const PhoneNumberSheet()),
    );
  }

  @override
  State<PhoneNumberSheet> createState() => _PhoneNumberSheetState();
}

class _PhoneNumberSheetState extends State<PhoneNumberSheet> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().requestOtp(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    final config = context.regionConfig;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (p, n) => p.challenge != n.challenge,
      listener: (context, state) {
        if (state.challenge.isLoaded) Navigator.of(context).pop();
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xxl,
              AppSpacing.md,
              AppSpacing.xxl,
              AppSpacing.xxl,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.signupWithNumber,
                          style: context.textTheme.labelMedium?.copyWith(
                            letterSpacing: 0.8,
                            color: colors.textMuted,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.cancel_outlined, color: colors.icon),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    s.enterMobile,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    controller: _controller,
                    hint: s.mobileHint,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.md),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.phone_android_outlined, size: 20),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            config.phonePrefix,
                            key: const Key('phone_prefix'),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d+\-\s]')),
                      LengthLimitingTextInputFormatter(15),
                    ],
                    validator: (v) =>
                        SignInWithPhone.isValid(v ?? '', config: config)
                        ? null
                        : s.invalidPhone,
                  ),
                  if (state.challenge.errorMessage case final message?) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: s.next,
                    height: 46,
                    radius: AppRadius.sm,
                    isLoading: state.challenge.isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    s.phoneHelp,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.textMuted,
                    ),
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
