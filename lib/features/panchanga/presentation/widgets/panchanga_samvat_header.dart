import 'package:flutter/material.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/panchanga.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';
import 'panchanga_table_widgets.dart';

/// First row of the panchanga table (Figma "1ST ROW"): era label above the
/// date, one column per `RegionConfig.samvatLabels` –
/// Nepal → वि.सं. | ई.सं. | शक संवत् | नेपाल संवत्;
/// India → विक्रम संवत् | शक संवत् (full Saka date) | ई.सं..
class PanchangaSamvatHeader extends StatelessWidget {
  const PanchangaSamvatHeader({required this.panchanga, super.key});
  final Panchanga panchanga;

  @override
  Widget build(BuildContext context) {
    final devanagari = context.usesDevanagariDigits;
    final lang = context.languageCode;
    final config = context.regionConfig;
    final s = PanchangaStrings.of(context);
    final p = panchanga;
    final cells = <(String, String)>[
      for (final kind in config.samvatLabels)
        (s.samvatLabel(kind), _value(kind, p, config, lang, devanagari)),
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final cell in cells)
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        cell.$1,
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        cell.$2,
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const PanchangaHairline(),
      ],
    );
  }

  static String _value(
    SamvatKind kind,
    Panchanga p,
    RegionConfig config,
    String lang,
    bool devanagari,
  ) => switch (kind) {
    // Bikram Sambat date (Nepal's traditional calendar).
    SamvatKind.bikram => PanchangaFormat.traditionalDate(
      p.date,
      calendar: const BikramSambatCalendar(),
      languageCode: lang,
    ),
    // North-Indian Vikram Samvat year.
    SamvatKind.vikram => PanchangaFormat.digits(
      '${VikramSamvat.yearFor(p.date)}',
      devanagari: devanagari,
    ),
    // Full Saka date when Saka is the region's calendar (India), else the
    // Shaka year only (Nepal design).
    SamvatKind.shaka =>
      config.calendar is SakaCalendar
          ? PanchangaFormat.traditionalDate(
              p.date,
              calendar: config.calendar,
              languageCode: lang,
            )
          : PanchangaFormat.digits('${p.shakaSamvat}', devanagari: devanagari),
    SamvatKind.nepalSambat =>
      '${PanchangaFormat.digits('${p.nepalSamvat}', devanagari: devanagari)} '
          '${p.nepalSamvatMonth(nepali: devanagari)}',
    SamvatKind.gregorian => PanchangaFormat.adDate(
      p.date,
      devanagari: devanagari,
    ),
  };
}
