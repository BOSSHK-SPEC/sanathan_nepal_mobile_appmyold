import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/user_profile.dart';
import '../l10n/profile_strings.dart';

/// Gradient header of the profile tab: bell/logout actions, avatar with edit
/// badge, name + verified badge, email, "Edit Profile" pill and the
/// "Complete Your Profile" ribbon.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    required this.onEdit,
    required this.onLogout,
    required this.onNotifications,
    super.key,
    this.onBack,
  });

  final UserProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onLogout;
  final VoidCallback onNotifications;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ProfileStrings.of(context);
    final onGradient = colors.onPrimary;
    return Container(
      decoration: BoxDecoration(gradient: colors.headerGradient),
      padding: EdgeInsets.only(top: context.padding.top),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (onBack != null)
                IconButton(
                  onPressed: onBack,
                  icon: Icon(Icons.arrow_back, color: onGradient),
                )
              else
                const SizedBox(width: AppSpacing.sm),
              const Spacer(),
              IconButton(
                tooltip: s.notifications,
                onPressed: onNotifications,
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: onGradient,
                  size: 20,
                ),
              ),
              IconButton(
                tooltip: s.logout,
                onPressed: onLogout,
                icon: Icon(Icons.logout_rounded, color: onGradient, size: 20),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Avatar(profile: profile, onEdit: onEdit),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              profile.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.headlineSmall?.copyWith(
                                color: onGradient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Tooltip(
                            message: profile.verified
                                ? s.verified
                                : s.notVerified,
                            child: Icon(
                              Icons.verified_rounded,
                              size: 16,
                              color: profile.verified
                                  ? colors.info
                                  : onGradient.withValues(alpha: 0.5),
                            ),
                          ),
                          if (!profile.isComplete) ...[
                            const SizedBox(width: 2),
                            Icon(
                              Icons.cancel_rounded,
                              size: 16,
                              color: colors.error,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        profile.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: onGradient.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _EditPill(label: s.editProfile, onTap: onEdit),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (!profile.isComplete)
            _CompleteRibbon(
              label: s.completeYourProfile,
              percent: profile.profileCompletion,
              onTap: onEdit,
            )
          else
            const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.profile, required this.onEdit});
  final UserProfile profile;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 84,
      height: 84,
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surface,
              border: Border.all(color: colors.onPrimary, width: 2),
            ),
            clipBehavior: Clip.antiAlias,
            child: profile.avatarUrl == null
                ? Icon(Icons.person, size: 44, color: colors.iconMuted)
                : AppImage(profile.avatarUrl!, width: 80, height: 80),
          ),
          Positioned(
            right: 0,
            bottom: 4,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surface,
                  border: Border.all(color: colors.accent),
                ),
                child: Icon(Icons.edit, size: 12, color: colors.accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditPill extends StatelessWidget {
  const _EditPill({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 3),
              Icon(Icons.edit_note_rounded, size: 12, color: colors.accent),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompleteRibbon extends StatelessWidget {
  const _CompleteRibbon({
    required this.label,
    required this.percent,
    required this.onTap,
  });
  final String label;
  final int percent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            gradient: colors.primaryGradient,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(AppRadius.pill),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            '$label · ${localizeDigits(context, '$percent')}%',
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
