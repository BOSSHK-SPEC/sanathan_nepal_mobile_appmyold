import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'product_photo.dart';

/// 160×190 listing card (Figma "product grid" on the Product & Service
/// listing page): centred square photo, heart, name, 2-line description and
/// a small "Add to cart" square button.
class ProductListCard extends StatelessWidget {
  const ProductListCard({
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    super.key,
    this.onFavourite,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final VoidCallback? onFavourite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final lang = context.languageCode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Center(
                  child: ProductPhoto(
                    product.primaryImage,
                    width: 80,
                    height: 80,
                    radius: AppRadius.md,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 4,
                  child: GestureDetector(
                    onTap: onFavourite,
                    child: Icon(
                      product.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 18,
                      color: product.isFavourite ? colors.error : colors.icon,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    product.titleFor(languageCode: lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall?.copyWith(fontSize: 13),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  MarketplaceFormat.priceOf(context, product.price),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              product.summaryFor(languageCode: lang),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textSecondary,
                height: 1.2,
              ),
            ),
            const Spacer(),
            Center(
              child: _SquareButton(label: s.addToCart, onTap: onAddToCart),
            ),
          ],
        ),
      ),
    );
  }
}

/// Figma "button - square" (80×20 gradient pill with 10px label).
class _SquareButton extends StatelessWidget {
  const _SquareButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 84,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: colors.primaryGradient,
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
