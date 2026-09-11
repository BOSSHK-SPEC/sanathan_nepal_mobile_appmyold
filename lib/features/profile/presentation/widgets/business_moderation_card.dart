import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';

/// Status card shown above the business tabs.
///
/// * Owner variant – status chip (pending / approved / rejected), the admin's
///   rejection note and a short hint about editing.
/// * Admin variant – status chip plus Approve / Reject buttons while the
///   listing is pending (re-moderation of rejected listings is allowed).
class BusinessModerationCard extends StatelessWidget {
  const BusinessModerationCard.owner({required this.business, super.key})
    : onApprove = null,
      onReject = null;

  const BusinessModerationCard.admin({
    required this.business,
    required VoidCallback this.onApprove,
    required VoidCallback this.onReject,
    super.key,
  });

  final BusinessProfile business;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  bool get _isAdmin => onApprove != null;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final (label, color) = switch (business.status) {
      BusinessStatus.approved => (s.approved, colors.success),
      BusinessStatus.rejected => (s.rejected, colors.error),
      BusinessStatus.pending => (s.pendingApproval, colors.warning),
    };
    final showActions = _isAdmin && business.status != BusinessStatus.approved;
    return ProfileSectionCard(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        0,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      title: _isAdmin ? s.adminActions : s.statusLabel,
      trailing: Container(
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
          style: context.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (business.moderationNote.isNotEmpty) ...[
            Text(
              '${s.adminNote}: ${business.moderationNote}',
              style: context.textTheme.bodySmall?.copyWith(color: colors.error),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (!_isAdmin)
            Text(
              s.ownerHint,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          if (showActions)
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: s.reject,
                    height: 36,
                    onPressed: onReject,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PrimaryButton(
                    label: s.approve,
                    height: 36,
                    padding: EdgeInsets.zero,
                    onPressed: onApprove,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
