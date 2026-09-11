import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/product_review.dart';
import '../cubit/product_reviews_cubit.dart';
import '../l10n/marketplace_strings.dart';

/// The seller's one public answer to a review.
///
/// A sheet over the list rather than a route, so the review being answered
/// stays visible behind it.
class ReviewReplySheet extends StatefulWidget {
  const ReviewReplySheet({required this.review, super.key});

  final ProductReview review;

  static Future<void> show(
    BuildContext context, {
    required ProductReview review,
  }) {
    final cubit = context.read<ProductReviewsCubit>();
    return AppBottomSheet.show<void>(
      context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: ReviewReplySheet(review: review),
      ),
    );
  }

  @override
  State<ReviewReplySheet> createState() => _ReviewReplySheetState();
}

class _ReviewReplySheetState extends State<ReviewReplySheet> {
  final _reply = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final s = MarketplaceStrings.of(context);
    final cubit = context.read<ProductReviewsCubit>();
    setState(() => _sending = true);
    final ok = await cubit.reply(widget.review.id, _reply.text);
    if (!mounted) return;
    setState(() => _sending = false);
    if (!ok) return;
    Navigator.of(context).pop();
    AppSnack.show(context, s.replySent);
  }

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return AppBottomSheet(
      title: s.replyToReview,
      subtitle: widget.review.authorName,
      actions: PrimaryButton(
        label: s.sendReply,
        isLoading: _sending,
        onPressed: _reply.text.trim().isEmpty || _sending ? null : _send,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.review.comment.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                widget.review.comment,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _reply,
            hint: s.replyHint,
            maxLines: 4,
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }
}
