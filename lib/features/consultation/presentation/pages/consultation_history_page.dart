import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/consultation.dart';
import '../cubit/consultation_history_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/consult_format.dart';

/// Past consultations, with lifetime spend and minutes.
class ConsultationHistoryPage extends StatelessWidget {
  const ConsultationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ConsultationHistoryCubit>()..load(),
    child: const _HistoryView(),
  );
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.consultationHistory, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ConsultationHistoryCubit, ConsultationHistoryState>(
          builder: (context, state) {
            final cubit = context.read<ConsultationHistoryCubit>();

            return switch (state.sessions) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 5),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ when state.isEmpty => _EmptyHistory(strings: s),
              _ => ListView(
                padding: const EdgeInsets.all(AppSpacing.pageGutter),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          label: s.totalSpent,
                          icon: Icons.payments_outlined,
                          valueWidget: MoneyText(
                            state.totalSpent,
                            style: context.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: StatTile(
                          label: s.totalMinutes,
                          icon: Icons.timer_outlined,
                          value: consultDigits(context, state.totalMinutes),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (final session in state.items)
                    _HistoryTile(session: session, strings: s),
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.session, required this.strings});

  final Consultation session;
  final ConsultationStrings strings;

  IconData get _icon => switch (session.channel) {
    ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
    ConsultChannel.voice => Icons.call_outlined,
    ConsultChannel.video => Icons.videocam_outlined,
  };

  StatusTone get _tone => switch (session.status) {
    ConsultationStatus.completed => StatusTone.success,
    ConsultationStatus.cancelled => StatusTone.neutral,
    _ => StatusTone.warning,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final completed = session.status == ConsultationStatus.completed;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      onTap: completed
          ? () => context.push(AppRoutes.consultSummaryPath(session.id))
          : null,
      child: Row(
        children: [
          AppAvatar(
            source: session.astrologerAvatar,
            name: session.astrologerName.en,
            size: 44,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.astrologerName.forLanguage(context.languageCode),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(_icon, size: 12, color: colors.iconMuted),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        completed
                            ? '${strings.minutesLabel(consultDigits(context, session.billedMinutes()))} · '
                                  '${relativeTime(context, session.createdAt)}'
                            : relativeTime(context, session.createdAt),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (completed)
                MoneyText(
                  session.amountCharged,
                  style: context.textTheme.titleSmall,
                ),
              const SizedBox(height: 2),
              StatusChip(
                label: strings.statusName(session.status),
                tone: _tone,
                dense: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.strings});

  final ConsultationStrings strings;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.forum_outlined, size: 44, color: context.colors.textMuted),
          const SizedBox(height: AppSpacing.md),
          Text(strings.noHistory, style: context.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            strings.noHistoryBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: strings.findAstrologer,
            expanded: false,
            onPressed: () => context.push(AppRoutes.astrologers),
          ),
        ],
      ),
    ),
  );
}
