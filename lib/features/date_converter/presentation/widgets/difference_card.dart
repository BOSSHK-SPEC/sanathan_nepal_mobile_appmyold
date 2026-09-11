import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/presentation/utils/calendar_format.dart';
import '../../domain/entities/converted_date.dart';
import '../l10n/date_converter_strings.dart';

/// "आजसँगको अन्तर" – signed day difference and a y/m/d age breakdown.
class DifferenceCard extends StatelessWidget {
  const DifferenceCard({required this.result, super.key});

  final ConvertedDate result;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final devanagari = context.usesDevanagariDigits;
    final strings = DateConverterStrings.of(context);
    final days = result.daysFromToday;
    final age = result.ageBreakdown;
    final String diffText;
    if (days == 0) {
      diffText = strings.isToday;
    } else if (days < 0) {
      diffText =
          '${CalendarFormat.digits(-days, devanagari: devanagari)} ${strings.daysAgo}';
    } else {
      diffText =
          '${CalendarFormat.digits(days, devanagari: devanagari)} ${strings.daysAhead}';
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.difference, style: context.textTheme.labelSmall),
                const SizedBox(height: 2),
                Text(diffText, style: context.textTheme.titleSmall),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.age, style: context.textTheme.labelSmall),
                const SizedBox(height: 2),
                Text(
                  '${CalendarFormat.digits(age.years, devanagari: devanagari)} '
                  '${strings.years}, '
                  '${CalendarFormat.digits(age.months, devanagari: devanagari)} '
                  '${strings.months}, '
                  '${CalendarFormat.digits(age.days, devanagari: devanagari)} '
                  '${strings.days}',
                  style: context.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
