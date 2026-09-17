import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/day_panchanga.dart';
import '../l10n/calendar_strings.dart';
import 'vrat_marker.dart';

/// Key to the month grid's marks: today's box, holiday colour, event dot and
/// the three vrat markers.
class PatroLegend extends StatelessWidget {
  const PatroLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = CalendarStrings.of(context);
    final style = context.textTheme.labelSmall?.copyWith(
      fontSize: 10,
      color: colors.textSecondary,
    );
    Widget item(Widget mark, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [mark, const SizedBox(width: 4), Text(label, style: style)],
    );

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.xs,
      children: [
        item(
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: colors.today,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          strings.today,
        ),
        item(
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: colors.holiday,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          strings.holiday,
        ),
        item(
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: colors.textPrimary,
              shape: BoxShape.circle,
            ),
          ),
          strings.legendEvent,
        ),
        for (final kind in VratKind.values)
          item(VratMarker(kind: kind, size: 8), strings.vrat(kind)),
      ],
    );
  }
}
