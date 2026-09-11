import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/compliance_notice.dart';
import '../cubit/compliance_cubit.dart';
import '../l10n/console_strings.dart';
import '../widgets/appeal_sheet.dart';

/// Warnings, penalties and policy notices from the platform.
///
/// Open notices sit above settled ones and never collapse away: this is the
/// screen an astrologer is pointed at when their placement drops, and a
/// notice they cannot find is a notice that reads as arbitrary enforcement.
class CompliancePage extends StatelessWidget {
  const CompliancePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ComplianceCubit>()..load(),
    child: const _ComplianceView(),
  );
}

class _ComplianceView extends StatelessWidget {
  const _ComplianceView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<ComplianceCubit, ComplianceState>(
      listenWhen: (p, c) =>
          c.actionError != null && p.actionError != c.actionError,
      listener: (context, state) => AppSnack.error(context, state.actionError!),
      builder: (context, state) {
        final cubit = context.read<ComplianceCubit>();

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.compliance, showBack: true),
          body: SafeArea(
            top: false,
            child: switch (state.notices) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.refresh,
              ),
              _ when state.isEmpty => EmptyViewWithBody(
                title: s.noNoticesTitle,
                body: s.noNoticesBody,
                icon: Icons.verified_outlined,
              ),
              _ => RefreshIndicator(
                onRefresh: cubit.refresh,
                color: colors.accent,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.xxxl,
                  ),
                  children: [
                    if (state.open.isNotEmpty) ...[
                      SectionHeader(title: s.complianceNeedsAction),
                      for (final notice in state.open)
                        _NoticeCard(
                          notice: notice,
                          busy: state.busyNoticeId == notice.id,
                        ),
                    ],
                    if (state.past.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      SectionHeader(title: s.compliancePast),
                      for (final notice in state.past)
                        _NoticeCard(
                          notice: notice,
                          busy: state.busyNoticeId == notice.id,
                        ),
                    ],
                  ],
                ),
              ),
            },
          ),
        );
      },
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.notice, required this.busy});

  final ComplianceNotice notice;
  final bool busy;

  StatusTone get _tone => switch (notice.severity) {
    ComplianceSeverity.info => StatusTone.info,
    ComplianceSeverity.warning => StatusTone.warning,
    ComplianceSeverity.critical => StatusTone.danger,
  };

  Color _accent(BuildContext context) => switch (notice.severity) {
    ComplianceSeverity.info => context.colors.accent,
    ComplianceSeverity.warning => context.colors.warning,
    ComplianceSeverity.critical => context.colors.error,
  };

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<ComplianceCubit>();
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        // A stripe in the severity colour, so a page of notices is scannable
        // without reading every title. IntrinsicHeight because a stretched
        // Row inside a scroll view would hand the stripe infinite height.
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 3,
                margin: const EdgeInsets.only(right: AppSpacing.md),
                decoration: BoxDecoration(
                  color: _accent(context),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StatusChip(
                          label: s.noticeKind(notice.kind),
                          tone: _tone,
                          dense: true,
                        ),
                        const Spacer(),
                        Text(
                          dateFormat.format(notice.issuedAt),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(notice.title, style: context.textTheme.titleSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      notice.body,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    if (notice.hasPenalty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      KeyValueRow(
                        label: s.amountWithheld,
                        valueWidget: MoneyText(
                          notice.penaltyAmount!,
                          color: colors.error,
                          style: context.textTheme.labelLarge,
                        ),
                      ),
                    ],
                    if (notice.requiredAction != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      KeyValueRow(
                        label: s.actionRequired,
                        value: notice.requiredAction!,
                      ),
                    ],
                    if (notice.dueBy != null)
                      KeyValueRow(
                        label: notice.isOverdue ? s.overdue : s.dueBy,
                        value: dateFormat.format(notice.dueBy!),
                        valueStyle: notice.isOverdue
                            ? context.textTheme.labelLarge?.copyWith(
                                color: colors.error,
                              )
                            : null,
                      ),
                    if (notice.referenceId != null)
                      KeyValueRow(
                        label: s.relatedSession,
                        value: notice.referenceId!,
                      ),
                    const SizedBox(height: AppSpacing.sm),
                    _NoticeActions(notice: notice, busy: busy, cubit: cubit),
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

class _NoticeActions extends StatelessWidget {
  const _NoticeActions({
    required this.notice,
    required this.busy,
    required this.cubit,
  });

  final ComplianceNotice notice;
  final bool busy;
  final ComplianceCubit cubit;

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    if (busy) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Row(
      children: [
        if (notice.status == ComplianceStatus.appealed)
          StatusChip(label: s.underAppeal, tone: StatusTone.info, dense: true)
        else if (notice.acknowledgedAt != null)
          Text(
            s.acknowledged,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.success,
            ),
          ),
        const Spacer(),
        if (notice.canAppeal)
          TextButton(
            onPressed: () => AppealSheet.show(context, notice: notice),
            child: Text(s.appeal),
          ),
        if (notice.isOpen)
          TextButton(
            onPressed: () => cubit.acknowledge(notice.id),
            child: Text(s.acknowledge),
          ),
      ],
    );
  }
}
