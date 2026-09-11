import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/entities/panchanga_detail.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';
import 'panchanga_table_widgets.dart';

/// Weekday + tithi banner row, the सूर्योदय/सूर्यास्त | चन्द्रोदय/चन्द्रास्त
/// grid, the centred "थप जानकारी" toggle and the day-level details block
/// (Figma "DINMAN DETAILS": दिनमान, उदयकालीन सूर्य/चन्द्रस्पष्ट, गति, वेलान्तर,
/// अहर्गण, अयनांश …).
class PanchangaSunMoonCard extends StatelessWidget {
  const PanchangaSunMoonCard({
    required this.panchanga,
    required this.expanded,
    required this.onToggle,
    super.key,
  });

  final Panchanga panchanga;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final devanagari = context.usesDevanagariDigits;
    final s = PanchangaStrings.of(context);
    final p = panchanga;
    final labelStyle = context.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w700,
    );
    final valueStyle = context.textTheme.labelSmall;
    Widget cell(String label, DateTime t) => Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 3,
        ),
        child: Row(
          children: [
            SizedBox(width: 62, child: Text(label, style: labelStyle)),
            Expanded(
              child: Text(
                PanchangaFormat.time(t, devanagari: devanagari),
                style: valueStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // "बिहीवार" | "फागुन शुक्ल पूर्णिमा"
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  s.weekdays[p.date.weekday % 7],
                  textAlign: TextAlign.center,
                  style: labelStyle,
                ),
              ),
              Expanded(
                child: Text(
                  p.tithiTitle(nepali: devanagari),
                  textAlign: TextAlign.center,
                  style: labelStyle,
                ),
              ),
            ],
          ),
        ),
        const PanchangaHairline(),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(children: [cell(s.sunrise, p.sunrise)]),
                    Row(children: [cell(s.sunset, p.sunset)]),
                  ],
                ),
              ),
              const PanchangaHairline(vertical: true),
              Expanded(
                child: Column(
                  children: [
                    Row(children: [cell(s.moonrise, p.moonrise)]),
                    Row(children: [cell(s.moonset, p.moonset)]),
                  ],
                ),
              ),
            ],
          ),
        ),
        const PanchangaHairline(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Center(
            child: MoreInfoButton(expanded: expanded, onTap: onToggle),
          ),
        ),
        PanchangaExpandable(
          expanded: expanded,
          child: _DayDetails(details: p.dayDetails),
        ),
      ],
    );
  }
}

/// Day-details block: first entry (दिनमान) full width, entries 2–5 as a
/// 2×2 grid (उदयकालीन सूर्य/चन्द्रस्पष्ट, सूर्य/चन्द्रस्पष्ट गति), the rest as
/// label | value rows.
class _DayDetails extends StatelessWidget {
  const _DayDetails({required this.details});
  final List<PanchangaDetail> details;

  @override
  Widget build(BuildContext context) {
    final devanagari = context.usesDevanagariDigits;
    final colors = context.colors;
    String value(PanchangaDetail d) =>
        PanchangaFormat.digits(d.value, devanagari: devanagari);
    final head = details.isEmpty ? null : details.first;
    final grid = details.length > 1 ? details.sublist(1, _min(5, details)) : [];
    final rows = details.length > 5 ? details.sublist(5) : <PanchangaDetail>[];
    Widget stat(PanchangaDetail d) => Column(
      children: [
        Text(
          d.label(nepali: devanagari),
          textAlign: TextAlign.center,
          style: context.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value(d),
          textAlign: TextAlign.center,
          style: context.textTheme.labelSmall,
        ),
      ],
    );
    return PanchangaSubTable(
      header: Column(
        children: [
          if (head != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: stat(head),
            ),
          if (grid.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.xs,
              ),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                border: Border.all(color: colors.border),
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < grid.length; i += 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Expanded(child: stat(grid[i])),
                          if (i + 1 < grid.length)
                            Expanded(child: stat(grid[i + 1]))
                          else
                            const Spacer(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
      rows: [for (final d in rows) (d.label(nepali: devanagari), value(d))],
    );
  }

  static int _min(int a, List<PanchangaDetail> l) =>
      a < l.length ? a : l.length;
}
