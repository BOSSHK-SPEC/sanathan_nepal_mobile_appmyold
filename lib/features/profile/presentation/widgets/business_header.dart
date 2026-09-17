import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';
import '../../../../core/widgets/rating_stars.dart';
import 'small_gradient_button.dart';

/// Cover + logo + name/category/rating block and Follow / Message actions
/// of the business profile page, with the admin status pill.
class BusinessHeader extends StatelessWidget {
  /// How far the logo hangs below the banner.
  static const double _logoOverhang = 32;

  const BusinessHeader({
    required this.business,
    required this.isFollowing,
    required this.onFollow,
    required this.onMessage,
    this.showMessage = true,
    super.key,
    this.onEdit,
    this.onChangeCover,
    this.onChangeLogo,
  });

  final BusinessProfile business;
  final bool isFollowing;
  final VoidCallback onFollow;
  final VoidCallback onMessage;

  /// Hidden for the owner and for an admin reviewing the listing: the server
  /// refuses a shop messaging itself, so offering the button would only ever
  /// produce an error.
  final bool showMessage;

  /// Opens the edit form (pencil beside the name) – hidden when `null`.
  final VoidCallback? onEdit;

  /// Owner only: change or remove the banner / logo. Hidden when `null`.
  /// The camera used to open the whole edit form, which had no picture
  /// fields at all — so neither picture could ever be set.
  final VoidCallback? onChangeCover;
  final VoidCallback? onChangeLogo;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ProfileStrings.of(context);
    final t = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // The logo hangs below the banner. Flutter only delivers taps
            // inside a widget's own bounds, so the overhang is part of the
            // Stack — otherwise the logo's camera is drawn but cannot be
            // pressed.
            Padding(
              padding: const EdgeInsets.only(bottom: _logoOverhang),
              child: Container(
                height: 137,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: business.coverUrl == null
                      ? colors.cardGradient
                      : null,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: colors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: business.coverUrl == null
                    ? Center(
                        child: Icon(
                          Icons.storefront_outlined,
                          size: 40,
                          color: colors.iconMuted,
                        ),
                      )
                    : AppImage(business.coverUrl!, fit: BoxFit.cover),
              ),
            ),
            if (onChangeCover != null)
              Positioned(
                right: AppSpacing.xxl,
                top: AppSpacing.sm,
                child: Semantics(
                  button: true,
                  label: s.changeBanner,
                  child: _RoundIcon(
                    icon: Icons.photo_camera_outlined,
                    onTap: onChangeCover!,
                  ),
                ),
              ),
            Positioned(
              left: AppSpacing.xxl,
              bottom: _logoOverhang - 28,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surface,
                  border: Border.all(color: colors.background, width: 3),
                ),
                clipBehavior: Clip.antiAlias,
                child: business.logoUrl == null
                    ? Icon(Icons.business, color: colors.accent, size: 28)
                    : AppImage(business.logoUrl!),
              ),
            ),
            if (onChangeLogo != null)
              Positioned(
                left: AppSpacing.xxl + 42,
                bottom: 0,
                child: Semantics(
                  button: true,
                  label: s.changeLogo,
                  child: _RoundIcon(
                    icon: Icons.photo_camera_outlined,
                    onTap: onChangeLogo!,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxxl - _logoOverhang),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            business.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: t.headlineMedium,
                          ),
                        ),
                        if (business.verified) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Icon(
                            Icons.verified_rounded,
                            size: 18,
                            color: colors.info,
                          ),
                        ],
                        if (onEdit != null) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Semantics(
                            button: true,
                            label: s.editBusiness,
                            child: GestureDetector(
                              onTap: onEdit,
                              child: Icon(
                                Icons.edit_outlined,
                                size: 15,
                                color: colors.accent,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      business.category,
                      style: t.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        RatingStars(rating: business.rating, size: 14),
                        const SizedBox(width: AppSpacing.xs),
                        Flexible(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            localizeDigits(
                              context,
                              '${business.rating.toStringAsFixed(1)} · '
                              '${business.reviewCount} ${s.reviews}',
                            ),
                            style: t.labelSmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _StatusPill(status: business.status),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SmallGradientButton(
                    label: isFollowing ? s.following : s.follow,
                    icon: isFollowing ? Icons.check : Icons.add,
                    height: 26,
                    outlined: isFollowing,
                    onPressed: onFollow,
                  ),
                  if (showMessage) ...[
                    const SizedBox(height: AppSpacing.xs),
                    SmallGradientButton(
                      label: s.message,
                      icon: Icons.mail_outline_rounded,
                      height: 26,
                      outlined: true,
                      onPressed: onMessage,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final BusinessStatus status;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final (label, color) = switch (status) {
      BusinessStatus.approved => (s.approved, colors.success),
      BusinessStatus.rejected => (s.rejected, colors.error),
      BusinessStatus.pending => (s.pendingApproval, colors.warning),
    };
    return Container(
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
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: context.colors.surface.withValues(alpha: 0.9),
    shape: const CircleBorder(),
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(icon, size: 16, color: context.colors.accent),
      ),
    ),
  );
}
