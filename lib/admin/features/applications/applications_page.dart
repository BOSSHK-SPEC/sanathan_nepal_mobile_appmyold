import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/status_chip.dart';
import '../../domain/entities/astrologer_application.dart';
import '../../motion/motion.dart';
import '../../shell/widgets/console_page.dart';
import '../../shell/widgets/console_panel.dart';
import '../../shell/widgets/decision_dialog.dart';
import 'cubit/applications_cubit.dart';

/// The astrologer verification queue.
class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ApplicationsCubit>()..load(),
      child: const _ApplicationsView(),
    );
  }
}

class _ApplicationsView extends StatelessWidget {
  const _ApplicationsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApplicationsCubit>();

    return BlocBuilder<ApplicationsCubit, ApplicationsState>(
      builder: (context, state) {
        return ConsolePage(
          title: 'Astrologer applications',
          subtitle:
              'Verify identity and experience before an astrologer can take paid consultations',
          onRefresh: cubit.load,
          banner: state.decisionError,
          child: LoadStateView<List<AstrologerApplication>>(
            state: state.applications,
            onRetry: cubit.load,
            isEmpty: (items) => items.isEmpty,
            emptyMessage: 'No applications waiting for review',
            emptyIcon: Icons.verified_user_outlined,
            builder: (context, items) => Column(
              children: [
                for (final (index, application) in items.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Reveal(
                      delay: Motion.stagger(index),
                      child: _ApplicationCard(
                        application: application,
                        busy: state.isDeciding(application.id),
                        onDecide: (approve) =>
                            _decide(context, application, approve: approve),
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

  Future<void> _decide(
    BuildContext context,
    AstrologerApplication application, {
    required bool approve,
  }) async {
    final cubit = context.read<ApplicationsCubit>();
    final decision = await showDecisionDialog(
      context,
      title: approve ? 'Approve applicant' : 'Reject applicant',
      subject:
          '${application.fullName} · ${application.experienceYears} years of experience',
      approve: approve,
    );
    if (decision == null) return;

    await cubit.decide(
      applicationId: application.id,
      approve: decision.approve,
      note: decision.note,
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({
    required this.application,
    required this.busy,
    required this.onDecide,
  });

  final AstrologerApplication application;
  final bool busy;
  final void Function(bool approve) onDecide;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final decided = application.status.isDecided;

    return ConsolePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: colors.chipBackground,
                child: Text(
                  application.fullName.characters.first.toUpperCase(),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.fullName,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${application.experienceYears} years experience'
                      '${application.submittedAt == null ? '' : ' · submitted ${relativeTime(context, application.submittedAt!)}'}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(
                label: application.status.name,
                tone: switch (application.status) {
                  ApplicationStatus.approved => StatusTone.success,
                  ApplicationStatus.rejected => StatusTone.danger,
                  ApplicationStatus.underReview => StatusTone.info,
                  _ => StatusTone.warning,
                },
              ),
            ],
          ),
          if (application.documents.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final entry in application.documents.entries)
                  Chip(
                    avatar: const Icon(Icons.description_outlined, size: 16),
                    label: Text(entry.key),
                    backgroundColor: colors.surfaceVariant,
                    side: BorderSide(color: colors.border),
                  ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: colors.warning,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    // Flagged rather than hidden: approving an astrologer with
                    // no documents on file is a decision someone should make
                    // knowingly, not by not noticing.
                    'No KYC documents attached to this application',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (!decided) ...[
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (busy)
                  const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else ...[
                  TextButton.icon(
                    onPressed: () => onDecide(false),
                    icon: const Icon(Icons.close_rounded, size: 18),
                    label: const Text('Reject'),
                    style: TextButton.styleFrom(foregroundColor: colors.error),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () => onDecide(true),
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text('Approve'),
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.success,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
