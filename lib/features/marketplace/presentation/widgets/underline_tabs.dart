import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// One entry of [UnderlineTabs].
class UnderlineTab {
  const UnderlineTab(this.label, {this.icon});
  final String label;
  final Widget? icon;
}

/// Text tabs with a 1px underline under the selected one
/// (Figma "Boosted Post | Boost Post to sell quickly | My Products…").
class UnderlineTabs extends StatelessWidget {
  const UnderlineTabs({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
    this.scrollable = true,
    this.padding = AppSpacing.page,
    this.spacing = AppSpacing.md,
  });

  final List<UnderlineTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool scrollable;
  final EdgeInsets padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final children = <Widget>[
      for (var i = 0; i < tabs.length; i++) ...[
        if (i > 0) SizedBox(width: spacing),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(i),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (tabs[i].icon != null) ...[
                      tabs[i].icon!,
                      const SizedBox(width: AppSpacing.xs),
                    ],
                    Text(
                      tabs[i].label,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: i == selectedIndex
                            ? colors.textPrimary
                            : colors.textSecondary,
                        fontWeight: i == selectedIndex
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Container(
                  height: 1.5,
                  color: i == selectedIndex ? colors.accent : colors.divider,
                ),
              ],
            ),
          ),
        ),
      ],
    ];
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: children,
    );
    if (!scrollable) return Padding(padding: padding, child: row);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: row,
    );
  }
}
