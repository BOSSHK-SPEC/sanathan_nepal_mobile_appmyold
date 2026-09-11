import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/product_review.dart';
import '../l10n/marketplace_strings.dart';

/// Average, count and the star breakdown.
///
/// The distribution earns its place: an average of 4.0 made of fives and
/// ones is a different product from one made of fours, and only the bars
/// show that.
class RatingSummaryCard extends StatelessWidget {
  const RatingSummaryCard({
    required this.summary,
    super.key,
    this.selectedStar,
    this.onStarTap,
  });

  final ProductRatingSummary summary;

  /// Star currently filtered on, if any.
  final int? selectedStar;
  final ValueChanged<int>? onStarTap;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                summary.average.toStringAsFixed(1),
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              RatingStars(rating: summary.average, size: 14),
              const SizedBox(height: AppSpacing.xs),
              Text(
                s.reviewCount(summary.total),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
              if (summary.verifiedCount > 0)
                Text(
                  '${summary.verifiedCount} ${s.verifiedPurchase.toLowerCase()}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.success,
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.xl),
          Expanded(
            child: Column(
              children: [
                for (var star = 5; star >= 1; star--)
                  _StarBar(
                    star: star,
                    share: summary.shareOf(star),
                    count: summary.distribution[star] ?? 0,
                    selected: selectedStar == star,
                    onTap: onStarTap == null ? null : () => onStarTap!(star),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarBar extends StatelessWidget {
  const _StarBar({
    required this.star,
    required this.share,
    required this.count,
    required this.selected,
    this.onTap,
  });

  final int star;
  final double share;
  final int count;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: count == 0 ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            SizedBox(
              width: 12,
              child: Text(
                '$star',
                style: context.textTheme.labelSmall?.copyWith(
                  color: selected ? colors.accent : colors.textMuted,
                ),
              ),
            ),
            Icon(
              Icons.star_rounded,
              size: 11,
              color: selected ? colors.accent : colors.textMuted,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: LinearProgressIndicator(
                  value: share,
                  minHeight: 5,
                  backgroundColor: colors.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation(
                    selected
                        ? colors.accent
                        : colors.accent.withValues(alpha: 0.55),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            SizedBox(
              width: 24,
              child: Text(
                '$count',
                textAlign: TextAlign.end,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
