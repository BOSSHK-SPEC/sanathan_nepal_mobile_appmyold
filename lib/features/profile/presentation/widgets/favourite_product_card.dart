import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/favourite_product.dart';
import '../l10n/profile_strings.dart';
import '../../../../core/widgets/rating_stars.dart';
import 'relative_time.dart';

/// Product card in the "Your Favorite Product & Services" grid
/// (image with heart, views/sold/stars row, name, description, price,
/// location, seller + time).
class FavouriteProductCard extends StatelessWidget {
  const FavouriteProductCard({required this.product, super.key, this.onTap});
  final FavouriteProduct product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final t = context.textTheme;
    final tiny = t.labelSmall?.copyWith(fontSize: 8, color: colors.textMuted);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 155 / 90,
                  child: product.imageUrl == null
                      ? Container(
                          color: colors.shimmer,
                          child: Icon(
                            Icons.diamond_outlined,
                            color: colors.iconMuted,
                            size: 32,
                          ),
                        )
                      : AppImage(product.imageUrl!),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.surface.withValues(alpha: 0.9),
                    ),
                    child: Icon(Icons.favorite, size: 11, color: colors.error),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 10,
                        color: colors.iconMuted,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        localizeDigits(context, _group(product.views)),
                        style: tiny,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 10,
                        color: colors.iconMuted,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        localizeDigits(context, '${product.sold}'),
                        style: tiny,
                      ),
                      const Spacer(),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: RatingStars(rating: product.rating, size: 9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: t.labelSmall?.copyWith(
                      fontSize: 9,
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${localizeDigits(context, product.priceLabel)} | ${product.condition}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.labelSmall?.copyWith(
                      fontSize: 10,
                      color: colors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 10,
                        color: colors.accent,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          product.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tiny,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.sellerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tiny?.copyWith(color: colors.textSecondary),
                        ),
                      ),
                      Text(
                        relativeTime(context, product.postedAt),
                        style: tiny,
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

  static String _group(int n) {
    final s = '$n';
    final b = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final fromEnd = s.length - i;
      b.write(s[i]);
      if (fromEnd > 1 && fromEnd % 3 == 1) b.write(',');
    }
    return '$b';
  }
}
