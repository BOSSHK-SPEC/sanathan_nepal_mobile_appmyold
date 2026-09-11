import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/session/permission.dart';
import '../../../../core/session/session_scope.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../messaging/presentation/l10n/messaging_strings.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';

/// LINKS tab: "Useful Links" list (Help & Support, Terms & Conditions,
/// Privacy Policy), seller entry ("My Business / Become a Seller"), the
/// admin-only "Admin: Business approvals" row and Delete Account.
class ProfileLinksTab extends StatelessWidget {
  const ProfileLinksTab({
    required this.onDeleteAccount,
    super.key,
    this.isAdmin = false,
  });
  final VoidCallback onDeleteAccount;

  /// Shows the "Admin: Business approvals" row.
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    return ProfileSectionCard(
      title: s.usefulLinks,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Column(
        children: [
          _LinkRow(
            icon: Icons.forum_outlined,
            // The messaging feature owns this translation; duplicating it into
            // the profile strings would give the same row two spellings.
            label: MessagingStrings.of(context).messages,
            onTap: () => context.push(AppRoutes.messages),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.location_on_outlined,
            label: s.addresses,
            onTap: () => context.push(AppRoutes.addresses),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.lock_outline_rounded,
            label: s.security,
            onTap: () => context.push(AppRoutes.accountSecurity),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.privacy_tip_outlined,
            label: s.dataPrivacy,
            onTap: () => context.push(AppRoutes.accountPrivacy),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.star_outline_rounded,
            label: s.rateYourPurchases,
            onTap: () => context.push(AppRoutes.pendingReviews),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.bookmark_outline_rounded,
            label: s.savedProducts,
            onTap: () => context.push(AppRoutes.savedProducts),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.favorite_outline_rounded,
            label: s.followingAstrologers,
            onTap: () => context.push(AppRoutes.astrologersFollowing),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.card_giftcard_rounded,
            label: s.inviteFriends,
            onTap: () => context.push(AppRoutes.referral),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.support_agent_outlined,
            label: s.helpSupport,
            onTap: () => context.push(AppRoutes.supportTickets),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.description_outlined,
            label: s.termsConditions,
            onTap: () => context.push(AppRoutes.termsConditions),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.shield_outlined,
            label: s.privacyPolicy,
            onTap: () => context.push(AppRoutes.privacyPolicy),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.storefront_outlined,
            label: s.myBusiness,
            onTap: () => context.push(AppRoutes.myBusiness),
          ),
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.auto_awesome_outlined,
            label: context.can(Permission.viewAstrologerConsole)
                ? s.astrologerConsole
                : s.becomeAstrologer,
            onTap: () => context.push(
              // An approved astrologer wants the console; everyone else
              // wants the application.
              context.can(Permission.viewAstrologerConsole)
                  ? AppRoutes.astrologerHome
                  : AppRoutes.astrologerApply,
            ),
          ),
          if (isAdmin) ...[
            Divider(color: colors.divider),
            _LinkRow(
              icon: Icons.admin_panel_settings_outlined,
              label: s.adminBusinessApprovals,
              onTap: () => context.push(AppRoutes.adminBusinesses),
            ),
          ],
          Divider(color: colors.divider),
          _LinkRow(
            icon: Icons.delete_outline_rounded,
            label: s.deleteAccount,
            color: colors.error,
            onTap: onDeleteAccount,
          ),
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color ?? colors.icon),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: color ?? colors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 18,
              color: color ?? colors.iconMuted,
            ),
          ],
        ),
      ),
    );
  }
}
