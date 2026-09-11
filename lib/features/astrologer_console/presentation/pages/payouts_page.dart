import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/payout.dart';
import '../cubit/payout_cubit.dart';
import '../l10n/console_strings.dart';

/// Payout history, plus the entry points to the account and withdrawal
/// screens. All three share one cubit because they read the same balances.
class PayoutsPage extends StatelessWidget {
  const PayoutsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PayoutCubit>(param1: context.region)..load(),
    child: const _PayoutsView(),
  );
}

class _PayoutsView extends StatelessWidget {
  const _PayoutsView();

  StatusTone _tone(PayoutStatus status) => switch (status) {
    PayoutStatus.paid => StatusTone.success,
    PayoutStatus.failed => StatusTone.danger,
    PayoutStatus.processing => StatusTone.info,
    PayoutStatus.requested => StatusTone.warning,
  };

  TimelineStepState _stepState(PayoutStatus status, int index) {
    final current = switch (status) {
      PayoutStatus.requested => 0,
      PayoutStatus.processing => 1,
      PayoutStatus.paid => 2,
      PayoutStatus.failed => 1,
    };
    if (status == PayoutStatus.failed && index == 2) {
      return TimelineStepState.failed;
    }
    if (index < current) return TimelineStepState.done;
    if (index == current) return TimelineStepState.current;
    return TimelineStepState.pending;
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<PayoutCubit, PayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: s.payoutHistory,
            showBack: true,
            actions: [
              IconButton(
                tooltip: s.taxDocuments,
                icon: const Icon(Icons.description_outlined),
                onPressed: () => context.push(AppRoutes.astrologerTax),
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
                _AccountCard(state: state),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        label: s.availableBalance,
                        icon: Icons.account_balance_wallet_outlined,
                        accentColor: colors.success,
                        valueWidget: MoneyText(
                          state.availableBalance,
                          style: context.textTheme.headlineMedium,
                          color: colors.success,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        label: s.pendingBalance,
                        icon: Icons.hourglass_bottom_rounded,
                        valueWidget: MoneyText(
                          state.pendingTotal,
                          style: context.textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  label: s.requestPayout,
                  height: 46,
                  onPressed: state.account == null
                      ? null
                      : () => context.push(AppRoutes.astrologerWithdraw),
                ),
                const SizedBox(height: AppSpacing.xl),
                SectionHeader(title: s.payoutHistory, padding: EdgeInsets.zero),
                const SizedBox(height: AppSpacing.sm),
                if (state.history.isEmpty)
                  EmptyView(
                    message: s.noPayouts,
                    icon: Icons.receipt_long_outlined,
                  )
                else
                  for (final payout in state.history)
                    AppCard(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MoneyText(
                                  payout.netAmount,
                                  style: context.textTheme.headlineSmall,
                                ),
                              ),
                              StatusChip(
                                label: s.payoutStatusName(payout.status),
                                tone: _tone(payout.status),
                                dense: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            DateFormat.yMMMd(
                              context.languageCode,
                            ).format(payout.requestedAt),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                          if (payout.isOpen) ...[
                            const SizedBox(height: AppSpacing.md),
                            AppTimeline(
                              steps: [
                                TimelineStep(
                                  title: s.payoutRequestedStatus,
                                  state: _stepState(payout.status, 0),
                                ),
                                TimelineStep(
                                  title: s.payoutProcessing,
                                  state: _stepState(payout.status, 1),
                                ),
                                TimelineStep(
                                  title: s.payoutPaid,
                                  state: _stepState(payout.status, 2),
                                ),
                              ],
                            ),
                          ],
                          if (payout.reference != null) ...[
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              payout.reference!,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                          ],
                        ],
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

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.state});

  final PayoutState state;

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;
    final account = state.account;

    if (account == null) {
      return AppCard(
        elevated: false,
        color: colors.warning.withValues(alpha: 0.12),
        onTap: () => context.push(AppRoutes.astrologerPayoutAccount),
        child: Row(
          children: [
            Icon(
              Icons.account_balance_outlined,
              size: 20,
              color: colors.warning,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.addPayoutAccount, style: context.textTheme.titleSmall),
                  Text(
                    s.payoutAccountBody,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: colors.iconMuted),
          ],
        ),
      );
    }

    return AppCard(
      onTap: () => context.push(AppRoutes.astrologerPayoutAccount),
      child: Row(
        children: [
          Icon(Icons.account_balance_outlined, size: 20, color: colors.accent),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.destinationName(account.destination),
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  account.maskedIdentifier,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          StatusChip(
            label: account.isUsable ? s.verified : s.payoutProcessing,
            tone: account.isUsable ? StatusTone.success : StatusTone.warning,
            dense: true,
          ),
        ],
      ),
    );
  }
}

/// Payout destination setup.
class PayoutAccountPage extends StatelessWidget {
  const PayoutAccountPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PayoutCubit>(param1: context.region)..load(),
    child: const _PayoutAccountView(),
  );
}

class _PayoutAccountView extends StatelessWidget {
  const _PayoutAccountView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<PayoutCubit, PayoutState>(
      builder: (context, state) {
        final cubit = context.read<PayoutCubit>();
        final draft = state.draft;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.payoutAccount, showBack: true),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Text(
                  s.payoutAccountBody,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final destination in state.destinations)
                      ChoiceChip(
                        label: Text(s.destinationName(destination)),
                        selected: draft.destination == destination,
                        onSelected: (_) => cubit.setDestination(destination),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  label: s.accountHolder,
                  required: true,
                  initialValue: draft.holderName,
                  onChanged: cubit.setHolderName,
                ),
                const SizedBox(height: AppSpacing.md),
                if (state.isBank) ...[
                  AppTextField(
                    label: s.bankName,
                    required: true,
                    initialValue: draft.bankName,
                    onChanged: cubit.setBankName,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                AppTextField(
                  label: switch (draft.destination) {
                    PayoutDestination.bankAccount => s.accountNumber,
                    PayoutDestination.upi => s.upiId,
                    _ => s.walletId,
                  },
                  required: true,
                  keyboardType:
                      draft.destination == PayoutDestination.bankAccount
                      ? TextInputType.number
                      : TextInputType.text,
                  inputFormatters:
                      draft.destination == PayoutDestination.bankAccount
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  initialValue: draft.identifier,
                  onChanged: cubit.setIdentifier,
                ),
                if (state.account != null && !state.account!.isUsable) ...[
                  const SizedBox(height: AppSpacing.lg),
                  AppCard(
                    elevated: false,
                    color: colors.warning.withValues(alpha: 0.12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: colors.warning,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            s.verificationPending,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (state.saveError != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    state.saveError!,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: s.saveAccount,
                  height: 46,
                  isLoading: state.saving.isLoading,
                  onPressed: state.canSaveAccount
                      ? () async {
                          final ok = await cubit.saveAccount();
                          if (ok && context.mounted) context.pop();
                        }
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Withdrawal request.
class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PayoutCubit>(param1: context.region)..load(),
    child: const _WithdrawView(),
  );
}

class _WithdrawView extends StatelessWidget {
  const _WithdrawView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<PayoutCubit, PayoutState>(
      builder: (context, state) {
        final cubit = context.read<PayoutCubit>();
        final amount = state.withdrawAmount ?? 0;
        final fee = state.history.isEmpty ? 40.0 : state.history.first.fee;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.withdraw, showBack: true),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                AppCard(
                  gradient: colors.cardGradient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.availableBalance,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      MoneyText(
                        state.availableBalance,
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppTextField(
                  label: s.withdrawAmount,
                  required: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: amount == 0 ? '' : amount.toStringAsFixed(0),
                  onChanged: cubit.setWithdrawAmount,
                  prefix: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Text(
                      context.regionConfig.symbolFor(context.languageCode),
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  suffix: TextButton(
                    onPressed: cubit.withdrawAll,
                    child: Text(s.withdrawAll),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppCard(
                  elevated: false,
                  color: colors.surfaceVariant,
                  child: KeyValueList(
                    divided: true,
                    children: [
                      KeyValueRow(
                        label: s.withdrawAmount,
                        valueWidget: MoneyText(
                          amount,
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                      KeyValueRow(
                        label: s.processingFee,
                        valueWidget: MoneyText(
                          -fee,
                          signed: true,
                          style: context.textTheme.bodyMedium,
                          color: colors.error,
                        ),
                      ),
                      KeyValueRow(
                        label: s.youWillReceive,
                        emphasised: true,
                        valueWidget: MoneyText(
                          (amount - fee).clamp(0, double.infinity),
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.withdrawError != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    state.withdrawError!,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: s.requestPayout,
                  height: 46,
                  isLoading: state.withdrawing.isLoading,
                  onPressed: state.canWithdraw
                      ? () async {
                          final ok = await cubit.withdraw();
                          if (ok && context.mounted) {
                            AppSnack.success(context, s.payoutRequested);
                            context.pop();
                          }
                        }
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Tax certificates and statements.
class TaxDocumentsPage extends StatelessWidget {
  const TaxDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PayoutCubit>(param1: context.region)..load(),
    child: const _TaxDocumentsView(),
  );
}

class _TaxDocumentsView extends StatelessWidget {
  const _TaxDocumentsView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.taxDocuments, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<PayoutCubit, PayoutState>(
          builder: (context, state) => ListView(
            padding: const EdgeInsets.all(AppSpacing.pageGutter),
            children: [
              for (final doc in state.taxDocuments)
                AppCard(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 22,
                        color: colors.accent,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.title,
                              style: context.textTheme.titleSmall,
                            ),
                            Text(
                              '${s.financialYear} ${doc.financialYear}',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MoneyText(
                        doc.amount,
                        style: context.textTheme.labelMedium,
                      ),
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
