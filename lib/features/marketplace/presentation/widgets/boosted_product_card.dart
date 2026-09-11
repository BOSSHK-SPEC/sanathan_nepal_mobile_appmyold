import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'product_photo.dart';

/// Compact 120×132 card used in the horizontal "Boosted Post" carousel.
class BoostedProductCard extends StatelessWidget {
  const BoostedProductCard({
    required this.product,
    required this.onTap,
    required this.onFavourite,
    super.key,
    this.width = 120,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavourite;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final lang = context.languageCode;
    final condition = product.condition == ProductCondition.used
        ? s.used
        : s.brandNew;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: colors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductPhoto(
              product.primaryImage,
              width: double.infinity,
              height: 80,
              iconSize: 28,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 5, 6, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.titleFor(languageCode: lang),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${MarketplaceFormat.priceOf(context, product.price)} | $condition',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.accent,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 8, color: colors.accent),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          product.locationFor(languageCode: lang),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 8,
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onFavourite,
                        child: Icon(
                          product.isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 10,
                          color: product.isFavourite
                              ? colors.error
                              : colors.textSecondary,
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
    );
  }
}
