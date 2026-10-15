import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/services/day_periods.dart';
import '../l10n/panchanga_strings.dart';
import 'day_period_row.dart';
import 'panchanga_format.dart';

/// Entry to the day-periods page from the panchanga screen.
///
/// It leads with what is running right now rather than with the word
/// "Choghadiya": someone checking the time of day wants the answer on the
/// screen they are already looking at, and the page behind this is for the
/// rest of the day.
class DayPeriodsLink extends StatelessWidget {
  const DayPeriodsLink({required this.panchanga, required this.now, super.key});

  final Panchanga panchanga;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;
    final s = PanchangaStrings.of(context);
    final devanagari = context.usesDevanagariDigits;
    // Only the daylight segments are known here; the night needs tomorrow's
    // sunrise, which the page behind this one loads.
    final current = DayPeriods.current(panchanga.choghadiya, now);
    final tint = current == null
        ? colors.primary
        : DayPeriodRow.qualityColor(colors, current.quality);

    return InkWell(
      onTap: () => context.push(
        '${AppRoutes.dayPeriods}?date='
        '${panchanga.date.toIso8601String().substring(0, 10)}',
      ),
      borderRadius: AppRadius.card,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 38,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.dayPeriods,
                    style: text.headlineSmall?.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  Text(
                    current == null
                        // Deliberately not naming the kaal windows: those are
                        // shown on the panchanga table in India only, and this
                        // link appears in every region.
                        ? '${s.choghadiya} · ${s.hora}'
                        : '${s.nowLabel}: '
                              '${current.name(nepali: context.isNepali || context.isHindi)} · '
                              '${s.until} '
                              '${PanchangaFormat.hm(current.end, devanagari: devanagari)}',
                    style: text.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.iconMuted),
          ],
        ),
      ),
    );
  }
}
