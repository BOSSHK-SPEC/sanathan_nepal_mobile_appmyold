import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import '../l10n/marketplace_strings.dart';
import 'product_grid_card.dart';

/// "Similar Products" title + horizontal strip of [ProductGridCard]s.
class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({
    required this.products,
    required this.onTap,
    super.key,
    this.onFavourite,
  });

  final List<Product> products;
  final ValueChanged<Product> onTap;
  final ValueChanged<Product>? onFavourite;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.page,
          child: Text(
            s.similarProducts,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageGutter,
            vertical: AppSpacing.xs,
          ),
          child: Divider(height: 1, color: colors.divider),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 215,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: AppSpacing.page,
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, i) => SizedBox(
              width: 170,
              child: ProductGridCard(
                product: products[i],
                onTap: () => onTap(products[i]),
                onFavourite: onFavourite == null
                    ? null
                    : () => onFavourite!(products[i]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
