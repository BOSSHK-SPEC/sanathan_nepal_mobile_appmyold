import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Row of small filter chips (Figma events filter bar:
/// "सबै | महत्वपुर्ण | सरकारी बिदा | हिन्दु चाड …").
///
/// * default – horizontally scrolling pill chips (Home events block);
/// * [wrap] – chips flow over several lines (events page: 2 rows);
/// * [boxed] – Figma events-page look: 8×8 indicator box + label instead of
///   an outlined pill.
class EventChipRow extends StatelessWidget {
  const EventChipRow({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
    this.padding = AppSpacing.page,
    this.trailing,
    this.wrap = false,
    this.boxed = false,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final EdgeInsets padding;

  /// Optional widget appended after the chips (e.g. "New Event +").
  final Widget? trailing;
  final bool wrap;
  final bool boxed;

  @override
  Widget build(BuildContext context) {
    final chips = [
      for (var i = 0; i < labels.length; i++)
        EventChip(
          label: labels[i],
          selected: i == selectedIndex,
          boxed: boxed,
          onTap: () => onChanged(i),
        ),
    ];
    if (wrap) {
      return Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Wrap(
                spacing: boxed ? AppSpacing.md : 6,
                runSpacing: boxed ? 6 : 4,
                children: chips,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.sm),
              trailing!,
            ],
          ],
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: [
          for (var i = 0; i < chips.length; i++) ...[
            chips[i],
            if (i != chips.length - 1) SizedBox(width: boxed ? 12 : 6),
          ],
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.md),
            trailing!,
          ],
        ],
      ),
    );
  }
}

/// A single filter chip – outlined/filled pill, or ([boxed]) a small
/// indicator square followed by the label.
class EventChip extends StatelessWidget {
  const EventChip({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
    this.color,
    this.boxed = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// Border/text colour override (e.g. holiday red / vrat green).
  final Color? color;
  final bool boxed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final c = color ?? colors.accent;
    if (boxed) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: selected ? c : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: selected ? c : colors.border),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall?.copyWith(
                  color: selected ? colors.textPrimary : colors.textSecondary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? c : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(color: selected ? c : colors.border),
        ),
        child: Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: selected
                ? colors.onChipSelected
                : (color ?? colors.textSecondary),
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
