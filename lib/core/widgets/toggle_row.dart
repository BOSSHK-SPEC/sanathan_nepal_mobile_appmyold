import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Label, optional note, and a switch.
///
/// A plain [Row] rather than a [SwitchListTile] on purpose: `ListTile`
/// asserts it has a [Material] ancestor to paint its ink on, and [AppCard] —
/// where these rows almost always live — is a decorated [Container].
class ToggleRow extends StatelessWidget {
  const ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
    this.note,
    this.enabled = true,
    this.trailing,
  });

  final String label;

  /// Explains what the switch does when the label alone cannot.
  final String? note;
  final bool value;
  final bool enabled;

  /// Shown between the text and the switch — a price, usually.
  final Widget? trailing;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: enabled ? colors.textPrimary : colors.textMuted,
                  ),
                ),
                if (note != null)
                  Text(
                    note!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null) ...[
            trailing!,
            const SizedBox(width: AppSpacing.sm),
          ],
          Switch(value: value, onChanged: enabled ? onChanged : null),
        ],
      ),
    );
  }
}
