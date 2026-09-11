import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/event.dart';

/// Inline checklist of a to-do row (Figma "Group 35994"): small square
/// checkboxes with their labels flowing in a [Wrap]. Tapping an item toggles
/// it via [onToggle].
class ChecklistWrap extends StatelessWidget {
  const ChecklistWrap({
    required this.items,
    super.key,
    this.onToggle,
    this.maxItems,
  });

  final List<ChecklistItem> items;
  final ValueChanged<String>? onToggle;

  /// Show at most this many items (`null` = all).
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final shown = maxItems == null ? items : items.take(maxItems!).toList();
    final hidden = items.length - shown.length;
    return Wrap(
      spacing: 10,
      runSpacing: 4,
      children: [
        for (final item in shown)
          InkWell(
            onTap: onToggle == null ? null : () => onToggle!(item.id),
            borderRadius: BorderRadius.circular(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.isDone
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  size: 12,
                  color: item.isDone ? colors.accent : colors.textMuted,
                ),
                const SizedBox(width: 3),
                Text(
                  item.label,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    color: item.isDone ? colors.textMuted : colors.textPrimary,
                    decoration: item.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
        if (hidden > 0)
          Text(
            '+$hidden',
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 9,
              color: colors.accent,
            ),
          ),
      ],
    );
  }
}
