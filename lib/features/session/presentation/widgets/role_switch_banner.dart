import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/session/app_role.dart';
import '../../../../core/session/permission.dart';
import '../../../../core/session/session_scope.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../l10n/session_strings.dart';

/// The invitation to become an astrologer, on the seeker's Profile.
///
/// It sits directly under the profile header rather than inside the Links tab
/// — supply acquisition is the app's most valuable funnel and should not be
/// nine rows deep behind a tab.
///
/// It is an advertisement, so it disappears the moment it is answered: an
/// approved astrologer is not a candidate, and their Profile should read as a
/// seeker's. They reach their console from Profile › Links or the quick menu,
/// and leave it through "Switch to personal" in the console's own bar.
///
/// Reads through [SessionScope], the same split the rest of the app uses.
class RoleSwitchBanner extends StatelessWidget {
  const RoleSwitchBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Already an astrologer: nothing to offer them here.
    if (context.hasRole(AppRole.astrologer)) return const SizedBox.shrink();
    if (!context.can(Permission.applyAsAstrologer)) {
      return const SizedBox.shrink();
    }

    final colors = context.colors;
    final s = SessionStrings.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.sm,
      ),
      child: AppCard(
        color: colors.surface,
        border: Border.all(color: colors.accent.withValues(alpha: 0.5)),
        onTap: () => context.push(AppRoutes.astrologerApply),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.accent.withValues(alpha: 0.14),
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 21,
                color: colors.accent,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.becomeAstrologer, style: context.textTheme.titleSmall),
                  const SizedBox(height: 1),
                  Text(
                    s.becomeAstrologerBody,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.chevron_right_rounded, color: colors.accent),
          ],
        ),
      ),
    );
  }
}
