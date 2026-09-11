import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../l10n/session_strings.dart';

/// Shown when the active role cannot reach a screen.
///
/// Route guards normally redirect before this renders; this covers the cases
/// where a screen is reached and only part of it is gated.
class PermissionDeniedView extends StatelessWidget {
  const PermissionDeniedView({super.key, this.message, this.onSwitchRole});

  final String? message;

  /// Offers the role switcher when the user holds another role that would
  /// grant access.
  final VoidCallback? onSwitchRole;

  @override
  Widget build(BuildContext context) {
    final strings = SessionStrings.of(context);
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.textMuted.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                color: colors.textMuted,
                size: 26,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              strings.noAccessTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message ?? strings.noAccessMessage,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (onSwitchRole != null)
              PrimaryButton(
                label: strings.switchRole,
                onPressed: onSwitchRole,
                expanded: false,
              )
            else
              SecondaryButton(
                label: strings.goBack,
                expanded: false,
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go('/home'),
              ),
          ],
        ),
      ),
    );
  }
}
