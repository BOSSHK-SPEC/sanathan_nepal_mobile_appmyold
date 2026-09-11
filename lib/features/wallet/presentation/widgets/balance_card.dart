import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/wallet_balance.dart';
import '../l10n/wallet_strings.dart';
import 'wallet_format.dart';

/// Balance hero: spendable total, bonus split, and how much talk time that
/// actually buys — the number people care about more than the currency one.
class BalanceCard extends StatelessWidget {
  const BalanceCard({
    required this.balance,
    required this.onAddMoney,
    super.key,
    this.chatRatePerMinute = 20,
  });

  final WalletBalance balance;
  final VoidCallback onAddMoney;

  /// Representative chat rate used only for the talk-time estimate.
  final double chatRatePerMinute;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = WalletStrings.of(context);
    final minutes = balance.minutesAffordable(chatRatePerMinute);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: colors.primaryGradient,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.availableBalance,
            style: context.textTheme.labelMedium?.copyWith(
              color: colors.onPrimary.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              MoneyText(
                balance.spendable,
                style: context.textTheme.displayLarge?.copyWith(height: 1.1),
                color: colors.onPrimary,
              ),
              if (minutes > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    '${s.minutesEstimate(walletDigits(context, minutes))} '
                    '${s.minutesOfChat}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (balance.promotional > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: colors.onPrimary.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.card_giftcard_rounded,
                    size: 13,
                    color: colors.onPrimary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    s.bonusCredit,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.onPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  MoneyText(
                    balance.promotional,
                    style: context.textTheme.labelSmall,
                    color: colors.onPrimary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              s.bonusNote,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.onPrimary.withValues(alpha: 0.75),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: colors.surface,
                foregroundColor: colors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              onPressed: onAddMoney,
              icon: const Icon(Icons.add_rounded, size: 19),
              label: Text(
                s.addMoney,
                style: context.textTheme.labelLarge?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
