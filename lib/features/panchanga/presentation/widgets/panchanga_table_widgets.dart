import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/panchanga_strings.dart';

/// Plain bold row label of the flat panchanga table (तिथि / नक्षत्र / …),
/// followed by a hairline separator (Figma "Line 16").
class PanchangaRowLabel extends StatelessWidget {
  const PanchangaRowLabel({required this.label, super.key, this.width = 66});
  final String label;
  final double width;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: width,
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const PanchangaHairline(vertical: true, length: 20),
      const SizedBox(width: AppSpacing.sm),
    ],
  );
}

/// Orange "थप जानकारी ⌄" toggle (chevron flips when expanded).
class MoreInfoButton extends StatelessWidget {
  const MoreInfoButton({
    required this.expanded,
    required this.onTap,
    super.key,
    this.compact = false,
  });
  final bool expanded;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = PanchangaStrings.of(context);
    return Semantics(
      button: true,
      label: expanded ? s.lessInfo : s.moreInfo,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? AppSpacing.sm : AppSpacing.md,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: colors.accent,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                s.moreInfo,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AnimatedRotation(
                turns: expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: colors.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 1 px divider line (horizontal by default) in the table's divider colour.
class PanchangaHairline extends StatelessWidget {
  const PanchangaHairline({super.key, this.vertical = false, this.length});
  final bool vertical;

  /// Extent along the line; null = fill the available space.
  final double? length;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.divider;
    return vertical
        ? Container(width: 1, height: length, color: color)
        : Container(height: 1, width: length, color: color);
  }
}

/// Two-column key/value table with alternating row tint and a vertical
/// hairline between the columns (every "थप जानकारी" expansion). An optional
/// centred [title] (e.g. the tithi name) sits above the rows.
class PanchangaSubTable extends StatelessWidget {
  const PanchangaSubTable({
    required this.rows,
    super.key,
    this.title,
    this.labelFlex = 4,
    this.header,
  });

  /// (label, value) pairs; values must already be localised.
  final List<(String, String)> rows;
  final String? title;
  final int labelFlex;

  /// Optional widget rendered above the rows (e.g. the दिनमान grid).
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      color: colors.surfaceVariant.withValues(alpha: 0.5),
      child: Column(
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Text(
                title!,
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ?header,
          for (var i = 0; i < rows.length; i++)
            Container(
              color: i.isEven ? colors.chipBackground : Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 3,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: labelFlex,
                    child: Text(
                      rows[i].$1,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  const PanchangaHairline(vertical: true, length: 16),
                  Expanded(
                    flex: 6,
                    child: Text(
                      rows[i].$2,
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Animated show/hide wrapper for expandable tables.
class PanchangaExpandable extends StatelessWidget {
  const PanchangaExpandable({
    required this.expanded,
    required this.child,
    super.key,
  });
  final bool expanded;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedSize(
    duration: const Duration(milliseconds: 200),
    alignment: Alignment.topCenter,
    child: expanded ? child : const SizedBox(width: double.infinity),
  );
}
