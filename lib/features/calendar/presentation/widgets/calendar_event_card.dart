import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../l10n/calendar_strings.dart';
import '../utils/calendar_format.dart';

/// Event list card below the Patro grid (Figma 320:361 bottom):
/// feature-image thumb, traditional (BS / Saka) date, AD date, title with
/// accent left rule, weekday / tithi / rashi chips.
class CalendarEventCard extends StatelessWidget {
  const CalendarEventCard({
    required this.event,
    required this.day,
    super.key,
    this.onTap,
  });

  final CalendarEvent event;
  final CalendarDay day;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languageCode = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final config = context.regionConfig;
    final strings = CalendarStrings.of(context);
    final tithi = event.tithi(languageCode: languageCode).isNotEmpty
        ? event.tithi(languageCode: languageCode)
        : day.lunarDay.tithiName(nepali: devanagari);
    final rashi = _rashiForDay(day, devanagari);
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: Container(
          height: 103,
          padding: const EdgeInsets.all(6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 63,
                height: 91,
                child: event.imageUrl == null
                    ? Container(
                        decoration: BoxDecoration(
                          color: colors.adBanner,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          strings.featureImage,
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            height: 0.95,
                          ),
                        ),
                      )
                    : AppImage(event.imageUrl!, radius: 5),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CalendarFormat.traditionalDate(
                        day.traditional,
                        calendar: config.calendar,
                        languageCode: languageCode,
                        era: config.labelsTraditionalEra,
                      ),
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CalendarFormat.adDateLong(day.ad),
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: colors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(width: 2, height: 14, color: colors.accent),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event.title(languageCode: languageCode),
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _Chip(
                          CalendarFormat.weekdayFull(
                            day.ad,
                            languageCode: languageCode,
                          ),
                        ),
                        _Chip(tithi),
                        _Chip(rashi),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _rashiForDay(CalendarDay day, bool nepali) {
    const ne = [
      'मेष',
      'वृष',
      'मिथुन',
      'कर्कट',
      'सिंह',
      'कन्या',
      'तुला',
      'वृश्चिक',
      'धनु',
      'मकर',
      'कुम्भ',
      'मीन',
    ];
    const en = [
      'Mesh',
      'Brish',
      'Mithun',
      'Karkat',
      'Singha',
      'Kanya',
      'Tula',
      'Brishchik',
      'Dhanu',
      'Makar',
      'Kumbha',
      'Meen',
    ];
    // Moon moves ~1 rashi every 2.25 days – deterministic approximation.
    final idx =
        ((day.ad.difference(DateTime(2000)).inDays) / 2.25).floor() % 12;
    return (nepali ? ne : en)[idx];
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 9),
    child: Text(
      text,
      style: context.textTheme.labelSmall?.copyWith(
        fontSize: 10,
        color: context.colors.textSecondary,
      ),
    ),
  );
}
