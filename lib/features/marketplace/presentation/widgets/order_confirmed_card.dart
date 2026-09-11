import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/order.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'order_summary_rows.dart';

/// "Your Order has been confirmed." card (Figma "ORDER CONFIRM").
class OrderConfirmedCard extends StatelessWidget {
  const OrderConfirmedCard({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    String price(num v) =>
        MarketplaceFormat.priceOf(context, v, decimals: true);
    final paid = order.status == 'paid';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: colors.success,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, size: 30, color: colors.onPrimary),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            s.orderConfirmed,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(height: AppSpacing.xl, color: colors.divider),
          SummaryRow(label: s.subtotal, value: price(order.subtotal)),
          SummaryRow(label: s.discount, value: price(order.discount)),
          SummaryRow(
            label: s.status,
            value: '',
            valueWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  paid ? Icons.check_circle : Icons.schedule,
                  size: 14,
                  color: paid ? colors.success : colors.warning,
                ),
                const SizedBox(width: 4),
                Text(
                  paid ? s.paid : s.pending,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          SummaryRow(label: s.shippingCosts, value: price(order.shippingCost)),
          SummaryRow(
            label: s.orderNumber,
            value: '#${MarketplaceFormat.digits(context, order.id)}',
            emphasize: true,
          ),
        ],
      ),
    );
  }
}
