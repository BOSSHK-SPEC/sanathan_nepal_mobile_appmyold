import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Horizontal pill/underline tab selector used in horoscope
/// (दैनिक / साप्ताहिक / मासिक / वार्षिक), events, profile etc.
class PillTabs extends StatelessWidget {
  const PillTabs({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
    this.filled = true,
    this.scrollable = false,
    this.padding = EdgeInsets.zero,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool filled;
  final bool scrollable;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final children = List.generate(labels.length, (i) {
      final selected = i == selectedIndex;
      final chip = AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: filled && selected ? colors.chipSelected : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: !filled && selected
              ? Border(bottom: BorderSide(color: colors.accent, width: 2))
              : null,
        ),
        child: Text(
          labels[i],
          style: context.textTheme.labelLarge?.copyWith(
            color: selected
                ? (filled ? colors.onChipSelected : colors.accent)
                : colors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      );
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(i),
        child: Padding(
          padding: EdgeInsets.only(right: i == labels.length - 1 ? 0 : 6),
          child: chip,
        ),
      );
    });
    if (scrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: padding,
        child: Row(children: children),
      );
    }
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
