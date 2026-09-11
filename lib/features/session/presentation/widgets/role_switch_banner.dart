import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/session/app_role.dart';
import '../../../../core/session/permission.dart';
import '../../../../core/session/session_scope.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/session_cubit.dart';
import '../l10n/session_strings.dart';

/// The astrologer entry point on the seeker's Profile.
///
/// Two states, because the same slot answers two different questions:
/// an approved astrologer wants to *switch*, and everyone else wants to know
/// this side of the app exists at all. It sits directly under the profile
/// header rather than inside the Links tab — supply acquisition is the app's
/// most valuable funnel and should not be nine rows deep behind a tab.
///
/// Reads through [SessionScope] and writes through [SessionCubit], the same
/// split the rest of the app uses.
class RoleSwitchBanner extends StatelessWidget {
  const RoleSwitchBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isAstrologer = context.hasRole(AppRole.astrologer);
    final canApply = context.can(Permission.applyAsAstrologer);
    if (!isAstrologer && !canApply) return const SizedBox.shrink();

    final colors = context.colors;
    final s = SessionStrings.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.sm,
      ),
      child: AppCard(
        gradient: isAstrologer ? colors.cardGradient : null,
        color: isAstrologer ? null : colors.surface,
        border: isAstrologer
            ? null
            : Border.all(color: colors.accent.withValues(alpha: 0.5)),
        onTap: () {
          if (isAstrologer) {
            context.read<SessionCubit>().switchRole(AppRole.astrologer);
            context.go(AppRoutes.astrologerHome);
          } else {
            context.push(AppRoutes.astrologerApply);
          }
        },
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
                  Text(
                    isAstrologer
                        ? s.roleName(AppRole.astrologer)
                        : s.becomeAstrologer,
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    isAstrologer
                        ? s.roleDescription(AppRole.astrologer)
                        : s.becomeAstrologerBody,
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
            Icon(
              isAstrologer
                  ? Icons.swap_horiz_rounded
                  : Icons.chevron_right_rounded,
              color: colors.accent,
            ),
          ],
        ),
      ),
    );
  }
}
