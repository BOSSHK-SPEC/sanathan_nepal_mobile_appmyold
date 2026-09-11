import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/session/app_role.dart';
import '../../../../core/session/app_session.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/session_cubit.dart';
import '../l10n/session_strings.dart';

/// Lets a multi-role account choose which side of the app to use.
///
/// Only offered when [AppSession.canSwitchRole] — a seeker-only account
/// never sees it.
class RoleSwitcherSheet extends StatelessWidget {
  const RoleSwitcherSheet({super.key});

  static Future<void> show(BuildContext context) => AppBottomSheet.show<void>(
    context,
    builder: (_) => BlocProvider<SessionCubit>.value(
      value: context.read<SessionCubit>(),
      child: const RoleSwitcherSheet(),
    ),
  );

  IconData _iconFor(AppRole role) => switch (role) {
    AppRole.seeker => Icons.person_outline_rounded,
    AppRole.astrologer => Icons.auto_awesome_outlined,
    AppRole.merchant => Icons.storefront_outlined,
    AppRole.moderator => Icons.shield_outlined,
    AppRole.finance => Icons.account_balance_outlined,
    AppRole.support => Icons.support_agent_outlined,
    AppRole.superAdmin => Icons.admin_panel_settings_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final strings = SessionStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<SessionCubit, AppSession>(
      builder: (context, session) {
        final roles = session.switchableRoles;
        final active = session.effectiveRole;

        return AppBottomSheet(
          title: strings.switchRole,
          subtitle: strings.switchRoleSubtitle,
          scrollable: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final role in roles)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    elevated: false,
                    color: role == active
                        ? colors.accent.withValues(alpha: 0.08)
                        : colors.surfaceVariant,
                    border: Border.all(
                      color: role == active
                          ? colors.accent
                          : Colors.transparent,
                    ),
                    onTap: () {
                      context.read<SessionCubit>().switchRole(role);
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.surface,
                          ),
                          child: Icon(
                            _iconFor(role),
                            size: 19,
                            color: role == active
                                ? colors.accent
                                : colors.iconMuted,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                strings.roleName(role),
                                style: context.textTheme.titleSmall,
                              ),
                              const SizedBox(height: 1),
                              Text(
                                strings.roleDescription(role),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (role == active)
                          Icon(
                            Icons.check_circle_rounded,
                            size: 20,
                            color: colors.accent,
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
