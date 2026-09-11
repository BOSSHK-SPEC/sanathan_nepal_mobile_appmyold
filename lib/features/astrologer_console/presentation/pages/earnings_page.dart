import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/earnings.dart';
import '../cubit/earnings_cubit.dart';
import '../l10n/console_strings.dart';

/// Earnings ledger with gross, commission and net made explicit.
///
/// Astrologers care about the net, but hiding the commission is the fastest
/// way to lose their trust — so all three are on screen.
class ConsoleEarningsPage extends StatelessWidget {
  const ConsoleEarningsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<EarningsCubit>()..load(),
    child: const _EarningsView(),
  );
}

class _EarningsView extends StatelessWidget {
  const _EarningsView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<EarningsCubit, EarningsState>(
      builder: (context, state) {
        final cubit = context.read<EarningsCubit>();
        final earnings = state.earnings;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: s.earnings,
            showBack: true,
            actions: [
              IconButton(
                tooltip: s.analytics,
                icon: const Icon(Icons.insights_outlined),
                onPressed: () => context.push(AppRoutes.astrologerAnalytics),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.md,
                AppSpacing.pageGutter,
                AppSpacing.xxxl,
              ),
              children: [
                AppSegmentedControl(
                  segments: [
                    for (final range in EarningsRange.values)
                      s.rangeName(range),
                  ],
                  selectedIndex: EarningsRange.values.indexOf(state.range),
                  onChanged: (i) => cubit.setRange(EarningsRange.values[i]),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppCard(
                  gradient: colors.cardGradient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.net,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      MoneyText(
                        earnings.net,
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      KeyValueList(
                        divided: true,
                        children: [
                          KeyValueRow(
                            label: s.gross,
                            valueWidget: MoneyText(
                              earnings.gross,
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          KeyValueRow(
                            label:
                                '${s.commission} · '
                                '${_digits(context, (earnings.effectiveCommissionRate * 100).round())}%',
                            valueWidget: MoneyText(
                              -earnings.commission,
                              signed: true,
                              style: context.textTheme.bodyMedium,
                              color: colors.error,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        label: s.pendingBalance,
                        icon: Icons.hourglass_bottom_rounded,
                        valueWidget: MoneyText(
                          earnings.pendingBalance,
                          style: context.textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        label: s.availableBalance,
                        icon: Icons.account_balance_wallet_outlined,
                        accentColor: colors.success,
                        valueWidget: MoneyText(
                          earnings.availableBalance,
                          style: context.textTheme.headlineMedium,
                          color: colors.success,
                        ),
                        onTap: () => context.push(AppRoutes.astrologerPayouts),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  label: s.withdraw,
                  height: 46,
                  onPressed: () => context.push(
                    state.needsPayoutAccount
                        ? AppRoutes.astrologerPayoutAccount
                        : AppRoutes.astrologerWithdraw,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${_digits(context, earnings.sessions)} '
                        '${s.totalSessions.toLowerCase()} · '
                        '${s.minutesLabel(_digits(context, earnings.minutes))}',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                if (state.summary.isLoading && earnings.entries.isEmpty)
                  const AppSkeletonList.tiles(count: 5)
                else if (earnings.entries.isEmpty)
                  EmptyView(
                    message: s.noEarnings,
                    icon: Icons.receipt_long_outlined,
                  )
                else
                  for (final entry in earnings.entries)
                    _EarningTile(entry: entry, strings: s),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EarningTile extends StatelessWidget {
  const _EarningTile({required this.entry, required this.strings});

  final EarningEntry entry;
  final ConsoleStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surfaceVariant,
            ),
            child: Icon(
              switch (entry.channel) {
                'voice' => Icons.call_outlined,
                'video' => Icons.videocam_outlined,
                _ => Icons.chat_bubble_outline_rounded,
              },
              size: 16,
              color: colors.iconMuted,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.clientName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  '${strings.minutesLabel(_digits(context, entry.minutes))} · '
                  '${relativeTime(context, entry.occurredAt)}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MoneyText(entry.net, style: context.textTheme.titleSmall),
              Text(
                '${strings.gross} ${entry.gross.toStringAsFixed(0)}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
