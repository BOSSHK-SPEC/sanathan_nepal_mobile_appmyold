import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/cart.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'order_summary_rows.dart';

/// Totals + coupon + "Continue Shopping" + "Checkout | total" (Figma "List").
class CartSummaryCard extends StatelessWidget {
  const CartSummaryCard({
    required this.cart,
    required this.couponController,
    required this.couponInvalid,
    required this.onApplyCoupon,
    required this.onContinueShopping,
    required this.onCheckout,
    super.key,
  });

  final Cart cart;
  final TextEditingController couponController;
  final bool couponInvalid;
  final VoidCallback onApplyCoupon;
  final VoidCallback onContinueShopping;
  final VoidCallback? onCheckout;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    String price(num v) =>
        MarketplaceFormat.priceOf(context, v, decimals: true);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SummaryRow(label: s.subtotal, value: price(cart.subtotal)),
          SummaryRow(label: s.discount, value: price(cart.discount)),
          SummaryRow(
            label: s.shippingCosts,
            value: price(cart.isEmpty ? 0 : cart.shippingCost),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: couponController,
                  textCapitalization: TextCapitalization.characters,
                  style: context.textTheme.bodySmall,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: s.couponCode,
                    errorText: couponInvalid ? s.invalidCoupon : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: (_) => onApplyCoupon(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              PrimaryButton(
                label: s.applyCoupon,
                expanded: false,
                height: 36,
                radius: AppRadius.sm,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                onPressed: onApplyCoupon,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: TextButton(
              onPressed: onContinueShopping,
              child: Text(
                s.continueShopping,
                style: context.textTheme.labelLarge?.copyWith(
                  color: colors.accent,
                  decoration: TextDecoration.underline,
                  decorationColor: colors.accent,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _TotalButton(
            label: s.checkout,
            total: price(cart.total),
            onPressed: onCheckout,
          ),
          Divider(height: AppSpacing.xxl, color: colors.divider),
          SecurePaymentsFooter(label: s.securePaymentsBy),
        ],
      ),
    );
  }
}

/// Wide gradient button "Checkout | Rs. 500.00" / "Place Order | …".
class _TotalButton extends StatelessWidget {
  const _TotalButton({
    required this.label,
    required this.total,
    this.onPressed,
  });
  final String label;
  final String total;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Opacity(
      opacity: onPressed == null ? 0.6 : 1,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: 40,
          decoration: BoxDecoration(
            gradient: colors.primaryGradient,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 14,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    color: colors.onPrimary.withValues(alpha: 0.7),
                  ),
                  Text(
                    total,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Public alias so checkout can reuse the same wide button.
class TotalActionButton extends StatelessWidget {
  const TotalActionButton({
    required this.label,
    required this.total,
    super.key,
    this.onPressed,
  });
  final String label;
  final String total;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) =>
      _TotalButton(label: label, total: total, onPressed: onPressed);
}
