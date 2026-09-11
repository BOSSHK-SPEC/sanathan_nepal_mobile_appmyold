import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/planet_position.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';
import 'panchanga_table_widgets.dart';

/// "सूर्योदयकालीन स्पष्ट ग्रहहरू" (Figma "GRAHA HARU"): centred title and a
/// two-column grid of `name  value` cells separated by hairlines.
class PlanetGrid extends StatelessWidget {
  const PlanetGrid({required this.planets, super.key});
  final List<PlanetPosition> planets;

  @override
  Widget build(BuildContext context) {
    final devanagari = context.usesDevanagariDigits;
    final s = PanchangaStrings.of(context);
    Widget cell(PlanetPosition? p) => Expanded(
      child: p == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      p.name(nepali: devanagari),
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      PanchangaFormat.digits(p.value, devanagari: devanagari),
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Text(
            s.planetsAtSunrise,
            textAlign: TextAlign.center,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        for (var i = 0; i < planets.length; i += 2) ...[
          const PanchangaHairline(),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                cell(planets[i]),
                const PanchangaHairline(vertical: true),
                cell(i + 1 < planets.length ? planets[i + 1] : null),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
