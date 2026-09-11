import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';
import 'status_chip.dart';

/// Consistent toast for action feedback.
///
/// Says what happened in the past tense ("Saved", "Appointment cancelled")
/// rather than what is happening.
abstract final class AppSnack {
  static void show(
    BuildContext context,
    String message, {
    StatusTone tone = StatusTone.neutral,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = context.colors;
    final accentFor = switch (tone) {
      StatusTone.neutral => colors.textPrimary,
      StatusTone.info => colors.info,
      StatusTone.success => colors.success,
      StatusTone.warning => colors.warning,
      StatusTone.danger => colors.error,
      StatusTone.accent => colors.accent,
    };
    final icon = switch (tone) {
      StatusTone.success => Icons.check_circle_outline_rounded,
      StatusTone.warning => Icons.warning_amber_rounded,
      StatusTone.danger => Icons.error_outline_rounded,
      StatusTone.info => Icons.info_outline_rounded,
      _ => null,
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          behavior: SnackBarBehavior.floating,
          backgroundColor: colors.surfaceElevated,
          elevation: 6,
          margin: const EdgeInsets.all(AppSpacing.pageGutter),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          content: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: accentFor),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Text(
                  message,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  textColor: colors.accent,
                  onPressed: onAction ?? () {},
                ),
        ),
      );
  }

  static void success(BuildContext context, String message) =>
      show(context, message, tone: StatusTone.success);

  static void error(BuildContext context, String message) =>
      show(context, message, tone: StatusTone.danger);
}
