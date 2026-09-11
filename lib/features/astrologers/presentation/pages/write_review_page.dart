import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/write_review_cubit.dart';
import '../l10n/astrologers_strings.dart';

/// Star rating, tags and an optional comment.
///
/// The comment is optional on purpose: requiring prose collapses review
/// volume, and a bare star rating is still signal.
class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({
    required this.astrologerId,
    super.key,
    this.consultationId,
  });

  final String astrologerId;
  final String? consultationId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        GetIt.I<WriteReviewCubit>(param1: astrologerId, param2: consultationId),
    child: const _WriteReviewView(),
  );
}

class _WriteReviewView extends StatefulWidget {
  const _WriteReviewView();

  @override
  State<_WriteReviewView> createState() => _WriteReviewViewState();
}

class _WriteReviewViewState extends State<_WriteReviewView> {
  final TextEditingController _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<WriteReviewCubit, WriteReviewState>(
      listenWhen: (p, n) => p.submission != n.submission,
      listener: (context, state) {
        if (state.isSubmitted) {
          AppSnack.success(context, s.reviewThanksMessage);
          // A shared review link opens this route directly, where there is
          // nothing to pop back to.
          if (context.canPop()) {
            context.pop(true);
          } else {
            context.go(AppRoutes.astrologers);
          }
        } else if (state.submission.isFailed) {
          AppSnack.error(
            context,
            state.submission.errorMessage ?? context.l10n.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<WriteReviewCubit>();

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.writeReview, showBack: true),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                AppCard(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.xl,
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      Text(
                        s.rateYourExperience,
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Center(
                        child: RatingStars(
                          rating: state.rating.toDouble(),
                          size: 40,
                          spacing: 6,
                          onChanged: cubit.setRating,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        state.rating == 0 ? s.tapAStar : '',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(s.whatStoodOut, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final tag in WriteReviewCubit.tagKeys)
                      _TagChip(
                        label: s.reviewTag(tag),
                        selected: state.tags.contains(tag),
                        onTap: () => cubit.toggleTag(tag),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _comment,
                  label: s.commentOptional,
                  hint: s.commentHint,
                  maxLines: 6,
                  minLines: 4,
                  onChanged: cubit.setComment,
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: s.submitReview,
                  height: 46,
                  isLoading: state.submission.isLoading,
                  onPressed: state.canSubmit ? cubit.submit : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.12)
              : colors.chipBackground,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? colors.accent : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            fontSize: 14,
            color: selected ? colors.accent : colors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
