import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/business_profile.dart';
import '../cubit/business_profile_cubit.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';
import '../../../../core/widgets/rating_stars.dart';

/// "Reviews" tab: rating summary + distribution bars, review list and a
/// "write a review" form synced with the backend API.
class BusinessReviewsSection extends StatefulWidget {
  const BusinessReviewsSection({required this.business, super.key});
  final BusinessProfile business;

  @override
  State<BusinessReviewsSection> createState() => _BusinessReviewsSectionState();
}

class _BusinessReviewsSectionState extends State<BusinessReviewsSection> {
  int _myRating = 0;
  final _controller = TextEditingController();
  List<BusinessReview> get _reviews => widget.business.reviews;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_myRating == 0 || _controller.text.trim().isEmpty) return;
    final rating = _myRating;
    final text = _controller.text.trim();
    _controller.clear();
    setState(() => _myRating = 0);
    context.read<BusinessProfileCubit>().addReview(rating, text);
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final t = context.textTheme;
    final b = widget.business;
    final counts = List<int>.filled(5, 0);
    for (final r in _reviews) {
      counts[(r.rating.clamp(1, 5)) - 1]++;
    }
    final total = _reviews.isEmpty ? 1 : _reviews.length;

    return Column(
      children: [
        ProfileSectionCard(
          title: s.customerReviews,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    localizeDigits(context, b.rating.toStringAsFixed(1)),
                    style: t.displayMedium?.copyWith(color: colors.accent),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingStars(rating: b.rating, size: 16),
                        Text(
                          s.basedOnReviews(
                            localizeDigits(context, '${b.reviewCount}'),
                          ),
                          style: t.labelSmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        localizeDigits(context, '${b.recommendedPercent}%'),
                        style: t.headlineSmall?.copyWith(color: colors.success),
                      ),
                      Text(s.recommended, style: t.labelSmall),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              for (var star = 5; star >= 1; star--)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 14,
                        child: Text(
                          localizeDigits(context, '$star'),
                          style: t.labelSmall,
                        ),
                      ),
                      Icon(Icons.star_rounded, size: 12, color: colors.warning),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          child: LinearProgressIndicator(
                            value: counts[star - 1] / total,
                            minHeight: 8,
                            backgroundColor: colors.chipBackground,
                            color: colors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        ProfileSectionCard(
          title: s.writeReview,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(s.ratings, style: t.titleSmall),
                  const SizedBox(width: AppSpacing.md),
                  RatingStars(
                    rating: _myRating.toDouble(),
                    size: 24,
                    onChanged: (r) => setState(() => _myRating = r),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                controller: _controller,
                label: s.review,
                maxLines: 3,
                minLines: 2,
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(label: s.submit, height: 36, onPressed: _submit),
            ],
          ),
        ),
        if (_reviews.isEmpty)
          ProfileSectionCard(child: Text(s.noReviews, style: t.bodySmall))
        else
          for (final r in _reviews) _ReviewTile(review: r),
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});
  final BusinessReview review;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final t = context.textTheme;
    final d = review.date;
    final date = localizeDigits(
      context,
      '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}',
    );
    return ProfileSectionCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: colors.chipBackground,
            child: Text(
              review.author.isEmpty ? '?' : review.author[0],
              style: t.titleSmall?.copyWith(color: colors.accent),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.author,
                  style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    RatingStars(rating: review.rating.toDouble(), size: 12),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      date,
                      style: t.labelSmall?.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(review.text, style: t.bodySmall),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 14,
                      color: colors.iconMuted,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${s.helpful} (${localizeDigits(context, '${review.helpfulCount}')})',
                      style: t.labelSmall?.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
