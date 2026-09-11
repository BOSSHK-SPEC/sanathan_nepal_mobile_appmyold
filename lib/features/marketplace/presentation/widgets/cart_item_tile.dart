import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/datasources/marketplace_categories.dart';
import '../../domain/entities/cart.dart';
import '../utils/marketplace_format.dart';
import 'product_photo.dart';

/// One cart line (Figma "Group 36018"): photo, title, category, − qty +,
/// unit price, line total and a remove (×) badge.
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    super.key,
  });

  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final t = context.textTheme;
    final lang = context.languageCode;
    final product = item.product;
    final category = MarketplaceCategories.all
        .where((c) => c.id == product.categoryId)
        .firstOrNull
        ?.name(languageCode: lang);
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 4),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductPhoto(
                  product.primaryImage,
                  width: 90,
                  height: 68,
                  radius: AppRadius.sm,
                  fit: BoxFit.cover,
                  iconSize: 26,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.titleFor(languageCode: lang),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        [?category, ...item.selectedOptions.values].join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.labelSmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          _QtyButton(icon: Icons.remove, onTap: onDecrement),
                          SizedBox(
                            width: 26,
                            child: Text(
                              MarketplaceFormat.digits(context, item.quantity),
                              textAlign: TextAlign.center,
                              style: t.labelLarge,
                            ),
                          ),
                          _QtyButton(icon: Icons.add, onTap: onIncrement),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              MarketplaceFormat.priceOf(context, product.price),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: t.labelSmall?.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ),
                          Text(
                            MarketplaceFormat.priceOf(context, item.lineTotal),
                            style: t.labelLarge?.copyWith(
                              color: colors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -8,
            left: -4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: colors.error,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 12, color: colors.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xs),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: colors.chipBackground,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(color: colors.border),
        ),
        child: Icon(icon, size: 14, color: colors.icon),
      ),
    );
  }
}
