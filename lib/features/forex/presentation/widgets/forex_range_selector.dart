import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/forex_range.dart';
import '../l10n/forex_strings.dart';

/// "Select date range ▾" pill + "1 W / 1 M / 1 Y" text toggles + the
/// buying / selling legend (Figma trend header row).
class ForexRangeSelector extends StatelessWidget {
  const ForexRangeSelector({
    required this.range,
    required this.onChanged,
    super.key,
  });

  final ForexRange range;
  final ValueChanged<ForexRange> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ForexStrings.of(context);
    String label(ForexRange r) => switch (r) {
      ForexRange.week => s.oneWeek,
      ForexRange.month => s.oneMonth,
      ForexRange.year => s.oneYear,
    };
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: PopupMenuButton<ForexRange>(
            onSelected: onChanged,
            initialValue: range,
            itemBuilder: (_) => [
              for (final r in ForexRange.values)
                PopupMenuItem(value: r, child: Text(label(r))),
            ],
            child: Container(
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              decoration: BoxDecoration(
                border: Border.all(color: colors.border),
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      s.selectDateRange,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 12,
                    color: colors.iconMuted,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        for (final r in ForexRange.values)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(r),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: Text(
                label(r),
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: r == range ? FontWeight.w700 : FontWeight.w400,
                  color: r == range ? colors.accent : colors.textSecondary,
                ),
              ),
            ),
          ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: _Legend(color: colors.error, label: s.buying),
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: _Legend(color: colors.info, label: s.selling),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
      const SizedBox(width: 3),
      Flexible(
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelSmall?.copyWith(fontSize: 9),
        ),
      ),
    ],
  );
}
