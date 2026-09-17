import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../l10n/calendar_strings.dart';
import '../utils/active_calendar_view_mode.dart';
import '../utils/calendar_format.dart';
import 'vrat_marker.dart';

/// A vrat day (Ekadashi, Purnima, Amavasya) in the Patro month list: which
/// vrat, the tithi and lunar month, the date in both calendars (led by the
/// grid's calendar) and when the tithi ends. Only built for days whose
/// panchanga is the server's calculation.
class VratDayCard extends StatelessWidget {
  const VratDayCard({required this.day, super.key, this.onTap});

  final CalendarDay day;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = day.exactPanchanga;
    if (p == null || !p.isVrat) return const SizedBox.shrink();
    final colors = context.colors;
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final config = context.regionConfig;
    final strings = CalendarStrings.of(context);
    final kind = p.vrat.first;
    final traditional = CalendarFormat.traditionalDate(
      day.traditional,
      calendar: config.calendar,
      languageCode: lang,
      era: config.labelsTraditionalEra,
    );
    final ad = CalendarFormat.adDateLong(day.ad);
    final dates = context.gregorianLeads ? '$ad · $traditional' : '$traditional · $ad';
    final endsAt = p.tithiEndsAt;
    final small = context.textTheme.labelSmall?.copyWith(
      fontSize: 10,
      color: colors.textSecondary,
    );

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.chipBackground,
                  shape: BoxShape.circle,
                ),
                child: VratMarker(kind: kind, size: 14),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.vrat(kind),
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      '${p.lunarMonth.resolve(lang)}'
                      '${p.isAdhikaMonth ? ' (${strings.adhika})' : ''} '
                      '${p.pakshaName.resolve(lang)} ${p.tithi.resolve(lang)}',
                      style: small,
                    ),
                    Text(dates, style: small),
                    if (endsAt != null)
                      Text(
                        strings.until(
                          CalendarFormat.time(endsAt, devanagari: devanagari),
                        ),
                        style: small,
                      ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 18, color: colors.iconMuted),
            ],
          ),
        ),
      ),
    );
  }
}
