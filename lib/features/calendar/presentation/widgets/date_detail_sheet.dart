import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../panchanga/presentation/cubit/panchanga_cubit.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../../domain/entities/day_panchanga.dart';
import '../../domain/services/day_panchanga_estimate.dart';
import '../l10n/calendar_strings.dart';
import '../utils/calendar_format.dart';
import 'event_detail_sheet.dart';
import 'vrat_marker.dart';

/// Day popup (Figma 320:1250): the date in both calendars, the day's tithi
/// with the moment it ends, sunrise and sunset, the five limbs of the
/// panchanga, vrat, events and the auspicious times a panel has published —
/// plus "add a reminder" and "share".
///
/// Panchanga comes from the server's ephemeris calculation. A day that has
/// none (offline, never fetched) shows the on-device estimate, labelled as
/// approximate. Auspicious times are never invented: a day with none
/// published says so.
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
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final config = context.regionConfig;
    final strings = CalendarStrings.of(context);
    final p = day.panchanga ?? DayPanchangaEstimate.forDate(day.ad, config);

    final title =
        '${CalendarFormat.traditionalDate(day.traditional, calendar: config.calendar, languageCode: lang, era: config.labelsTraditionalEra)}, '
        '${CalendarFormat.weekdayFull(day.ad, languageCode: lang)}';
    final month =
        '${p.lunarMonth.resolve(lang)}'
        '${p.isAdhikaMonth ? ' (${strings.adhika})' : ''}';
    final tithi = '${p.tithi.resolve(lang)}, $month ${p.pakshaName.resolve(lang)}';
    final endsAt = p.tithiEndsAt;
    final until = endsAt == null
        ? null
        : strings.until(CalendarFormat.time(endsAt, devanagari: devanagari));
    String time(DateTime t) => CalendarFormat.time(t, devanagari: devanagari);

    final sheet = DecoratedBox(
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
                  Text(tithi, style: context.textTheme.bodyMedium),
                  if (until != null)
                    Text(
                      until,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SunTime(
                        icon: Icons.wb_twilight,
                        label: strings.sunrise,
                        time: time(p.sunrise),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      _SunTime(
                        icon: Icons.nightlight_outlined,
                        label: strings.sunset,
                        time: time(p.sunset),
                      ),
                    ],
                  ),
                  if (p.isApproximate) ...[
                    const SizedBox(height: AppSpacing.xs),
                    _ApproximateNote(text: strings.approximateNote),
                  ],
                ],
              ),
            ),
            if (p.isVrat && !p.isApproximate) ...[
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                children: [
                  for (final kind in p.vrat)
                    Chip(
                      avatar: VratMarker(kind: kind, size: 10),
                      label: Text(strings.vrat(kind)),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            Text(strings.panchanga, style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            _InfoRow(
              label: strings.day,
              value: CalendarFormat.weekdayFull(day.ad, languageCode: lang),
            ),
            _InfoRow(
              label: strings.tithi,
              value: [
                '${p.tithi.resolve(lang)} (${p.pakshaName.resolve(lang)})',
                ?until,
              ].join(' · '),
            ),
            _InfoRow(label: strings.nakshatra, value: p.nakshatra.resolve(lang)),
            _InfoRow(label: strings.yog, value: p.yoga.resolve(lang)),
            _InfoRow(label: strings.karan, value: p.karana.resolve(lang)),
            _InfoRow(label: strings.moonSign, value: p.moonRashi.resolve(lang)),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('${AppRoutes.panchanga}?date=${_iso(day.ad)}');
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
            const _PublishedSaits(),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.push(
                        AppRoutes.eventCreate,
                        extra: DateTime(day.ad.year, day.ad.month, day.ad.day),
                      );
                    },
                    icon: const Icon(Icons.alarm_add_outlined, size: 18),
                    label: Text(strings.addReminder),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => SharePlus.instance.share(
                      ShareParams(
                        subject: title,
                        text: _shareText(
                          title: title,
                          tithi: tithi,
                          until: until,
                          panchanga: p,
                          lang: lang,
                          strings: strings,
                          time: time,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.share_outlined, size: 18),
                    label: Text(strings.share),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Published auspicious times come from the panchanga feature, the same
    // way the date converter shows them.
    if (!sl.isRegistered<PanchangaCubit>()) return sheet;
    return BlocProvider<PanchangaCubit>(
      create: (_) => sl<PanchangaCubit>()..selectDate(day.ad),
      child: sheet,
    );
  }

  String _shareText({
    required String title,
    required String tithi,
    required String? until,
    required DayPanchanga panchanga,
    required String lang,
    required CalendarStrings strings,
    required String Function(DateTime) time,
  }) => [
    title,
    CalendarFormat.adDate(day.ad),
    '${strings.tithi}: $tithi${until == null ? '' : ' ($until)'}',
    '${strings.nakshatra}: ${panchanga.nakshatra.resolve(lang)}',
    '${strings.sunrise} ${time(panchanga.sunrise)} · '
        '${strings.sunset} ${time(panchanga.sunset)}',
    for (final e in day.events) '• ${e.title(languageCode: lang)}',
    if (panchanga.isApproximate) strings.approximateNote,
  ].join('\n');

  static String _iso(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

/// The auspicious times published for the day, or a plain statement that
/// none are — never a list made up from the tithi.
class _PublishedSaits extends StatelessWidget {
  const _PublishedSaits();

  @override
  Widget build(BuildContext context) {
    final strings = CalendarStrings.of(context);
    final colors = context.colors;
    final muted = context.textTheme.bodySmall?.copyWith(
      color: colors.textSecondary,
    );
    if (!sl.isRegistered<PanchangaCubit>()) {
      return Text(strings.noSaitsForDay, style: muted);
    }
    return BlocBuilder<PanchangaCubit, PanchangaState>(
      buildWhen: (a, b) => a.saits != b.saits || a.date != b.date,
      builder: (context, state) => switch (state.saits) {
        Loaded() => state.saitsToday.isEmpty
            ? Text(strings.noSaitsForDay, style: muted)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final sait in state.saitsToday)
                    _Bullet(
                      text: sait.title(nepali: context.usesDevanagariDigits),
                    ),
                ],
              ),
        Failed() => Text(strings.saitsUnavailable, style: muted),
        _ => const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      },
    );
  }
}

class _ApproximateNote extends StatelessWidget {
  const _ApproximateNote({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.info_outline, size: 12, color: context.colors.textMuted),
      const SizedBox(width: 4),
      Flexible(
        child: Text(
          text,
          textAlign: TextAlign.end,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: 9,
            color: context.colors.textMuted,
          ),
        ),
      ),
    ],
  );
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
          width: 72,
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
