import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/domain/entities/calendar_view_mode.dart';
import '../../../calendar/presentation/utils/calendar_format.dart';
import '../../domain/entities/metal_rates.dart';
import '../l10n/home_strings.dart';

/// Left column of the Home header: month/year, today badge, secondary date,
/// clock and gold/silver mini card (Figma "Group 35645" / "आजको सुन, चाँदीको
/// दर").
///
/// Mirrors the region's default calendar view: Nepal shows the Bikram
/// Sambat month + day with the A.D. date underneath; India shows the
/// Gregorian month + day with the Saka date underneath. Time carries the
/// region's zone label (NST / IST) and bullion is priced in the region's
/// currency per unit (रु./tola, ₹/10 g).
class TodaySummaryColumn extends StatelessWidget {
  const TodaySummaryColumn({
    required this.now,
    super.key,
    this.metalRates,
    this.width = 78,
  });

  final DateTime now;
  final MetalRates? metalRates;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = HomeStrings.of(context);
    final config = context.regionConfig;
    final languageCode = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final calendar = config.calendar;
    final traditional = calendar.fromGregorian(now);
    final traditionalPrimary =
        config.defaultCalendarViewMode == CalendarViewMode.traditional;

    final String monthYear;
    final String day;
    final String secondaryDate;
    if (traditionalPrimary) {
      // "फागुन,२०७९" / "Falgun,2079" + "Mar 6 , 2023"
      monthYear = CalendarFormat.traditionalMonthTitle(
        calendar,
        traditional.year,
        traditional.month,
        languageCode: languageCode,
      ).replaceAll(', ', ',');
      day = CalendarFormat.digits(traditional.day, devanagari: devanagari);
      secondaryDate =
          '${CalendarFormat.adMonthShort(now.month)} ${now.day} , '
          '${now.year}';
    } else {
      // "August, 2026" + "Shravana 27, 1948 Saka"
      monthYear = CalendarFormat.adMonthTitle(
        now.year,
        now.month,
        languageCode: languageCode,
      );
      day = CalendarFormat.digits(now.day, devanagari: devanagari);
      secondaryDate = CalendarFormat.traditionalDate(
        traditional,
        calendar: calendar,
        languageCode: languageCode,
        era: true,
      );
    }
    final weekday = CalendarFormat.weekdayFull(now, languageCode: languageCode);
    final time = RegionFormat.time(now, config: config);
    final unit = devanagari ? config.metalUnitLocal : config.metalUnitEn;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              monthYear,
              style: context.textTheme.headlineMedium?.copyWith(height: 1.1),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            width: 70,
            height: 50,
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: colors.border.withValues(alpha: 0.5)),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(-0.15, -0.6),
                  child: Text(
                    day,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: colors.accent,
                      height: 1,
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Icon(
                    Icons.wb_sunny_outlined,
                    size: 11,
                    color: colors.warning,
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 16,
                  child: Icon(
                    Icons.nightlight_outlined,
                    size: 11,
                    color: colors.textMuted,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 2,
                  child: Text(
                    weekday,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textPrimary,
                      fontSize: 9,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            secondaryDate,
            style: context.textTheme.labelMedium,
            maxLines: 2,
          ),
          Text(
            time,
            style: context.textTheme.labelMedium?.copyWith(fontSize: 11),
          ),
          const SizedBox(height: AppSpacing.sm),
          Tooltip(
            message: '${s.goldSilverToday} (${s.perUnit(unit)})',
            child: Container(
              width: 70,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RateRow(
                    iconColor: const Color(0xFFE0A030),
                    value: metalRates?.goldPerUnit,
                    config: config,
                    languageCode: languageCode,
                  ),
                  const SizedBox(height: 2),
                  _RateRow(
                    iconColor: const Color(0xFFB8B8B8),
                    value: metalRates?.silverPerUnit,
                    config: config,
                    languageCode: languageCode,
                  ),
                  Text(
                    s.perUnit(unit),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 7,
                      color: colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RateRow extends StatelessWidget {
  const _RateRow({
    required this.iconColor,
    required this.value,
    required this.config,
    required this.languageCode,
  });
  final Color iconColor;
  final double? value;
  final RegionConfig config;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final formatted = value == null
        ? '—'
        : RegionFormat.money(
            value!,
            config: config,
            languageCode: languageCode,
          );
    return Row(
      children: [
        Icon(Icons.circle, size: 10, color: iconColor),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            formatted,
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 8,
              color: context.colors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
