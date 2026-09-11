import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../cubit/transactions_cubit.dart';
import '../l10n/wallet_strings.dart';
import '../widgets/transaction_tile.dart';

/// Full wallet ledger, grouped by day, with range / direction / category
/// filters and in/out totals for the selected window.
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<TransactionsCubit>()..load(),
    child: const _TransactionsView(),
  );
}

class _TransactionsView extends StatelessWidget {
  const _TransactionsView();

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.transactions, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            final cubit = context.read<TransactionsCubit>();

            return Column(
              children: [
                _FilterBar(state: state),
                _Totals(state: state),
                Expanded(
                  child: switch (state.transactions) {
                    Idle() || Loading(previous: null) =>
                      const AppSkeletonList.tiles(count: 7),
                    Failed(:final failure, previous: null) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.load,
                    ),
                    _ when state.isEmpty => _EmptyLedger(
                      canClear: state.filter.hasFilters,
                      onClear: cubit.clearFilters,
                    ),
                    _ => _Ledger(state: state),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.state});

  final TransactionsState state;

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final cubit = context.read<TransactionsCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
        child: Row(
          children: [
            for (final range in LedgerRange.values) ...[
              _Chip(
                label: s.rangeName(range),
                selected: state.filter.range == range,
                onTap: () => cubit.setRange(range),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Container(
              width: 1,
              height: 22,
              color: context.colors.divider,
              margin: const EdgeInsets.only(right: AppSpacing.sm),
            ),
            for (final direction in <TransactionDirection?>[
              null,
              TransactionDirection.credit,
              TransactionDirection.debit,
            ]) ...[
              _Chip(
                label: s.directionName(direction),
                selected: state.filter.direction == direction,
                onTap: () => cubit.setDirection(direction),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs + 2,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.chipSelected : colors.chipBackground,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: selected ? colors.onChipSelected : colors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals({required this.state});

  final TransactionsState state;

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;
    if (state.entries.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: StatTile(
              label: s.moneyIn,
              icon: Icons.south_west_rounded,
              accentColor: colors.success,
              valueWidget: MoneyText(
                state.totalIn,
                style: context.textTheme.headlineMedium,
                color: colors.success,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: StatTile(
              label: s.moneyOut,
              icon: Icons.north_east_rounded,
              accentColor: colors.error,
              valueWidget: MoneyText(
                state.totalOut,
                style: context.textTheme.headlineMedium,
                color: colors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Ledger extends StatelessWidget {
  const _Ledger({required this.state});

  final TransactionsState state;

  @override
  Widget build(BuildContext context) {
    final byDay = state.byDay;
    final days = byDay.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      itemCount: days.length,
      itemBuilder: (context, i) {
        final day = days[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.xs,
              ),
              child: Text(
                _dayLabel(context, day),
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            for (final t in byDay[day]!)
              TransactionTile(
                transaction: t,
                showBalance: true,
                onTap: () => context.push(AppRoutes.walletRefundPath(t.id)),
              ),
          ],
        );
      },
    );
  }

  String _dayLabel(BuildContext context, DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (day == today) return context.l10n.today;
    if (day == today.subtract(const Duration(days: 1))) {
      return context.l10n.yesterday;
    }
    return DateFormat.yMMMd(context.languageCode).format(day);
  }
}

class _EmptyLedger extends StatelessWidget {
  const _EmptyLedger({required this.canClear, required this.onClear});

  final bool canClear;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 42,
              color: context.colors.textMuted,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(s.noTransactions, style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(
              s.noTransactionsHint,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.textMuted,
              ),
            ),
            if (canClear) ...[
              const SizedBox(height: AppSpacing.xl),
              SecondaryButton(
                label: s.clear,
                expanded: false,
                onPressed: onClear,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
