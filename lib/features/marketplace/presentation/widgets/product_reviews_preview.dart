import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/product_review.dart';
import '../cubit/product_reviews_cubit.dart';
import '../l10n/marketplace_strings.dart';
import 'product_review_tile.dart';
import 'rating_summary_card.dart';

/// The reviews block on a product page: scores, the two most helpful
/// reviews, and a way through to the rest.
///
/// Carries its own cubit so the details page is not coupled to review
/// loading — a slow review fetch must never hold up the buy button.
class ProductReviewsPreview extends StatelessWidget {
  const ProductReviewsPreview({
    required this.productId,
    super.key,
    this.isSeller = false,
  });

  final String productId;
  final bool isSeller;

  /// How many reviews to show inline before deferring to the full list.
  static const int previewCount = 2;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<ProductReviewsCubit>(param1: productId)
      // The two reviews shown inline should be the ones buyers found most
      // useful, not merely the newest.
      ..load(sort: ReviewSort.helpful),
    child: _PreviewBody(productId: productId, isSeller: isSeller),
  );
}

class _PreviewBody extends StatelessWidget {
  const _PreviewBody({required this.productId, required this.isSeller});

  final String productId;
  final bool isSeller;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ProductReviewsCubit, ProductReviewsState>(
      builder: (context, state) {
        final cubit = context.read<ProductReviewsCubit>();
        final shown = state.all
            .take(ProductReviewsPreview.previewCount)
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    s.ratingsAndReviews,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                if (!state.scores.isEmpty)
                  TextButton(
                    onPressed: () =>
                        context.push(AppRoutes.productReviewsPath(productId)),
                    child: Text(s.allReviews),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (state.reviews.isLoading && state.all.isEmpty)
              // A reserved box with no animation. This block sits below the
              // fold so a shimmer is rarely seen, and any endless animation
              // here keeps the whole page scheduling frames.
              Container(
                height: 96,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              )
            else if (state.scores.isEmpty)
              // No scores at all is an invitation, not an error.
              AppCard(
                child: Column(
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      size: 32,
                      color: colors.accent,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(s.noReviewsTitle, style: context.textTheme.titleSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      s.noReviewsBody,
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                    if (!isSeller) ...[
                      const SizedBox(height: AppSpacing.sm),
                      TextButton(
                        onPressed: () => context.push(
                          AppRoutes.productReviewNewPath(productId),
                        ),
                        child: Text(s.beTheFirst),
                      ),
                    ],
                  ],
                ),
              )
            else ...[
              RatingSummaryCard(
                summary: state.scores,
                onStarTap: (star) =>
                    context.push(AppRoutes.productReviewsPath(productId)),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final review in shown)
                ProductReviewTile(
                  review: review,
                  onHelpful: () => cubit.toggleHelpful(review.id),
                ),
              if (state.scores.total > shown.length)
                SecondaryButton(
                  label: s.allReviews,
                  onPressed: () =>
                      context.push(AppRoutes.productReviewsPath(productId)),
                ),
            ],
          ],
        );
      },
    );
  }
}
