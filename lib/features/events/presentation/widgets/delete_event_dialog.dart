import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../l10n/events_strings.dart';

/// Figma "DELETE POPUP" – bin icon, question, note, Cancel / Delete buttons.
class DeleteEventDialog extends StatelessWidget {
  const DeleteEventDialog({super.key, this.title, this.message});

  final String? title;
  final String? message;

  /// Returns `true` when the user confirmed.
  static Future<bool> confirm(
    BuildContext context, {
    String? title,
    String? message,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteEventDialog(title: title, message: message),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xxl,
          AppSpacing.xxxl,
          AppSpacing.xxl,
          AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_outline, size: 32, color: colors.accent),
            const SizedBox(height: AppSpacing.md),
            Text(
              title ?? s.deleteTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message ?? s.deleteMessage,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,
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
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: PrimaryButton(
                    label: s.delete,
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
