import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/panchanga.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_element_row.dart';
import 'panchanga_muhurta_row.dart';
import 'panchanga_samvat_header.dart';
import 'panchanga_sun_moon_card.dart';
import 'panchanga_table_widgets.dart';
import 'planet_grid.dart';

/// Flat, hairline-separated panchanga table (Figma "PANCHANGA" card on the
/// Home page and the Panchanga page). Owns which rows are expanded.
class PanchangaTable extends StatefulWidget {
  const PanchangaTable({
    required this.panchanga,
    super.key,
    this.initiallyExpanded = false,
  });

  final Panchanga panchanga;

  /// Expand every "थप जानकारी" table on first build (used on the full page).
  final bool initiallyExpanded;

  @override
  State<PanchangaTable> createState() => _PanchangaTableState();
}

enum _Row { day, tithi, nakshatra, karana, yoga, muhurta }

class _PanchangaTableState extends State<PanchangaTable> {
  late final Set<_Row> _expanded = {
    if (widget.initiallyExpanded) ..._Row.values,
  };

  void _toggle(_Row row) => setState(() {
    if (!_expanded.remove(row)) _expanded.add(row);
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final devanagari = context.usesDevanagariDigits;
    final s = PanchangaStrings.of(context);
    final p = widget.panchanga;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PanchangaSamvatHeader(panchanga: p),
          // The on-device estimate can put the tithi a day out; say so rather
          // than presenting it as the day's panchanga.
          if (p.isApproximate)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 12, color: colors.textMuted),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      s.approximateNote,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          PanchangaSunMoonCard(
            panchanga: p,
            expanded: _expanded.contains(_Row.day),
            onToggle: () => _toggle(_Row.day),
          ),
          PanchangaElementRow(
            label: s.tithi,
            element: p.tithi,
            expanded: _expanded.contains(_Row.tithi),
            onToggle: () => _toggle(_Row.tithi),
          ),
          PanchangaElementRow(
            label: s.nakshatra,
            element: p.nakshatra,
            expanded: _expanded.contains(_Row.nakshatra),
            onToggle: () => _toggle(_Row.nakshatra),
          ),
          PanchangaElementRow(
            label: s.karana,
            element: p.karana,
            expanded: _expanded.contains(_Row.karana),
            onToggle: () => _toggle(_Row.karana),
          ),
          PanchangaElementRow(
            label: s.yoga,
            element: p.yoga,
            expanded: _expanded.contains(_Row.yoga),
            onToggle: () => _toggle(_Row.yoga),
          ),
          // Rahu Kaal / Yamaganda / Gulika / Abhijit / Choghadiya – Indian
          // users expect these; the Nepal design has no row for them.
          if (context.regionConfig.isIndia)
            PanchangaMuhurtaRow(
              panchanga: p,
              expanded: _expanded.contains(_Row.muhurta),
              onToggle: () => _toggle(_Row.muhurta),
            ),
          const PanchangaHairline(),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _KeyValue(
                    label: s.chandraRashi,
                    value: p.chandraRashi(nepali: devanagari),
                  ),
                ),
                const PanchangaHairline(vertical: true),
                Expanded(
                  child: _KeyValue(
                    label: s.anandadiYoga,
                    value: p.anandadiYoga(nepali: devanagari),
                  ),
                ),
              ],
            ),
          ),
          const PanchangaHairline(),
          PlanetGrid(planets: p.planets),
        ],
      ),
    );
  }
}

/// Centred label-above-value cell (चन्द्रराशि / आनन्दादि योग).
class _KeyValue extends StatelessWidget {
  const _KeyValue({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
    child: Column(
      children: [
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(value, style: context.textTheme.labelSmall),
      ],
    ),
  );
}
