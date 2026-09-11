import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/status_chip.dart';
import '../../domain/entities/abuse_report.dart';
import '../../motion/motion.dart';
import '../../shell/widgets/console_page.dart';
import '../../shell/widgets/console_panel.dart';
import 'cubit/moderation_cubit.dart';

/// Abuse reports raised by users.
class ModerationPage extends StatelessWidget {
  const ModerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ModerationCubit>()..load(),
      child: const _ModerationView(),
    );
  }
}

class _ModerationView extends StatelessWidget {
  const _ModerationView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ModerationCubit>();

    return BlocBuilder<ModerationCubit, ModerationState>(
      builder: (context, state) {
        return ConsolePage(
          title: 'Moderation',
          subtitle: state.showResolved
              ? 'Reports that have already been dealt with'
              : 'Reports waiting for a moderator',
          onRefresh: cubit.load,
          banner: state.actionError,
          actions: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Open')),
                ButtonSegment(value: true, label: Text('Resolved')),
              ],
              selected: {state.showResolved},
              showSelectedIcon: false,
              onSelectionChanged: (selection) =>
                  cubit.setShowResolved(selection.first),
            ),
          ],
          child: LoadStateView<List<AbuseReport>>(
            state: state.reports,
            onRetry: cubit.load,
            isEmpty: (items) => items.isEmpty,
            emptyMessage: state.showResolved
                ? 'Nothing has been resolved yet'
                : 'No open reports — the queue is clear',
            emptyIcon: Icons.flag_outlined,
            builder: (context, items) => Column(
              children: [
                for (final (index, report) in items.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Reveal(
                      delay: Motion.stagger(index),
                      child: _ReportCard(
                        report: report,
                        busy: state.isResolving(report.id),
                        onResolve: () => cubit.resolve(report.id),
                      ),
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

class _ReportCard extends StatelessWidget {
  const _ReportCard({
    required this.report,
    required this.busy,
    required this.onResolve,
  });

  final AbuseReport report;
  final bool busy;
  final VoidCallback onResolve;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ConsolePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              StatusChip(
                label: report.reason.label,
                tone: switch (report.reason) {
                  ReportReason.fraud ||
                  ReportReason.impersonation => StatusTone.danger,
                  ReportReason.abusive => StatusTone.warning,
                  _ => StatusTone.neutral,
                },
                dense: true,
              ),
              const SizedBox(width: 8),
              Text(
                'on ${report.targetType}',
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                relativeTime(context, report.createdAt),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
          if (report.detail.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              report.detail,
              style: context.textTheme.bodyMedium?.copyWith(height: 1.45),
            ),
          ],
          const SizedBox(height: 12),
          // Ids are shown in full and selectable: the next step for a moderator
          // is usually to look the target up somewhere else, and a truncated id
          // means retyping it from a screenshot.
          SelectableText(
            'target ${report.targetId}   ·   reporter ${report.reporterId}',
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
              fontFamily: 'monospace',
            ),
          ),
          if (!report.resolved) ...[
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: busy
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : FilledButton.icon(
                      onPressed: onResolve,
                      icon: const Icon(Icons.done_all_rounded, size: 18),
                      label: const Text('Mark resolved'),
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
