import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/product_review.dart';
import '../l10n/marketplace_strings.dart';

/// One review: stars, body, photos, the seller's reply and a helpful vote.
class ProductReviewTile extends StatelessWidget {
  const ProductReviewTile({
    required this.review,
    super.key,
    this.onHelpful,
    this.onReply,
    this.busy = false,
  });

  final ProductReview review;
  final VoidCallback? onHelpful;

  /// Provided only to the seller who owns the listing.
  final VoidCallback? onReply;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppAvatar(
                  source: review.authorAvatar,
                  name: review.authorName,
                  size: 32,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.authorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelLarge,
                      ),
                      Row(
                        children: [
                          RatingStars(
                            rating: review.rating.toDouble(),
                            size: 12,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          // Flexible: a long relative time next to a
                          // verified badge leaves this row little room.
                          Flexible(
                            child: Text(
                              relativeTime(context, review.createdAt),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Verified is derived from the order, never a badge someone
                // can award themselves.
                if (review.isVerifiedPurchase)
                  StatusChip(
                    label: s.verifiedPurchase,
                    tone: StatusTone.success,
                    dense: true,
                  ),
              ],
            ),
            if (review.comment.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(review.comment, style: context.textTheme.bodySmall),
            ],
            if (review.hasPhotos) ...[
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 64,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: review.photos.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, i) => Container(
                    width: 64,
                    decoration: BoxDecoration(
                      color: colors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      Icons.photo_outlined,
                      size: 20,
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ),
            ],
            if (review.hasReply) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.sellerReplied,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.accent,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.sellerReply!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                if (busy)
                  const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  TextButton.icon(
                    onPressed: onHelpful,
                    icon: Icon(
                      review.markedHelpful
                          ? Icons.thumb_up_rounded
                          : Icons.thumb_up_outlined,
                      size: 15,
                      color: review.markedHelpful
                          ? colors.accent
                          : colors.textMuted,
                    ),
                    label: Text(
                      review.helpfulCount == 0
                          ? s.helpful
                          : '${s.helpful} (${review.helpfulCount})',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: review.markedHelpful
                            ? colors.accent
                            : colors.textMuted,
                      ),
                    ),
                  ),
                const Spacer(),
                // A seller answers once; after that the button is gone
                // rather than disabled, because there is nothing to retry.
                if (onReply != null && !review.hasReply)
                  TextButton(onPressed: onReply, child: Text(s.replyToReview)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
