import '../../../../core/media/media_bucket.dart';
import '../../../../core/media/media_upload_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/user_profile.dart';
import '../cubit/edit_profile_cubit.dart';
import '../l10n/profile_strings.dart';
import '../widgets/avatar_picker.dart';
import '../widgets/dob_format.dart';
import '../../../../core/widgets/traditional_date_picker.dart';
import '../widgets/zodiac_dropdown.dart';

/// Edit profile form (Figma "EDIT USER PROFILE" 1873:4031 dark / 1351:2978
/// light). Phone prefix and the traditional DOB calendar (B.S. / Saka)
/// follow the active region.
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<EditProfileCubit>()..load(),
    child: const EditProfileView(),
  );
}

/// Widget-testable body of [EditProfilePage].
class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  final _phone = TextEditingController();
  final _religion = TextEditingController();
  final _birthPlace = TextEditingController();
  final _address = TextEditingController();
  final _bio = TextEditingController();
  Gender? _gender;
  ProfileZodiac? _zodiac;
  String? _dobBs;
  String? _dobAd;
  String? _birthTime;
  String? _avatarFile;
  bool _seeded = false;

  @override
  void dispose() {
    for (final c in [
      _name,
      _email,
      _phone,
      _religion,
      _birthPlace,
      _address,
      _bio,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _seed(UserProfile p) {
    if (_seeded) return;
    _seeded = true;
    _name.text = p.name;
    _email.text = p.email;
    _phone.text = p.phone;
    _religion.text = p.religion ?? '';
    _birthPlace.text = p.birthPlace ?? '';
    _address.text = p.address ?? '';
    _bio.text = p.bio ?? '';
    _gender = p.gender;
    _zodiac = p.zodiacSign;
    _dobAd = p.dobAd;
    // Re-derive the traditional date for the active region's calendar.
    _dobBs = DobFormat.traditionalFor(context, dobAd: p.dobAd, stored: p.dobBs);
    _birthTime = p.birthTime;
    _avatarFile = p.avatarUrl;
  }

  DateTime get _initialDob {
    final now = DateTime.now();
    return DobFormat.parseAd(_dobAd) ?? DateTime(now.year - 20);
  }

  void _applyDob(DateTime picked) {
    final trad = context.traditionalCalendar.fromGregorian(picked);
    setState(() {
      _dobAd = DobFormat.ymd(picked.year, picked.month, picked.day);
      _dobBs = DobFormat.traditional(trad);
    });
  }

  /// Gregorian (A.D.) picker.
  Future<void> _pickDobAd() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _initialDob,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) _applyDob(picked);
  }

  /// Traditional-calendar picker (B.S. in Nepal, Saka in India).
  Future<void> _pickDobTraditional() async {
    final s = ProfileStrings.of(context);
    final picked = await TraditionalDatePicker.show(
      context,
      title: s.dobIn(
        context.traditionalCalendar.eraLabel(
          languageCode: context.languageCode,
        ),
      ),
      initial: _initialDob,
      // Same range as the A.D. picker above.
      firstDate: DateTime(1900),
      confirmLabel: s.save,
    );
    if (picked != null) _applyDob(picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
    );
    if (picked == null) return;
    final h = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
    setState(() {
      _birthTime =
          '$h:${picked.minute.toString().padLeft(2, '0')}:00 '
          '${picked.period == DayPeriod.am ? 'AM' : 'PM'}';
    });
  }

  void _save(UserProfile base) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<EditProfileCubit>().save(
      base.copyWith(
        name: _name.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        religion: _religion.text.trim(),
        birthPlace: _birthPlace.text.trim(),
        address: _address.text.trim(),
        bio: _bio.text.trim(),
        gender: _gender,
        zodiacSign: _zodiac,
        dobBs: _dobBs,
        dobAd: _dobAd,
        birthTime: _birthTime,
        avatarUrl: _avatarFile,
      ),
    );
  }

  /// Uploads a new profile photo.
  ///
  /// Avatars go to the public bucket because other people see them — on a
  /// review, in a chat, beside an astrologer's name — so what is stored is a
  /// durable URL rather than an id needing a signed fetch every time it is
  /// drawn.
  Future<void> _pickAvatar() async {
    final uploaded = await pickAndUploadMedia(
      context,
      bucket: MediaBucket.publicCatalog,
      title: ProfileStrings.of(context).profilePhoto,
    );
    if (uploaded == null || !mounted) return;
    setState(() => _avatarFile = uploaded.url);
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final config = context.regionConfig;
    final era = context.traditionalCalendar.eraLabel(
      languageCode: context.languageCode,
    );
    return Scaffold(
      appBar: AppTopBar(title: s.editProfile, showBack: true),
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
        listenWhen: (p, n) => p.save != n.save,
        listener: (context, state) {
          switch (state.save) {
            case Loaded():
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(s.profileSaved)));
              Navigator.of(context).maybePop(true);
            case Failed(:final failure):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            case Idle() || Loading():
              break;
          }
        },
        builder: (context, state) {
          final profile = state.profile.dataOrNull;
          if (profile == null) {
            return switch (state.profile) {
              Failed(:final failure) => ErrorView(
                message: failure.message,
                onRetry: context.read<EditProfileCubit>().load,
              ),
              _ => const LoadingView(),
            };
          }
          _seed(profile);
          final saving = state.save.isLoading;
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                AvatarPicker(
                  fileName: _avatarFile,
                  onTap: _pickAvatar,
                  required: false,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _name,
                  label: s.fullName,
                  required: true,
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? s.required : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _email,
                  label: s.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  // Optional: many people sign in with a phone number and have
                  // no email to give. Only an address that was typed is
                  // checked — and properly, not merely for an @.
                  validator: (v) {
                    final email = (v ?? '').trim();
                    return email.isEmpty || _emailPattern.hasMatch(email)
                        ? null
                        : s.invalidEmail;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _phone,
                  label: s.phoneNumber,
                  required: true,
                  hint: '${config.phonePrefix} 98XXXXXXXX',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? s.required : null,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(s.gender, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.md,
                  children: [
                    for (final (g, label) in [
                      (Gender.female, s.female),
                      (Gender.male, s.male),
                      (Gender.other, s.other),
                    ])
                      AppRadioOption<Gender?>(
                        value: g,
                        groupValue: _gender,
                        label: label,
                        textStyle: context.textTheme.bodyMedium,
                        onChanged: (v) => setState(() => _gender = v),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _PickerField(
                        label: s.dobIn(era),
                        value: _dobBs,
                        icon: Icons.calendar_today_outlined,
                        onTap: _pickDobTraditional,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _PickerField(
                        label: s.dobAd,
                        value: _dobAd,
                        icon: Icons.calendar_month_outlined,
                        onTap: _pickDobAd,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _PickerField(
                        label: s.birthTime,
                        value: _birthTime,
                        icon: Icons.access_time,
                        onTap: _pickTime,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppTextField(
                        controller: _birthPlace,
                        label: s.birthPlace,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                // Optional, as at sign-up and on the server: sign-up never
                // asks for an address, so marking it required here flagged
                // every new account's profile as incomplete.
                AppTextField(
                  controller: _address,
                  label: s.currentAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _religion,
                  label: s.religion,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                ZodiacDropdown(
                  label: s.horoscope,
                  value: _zodiac,
                  onChanged: (z) => setState(() => _zodiac = z),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _bio,
                  label: s.shortBio,
                  maxLines: 3,
                  minLines: 2,
                ),
                const SizedBox(height: AppSpacing.xxl),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        label: s.cancel,
                        height: 40,
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        label: s.saveChanges,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        isLoading: saving,
                        onPressed: () => _save(profile),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final String? value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: onTap,
          borderRadius: AppRadius.input,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.border),
              borderRadius: AppRadius.input,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value == null
                        ? 'YYYY/MM/DD'
                        : localizeDigits(context, value!),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: value == null
                          ? colors.textMuted
                          : colors.textPrimary,
                    ),
                  ),
                ),
                Icon(icon, size: 16, color: colors.iconMuted),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
