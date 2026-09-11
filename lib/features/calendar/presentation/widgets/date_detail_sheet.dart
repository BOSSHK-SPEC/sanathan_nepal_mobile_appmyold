import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../../domain/services/panchanga_approximator.dart';
import '../l10n/calendar_strings.dart';
import '../utils/calendar_format.dart';
import 'event_detail_sheet.dart';

/// Day popup (Figma 320:1250): traditional/AD title, "आज" chip, tithi +
/// paksha, sunrise/sunset (region's default city), पञ्चाङ्ग rows, events
/// and शुभ साइत.
class DateDetailSheet extends StatelessWidget {
  const DateDetailSheet({required this.day, super.key});

  final CalendarDay day;

  static Future<void> show(BuildContext context, CalendarDay day) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (_) => DateDetailSheet(day: day),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languageCode = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final config = context.regionConfig;
    final strings = CalendarStrings.of(context);
    final info = PanchangaApproximator.forRegion(day.ad, config);
    final title =
        '${CalendarFormat.traditionalDate(day.traditional, calendar: config.calendar, languageCode: languageCode, era: config.labelsTraditionalEra)}, '
        '${CalendarFormat.weekdayFull(day.ad, languageCode: languageCode)}';
    final tithi = info.lunarDay.tithiName(nepali: devanagari);
    final paksha = info.lunarDay.pakshaName(nepali: devanagari);
    final lunarIndex = PanchangaApproximator.siderealMonthIndex(day.ad);
    final lunarMonth = devanagari
        ? _lunarMonthNe[lunarIndex]
        : _lunarMonthEn[lunarIndex];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.62,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.textTheme.headlineMedium),
                      const SizedBox(height: 2),
                      Text(
                        CalendarFormat.adDate(day.ad),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (day.isToday) _TodayChip(label: strings.todayChip),
                const SizedBox(width: AppSpacing.sm),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Icon(Icons.close, size: 18, color: colors.iconMuted),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$tithi, $lunarMonth $paksha',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SunTime(
                        icon: Icons.wb_twilight,
                        label: strings.sunrise,
                        time: CalendarFormat.time(
                          info.sunrise,
                          devanagari: devanagari,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      _SunTime(
                        icon: Icons.nightlight_outlined,
                        label: strings.sunset,
                        time: CalendarFormat.time(
                          info.sunset,
                          devanagari: devanagari,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(strings.panchanga, style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            _InfoRow(
              label: strings.day,
              value: CalendarFormat.weekdayFull(
                day.ad,
                languageCode: languageCode,
              ),
            ),
            _InfoRow(
              label: strings.nakshatra,
              value: info.nakshatra(nepali: devanagari),
            ),
            _InfoRow(label: strings.tithi, value: '$tithi ($paksha)'),
            _InfoRow(
              label: strings.karan,
              value: info.karan(nepali: devanagari),
            ),
            _InfoRow(
              label: strings.yog,
              value: info.yog(nepali: devanagari),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push(AppRoutes.panchanga);
                },
                child: Text(
                  strings.moreInfo,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.accent,
                  ),
                ),
              ),
            ),
            Text(strings.events, style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            if (day.events.isEmpty)
              Text(
                strings.noEvents,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
              )
            else
              for (final e in day.events)
                _EventLine(
                  event: e,
                  onTap: () {
                    Navigator.of(context).pop();
                    EventDetailSheet.show(context, event: e, day: day);
                  },
                ),
            const SizedBox(height: AppSpacing.lg),
            Text(strings.subhaSait, style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            for (final s in _subhaSait(day, strings)) _Bullet(text: s),
          ],
        ),
      ),
    );
  }

  /// Deterministic mock शुभ साइत bullets keyed on tithi.
  List<String> _subhaSait(CalendarDay day, CalendarStrings strings) {
    final t = day.lunarDay.tithiIndex;
    if (day.isWeekend || t == 4 || t == 9 || t == 14) {
      return [strings.noSubhaSait];
    }
    return [
      if (t.isOdd) strings.muhurtaPasni,
      if (t % 3 == 0) strings.muhurtaWedding,
      if (t % 5 == 0) strings.muhurtaHavan,
      if (t.isEven) strings.muhurtaTravel,
    ];
  }

  /// Lunar month names indexed by sidereal solar month (0 = Mesha/Vaishakh).
  static const List<String> _lunarMonthNe = [
    'वैशाख',
    'ज्येष्ठ',
    'आषाढ',
    'श्रावण',
    'भाद्र',
    'आश्विन',
    'कार्तिक',
    'मार्ग',
    'पौष',
    'माघ',
    'फाल्गुण',
    'चैत्र',
  ];
  static const List<String> _lunarMonthEn = [
    'Vaishakh',
    'Jyeshtha',
    'Ashadh',
    'Shrawan',
    'Bhadra',
    'Ashwin',
    'Kartik',
    'Marga',
    'Poush',
    'Magh',
    'Falgun',
    'Chaitra',
  ];
}

class _TodayChip extends StatelessWidget {
  const _TodayChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    decoration: BoxDecoration(
      border: Border.all(color: context.colors.today),
      borderRadius: BorderRadius.circular(3),
    ),
    child: Text(
      label,
      style: context.textTheme.labelSmall?.copyWith(
        color: context.colors.today,
        fontSize: 9,
      ),
    ),
  );
}

class _SunTime extends StatelessWidget {
  const _SunTime({required this.icon, required this.label, required this.time});
  final IconData icon;
  final String label;
  final String time;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 12, color: context.colors.iconMuted),
      const SizedBox(width: 2),
      Text(
        '$label $time',
        style: context.textTheme.labelSmall?.copyWith(fontSize: 9),
      ),
    ],
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 64,
          child: Text(label, style: context.textTheme.titleSmall),
        ),
        Expanded(
          child: Text(
            value,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}

class _EventLine extends StatelessWidget {
  const _EventLine({required this.event, required this.onTap});
  final CalendarEvent event;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: event.isHoliday ? colors.holiday : colors.accent,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                event.title(languageCode: context.languageCode),
                style: context.textTheme.bodySmall,
              ),
            ),
            Icon(Icons.chevron_right, size: 16, color: colors.iconMuted),
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.textMuted,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text, style: context.textTheme.bodySmall)),
      ],
    ),
  );
}
