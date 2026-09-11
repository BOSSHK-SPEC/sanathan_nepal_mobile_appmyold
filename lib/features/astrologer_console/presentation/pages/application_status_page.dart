import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../session/presentation/cubit/session_cubit.dart';
import '../../domain/entities/application.dart';
import '../cubit/application_cubit.dart';
import '../l10n/console_strings.dart';

/// Where the application stands, per document.
///
/// A timeline rather than a single status, because "under review" tells an
/// applicant nothing, and a rejection that names the one bad document is
/// fixable while a blanket refusal is not.
class ApplicationStatusPage extends StatelessWidget {
  const ApplicationStatusPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = GetIt.I<ApplicationCubit>()..load();
      // Approval is what grants the astrologer role, so the session has to
      // be re-read before the console routes will let anyone through.
      cubit.watchForDecision(
        onApproved: () => context.read<SessionCubit>().load(),
      );
      return cubit;
    },
    child: const _ApplicationStatusView(),
  );
}

class _ApplicationStatusView extends StatelessWidget {
  const _ApplicationStatusView();

  StatusTone _tone(ApplicationStatus status) => switch (status) {
    ApplicationStatus.approved => StatusTone.success,
    ApplicationStatus.rejected => StatusTone.danger,
    ApplicationStatus.moreInfoNeeded => StatusTone.warning,
    _ => StatusTone.info,
  };

  TimelineStepState _stepState(ApplicationStatus status, ApplicationStatus at) {
    const order = [
      ApplicationStatus.submitted,
      ApplicationStatus.underReview,
      ApplicationStatus.approved,
    ];
    final currentIndex = order.indexOf(status);
    final stepIndex = order.indexOf(at);
    if (status == ApplicationStatus.rejected &&
        at == ApplicationStatus.approved) {
      return TimelineStepState.failed;
    }
    if (currentIndex < 0) return TimelineStepState.pending;
    if (stepIndex < currentIndex) return TimelineStepState.done;
    if (stepIndex == currentIndex) return TimelineStepState.current;
    return TimelineStepState.pending;
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        final application = state.form;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.applicationStatus, showBack: true),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.accent.withValues(alpha: 0.12),
                        ),
                        child: Icon(
                          switch (application.status) {
                            ApplicationStatus.approved =>
                              Icons.verified_rounded,
                            ApplicationStatus.rejected => Icons.cancel_outlined,
                            ApplicationStatus.moreInfoNeeded =>
                              Icons.edit_note_rounded,
                            _ => Icons.hourglass_top_rounded,
                          },
                          size: 34,
                          color: colors.accent,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      StatusChip(
                        label: s.statusName(application.status),
                        tone: _tone(application.status),
                      ),
                      if (application.submittedAt != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          relativeTime(context, application.submittedAt!),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppCard(
                  child: AppTimeline(
                    steps: [
                      TimelineStep(
                        title: s.statusSubmitted,
                        state: _stepState(
                          application.status,
                          ApplicationStatus.submitted,
                        ),
                      ),
                      TimelineStep(
                        title: s.statusUnderReview,
                        state: _stepState(
                          application.status,
                          ApplicationStatus.underReview,
                        ),
                      ),
                      TimelineStep(
                        title: s.statusApproved,
                        subtitle: s.submittedBody,
                        state: _stepState(
                          application.status,
                          ApplicationStatus.approved,
                        ),
                      ),
                    ],
                  ),
                ),
                // A note only exists once a reviewer writes one. The API
                // returns an empty string until then, which rendered as a
                // headed panel with nothing in it.
                if ((application.reviewerNote ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  AppCard(
                    elevated: false,
                    color: colors.warning.withValues(alpha: 0.12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.reviewerNote,
                          style: context.textTheme.titleSmall?.copyWith(
                            color: colors.warning,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          application.reviewerNote!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                if (application.status == ApplicationStatus.approved)
                  PrimaryButton(
                    label: s.openConsole,
                    height: 46,
                    // The console's guard reads the session synchronously, so
                    // the role must be on the account and the session
                    // reloaded *before* navigating. Going first and granting
                    // after is a race the user loses: the guard sees a seeker
                    // and redirects them to the intro screen for the
                    // application they have just finished.
                    onPressed: () async {
                      final router = GoRouter.of(context);
                      final session = context.read<SessionCubit>();
                      await context
                          .read<ApplicationCubit>()
                          .claimConsoleAccess();
                      await session.load();
                      router.go(AppRoutes.astrologerHome);
                    },
                  )
                else if (application.status.isEditable)
                  PrimaryButton(
                    label: s.fixAndResubmit,
                    height: 46,
                    onPressed: () =>
                        context.pushReplacement(AppRoutes.astrologerKyc),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
