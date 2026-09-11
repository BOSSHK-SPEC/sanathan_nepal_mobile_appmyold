import '../../../../core/media/media_bucket.dart';
import '../../../../core/media/media_upload_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/write_product_review_cubit.dart';
import '../l10n/marketplace_strings.dart';

/// Rating and written review for one product.
class WriteProductReviewPage extends StatelessWidget {
  const WriteProductReviewPage({
    required this.productId,
    super.key,
    this.orderId,
  });

  final String productId;

  /// Set when the review is written from a delivered order — that is what
  /// makes it a verified purchase.
  final String? orderId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        sl<WriteProductReviewCubit>(param1: productId, param2: orderId),
    child: const WriteProductReviewView(),
  );
}

/// Widget-testable body of [WriteProductReviewPage].
class WriteProductReviewView extends StatefulWidget {
  const WriteProductReviewView({super.key});

  @override
  State<WriteProductReviewView> createState() => _WriteProductReviewViewState();
}

class _WriteProductReviewViewState extends State<WriteProductReviewView> {
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final s = MarketplaceStrings.of(context);
    final cubit = context.read<WriteProductReviewCubit>();
    final ok = await cubit.submit();
    if (!mounted) return;
    if (!ok) {
      AppSnack.error(context, cubit.state.submitError ?? s.submitReview);
      return;
    }
    AppSnack.show(context, s.reviewThanks);
    // Deep-linked from an order or a notification there may be nothing to
    // pop back to.
    context.canPop() ? context.pop() : context.go(AppRoutes.marketplace);
  }

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<WriteProductReviewCubit, WriteProductReviewState>(
      builder: (context, state) {
        final cubit = context.read<WriteProductReviewCubit>();
        final draft = state.draft;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.writeReview, showBack: true),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Text(s.rateThisProduct, style: context.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.lg),
                Center(
                  child: RatingStars(
                    rating: draft.rating.toDouble(),
                    size: 40,
                    spacing: AppSpacing.sm,
                    onChanged: cubit.setRating,
                  ),
                ),
                if (draft.rating > 0) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Center(
                    child: Text(
                      s.starsLabel(draft.rating),
                      style: context.textTheme.labelMedium?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                AppTextField(
                  controller: _comment,
                  hint: s.reviewCommentHint,
                  maxLines: 5,
                  onChanged: cubit.setComment,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(s.addPhotos, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final photo in draft.photos)
                      _PhotoChip(onRemove: () => cubit.removePhoto(photo)),
                    _AddPhotoTile(
                      onTap: () async {
                        // A review photo is shown to every shopper reading the
                        // review, so it is public and stored as a URL.
                        final uploaded = await pickAndUploadMedia(
                          context,
                          bucket: MediaBucket.publicCatalog,
                          title: s.addPhotos,
                        );
                        if (uploaded != null) cubit.addPhoto(uploaded.url);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: s.submitReview,
                  isLoading: state.isSubmitting,
                  // A star is the whole requirement; demanding prose is how
                  // review prompts get abandoned.
                  onPressed: state.canSubmit ? _submit : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PhotoChip extends StatelessWidget {
  const _PhotoChip({required this.onRemove});

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Stack(
      children: [
        Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(Icons.photo_outlined, size: 22, color: colors.textMuted),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close_rounded, size: 14, color: colors.error),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        height: 68,
        width: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: colors.border),
        ),
        child: Icon(
          Icons.add_a_photo_outlined,
          size: 20,
          color: colors.textMuted,
        ),
      ),
    );
  }
}
