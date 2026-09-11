import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import 'product_grid_card.dart';

/// Non-scrolling two-column grid of [ProductGridCard]s (embeds in a page
/// scroll view). Uses a max-extent delegate so it adapts to tablets.
class ProductGrid extends StatelessWidget {
  const ProductGrid({
    required this.products,
    required this.onTap,
    super.key,
    this.onFavourite,
    this.onEdit,
    this.onDelete,
    this.padding = AppSpacing.page,
    this.now,
  });

  final List<Product> products;
  final ValueChanged<Product> onTap;
  final ValueChanged<Product>? onFavourite;

  /// Seller actions forwarded to [ProductGridCard] for `isMine` listings.
  final ValueChanged<Product>? onEdit;
  final ValueChanged<Product>? onDelete;
  final EdgeInsets padding;
  final DateTime? now;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: padding,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      mainAxisExtent: 215,
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
    ),
    itemBuilder: (context, i) {
      final p = products[i];
      return ProductGridCard(
        product: p,
        now: now,
        onTap: () => onTap(p),
        onFavourite: onFavourite == null ? null : () => onFavourite!(p),
        onEdit: onEdit == null || !p.isMine ? null : () => onEdit!(p),
        onDelete: onDelete == null || !p.isMine ? null : () => onDelete!(p),
      );
    },
  );
}
