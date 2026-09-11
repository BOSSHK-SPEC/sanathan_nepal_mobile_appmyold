import '../../../../core/media/media_bucket.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/media/media_upload_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/domain/entities/specialty.dart';
import '../../../astrologers/presentation/l10n/astrologers_strings.dart';
import '../../domain/entities/application.dart';
import '../cubit/application_cubit.dart';
import '../l10n/console_strings.dart';

/// Five-step KYC wizard. Every edit saves a draft.
class KycWizardPage extends StatelessWidget {
  const KycWizardPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ApplicationCubit>()..load(),
    child: const _KycWizardView(),
  );
}

class _KycWizardView extends StatelessWidget {
  const _KycWizardView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<ApplicationCubit, ApplicationState>(
      listenWhen: (p, n) => p.submission != n.submission,
      listener: (context, state) {
        if (state.submission.isFailed) {
          AppSnack.error(
            context,
            state.submission.errorMessage ?? context.l10n.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ApplicationCubit>();

        return PopScope(
          canPop: state.isFirstStep,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) cubit.previousStep();
          },
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppTopBar(
              title: s.becomeAstrologer,
              showBack: true,
              onBack: () =>
                  state.isFirstStep ? context.pop() : cubit.previousStep(),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  AppStepper(
                    steps: [
                      for (final step in KycStep.values) s.stepName(step),
                    ],
                    currentIndex: state.stepIndex,
                    onStepTapped: (i) =>
                        i <= state.stepIndex ? cubit.goToStep(i) : null,
                  ),
                  Expanded(
                    child: switch (state.step) {
                      KycStep.identity => const _IdentityStep(),
                      KycStep.credentials => const _CredentialsStep(),
                      KycStep.expertise => const _ExpertiseStep(),
                      KycStep.pricing => const _PricingStep(),
                      KycStep.introduction => const _IntroductionStep(),
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _WizardBar(state: state),
          ),
        );
      },
    );
  }
}

class _WizardBar extends StatelessWidget {
  const _WizardBar({required this.state});

  final ApplicationState state;

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<ApplicationCubit>();

    final outstanding = _outstanding(context, state);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (outstanding != null) ...[
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                      color: colors.textMuted,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        s.stepIncomplete(outstanding),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              Row(
                children: [
                  if (!state.isFirstStep) ...[
                    Expanded(
                      child: SecondaryButton(
                        label: s.back,
                        onPressed: cubit.previousStep,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  Expanded(
                    flex: 2,
                    child: state.isLastStep
                        ? PrimaryButton(
                            label: s.submitApplication,
                            height: 46,
                            isLoading: state.submission.isLoading,
                            onPressed: state.form.canSubmit
                                ? () async {
                                    final ok = await cubit.submit();
                                    if (ok && context.mounted) {
                                      context.pushReplacement(
                                        AppRoutes.astrologerApplication,
                                      );
                                    }
                                  }
                                : null,
                          )
                        : PrimaryButton(
                            label: s.next,
                            height: 46,
                            onPressed: state.canAdvance
                                ? () async {
                                    // Flush before moving on: a keystroke made
                                    // a moment ago is still inside the
                                    // debounce window.
                                    await cubit.saveNow();
                                    cubit.nextStep();
                                  }
                                : null,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// What the current step is still missing, in the user's words.
  ///
  /// Missing documents are named first because they are the least obvious
  /// thing to be blocked on; text fields are visibly empty.
  String? _outstanding(BuildContext context, ApplicationState state) {
    if (state.canAdvance) return null;
    final s = ConsoleStrings.of(context);
    final form = state.form;

    // What is *actually* missing, field by field. Listing the step's fields
    // regardless of their contents told an applicant to "add Years of
    // experience" while the field plainly read 4 — and never mentioned the
    // one rule they had broken, the bio's minimum length.
    final bioShortfall =
        AstrologerApplication.minBioLength - form.bio.trim().length;

    final missing = <String>[
      for (final kind in form.missingForStep(state.step))
        _documentLabel(s, kind),
      ...switch (state.step) {
        KycStep.identity => [
          if (form.fullName.trim().isEmpty) s.fullName,
          if (form.phone.trim().isEmpty) s.phone,
        ],
        KycStep.credentials => [
          if (form.experienceYears <= 0) s.yearsExperience,
          if (bioShortfall > 0) s.aboutYouShort(bioShortfall),
        ],
        KycStep.expertise => [
          if (form.specialties.isEmpty) s.specialities,
          if (form.languageCodes.isEmpty) s.languagesYouSpeak,
        ],
        KycStep.pricing => [if (!form.pricingComplete) s.setYourRates],
        KycStep.introduction => [if (!form.introductionComplete) s.acceptTerms],
      },
    ];

    // A step can be incomplete for a reason none of the above names — better
    // a generic prompt than an empty bar that explains nothing.
    if (missing.isEmpty) return s.stepIncompleteGeneric;
    return missing.join(', ');
  }

  String _documentLabel(ConsoleStrings s, KycDocumentKind kind) =>
      switch (kind) {
        KycDocumentKind.identityFront => s.idFront,
        KycDocumentKind.identityBack => s.idBack,
        KycDocumentKind.selfie => s.selfie,
        KycDocumentKind.certificate => s.certificate,
        KycDocumentKind.addressProof => s.addressProof,
      };
}

class _StepBody extends StatelessWidget {
  const _StepBody({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.pageGutter,
      0,
      AppSpacing.pageGutter,
      AppSpacing.xxl,
    ),
    children: children,
  );
}

/// Text fields are seeded from the saved draft rather than shown as hints:
/// a wizard people leave and come back to has to show what they already
/// typed as real, editable text.
class _IdentityStep extends StatefulWidget {
  const _IdentityStep();

  @override
  State<_IdentityStep> createState() => _IdentityStepState();
}

class _IdentityStepState extends State<_IdentityStep> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  /// Whether the saved draft has been written into the fields yet.
  ///
  /// The application arrives asynchronously, so seeding the controllers once
  /// at construction caught whatever was loaded at that instant — usually
  /// nothing. The applicant then saw three empty boxes over a draft that was
  /// safely stored, and retyping was the only way forward.
  var _seeded = false;

  void _seed(LoadState<AstrologerApplication> application) {
    // Wait for the draft to actually arrive. Seeding on the first frame — when
    // the state is still idle — writes three empty strings and then considers
    // the job done, which is the same empty form with extra steps.
    if (_seeded) return;
    final draft = application.dataOrNull;
    if (draft == null) return;

    // Once only: overwriting a field mid-edit would fight the keyboard.
    _seeded = true;
    _name.text = draft.fullName;
    _phone.text = draft.phone;
    _email.text = draft.email;
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final cubit = context.read<ApplicationCubit>();
    _seed(context.watch<ApplicationCubit>().state.application);

    return _StepBody(
      children: [
        AppTextField(
          controller: _name,
          label: s.fullName,
          required: true,
          onChanged: cubit.setName,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _phone,
          label: s.phone,
          required: true,
          keyboardType: TextInputType.phone,
          hint: context.regionConfig.phonePrefix,
          onChanged: cubit.setPhone,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _email,
          label: s.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: cubit.setEmail,
        ),
        const SizedBox(height: AppSpacing.xl),
        _DocumentField(kind: KycDocumentKind.identityFront, label: s.idFront),
        const SizedBox(height: AppSpacing.md),
        _DocumentField(kind: KycDocumentKind.identityBack, label: s.idBack),
        const SizedBox(height: AppSpacing.md),
        _DocumentField(kind: KycDocumentKind.selfie, label: s.selfie),
        const SizedBox(height: AppSpacing.md),
        _DocumentField(
          kind: KycDocumentKind.addressProof,
          label: s.addressProof,
        ),
      ],
    );
  }
}

/// Upload target for one KYC document.
///
/// Identity documents go to the private bucket: they are read by a reviewer
/// and by nobody else, and are never served from a public URL. A PDF is
/// allowed because that is what a licence or a certificate usually is.
class _DocumentField extends StatelessWidget {
  const _DocumentField({required this.kind, required this.label});

  final KycDocumentKind kind;
  final String label;

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final cubit = context.read<ApplicationCubit>();
    final state = context.watch<ApplicationCubit>().state;
    final document = state.form.documentFor(kind);

    return AppUploadField(
      variant: UploadVariant.row,
      label: label,
      helper: document.isSatisfied
          ? null
          : s.uploadHint(MediaBucket.privateDocs.maxSizeLabel),
      source: document.isSatisfied ? document.fileRef : null,
      // A KYC document is private and stored by id, so there is nothing to
      // preview — say it is attached instead of drawing a broken image.
      filledLabel: s.documentAttached,
      icon: document.isSatisfied
          ? Icons.check_circle_outline_rounded
          : Icons.upload_file_outlined,
      busy: state.removingDocument == kind,
      // Documents are the applicant's to change only while the application is
      // still theirs; once it is queued the reviewer is deciding on this exact
      // file. The server enforces the same rule — this keeps the screen from
      // offering an action that would come back refused.
      enabled: state.form.status.allowsDocumentChanges,
      onTap: () async {
        final uploaded = await pickAndUploadMedia(
          context,
          bucket: MediaBucket.privateDocs,
          title: label,
        );
        if (uploaded == null || !context.mounted) return;
        // The id, not a URL: a private document is only ever fetched through a
        // short-lived signed link the reviewer is issued.
        await cubit.uploadDocument(kind, uploaded.mediaId);
      },
      // Confirmed rather than immediate: the stored file is deleted, so there
      // is nothing to undo afterwards, and an identity document is not
      // something to lose to a mis-tap on a 14px target.
      onRemove: document.isSatisfied
          ? () async {
              final confirmed = await AppConfirmSheet.show(
                context,
                title: s.removeDocumentTitle,
                message: s.removeDocumentMessage(label),
                confirmLabel: s.removeDocumentConfirm,
                cancelLabel: context.l10n.cancel,
                icon: Icons.delete_outline_rounded,
              );
              if (!confirmed || !context.mounted) return;
              await cubit.removeDocument(kind);
              if (context.mounted) AppSnack.show(context, s.documentRemoved);
            }
          : null,
    );
  }
}

class _CredentialsStep extends StatefulWidget {
  const _CredentialsStep();

  @override
  State<_CredentialsStep> createState() => _CredentialsStepState();
}

class _CredentialsStepState extends State<_CredentialsStep> {
  final _years = TextEditingController();
  final _bio = TextEditingController();

  /// Same reason as the identity step: the draft arrives asynchronously, so
  /// seeding at construction writes whatever was loaded at that instant —
  /// usually nothing.
  var _seeded = false;

  void _seed(LoadState<AstrologerApplication> application) {
    if (_seeded) return;
    final draft = application.dataOrNull;
    if (draft == null) return;

    _seeded = true;
    _years.text = draft.experienceYears == 0 ? '' : '${draft.experienceYears}';
    _bio.text = draft.bio;
  }

  @override
  void dispose() {
    _years.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _seed(context.watch<ApplicationCubit>().state.application);
    final s = ConsoleStrings.of(context);
    final cubit = context.read<ApplicationCubit>();
    final form = context.watch<ApplicationCubit>().state.form;

    return _StepBody(
      children: [
        AppTextField(
          controller: _years,
          label: s.yearsExperience,
          required: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (v) => cubit.setExperience(int.tryParse(v) ?? 0),
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _bio,
          label: s.aboutYou,
          required: true,
          hint: s.aboutYouHint,
          maxLines: 7,
          minLines: 5,
          onChanged: cubit.setBio,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${form.bio.trim().length} / ${AstrologerApplication.minBioLength}',
          textAlign: TextAlign.end,
          style: context.textTheme.labelSmall?.copyWith(
            color: form.credentialsComplete
                ? context.colors.success
                : context.colors.textMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _DocumentField(kind: KycDocumentKind.certificate, label: s.certificate),
      ],
    );
  }
}

class _ExpertiseStep extends StatelessWidget {
  const _ExpertiseStep();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final a = AstrologersStrings.of(context);
    final cubit = context.read<ApplicationCubit>();
    final form = context.watch<ApplicationCubit>().state.form;
    final languages = context.regionConfig.languageCodes;

    return _StepBody(
      children: [
        Text(s.specialities, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        FilterChipGroup<Specialty>(
          options: Specialty.values,
          labelOf: a.specialty,
          selected: form.specialties.toSet(),
          onChanged: (next) {
            for (final specialty in Specialty.values) {
              final was = form.specialties.contains(specialty);
              if (was != next.contains(specialty)) {
                cubit.toggleSpecialty(specialty);
              }
            }
          },
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(s.languagesYouSpeak, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        FilterChipGroup<String>(
          options: languages,
          labelOf: a.languageName,
          selected: form.languageCodes.toSet(),
          onChanged: (next) {
            for (final code in languages) {
              final was = form.languageCodes.contains(code);
              if (was != next.contains(code)) cubit.toggleLanguage(code);
            }
          },
        ),
      ],
    );
  }
}

class _PricingStep extends StatefulWidget {
  const _PricingStep();

  @override
  State<_PricingStep> createState() => _PricingStepState();
}

class _PricingStepState extends State<_PricingStep> {
  late final Map<ConsultChannel, TextEditingController> _rates = {
    for (final channel in ConsultChannel.values)
      channel: TextEditingController(
        text:
            context
                .read<ApplicationCubit>()
                .state
                .form
                .ratePerMinute[channel]
                ?.toStringAsFixed(0) ??
            '',
      ),
  };

  @override
  void dispose() {
    for (final controller in _rates.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final a = AstrologersStrings.of(context);
    final cubit = context.read<ApplicationCubit>();
    final colors = context.colors;

    return _StepBody(
      children: [
        Text(s.setYourRates, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Text(
          s.ratesNote,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final channel in ConsultChannel.values) ...[
          AppTextField(
            controller: _rates[channel],
            label: a.channelName(channel),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hint: s.notOffered,
            prefix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                context.regionConfig.symbolFor(context.languageCode),
                style: context.textTheme.titleMedium,
              ),
            ),
            onChanged: (v) => cubit.setRate(channel, double.tryParse(v)),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _IntroductionStep extends StatelessWidget {
  const _IntroductionStep();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final cubit = context.read<ApplicationCubit>();
    final form = context.watch<ApplicationCubit>().state.form;
    final colors = context.colors;

    return _StepBody(
      children: [
        AppUploadField(
          variant: UploadVariant.dropzone,
          label: s.introVideo,
          helper: s.introVideoHint,
          icon: Icons.videocam_outlined,
          source: form.introVideoRef,
          // See the console profile page: video has no bucket yet, and a
          // reference to a file that was never uploaded is worse than an
          // obviously unavailable field.
          enabled: false,
          onTap: () {},
          onRemove: form.introVideoRef == null
              ? null
              : () => cubit.setIntroVideo(null),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppCard(
          elevated: false,
          color: colors.surfaceVariant,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.termsTitle, style: context.textTheme.titleSmall),
              const SizedBox(height: AppSpacing.sm),
              Text(
                s.termsBody,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        LabeledToggle(
          label: s.acceptTerms,
          value: form.termsAcceptedAt != null,
          onChanged: (v) => v ? cubit.acceptTerms() : null,
        ),
        if (form.missingRequired.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            elevated: false,
            color: colors.warning.withValues(alpha: 0.12),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: colors.warning,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    s.uploadHint(MediaBucket.privateDocs.maxSizeLabel),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
