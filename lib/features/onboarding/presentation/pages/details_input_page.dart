import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/user_profile_draft.dart';
import '../cubit/profile_details_cubit.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/date_of_birth_field.dart';
import '../widgets/auth_flow_navigation.dart';
import '../widgets/page_dots.dart';
import '../widgets/post_sign_in_scope.dart';

/// Details Input Page (Figma 205:15): name, DOB (BS/AD · Saka/A.D.), birth
/// time & place,
/// gender and horoscope sign. Submits via [ProfileDetailsCubit].
class DetailsInputPage extends StatelessWidget {
  const DetailsInputPage({super.key, this.cubit});

  /// Optional cubit override (tests); defaults to `sl<ProfileDetailsCubit>()`.
  final ProfileDetailsCubit? cubit;

  @override
  Widget build(BuildContext context) => BlocProvider<ProfileDetailsCubit>(
    create: (_) => cubit ?? sl<ProfileDetailsCubit>(),
    // Reached right after OTP: Back must not reopen sign-in.
    child: const PostSignInScope(child: _DetailsForm()),
  );
}

class _DetailsForm extends StatefulWidget {
  const _DetailsForm();

  @override
  State<_DetailsForm> createState() => _DetailsFormState();
}

class _DetailsFormState extends State<_DetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _timeController = TextEditingController();

  /// Nothing is judged until Continue is pressed. `onUserInteraction` on a
  /// [Form] re-validates *every* field as soon as *any* one changes, so typing
  /// a name used to flag the gender and date fields the person had not reached
  /// yet. After the first attempt, fields re-check as they are edited, so an
  /// error clears the moment it is fixed.
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) {
      if (_autovalidate != AutovalidateMode.onUserInteraction) {
        setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      }
      return;
    }
    context.read<ProfileDetailsCubit>().submit();
  }

  String _time(int? minutes) {
    if (minutes == null) return '';
    final t = TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
    final text = MaterialLocalizations.of(context).formatTimeOfDay(t);
    return context.usesDevanagariDigits ? text.toDevanagariDigits() : text;
  }

  Future<void> _pickTime(int? current) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current == null
          ? const TimeOfDay(hour: 6, minute: 30)
          : TimeOfDay(hour: current ~/ 60, minute: current % 60),
    );
    if (picked != null && mounted) {
      context.read<ProfileDetailsCubit>().setBirthTime(
        picked.hour * 60 + picked.minute,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    return BlocConsumer<ProfileDetailsCubit, ProfileDetailsState>(
      listenWhen: (p, n) => p.submission != n.submission,
      listener: (context, state) {
        switch (state.submission) {
          case Loaded():
            AuthFlowNavigation.onDetailsSubmitted(context);
          case Failed(:final failure):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          default:
            break;
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProfileDetailsCubit>();
        final draft = state.draft;
        _timeController.text = _time(draft.birthTimeMinutes);
        return Scaffold(
          // No back arrow: the step before this one is the OTP dialog of an
          // account that is now signed in. See [PostSignInScope].
          appBar: AppTopBar(title: s.detailsTitle),
          body: SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidate,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.lg,
                  AppSpacing.pageGutter,
                  AppSpacing.xxl,
                ),
                children: [
                  Text(
                    s.detailsSubtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    label: s.fullName,
                    required: true,
                    hint: s.fullNameHint,
                    initialValue: draft.fullName,
                    textInputAction: TextInputAction.next,
                    onChanged: cubit.setFullName,
                    validator: (v) =>
                        (v ?? '').trim().length < 2 ? s.requiredField : null,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: s.email,
                    hint: s.emailHint,
                    initialValue: draft.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: cubit.setEmail,
                    // Optional: only an address that was actually typed is
                    // checked. Trimmed first — a stray space from the keyboard
                    // or autofill used to count as "filled in" and fail.
                    validator: (v) {
                      final email = (v ?? '').trim();
                      return email.isEmpty || _email.hasMatch(email)
                          ? null
                          : s.invalidEmail;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  DateOfBirthField(
                    value: draft.dateOfBirth,
                    system: draft.dateSystem,
                    onDateChanged: cubit.setDateOfBirth,
                    onSystemChanged: cubit.setDateSystem,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: s.birthTime,
                          hint: s.pickTime,
                          readOnly: true,
                          controller: _timeController,
                          onTap: () => _pickTime(draft.birthTimeMinutes),
                          suffix: Icon(
                            Icons.access_time,
                            color: colors.iconMuted,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppTextField(
                          label: s.birthPlace,
                          hint: s.birthPlaceHint(
                            context.regionConfig.defaultCity.name(
                              context.languageCode,
                            ),
                          ),
                          initialValue: draft.birthPlace,
                          textInputAction: TextInputAction.done,
                          onChanged: cubit.setBirthPlace,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _GenderField(value: draft.gender, onChanged: cubit.setGender),
                  const SizedBox(height: AppSpacing.lg),
                  Text(s.horoscopeSign, style: context.textTheme.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<ZodiacSign>(
                    initialValue: draft.zodiacSign,
                    hint: Text(s.selectSign),
                    isExpanded: true,
                    items: [
                      for (final z in ZodiacSign.values)
                        DropdownMenuItem(value: z, child: Text(s.zodiac(z))),
                    ],
                    onChanged: (v) {
                      if (v != null) cubit.setZodiacSign(v);
                    },
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  const Center(child: PageDots(count: 4, activeIndex: 2)),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: context.l10n.continueLabel,
                    isLoading: state.isSubmitting,
                    onPressed: _submit,
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

class _GenderField extends StatelessWidget {
  const _GenderField({required this.value, required this.onChanged});
  final Gender? value;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    return FormField<Gender>(
      initialValue: value,
      validator: (_) => value == null ? s.requiredField : null,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: s.gender,
              style: context.textTheme.titleSmall,
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: colors.error),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.lg,
            children: [
              AppRadioOption<Gender?>(
                value: Gender.male,
                groupValue: value,
                label: s.male,
                onChanged: (v) => onChanged(v!),
              ),
              AppRadioOption<Gender?>(
                value: Gender.female,
                groupValue: value,
                label: s.female,
                onChanged: (v) => onChanged(v!),
              ),
              AppRadioOption<Gender?>(
                value: Gender.other,
                groupValue: value,
                label: s.other,
                onChanged: (v) => onChanged(v!),
              ),
            ],
          ),
          if (field.hasError)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(
                field.errorText!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
