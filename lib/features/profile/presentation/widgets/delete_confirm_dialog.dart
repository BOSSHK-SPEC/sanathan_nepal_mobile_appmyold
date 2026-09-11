import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../l10n/profile_strings.dart';

/// Confirmation dialog matching Figma "DELETE POPUP" (1517:4370 light /
/// 1517:4361 dark): trash icon, title, message, Cancel + Delete buttons.
class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog({
    required this.title,
    required this.message,
    super.key,
    this.confirmLabel,
    this.icon = Icons.delete_outline_rounded,
  });

  final String title;
  final String message;
  final String? confirmLabel;
  final IconData icon;

  /// Shows the dialog and resolves to `true` when confirmed.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    IconData icon = Icons.delete_outline_rounded,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        icon: icon,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ProfileStrings.of(context);
    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xxl,
          AppSpacing.xl,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.error.withValues(alpha: 0.12),
              ),
              child: Icon(icon, color: colors.error, size: 30),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: s.cancel,
                    height: 36,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PrimaryButton(
                    label: confirmLabel ?? s.delete,
                    height: 36,
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
