import '../../../../core/media/media_bucket.dart';
import '../../../../core/media/media_upload_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/astrologer_profile.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/specialty.dart';
import '../../../astrologers/presentation/l10n/astrologers_strings.dart';
import '../cubit/astrologer_profile_cubit.dart';
import '../l10n/console_strings.dart';

/// The profile seekers browse, editable after approval.
///
/// The KYC application is a filed record and stays as submitted; this is the
/// living copy. Changes are held in the cubit until Publish, so backing out
/// of a half-finished edit leaves the public profile untouched.
class AstrologerProfilePage extends StatelessWidget {
  const AstrologerProfilePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AstrologerProfileCubit>()..load(),
    child: const _ProfileEditorView(),
  );
}

class _ProfileEditorView extends StatelessWidget {
  const _ProfileEditorView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<AstrologerProfileCubit, AstrologerProfileState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppTopBar(title: s.editProfile, showBack: true),
        body: SafeArea(
          child: state.profile.dataOrNull == null
              ? switch (state.profile) {
                  Failed(:final failure) => ErrorView(
                    message: failure.message,
                    onRetry: context.read<AstrologerProfileCubit>().load,
                  ),
                  _ => const LoadingView(),
                }
              // Keyed on the loaded profile so the controllers below are
              // seeded once per load rather than fighting every keystroke.
              : _ProfileForm(key: ValueKey(state.profile.dataOrNull)),
        ),
      ),
    );
  }
}

class _ProfileForm extends StatefulWidget {
  const _ProfileForm({super.key});

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  late final AstrologerProfileCubit _cubit = context
      .read<AstrologerProfileCubit>();
  final _name = TextEditingController();
  final _headline = TextEditingController();
  final _about = TextEditingController();
  final _years = TextEditingController();

  /// The profile is fetched, so seeding at construction catches an empty
  /// draft and never corrects itself — the astrologer sees blank fields over
  /// a profile that is already published.
  var _seeded = false;

  void _seed(LoadState<AstrologerProfileDraft> profile) {
    if (_seeded) return;
    final draft = profile.dataOrNull;
    if (draft == null) return;

    _seeded = true;
    _name.text = draft.displayName;
    _headline.text = draft.headline;
    _about.text = draft.about;
    _years.text = draft.experienceYears == 0 ? '' : '${draft.experienceYears}';
  }

  @override
  void dispose() {
    _name.dispose();
    _headline.dispose();
    _about.dispose();
    _years.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    final s = ConsoleStrings.of(context);
    final saved = await _cubit.save();
    if (!mounted) return;
    if (saved) {
      AppSnack.show(context, s.profilePublished);
    } else {
      AppSnack.error(context, _cubit.state.saveError ?? s.profilePublished);
    }
  }

  @override
  Widget build(BuildContext context) {
    _seed(context.watch<AstrologerProfileCubit>().state.profile);
    final s = ConsoleStrings.of(context);
    final a = AstrologersStrings.of(context);
    final colors = context.colors;
    final languages = context.regionConfig.languageCodes;

    return BlocBuilder<AstrologerProfileCubit, AstrologerProfileState>(
      builder: (context, state) {
        final profile = state.working;

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.pageGutter),
                children: [
                  _StrengthMeter(
                    value: profile.completeness,
                    label: s.profileStrength,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Center(
                    child: Column(
                      children: [
                        AppAvatar(
                          source: profile.avatarRef,
                          name: profile.displayName,
                          size: 88,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TextButton(
                          onPressed: () async {
                            if (profile.avatarRef != null) {
                              _cubit.setAvatar(null);
                              return;
                            }
                            // Seekers browse these photos before choosing an
                            // astrologer, so the avatar is public.
                            final uploaded = await pickAndUploadMedia(
                              context,
                              bucket: MediaBucket.publicCatalog,
                              title: s.profilePhoto,
                            );
                            if (uploaded != null) {
                              _cubit.setAvatar(uploaded.url);
                            }
                          },
                          child: Text(
                            profile.avatarRef == null
                                ? s.profilePhoto
                                : context.l10n.delete,
                          ),
                        ),
                        Text(
                          s.profilePhotoHint,
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    controller: _name,
                    label: s.fullName,
                    onChanged: _cubit.setDisplayName,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _headline,
                    label: s.profileHeadline,
                    hint: s.profileHeadlineHint,
                    onChanged: _cubit.setHeadline,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _about,
                    label: s.aboutYou,
                    hint: s.aboutYouHint,
                    maxLines: 5,
                    onChanged: _cubit.setAbout,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _years,
                    label: s.yearsExperience,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (v) =>
                        _cubit.setExperienceYears(int.tryParse(v) ?? 0),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(s.specialities, style: context.textTheme.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  FilterChipGroup<Specialty>(
                    options: Specialty.values,
                    labelOf: a.specialty,
                    selected: profile.specialties.toSet(),
                    onChanged: (next) {
                      for (final specialty in Specialty.values) {
                        final was = profile.specialties.contains(specialty);
                        if (was != next.contains(specialty)) {
                          _cubit.toggleSpecialty(specialty);
                        }
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    s.languagesYouSpeak,
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  FilterChipGroup<String>(
                    options: languages,
                    labelOf: a.languageName,
                    selected: profile.languageCodes.toSet(),
                    onChanged: (next) {
                      for (final code in languages) {
                        final was = profile.languageCodes.contains(code);
                        if (was != next.contains(code)) {
                          _cubit.toggleLanguage(code);
                        }
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppUploadField(
                    label: s.introVideo,
                    helper: s.introVideoHint,
                    icon: Icons.videocam_outlined,
                    source: profile.introVideoRef,
                    // Disabled rather than faked. No storage bucket accepts
                    // video yet, so a tap here could only record a reference
                    // to a file that was never uploaded — which would fail on
                    // submission, after the astrologer thought they were done.
                    enabled: false,
                    onTap: () {},
                    onRemove: profile.introVideoRef == null
                        ? null
                        : () => _cubit.setIntroVideo(null),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    s.profileVisibility,
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppCard(
                    child: ToggleRow(
                      label: s.hideFromSearch,
                      note: s.hideFromSearchNote,
                      value: profile.hiddenFromSearch,
                      onChanged: _cubit.setHiddenFromSearch,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg),
                ),
                border: Border(top: BorderSide(color: colors.divider)),
              ),
              child: SafeArea(
                top: false,
                child: PrimaryButton(
                  label: s.publishProfile,
                  isLoading: state.saving.isLoading,
                  onPressed: state.canSave ? _publish : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// How complete the profile looks to a seeker.
///
/// A number alone does not motivate; the bar makes the gap between the
/// current profile and a full one visible at a glance.
class _StrengthMeter extends StatelessWidget {
  const _StrengthMeter({required this.value, required this.label});

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: context.textTheme.labelMedium),
            Text(
              '${(value * 100).round()}%',
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.accent,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: colors.surfaceVariant,
            valueColor: AlwaysStoppedAnimation(colors.accent),
          ),
        ),
      ],
    );
  }
}
