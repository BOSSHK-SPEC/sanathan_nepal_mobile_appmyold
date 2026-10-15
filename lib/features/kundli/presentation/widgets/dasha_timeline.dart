import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/dasha.dart';
import '../l10n/kundli_strings.dart';

/// The whole Vimshottari cycle drawn to scale: one hundred and twenty years
/// across the width, each mahadasha as wide as it is long.
///
/// The list of periods below it gives the dates; this gives the shape of a
/// life — that Shukra runs for twenty years and Surya for six, and where today
/// falls among them. Colour carries only past, present and future, so the bar
/// stays in the app's palette instead of turning into nine arbitrary hues.
class DashaTimeline extends StatelessWidget {
  const DashaTimeline({
    required this.periods,
    required this.now,
    super.key,
    this.height = 34,
  });

  final List<DashaPeriod> periods;
  final DateTime now;
  final double height;

  /// Ages the axis is labelled with: five evenly spaced points across the run
  /// the chart actually covers, rounded to whole years.
  @visibleForTesting
  static List<int> ageTicks(List<DashaPeriod> periods, {int count = 5}) {
    if (periods.isEmpty || count < 2) return const [];
    final years =
        periods.last.end.difference(periods.first.start).inDays / 365.25;
    return [
      for (var i = 0; i < count; i++)
        (years * i / (count - 1)).round(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;
    final s = KundliStrings.of(context);
    if (periods.isEmpty) return const SizedBox.shrink();

    final start = periods.first.start;
    final end = periods.last.end;
    final span = end.difference(start).inSeconds;
    if (span <= 0) return const SizedBox.shrink();

    // Where today sits in the whole run, 0–1. Outside it (a chart cast for an
    // unborn or very old date) there is simply no marker.
    final elapsed = now.difference(start).inSeconds / span;
    final marker = elapsed >= 0 && elapsed <= 1 ? elapsed : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: Row(
                      children: [
                        for (final p in periods)
                          Expanded(
                            flex: p.length.inDays,
                            child: _Segment(
                              period: p,
                              now: now,
                              // A label needs room; the six-year periods have
                              // none, and a clipped "Su" is worse than a
                              // colour the legend explains.
                              showLabel:
                                  width * p.length.inDays / span * 86400 > 26,
                              strings: s,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (marker != null)
                    Positioned(
                      left: (width * marker).clamp(0.0, width - 2),
                      top: -3,
                      bottom: -3,
                      child: Container(width: 2, color: colors.textPrimary),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            // The axis is in years of age, which is how a dasha is talked
            // about. It is NOT 0–120: a chart begins part-way through its
            // first mahadasha, so the run from birth is the balance of that
            // one plus the rest — always short of the full cycle.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final age in ageTicks(periods))
                  Text(
                    '$age',
                    style: text.labelSmall?.copyWith(color: colors.textMuted),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.period,
    required this.now,
    required this.showLabel,
    required this.strings,
  });

  final DashaPeriod period;
  final DateTime now;
  final bool showLabel;
  final KundliStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isCurrent = period.isCurrent(now: now);
    final isPast = period.isPast(now: now);
    final fill = isCurrent
        ? colors.accent
        : isPast
        ? colors.textMuted.withValues(alpha: 0.35)
        : colors.chipBackground;

    return Semantics(
      label: '${strings.grahaName(period.graha)} '
          '${period.start.year}–${period.end.year}',
      selected: isCurrent,
      child: Container(
        decoration: BoxDecoration(
          color: fill,
          border: Border(
            right: BorderSide(color: colors.surface, width: 1),
          ),
        ),
        alignment: Alignment.center,
        child: showLabel
            ? Text(
                strings.grahaShort(period.graha),
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: context.textTheme.labelSmall?.copyWith(
                  color: isCurrent ? colors.onPrimary : colors.textSecondary,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                ),
              )
            : null,
      ),
    );
  }
}
