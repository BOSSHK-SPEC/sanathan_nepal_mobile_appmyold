import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../cubit/reviews_inbox_cubit.dart';
import '../l10n/console_strings.dart';

/// Reviews with the right of reply.
///
/// Opens on "needs reply" rather than "all": this is a working queue, not a
/// vanity feed.
class ReviewsInboxPage extends StatelessWidget {
  const ReviewsInboxPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ReviewsInboxCubit>()..load(),
    child: const _ReviewsInboxView(),
  );
}

class _ReviewsInboxView extends StatelessWidget {
  const _ReviewsInboxView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.reviews, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ReviewsInboxCubit, ReviewsInboxState>(
          builder: (context, state) {
            final cubit = context.read<ReviewsInboxCubit>();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.pageGutter),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          label: s.yourRating,
                          icon: Icons.star_outline_rounded,
                          value: state.averageRating.toStringAsFixed(1),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: StatTile(
                          label: s.needsReply,
                          icon: Icons.reply_outlined,
                          accentColor: state.needsReplyCount > 0
                              ? colors.warning
                              : null,
                          value: '${state.needsReplyCount}',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pageGutter,
                  ),
                  child: AppSegmentedControl(
                    segments: [s.needsReply, s.critical, s.allReviews],
                    selectedIndex: switch (state.filter) {
                      ReviewFilter.needsReply => 0,
                      ReviewFilter.critical => 1,
                      ReviewFilter.all => 2,
                    },
                    onChanged: (i) => cubit.setFilter(switch (i) {
                      0 => ReviewFilter.needsReply,
                      1 => ReviewFilter.critical,
                      _ => ReviewFilter.all,
                    }),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: switch (state.reviews) {
                    Idle() || Loading(previous: null) =>
                      const AppSkeletonList.tiles(count: 4),
                    Failed(:final failure, previous: null) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.load,
                    ),
                    _ when state.isEmpty => EmptyView(
                      message: s.noReviews,
                      icon: Icons.done_all_rounded,
                    ),
                    _ => ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.pageGutter,
                        0,
                        AppSpacing.pageGutter,
                        AppSpacing.xxxl,
                      ),
                      children: [
                        for (final review in state.visible)
                          _ReviewCard(review: review, strings: s),
                      ],
                    ),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review, required this.strings});

  final AstrologerReview review;
  final ConsoleStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(name: review.authorName, size: 34),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.authorName,
                      style: context.textTheme.titleSmall,
                    ),
                    Row(
                      children: [
                        RatingStars(rating: review.rating.toDouble(), size: 12),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          relativeTime(context, review.createdAt),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              review.comment,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          if (review.hasReply)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border(
                  left: BorderSide(color: colors.accent, width: 2),
                ),
              ),
              child: Text(
                review.reply!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            )
          else
            SecondaryButton(
              label: strings.writeReply,
              expanded: false,
              height: 34,
              onPressed: () => _reply(context),
            ),
        ],
      ),
    );
  }

  Future<void> _reply(BuildContext context) async {
    final cubit = context.read<ReviewsInboxCubit>();

    // The controller belongs to the sheet, not to this method: disposing it
    // after `show()` resolves kills it while the sheet is still animating out.
    final text = await AppBottomSheet.show<String>(
      context,
      builder: (sheetContext) => TextControllerScope(
        count: 1,
        builder: (scopeContext, controllers) => AppBottomSheet(
          title: strings.writeReply,
          subtitle: strings.replyHint,
          actions: PrimaryButton(
            label: strings.sendReply,
            height: 46,
            // Nothing to reply with is not a reply.
            onPressed: controllers.first.text.trim().isEmpty
                ? null
                : () => Navigator.of(
                    scopeContext,
                  ).pop(controllers.first.text.trim()),
          ),
          child: AppTextField(
            controller: controllers.first,
            maxLines: 5,
            minLines: 3,
            hint: strings.replyHint,
          ),
        ),
      ),
    );

    if (text == null || text.isEmpty || !context.mounted) return;
    final ok = await cubit.reply(review.id, text);
    if (ok && context.mounted) {
      AppSnack.success(context, strings.replyPosted);
    }
  }
}
