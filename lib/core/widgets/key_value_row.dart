import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Label on the left, value on the right — the row that every summary,
/// ledger entry, order total and chart table is built from.
class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    required this.label,
    super.key,
    this.value,
    this.valueWidget,
    this.emphasised = false,
    this.labelStyle,
    this.valueStyle,
    this.padding = const EdgeInsets.symmetric(vertical: AppSpacing.xs + 2),
    this.icon,
  }) : assert(
         value != null || valueWidget != null,
         'Provide either value or valueWidget',
       );

  final String label;
  final String? value;

  /// Use instead of [value] for chips, money, links.
  final Widget? valueWidget;

  /// Bolder type and primary colour — for totals and final amounts.
  final bool emphasised;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final EdgeInsets padding;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: colors.iconMuted),
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(
            child: Text(
              label,
              style:
                  labelStyle ??
                  context.textTheme.bodyMedium?.copyWith(
                    color: emphasised ? colors.textPrimary : colors.textMuted,
                    fontWeight: emphasised ? FontWeight.w600 : null,
                  ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child:
                  valueWidget ??
                  Text(
                    value!,
                    textAlign: TextAlign.right,
                    style:
                        valueStyle ??
                        context.textTheme.bodyMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: emphasised
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Vertically stacked [KeyValueRow]s with hairline dividers.
class KeyValueList extends StatelessWidget {
  const KeyValueList({required this.children, super.key, this.divided = false});

  final List<Widget> children;
  final bool divided;

  @override
  Widget build(BuildContext context) {
    if (!divided) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          children[i],
          if (i != children.length - 1)
            Divider(height: 1, thickness: 1, color: colors.divider),
        ],
      ],
    );
  }
}
