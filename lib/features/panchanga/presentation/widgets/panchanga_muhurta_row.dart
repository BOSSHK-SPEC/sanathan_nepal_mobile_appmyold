import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/entities/time_window.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';
import 'panchanga_table_widgets.dart';

/// India-only row of the panchanga table: Rahu Kaal / Yamaganda / Gulika Kaal
/// / Abhijit Muhurat summary with the expandable Choghadiya table.
class PanchangaMuhurtaRow extends StatelessWidget {
  const PanchangaMuhurtaRow({
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
    final colors = context.colors;
    final devanagari = context.usesDevanagariDigits;
    final s = PanchangaStrings.of(context);
    final p = panchanga;
    final windows = <TimeWindow>[
      ?p.rahuKaal,
      ?p.yamaganda,
      ?p.gulikaKaal,
      ?p.abhijitMuhurat,
    ];
    if (windows.isEmpty && p.choghadiya.isEmpty) {
      return const SizedBox.shrink();
    }
    String range(TimeWindow w) =>
        PanchangaFormat.range(w.start, w.end, devanagari: devanagari);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  s.muhurtaTitle,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              if (p.choghadiya.isNotEmpty)
                MoreInfoButton(
                  expanded: expanded,
                  onTap: onToggle,
                  compact: true,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.xxs,
            children: [
              for (final w in windows)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${s.kaalLabel(w.kind)} ',
                        style: TextStyle(
                          color: w.kind == TimeWindowKind.abhijit
                              ? colors.success
                              : colors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: range(w)),
                    ],
                  ),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
            ],
          ),
          if (p.choghadiya.isNotEmpty)
            PanchangaExpandable(
              expanded: expanded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xs),
                  PanchangaSubTable(
                    title: s.choghadiya,
                    rows: [
                      for (final c in p.choghadiya)
                        (
                          '${c.name(nepali: devanagari)} · '
                              '${c.quality == ChoghadiyaQuality.bad ? s.inauspicious : s.auspicious}',
                          range(c),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
