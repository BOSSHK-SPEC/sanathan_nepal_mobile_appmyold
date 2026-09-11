import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/session_summary.dart';
import '../cubit/session_summary_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/consult_format.dart';

/// Receipt, notes and remedies after a session ends.
///
/// The remedies are where a consultation turns into a purchase, so each one
/// that maps to a product links straight into the marketplace.
class ConsultSummaryPage extends StatelessWidget {
  const ConsultSummaryPage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<SessionSummaryCubit>(param1: consultationId)..load(),
    child: const _SummaryView(),
  );
}

class _SummaryView extends StatelessWidget {
  const _SummaryView();

  IconData _remedyIcon(RemedyKind kind) => switch (kind) {
    RemedyKind.gemstone => Icons.diamond_outlined,
    RemedyKind.mantra => Icons.record_voice_over_outlined,
    RemedyKind.puja => Icons.local_fire_department_outlined,
    RemedyKind.donation => Icons.volunteer_activism_outlined,
    RemedyKind.fasting => Icons.no_food_outlined,
    RemedyKind.practice => Icons.self_improvement_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<SessionSummaryCubit, SessionSummaryState>(
      builder: (context, state) {
        final cubit = context.read<SessionSummaryCubit>();
        final session = state.consultation;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: s.sessionSummary,
            leading: IconButton(
              icon: Icon(Icons.close_rounded, color: colors.icon),
              onPressed: () => context.go(AppRoutes.consultHistory),
            ),
          ),
          body: SafeArea(
            top: false,
            child: session == null
                ? (state.session.isFailed
                      ? ErrorView(
                          message: state.session.errorMessage,
                          onRetry: cubit.load,
                        )
                      : const LoadingView())
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.pageGutter),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            AppAvatar(
                              source: session.astrologerAvatar,
                              name: session.astrologerName.en,
                              size: 68,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              session.astrologerName.forLanguage(
                                context.languageCode,
                              ),
                              style: context.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            StatusChip(
                              label: s.statusName(session.status),
                              tone: StatusTone.success,
                              dense: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      AppCard(
                        child: KeyValueList(
                          divided: true,
                          children: [
                            KeyValueRow(
                              label: s.duration,
                              value: s.minutesLabel(
                                consultDigits(context, session.billedMinutes()),
                              ),
                            ),
                            KeyValueRow(
                              label: s.ratePerMinute,
                              valueWidget: MoneyText(
                                session.ratePerMinute,
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                            KeyValueRow(
                              label: s.totalCharged,
                              emphasised: true,
                              valueWidget: MoneyText(
                                session.amountCharged,
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      if (state.isAwaitingNotes)
                        AppCard(
                          elevated: false,
                          color: colors.surfaceVariant,
                          child: Column(
                            children: [
                              Icon(
                                Icons.edit_note_rounded,
                                size: 32,
                                color: colors.textMuted,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                s.awaitingNotes,
                                style: context.textTheme.titleSmall,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                s.awaitingNotesBody,
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        )
                      else ...[
                        Text(
                          s.astrologerNotes,
                          style: context.textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppCard(
                          child: Text(
                            state.notes!.notes,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(s.remedies, style: context.textTheme.titleSmall),
                        const SizedBox(height: AppSpacing.sm),
                        for (final remedy in state.notes!.remedies)
                          AppCard(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.accent.withValues(
                                      alpha: 0.12,
                                    ),
                                  ),
                                  child: Icon(
                                    _remedyIcon(remedy.kind),
                                    size: 18,
                                    color: colors.accent,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              remedy.title.forLanguage(
                                                context.languageCode,
                                              ),
                                              style:
                                                  context.textTheme.titleSmall,
                                            ),
                                          ),
                                          StatusChip(
                                            label: s.remedyKind(remedy.kind),
                                            dense: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        remedy.description.forLanguage(
                                          context.languageCode,
                                        ),
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(color: colors.textMuted),
                                      ),
                                      if (remedy.isPurchasable) ...[
                                        const SizedBox(height: AppSpacing.sm),
                                        SecondaryButton(
                                          label: s.shopRemedy,
                                          expanded: false,
                                          height: 32,
                                          onPressed: () => context.push(
                                            AppRoutes.productDetailsPath(
                                              remedy.productId!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                      if (state.notes?.hasTranscript ?? false) ...[
                        const SizedBox(height: AppSpacing.lg),
                        SecondaryButton(
                          label: s.viewTranscript,
                          icon: Icon(
                            Icons.article_outlined,
                            size: 17,
                            color: colors.accent,
                          ),
                          onPressed: () => context.push(
                            AppRoutes.consultTranscriptPath(session.id),
                          ),
                        ),
                      ] else if (state.notes?.recordingUrl != null) ...[
                        const SizedBox(height: AppSpacing.lg),
                        SecondaryButton(
                          label: s.playRecording,
                          icon: Icon(
                            Icons.play_circle_outline_rounded,
                            size: 17,
                            color: colors.accent,
                          ),
                          // No media player yet; saying so is better than a
                          // button that does nothing.
                          onPressed: () =>
                              AppSnack.show(context, s.recordingUnavailable),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.xl),
                      PrimaryButton(
                        label: s.rateSession,
                        height: 46,
                        icon: Icon(
                          Icons.star_outline_rounded,
                          size: 18,
                          color: colors.onPrimary,
                        ),
                        onPressed: () => context.push(
                          AppRoutes.astrologerReviewPath(
                            session.astrologerId,
                            consultationId: session.id,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: s.bookAgain,
                        onPressed: () => context.go(
                          AppRoutes.astrologerProfilePath(session.astrologerId),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
