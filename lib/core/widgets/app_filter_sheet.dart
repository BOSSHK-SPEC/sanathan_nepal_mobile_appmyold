import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';
import 'app_bottom_sheet.dart';
import 'primary_button.dart';

/// Filter sheet chrome: title, scrollable body of filter sections, a reset
/// action and a pinned apply button that reports the result count.
///
/// The sheet owns no filter state — the caller passes the current selection
/// down and receives changes back, so filters stay in the feature's cubit.
class AppFilterSheet extends StatelessWidget {
  const AppFilterSheet({
    required this.title,
    required this.applyLabel,
    required this.resetLabel,
    required this.onApply,
    required this.onReset,
    required this.children,
    super.key,
    this.canReset = true,
  });

  final String title;

  /// Already-composed, e.g. "Show 24 astrologers".
  final String applyLabel;
  final String resetLabel;
  final VoidCallback onApply;
  final VoidCallback onReset;
  final List<Widget> children;
  final bool canReset;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppBottomSheet(
      title: title,
      showClose: true,
      actions: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              label: resetLabel,
              onPressed: canReset ? onReset : null,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 2,
            child: PrimaryButton(label: applyLabel, onPressed: onApply),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Divider(
                height: AppSpacing.xxl,
                thickness: 1,
                color: colors.divider,
              ),
          ],
        ],
      ),
    );
  }
}

/// A titled block inside a filter sheet.
class FilterSection extends StatelessWidget {
  const FilterSection({
    required this.title,
    required this.child,
    super.key,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(child: Text(title, style: context.textTheme.titleSmall)),
          ?trailing,
        ],
      ),
      const SizedBox(height: AppSpacing.md),
      child,
    ],
  );
}

/// Wrapping chip group supporting single or multiple selection.
class FilterChipGroup<T> extends StatelessWidget {
  const FilterChipGroup({
    required this.options,
    required this.labelOf,
    required this.selected,
    required this.onChanged,
    super.key,
    this.multiSelect = true,
    this.iconOf,
  });

  final List<T> options;
  final String Function(T value) labelOf;
  final IconData? Function(T value)? iconOf;
  final Set<T> selected;

  /// Reports the full next selection, so the caller never mutates in place.
  final ValueChanged<Set<T>> onChanged;
  final bool multiSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        final icon = iconOf?.call(option);
        return GestureDetector(
          onTap: () {
            final next = multiSelect ? Set<T>.from(selected) : <T>{};
            if (multiSelect && isSelected) {
              next.remove(option);
            } else {
              next.add(option);
            }
            onChanged(next);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.accent.withValues(alpha: 0.12)
                  : colors.chipBackground,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: isSelected ? colors.accent : Colors.transparent,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 14,
                    color: isSelected ? colors.accent : colors.iconMuted,
                  ),
                  const SizedBox(width: AppSpacing.xs + 2),
                ],
                Text(
                  labelOf(option),
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: 14,
                    color: isSelected ? colors.accent : colors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Min–max slider with the current bounds rendered above it.
class FilterRange extends StatelessWidget {
  const FilterRange({
    required this.min,
    required this.max,
    required this.values,
    required this.onChanged,
    required this.labelBuilder,
    super.key,
    this.divisions,
  });

  final double min;
  final double max;
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;
  final String Function(double value) labelBuilder;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelBuilder(values.start),
              style: context.textTheme.titleSmall?.copyWith(
                color: colors.accent,
              ),
            ),
            Text(
              labelBuilder(values.end),
              style: context.textTheme.titleSmall?.copyWith(
                color: colors.accent,
              ),
            ),
          ],
        ),
        RangeSlider(
          min: min,
          max: max,
          values: values,
          divisions: divisions,
          activeColor: colors.accent,
          inactiveColor: colors.divider,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
