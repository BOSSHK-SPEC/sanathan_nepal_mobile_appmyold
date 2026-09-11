import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';
import '../../../../core/widgets/rating_stars.dart';
import 'small_gradient_button.dart';

/// Row of the admin "Business approvals" list: logo, name, category,
/// rating, status chip and quick Approve / Reject actions (pending only).
class AdminBusinessTile extends StatelessWidget {
  const AdminBusinessTile({
    required this.business,
    required this.onTap,
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  final BusinessProfile business;
  final VoidCallback onTap;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final t = context.textTheme;
    final b = business;
    final (label, color) = switch (b.status) {
      BusinessStatus.approved => (s.approved, colors.success),
      BusinessStatus.rejected => (s.rejected, colors.error),
      BusinessStatus.pending => (s.pendingApproval, colors.warning),
    };
    return ProfileSectionCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: colors.border),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: b.logoUrl == null
                      ? Icon(Icons.storefront_outlined, color: colors.iconMuted)
                      : AppImage(b.logoUrl!, width: 48, height: 48),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        b.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: t.labelSmall?.copyWith(color: colors.textMuted),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          RatingStars(rating: b.rating, size: 12),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            localizeDigits(context, '(${b.reviewCount})'),
                            style: t.labelSmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                  child: Text(
                    label,
                    style: t.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (b.moderationNote.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${s.adminNote}: ${b.moderationNote}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: t.labelSmall?.copyWith(color: colors.error),
              ),
            ],
            if (b.status == BusinessStatus.pending) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallGradientButton(
                    label: s.reject,
                    outlined: true,
                    height: 26,
                    onPressed: onReject,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  SmallGradientButton(
                    label: s.approve,
                    height: 26,
                    onPressed: onApprove,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
