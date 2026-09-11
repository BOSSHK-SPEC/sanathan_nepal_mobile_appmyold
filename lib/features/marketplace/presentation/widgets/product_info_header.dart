import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../app/router/app_routes.dart';
import '../../domain/entities/product.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import '../../../../core/widgets/rating_stars.dart';

/// Title + price on one row ("मोती" · "$ 150.00"), then the seller line
/// ("Dr. Uttam Upadhyaya · 7 minutes ago" with views / likes on the right)
/// and the condition + stars strip (Figma light / dark Product Details).
class ProductInfoHeader extends StatelessWidget {
  const ProductInfoHeader({required this.product, super.key, this.now});

  final Product product;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final t = context.textTheme;
    final lang = context.languageCode;
    final condition = product.condition == ProductCondition.used
        ? s.used
        : s.brandNew;
    final muted = t.labelSmall?.copyWith(color: colors.textSecondary);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.titleFor(languageCode: lang),
                style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              MarketplaceFormat.priceOf(context, product.price, decimals: true),
              style: t.headlineMedium?.copyWith(
                color: colors.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            if (product.seller.verified) ...[
              Icon(Icons.verified, size: 14, color: colors.info),
              const SizedBox(width: 3),
            ],
            Flexible(
              child: Text(
                product.seller.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: t.labelMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '  ·  ${MarketplaceFormat.timeAgo(context, product.postedAt, now: now)}',
              style: muted,
            ),
            const Spacer(),
            Icon(
              Icons.remove_red_eye_outlined,
              size: 14,
              color: colors.iconMuted,
            ),
            const SizedBox(width: 3),
            Text(
              MarketplaceFormat.countOf(context, product.views),
              style: muted,
            ),
            const SizedBox(width: AppSpacing.md),
            Icon(Icons.favorite_border, size: 13, color: colors.iconMuted),
            const SizedBox(width: 3),
            Text(
              MarketplaceFormat.countOf(context, product.likes),
              style: muted,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Text(
                '${MarketplaceFormat.priceOf(context, product.price)} | $condition',
                style: t.titleSmall?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // The score has to lead somewhere: a number a buyer cannot
            // interrogate is not something they will trust.
            InkWell(
              onTap: () =>
                  context.push(AppRoutes.productReviewsPath(product.id)),
              child: RatingStars(rating: product.rating, size: 16),
            ),
            if (product.isMine) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colors.chipSelected,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  s.myProductBadge,
                  style: t.labelSmall?.copyWith(color: colors.onChipSelected),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
