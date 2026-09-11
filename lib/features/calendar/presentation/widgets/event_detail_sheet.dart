import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../l10n/calendar_strings.dart';
import '../utils/calendar_format.dart';

/// Event popup (Figma 320:825): "‹ पहाडमा होली", "फागुन २२, २०७९ | 06 March,
/// 2023 | सोमबार", image + description.
class EventDetailSheet extends StatelessWidget {
  const EventDetailSheet({required this.event, required this.day, super.key});

  final CalendarEvent event;
  final CalendarDay day;

  static Future<void> show(
    BuildContext context, {
    required CalendarEvent event,
    required CalendarDay day,
  }) => showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => EventDetailSheet(event: event, day: day),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languageCode = context.languageCode;
    final config = context.regionConfig;
    final strings = CalendarStrings.of(context);
    final description = event.description(languageCode: languageCode);
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: colors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  event.title(languageCode: languageCode),
                  style: context.textTheme.headlineMedium,
                ),
              ),
              if (day.isToday)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.today),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    strings.todayChip,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.today,
                      fontSize: 9,
                    ),
                  ),
                ),
              const SizedBox(width: AppSpacing.md),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.close, size: 18, color: colors.iconMuted),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 2),
            child: Text(
              '${CalendarFormat.traditionalDate(day.traditional, calendar: config.calendar, languageCode: languageCode, era: config.labelsTraditionalEra)} | '
              '${CalendarFormat.adDate(day.ad)} | '
              '${CalendarFormat.weekdayFull(day.ad, languageCode: languageCode)}',
              style: context.textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Icon(
              Icons.calendar_today_outlined,
              size: 14,
              color: colors.iconMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage(
                event.imageUrl ?? '',
                width: 110,
                height: 84,
                radius: AppRadius.sm,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  description.isEmpty
                      ? (event.isHoliday ? strings.holiday : '')
                      : description,
                  style: context.textTheme.bodySmall?.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
