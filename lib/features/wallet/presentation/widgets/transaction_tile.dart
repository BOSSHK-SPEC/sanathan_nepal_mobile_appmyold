import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../l10n/wallet_strings.dart';

/// One ledger row: what it was for, when, and the signed amount.
///
/// Direction is carried by the icon and a `+`/`-` prefix as well as colour,
/// so the row still reads correctly without colour perception.
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    required this.transaction,
    super.key,
    this.onTap,
    this.showBalance = false,
  });

  final WalletTransaction transaction;
  final VoidCallback? onTap;

  /// Ledger screens show the running balance; the wallet home does not.
  final bool showBalance;

  IconData get _icon => switch (transaction.category) {
    TransactionCategory.topUp => Icons.add_card_outlined,
    TransactionCategory.bonus => Icons.card_giftcard_rounded,
    TransactionCategory.consultation => Icons.forum_outlined,
    TransactionCategory.report => Icons.description_outlined,
    TransactionCategory.productPurchase => Icons.shopping_bag_outlined,
    TransactionCategory.refund => Icons.undo_rounded,
    TransactionCategory.cashback => Icons.savings_outlined,
    TransactionCategory.adjustment => Icons.tune_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = WalletStrings.of(context);
    final credit = transaction.isCredit;
    final tint = credit ? colors.success : colors.textSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tint.withValues(alpha: 0.12),
              ),
              child: Icon(_icon, size: 18, color: tint),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.category(transaction.category),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    transaction.description.isEmpty
                        ? relativeTime(context, transaction.createdAt)
                        : '${transaction.description} · '
                              '${relativeTime(context, transaction.createdAt)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MoneyText(
                  transaction.signedAmount,
                  signed: true,
                  toneBySign: true,
                  style: context.textTheme.titleSmall,
                ),
                if (showBalance) ...[
                  const SizedBox(height: 1),
                  MoneyText(
                    transaction.balanceAfter,
                    style: context.textTheme.labelSmall,
                    color: colors.textMuted,
                  ),
                ],
              ],
            ),
            if (onTap != null) ...[
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: colors.iconMuted,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
