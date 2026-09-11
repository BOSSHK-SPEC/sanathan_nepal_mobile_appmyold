import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/wallet_cubit.dart';
import '../l10n/wallet_strings.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/wallet_format.dart';

/// Wallet home: balance, quick top-up tiers, recent activity.
class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<WalletCubit>()..load(),
    child: const _WalletView(),
  );
}

class _WalletView extends StatelessWidget {
  const _WalletView();

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(
        title: s.wallet,
        showBack: true,
        actions: [
          IconButton(
            tooltip: s.transactions,
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => context.push(AppRoutes.walletTransactions),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            final cubit = context.read<WalletCubit>();

            if (state.balance.isFailed && state.balance.dataOrNull == null) {
              return ErrorView(
                message: state.balance.errorMessage,
                onRetry: cubit.load,
              );
            }
            if (state.balance.dataOrNull == null) {
              return const _WalletSkeleton();
            }

            return RefreshIndicator(
              onRefresh: cubit.load,
              color: colors.accent,
              child: ListView(
                padding: const EdgeInsets.only(
                  top: AppSpacing.md,
                  bottom: AppSpacing.xxxl,
                ),
                children: [
                  BalanceCard(
                    balance: state.wallet,
                    onAddMoney: () async {
                      await context.push(AppRoutes.walletTopUp);
                      if (context.mounted) await cubit.refreshBalance();
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (state.topUpOptions.isNotEmpty) ...[
                    SectionHeader(title: s.addMoney),
                    SizedBox(
                      height: 70,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.pageGutter,
                        ),
                        itemCount: state.topUpOptions.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (context, i) {
                          final option = state.topUpOptions[i];
                          return _QuickTopUpChip(
                            amount: option.amount,
                            bonus: option.bonus,
                            onTap: () async {
                              await context.push(
                                AppRoutes.walletTopUpPath(
                                  amount: option.amount,
                                ),
                              );
                              if (context.mounted) {
                                await cubit.refreshBalance();
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                  SectionHeader(
                    title: s.recentActivity,
                    trailing: TextButton(
                      onPressed: () =>
                          context.push(AppRoutes.walletTransactions),
                      child: Text(
                        s.viewAll,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.accent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.pageGutter,
                    ),
                    child: state.wallet.recent.isEmpty
                        ? _EmptyWallet(strings: s)
                        : Column(
                            children: [
                              for (final t in state.wallet.recent)
                                TransactionTile(
                                  transaction: t,
                                  onTap: () => context.push(
                                    AppRoutes.walletRefundPath(t.id),
                                  ),
                                ),
                            ],
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _QuickTopUpChip extends StatelessWidget {
  const _QuickTopUpChip({
    required this.amount,
    required this.bonus,
    required this.onTap,
  });

  final double amount;
  final double bonus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = WalletStrings.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoneyText(amount, style: context.textTheme.headlineSmall),
            if (bonus > 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '+',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.success,
                    ),
                  ),
                  MoneyText(
                    bonus,
                    style: context.textTheme.labelSmall,
                    color: colors.success,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    s.extra,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.success,
                    ),
                  ),
                ],
              )
            else
              Text(
                walletDigits(context, ''),
                style: context.textTheme.labelSmall,
              ),
          ],
        ),
      ),
    );
  }
}

class _EmptyWallet extends StatelessWidget {
  const _EmptyWallet({required this.strings});

  final WalletStrings strings;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
    child: Column(
      children: [
        Icon(
          Icons.account_balance_wallet_outlined,
          size: 40,
          color: context.colors.textMuted,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(strings.emptyWalletTitle, style: context.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.xs),
        Text(
          strings.emptyWalletBody,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.textMuted,
          ),
        ),
      ],
    ),
  );
}

class _WalletSkeleton extends StatelessWidget {
  const _WalletSkeleton();

  @override
  // A ListView, not a Column: the placeholder is taller than a short
  // viewport and must scroll rather than overflow.
  Widget build(BuildContext context) => const AppShimmer(
    child: SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.pageGutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeleton(height: 168, radius: AppRadius.xl),
          SizedBox(height: AppSpacing.xl),
          AppSkeleton.text(width: 140, height: 16),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(height: 70, radius: AppRadius.lg),
          SizedBox(height: AppSpacing.xl),
          AppSkeletonList.tiles(count: 4, padding: EdgeInsets.zero),
        ],
      ),
    ),
  );
}
