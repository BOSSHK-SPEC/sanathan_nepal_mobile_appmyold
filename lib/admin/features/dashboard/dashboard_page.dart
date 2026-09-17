import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/money_text.dart';
import '../../auth/cubit/admin_auth_cubit.dart';
import '../../domain/entities/financial_summary.dart';
import '../../motion/motion.dart';
import '../../router/admin_routes.dart';
import '../../shell/widgets/console_page.dart';
import '../../shell/widgets/console_panel.dart';
import 'cubit/dashboard_cubit.dart';

/// Money in, money out, and where to go next.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardCubit>()..load(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return ConsolePage(
          title: 'Overview',
          subtitle: 'Everything that moved in the last ${state.days} days',
          onRefresh: cubit.load,
          actions: [
            _WindowSelector(days: state.days, onChanged: cubit.setWindow),
          ],
          child: LoadStateView<FinancialSummary>(
            state: state.summary,
            onRetry: cubit.load,
            builder: (context, summary) => _Summary(summary: summary),
          ),
        );
      },
    );
  }
}

class _WindowSelector extends StatelessWidget {
  const _WindowSelector({required this.days, required this.onChanged});

  final int days;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      segments: [
        for (final window in DashboardCubit.windows)
          ButtonSegment(
            value: window,
            label: Text(window == 365 ? '1y' : '${window}d'),
          ),
      ],
      selected: {days},
      showSelectedIcon: false,
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.summary});

  final FinancialSummary summary;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final session = context.watch<AdminAuthCubit>().state.user;
    final shortcuts = session == null
        ? <ConsoleDestination>[]
        : ConsoleDestination.permittedFor(
            session.permissions,
          ).where((d) => d.path != AdminRoutes.overview).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PanelGrid(
          children: [
            _Metric(
              label: 'Gross revenue',
              amount: summary.grossRevenue,
              icon: Icons.trending_up_rounded,
              tone: colors.success,
            ),
            _Metric(
              label: 'Net of refunds',
              amount: summary.netRevenue,
              icon: Icons.savings_rounded,
              tone: colors.primary,
            ),
            _Metric(
              label: 'Refunded',
              amount: summary.refunds,
              icon: Icons.undo_rounded,
              tone: colors.error,
              // A refund rate is the number that tells you whether refunds are
              // a rounding error or a problem; the absolute figure alone does
              // not, because it grows with a healthy business too.
              caption:
                  '${(summary.refundRate * 100).toStringAsFixed(1)}% of gross',
            ),
            _Metric(
              label: 'Awaiting payout',
              amount: summary.pendingPayouts,
              icon: Icons.hourglass_bottom_rounded,
              tone: colors.warning,
              caption: 'Owed to astrologers and sellers',
            ),
          ],
        ),
        const SizedBox(height: 16),
        PanelGrid(
          minTileWidth: 300,
          children: [
            ConsolePanel(
              title: 'Where revenue came from',
              child: Column(
                children: [
                  _SplitRow(
                    label: 'Consultations',
                    amount: summary.consultationRevenue,
                    total: summary.grossRevenue,
                    count: '${summary.consultationCount} sessions',
                    color: colors.primary,
                  ),
                  const SizedBox(height: 14),
                  _SplitRow(
                    label: 'Marketplace',
                    amount: summary.marketplaceRevenue,
                    total: summary.grossRevenue,
                    count: '${summary.orderCount} orders',
                    color: colors.accent,
                  ),
                  const SizedBox(height: 14),
                  _SplitRow(
                    label: 'Wallet top-ups',
                    amount: summary.walletTopUps,
                    total: summary.grossRevenue,
                    // Top-ups are deliberately labelled as not-yet-revenue:
                    // money in the wallet has been paid to us but not earned,
                    // and counting it twice is the classic way to overstate a
                    // marketplace's numbers.
                    count: 'Held as balance, not yet earned',
                    color: colors.info,
                  ),
                ],
              ),
            ),
            ConsolePanel(
              title: 'Volume',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CountRow(
                    label: 'Orders',
                    value: summary.orderCount,
                    caption: summary.orderCount == 0
                        ? 'None in this window'
                        : 'Average ${_money(context, summary.averageOrderValue)}',
                  ),
                  const Divider(height: 28),
                  _CountRow(
                    label: 'Consultations',
                    value: summary.consultationCount,
                    caption: 'Billed by the minute, server-side',
                  ),
                ],
              ),
            ),
          ],
        ),
        if (shortcuts.isNotEmpty) ...[
          const SizedBox(height: 28),
          Text(
            'Your sections',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          PanelGrid(
            minTileWidth: 260,
            children: [
              for (final destination in shortcuts)
                TiltCard(
                  onTap: () => context.go(destination.path),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(destination.icon, color: colors.primary),
                      const SizedBox(height: 14),
                      Text(
                        destination.label,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        destination.blurb,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  static String _money(BuildContext context, double amount) =>
      amount.toStringAsFixed(0);
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.amount,
    required this.icon,
    required this.tone,
    this.caption,
  });

  final String label;
  final double amount;
  final IconData icon;
  final Color tone;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ConsolePanel(
      tilt: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: tone),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: MoneyText(
              amount,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
              ),
            ),
          ),
          if (caption != null) ...[
            const SizedBox(height: 6),
            Text(
              caption!,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SplitRow extends StatelessWidget {
  const _SplitRow({
    required this.label,
    required this.amount,
    required this.total,
    required this.count,
    required this.color,
  });

  final String label;
  final double amount;
  final double total;
  final String count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final share = total <= 0 ? 0.0 : (amount / total).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
            MoneyText(
              amount,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: share),
            duration: Motion.slow,
            curve: Motion.enter,
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: colors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          count,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _CountRow extends StatelessWidget {
  const _CountRow({
    required this.label,
    required this.value,
    required this.caption,
  });

  final String label;
  final int value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(
                caption,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ),
        Text(
          '$value',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
