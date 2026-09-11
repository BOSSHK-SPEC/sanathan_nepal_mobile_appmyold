import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/money_text.dart';
import '../../domain/entities/pending_payout.dart';
import '../../motion/motion.dart';
import '../../shell/widgets/console_page.dart';
import '../../shell/widgets/console_panel.dart';
import '../../shell/widgets/decision_dialog.dart';
import 'cubit/payouts_cubit.dart';

/// Payout requests from astrologers and sellers.
class PayoutsPage extends StatelessWidget {
  const PayoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PayoutsCubit>()..load(),
      child: const _PayoutsView(),
    );
  }
}

class _PayoutsView extends StatelessWidget {
  const _PayoutsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PayoutsCubit>();

    return BlocBuilder<PayoutsCubit, PayoutsState>(
      builder: (context, state) {
        return ConsolePage(
          title: 'Payouts',
          subtitle:
              'Money leaving the platform. Every decision is recorded against your account.',
          onRefresh: cubit.load,
          banner: state.actionError,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.items.isNotEmpty) ...[
                ConsolePanel(
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        color: context.colors.warning,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          '${state.items.length} request'
                          '${state.items.length == 1 ? '' : 's'} awaiting a decision',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                      MoneyText(
                        state.totalRequested,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              LoadStateView<List<PendingPayout>>(
                state: state.payouts,
                onRetry: cubit.load,
                isEmpty: (items) => items.isEmpty,
                emptyMessage: 'No payouts waiting',
                emptyIcon: Icons.account_balance_outlined,
                builder: (context, items) => Column(
                  children: [
                    for (final (index, payout) in items.indexed)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Reveal(
                          delay: Motion.stagger(index),
                          child: _PayoutRow(
                            payout: payout,
                            busy: state.isDeciding(payout.id),
                            onDecide: (approve) =>
                                _decide(context, payout, approve: approve),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _decide(
    BuildContext context,
    PendingPayout payout, {
    required bool approve,
  }) async {
    final cubit = context.read<PayoutsCubit>();
    final decision = await showDecisionDialog(
      context,
      title: approve ? 'Release this payout' : 'Reject this payout',
      subject: 'Requested by ${payout.userId}',
      approve: approve,
      // Only on approval: a rejected payout has no bank reference to record,
      // and asking for one would imply money moved.
      askForReference: true,
    );
    if (decision == null) return;

    await cubit.decide(
      payoutId: payout.id,
      approve: decision.approve,
      note: decision.note,
      reference: decision.reference,
    );
  }
}

class _PayoutRow extends StatelessWidget {
  const _PayoutRow({
    required this.payout,
    required this.busy,
    required this.onDecide,
  });

  final PendingPayout payout;
  final bool busy;
  final void Function(bool approve) onDecide;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ConsolePanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoneyText(
                  payout.amount,
                  decimals: 2,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  payout.userId,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'requested ${relativeTime(context, payout.createdAt)}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (busy)
            const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else ...[
            TextButton(
              onPressed: () => onDecide(false),
              style: TextButton.styleFrom(foregroundColor: colors.error),
              child: const Text('Reject'),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: () => onDecide(true),
              icon: const Icon(Icons.send_rounded, size: 16),
              label: const Text('Release'),
            ),
          ],
        ],
      ),
    );
  }
}
