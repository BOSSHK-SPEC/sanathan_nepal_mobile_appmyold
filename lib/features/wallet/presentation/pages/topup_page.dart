import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/topup_cubit.dart';
import '../l10n/wallet_strings.dart';

/// Two-step top-up: amount, then payment method.
///
/// The payment attempt is only created on "Pay now", so backing out of the
/// method step leaves no orphaned intent behind.
class TopUpPage extends StatelessWidget {
  const TopUpPage({super.key, this.initialAmount});

  /// Pre-selects a tier when arriving from a quick-top-up chip.
  final double? initialAmount;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = GetIt.I<TopUpCubit>(param1: context.regionConfig)..load();
      if (initialAmount != null) cubit.selectAmount(initialAmount!);
      return cubit;
    },
    child: const _TopUpView(),
  );
}

class _TopUpView extends StatelessWidget {
  const _TopUpView();

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<TopUpCubit, TopUpState>(
      builder: (context, state) {
        final cubit = context.read<TopUpCubit>();

        return PopScope(
          canPop: state.step == 0,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) cubit.backToAmountStep();
          },
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppTopBar(
              title: s.addMoneyTitle,
              showBack: true,
              onBack: () =>
                  state.step == 0 ? context.pop() : cubit.backToAmountStep(),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  AppStepper(
                    steps: [s.chooseAmount, s.paymentMethod],
                    currentIndex: state.step,
                    onStepTapped: (i) =>
                        i == 0 ? cubit.backToAmountStep() : null,
                  ),
                  Expanded(
                    child: state.step == 0
                        ? const _AmountStep()
                        : const _MethodStep(),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _TopUpActionBar(state: state),
          ),
        );
      },
    );
  }
}

class _AmountStep extends StatefulWidget {
  const _AmountStep();

  @override
  State<_AmountStep> createState() => _AmountStepState();
}

class _AmountStepState extends State<_AmountStep> {
  final TextEditingController _custom = TextEditingController();

  @override
  void dispose() {
    _custom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<TopUpCubit, TopUpState>(
      builder: (context, state) {
        final cubit = context.read<TopUpCubit>();

        if (state.options.isLoading && state.tiers.isEmpty) {
          return const AppShimmer(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.pageGutter),
              child: Column(
                children: [
                  AppSkeleton(height: 64, radius: AppRadius.lg),
                  SizedBox(height: AppSpacing.md),
                  AppSkeleton(height: 64, radius: AppRadius.lg),
                  SizedBox(height: AppSpacing.md),
                  AppSkeleton(height: 64, radius: AppRadius.lg),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pageGutter,
            0,
            AppSpacing.pageGutter,
            AppSpacing.xxl,
          ),
          children: [
            for (final option in state.tiers)
              _AmountTile(
                amount: option.amount,
                bonus: option.bonus,
                popular: option.popular,
                selected:
                    state.selectedAmount == option.amount &&
                    state.customAmount.isEmpty,
                onTap: () {
                  _custom.clear();
                  cubit.selectAmount(option.amount);
                },
              ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _custom,
              label: s.customAmount,
              hint: s.customAmountHint,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: false,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: cubit.setCustomAmount,
              prefix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  context.regionConfig.symbolFor(context.languageCode),
                  style: context.textTheme.titleMedium,
                ),
              ),
            ),
            if (state.amountError != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                s.amountOutOfRange,
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _AmountTile extends StatelessWidget {
  const _AmountTile({
    required this.amount,
    required this.bonus,
    required this.popular,
    required this.selected,
    required this.onTap,
  });

  final double amount;
  final double bonus;
  final bool popular;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = WalletStrings.of(context);

    return AppCard(
      onTap: onTap,
      elevated: false,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      color: selected ? colors.accent.withValues(alpha: 0.08) : colors.surface,
      border: Border.all(
        color: selected ? colors.accent : colors.border,
        width: selected ? 1.5 : 1,
      ),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 20,
            color: selected ? colors.accent : colors.iconMuted,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MoneyText(amount, style: context.textTheme.headlineSmall),
                if (bonus > 0) ...[
                  const SizedBox(width: AppSpacing.sm),
                  StatusChip(
                    label: '+ ${bonus.toStringAsFixed(0)} ${s.extra}',
                    tone: StatusTone.success,
                    dense: true,
                  ),
                ],
              ],
            ),
          ),
          if (popular)
            StatusChip(label: s.popular, tone: StatusTone.accent, dense: true),
        ],
      ),
    );
  }
}

class _MethodStep extends StatelessWidget {
  const _MethodStep();

  IconData _icon(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa ||
    PaymentRail.khalti => Icons.account_balance_wallet_outlined,
    PaymentRail.upi => Icons.qr_code_rounded,
    PaymentRail.card => Icons.credit_card_rounded,
    PaymentRail.netBanking ||
    PaymentRail.bankTransfer => Icons.account_balance_outlined,
    PaymentRail.cashOnDelivery => Icons.payments_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<TopUpCubit, TopUpState>(
      builder: (context, state) {
        final cubit = context.read<TopUpCubit>();
        // Cash is a delivery-time method; it cannot fund a wallet.
        final rails = state.rails
            .where((r) => r != PaymentRail.cashOnDelivery)
            .toList();

        return ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pageGutter,
            0,
            AppSpacing.pageGutter,
            AppSpacing.xxl,
          ),
          children: [
            AppCard(
              elevated: false,
              color: colors.surfaceVariant,
              child: KeyValueList(
                children: [
                  KeyValueRow(
                    label: s.youWillGet,
                    valueWidget: MoneyText(
                      state.totalCredited,
                      style: context.textTheme.headlineSmall,
                      color: colors.accent,
                    ),
                  ),
                  if (state.bonus > 0)
                    KeyValueRow(
                      label: s.includingBonus,
                      valueWidget: MoneyText(
                        state.bonus,
                        style: context.textTheme.labelMedium,
                        color: colors.success,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(s.choosePaymentMethod, style: context.textTheme.titleSmall),
            const SizedBox(height: AppSpacing.md),
            for (final rail in rails)
              AppCard(
                elevated: false,
                onTap: () => cubit.selectRail(rail),
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                color: state.rail == rail
                    ? colors.accent.withValues(alpha: 0.08)
                    : colors.surface,
                border: Border.all(
                  color: state.rail == rail ? colors.accent : colors.border,
                  width: state.rail == rail ? 1.5 : 1,
                ),
                child: Row(
                  children: [
                    Icon(
                      _icon(rail),
                      size: 20,
                      color: state.rail == rail
                          ? colors.accent
                          : colors.iconMuted,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        s.railName(rail),
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    if (state.rail == rail)
                      Icon(
                        Icons.check_circle_rounded,
                        size: 20,
                        color: colors.accent,
                      ),
                  ],
                ),
              ),
            if (state.intent.isFailed) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                state.intent.errorMessage ?? context.l10n.somethingWentWrong,
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TopUpActionBar extends StatelessWidget {
  const _TopUpActionBar({required this.state});

  final TopUpState state;

  @override
  Widget build(BuildContext context) {
    final s = WalletStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<TopUpCubit>();

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: state.step == 0
              ? PrimaryButton(
                  label: s.continueLabel,
                  height: 46,
                  onPressed: state.canContinue ? cubit.goToMethodStep : null,
                )
              : PrimaryButton(
                  label: s.payNow,
                  height: 46,
                  isLoading: state.intent.isLoading,
                  onPressed: state.canPay
                      ? () async {
                          final intent = await cubit.pay();
                          if (intent != null && context.mounted) {
                            context.pushReplacement(
                              AppRoutes.walletPaymentPath(intent.id),
                            );
                          }
                        }
                      : null,
                ),
        ),
      ),
    );
  }
}
