import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/product_review.dart';
import '../cubit/product_reviews_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../widgets/product_review_tile.dart';
import '../widgets/rating_summary_card.dart';
import '../widgets/review_reply_sheet.dart';

/// Every review on one listing, with the star breakdown and its filters.
class ProductReviewsPage extends StatelessWidget {
  const ProductReviewsPage({
    required this.productId,
    super.key,
    this.isSeller = false,
  });

  final String productId;

  /// Shows the reply action. The listing owner only.
  final bool isSeller;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<ProductReviewsCubit>(param1: productId)..load(),
    child: ProductReviewsView(productId: productId, isSeller: isSeller),
  );
}

/// Widget-testable body of [ProductReviewsPage].
class ProductReviewsView extends StatelessWidget {
  const ProductReviewsView({
    required this.productId,
    super.key,
    this.isSeller = false,
  });

  final String productId;
  final bool isSeller;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<ProductReviewsCubit, ProductReviewsState>(
      listenWhen: (a, b) =>
          b.actionError != null && a.actionError != b.actionError,
      listener: (context, state) => AppSnack.error(context, state.actionError!),
      builder: (context, state) {
        final cubit = context.read<ProductReviewsCubit>();

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.ratingsAndReviews, showBack: true),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.md,
                AppSpacing.pageGutter,
                AppSpacing.xxl,
              ),
              children: [
                if (!state.scores.isEmpty) ...[
                  RatingSummaryCard(
                    summary: state.scores,
                    selectedStar: state.minRating,
                    onStarTap: cubit.setMinRating,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _FilterRow(state: state, cubit: cubit),
                  const SizedBox(height: AppSpacing.sm),
                ],
                switch (state.reviews) {
                  Idle() || Loading(previous: null) =>
                    const AppSkeletonList.tiles(count: 3),
                  Failed(:final failure, previous: null) => ErrorView(
                    message: failure.message,
                    onRetry: cubit.load,
                  ),
                  // An empty *filtered* list is a different message from a
                  // product nobody has reviewed at all.
                  _ when state.isEmpty && state.hasFilters => EmptyView(
                    message: s.noReviewsBody,
                    icon: Icons.filter_alt_off_outlined,
                  ),
                  _ when state.isEmpty => EmptyViewWithBody(
                    title: s.noReviewsTitle,
                    body: s.noReviewsBody,
                    icon: Icons.rate_review_outlined,
                    actionLabel: s.beTheFirst,
                    onAction: () =>
                        context.push(AppRoutes.productReviewNewPath(productId)),
                  ),
                  _ => Column(
                    children: [
                      for (final review in state.all)
                        ProductReviewTile(
                          review: review,
                          busy: state.busyReviewId == review.id,
                          onHelpful: () => cubit.toggleHelpful(review.id),
                          onReply: isSeller
                              ? () => ReviewReplySheet.show(
                                  context,
                                  review: review,
                                )
                              : null,
                        ),
                    ],
                  ),
                },
              ],
            ),
          ),
          floatingActionButton: isSeller
              ? null
              : FloatingActionButton.extended(
                  onPressed: () =>
                      context.push(AppRoutes.productReviewNewPath(productId)),
                  icon: const Icon(Icons.rate_review_outlined),
                  label: Text(s.writeReview),
                ),
        );
      },
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.state, required this.cubit});

  final ProductReviewsState state;
  final ProductReviewsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    return SizedBox(
      height: 34,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final sort in ReviewSort.values) ...[
            ChoiceChip(
              label: Text(s.reviewSortName(sort)),
              selected: state.sort == sort,
              onSelected: (_) => cubit.setSort(sort),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          FilterChip(
            label: Text(s.withPhotos),
            selected: state.withPhotosOnly,
            onSelected: cubit.setWithPhotosOnly,
          ),
        ],
      ),
    );
  }
}
