import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/repositories/product_review_repository.dart';
import '../cubit/pending_reviews_cubit.dart';
import '../l10n/marketplace_strings.dart';

/// Delivered purchases still waiting on a review.
///
/// The prompt has to live somewhere the buyer will actually see it; a nudge
/// buried in each order is how ratings stay empty.
class PendingReviewsPage extends StatelessWidget {
  const PendingReviewsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<PendingReviewsCubit>()..load(),
    child: const PendingReviewsView(),
  );
}

/// Widget-testable body of [PendingReviewsPage].
class PendingReviewsView extends StatelessWidget {
  const PendingReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.rateYourPurchases, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<PendingReviewsCubit, PendingReviewsState>(
          builder: (context, state) {
            final cubit = context.read<PendingReviewsCubit>();
            return switch (state.pending) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.refresh,
              ),
              _ when state.isEmpty => EmptyView(
                message: s.noPendingReviews,
                icon: Icons.done_all_rounded,
              ),
              _ => RefreshIndicator(
                onRefresh: cubit.refresh,
                color: colors.accent,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.xxl,
                  ),
                  itemCount: state.all.length + 1,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: Text(
                          s.rateYourPurchasesBody,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      );
                    }
                    return _PendingRow(pending: state.all[i - 1]);
                  },
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}

class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.pending});

  final PendingReview pending;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 20,
                color: colors.textMuted,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pending.productName,
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    '${s.deliveredOn} '
                    '${dateFormat.format(pending.deliveredAt)}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              // Carrying the order id is what makes the resulting review a
              // verified purchase.
              onPressed: () => context.push(
                AppRoutes.productReviewNewPath(
                  pending.productId,
                  orderId: pending.orderId,
                ),
              ),
              child: Text(s.rateIt),
            ),
          ],
        ),
      ),
    );
  }
}
