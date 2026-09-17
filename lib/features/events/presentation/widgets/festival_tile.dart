import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../calendar/presentation/utils/active_calendar_view_mode.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import 'add_reminder_button.dart';
import 'days_left_badge.dart';
import 'event_tag.dart';

/// Row of the "Festivals" tab (Figma "Group 35879", 335×35):
/// thumbnail · title + tags · date line + "Add Event/Reminder" · days-left.
class FestivalTile extends StatelessWidget {
  const FestivalTile({
    required this.event,
    super.key,
    this.onTap,
    this.onAddReminder,
    this.now,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.pageGutter,
      vertical: 7,
    ),
  });

  final Event event;
  final VoidCallback? onTap;
  final VoidCallback? onAddReminder;
  final DateTime? now;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final lang = context.languageCode;
    final tags = <Widget>[
      if (event.isHoliday)
        EventTag(label: s.publicHoliday, color: colors.holiday),
      if (event.category != EventCategory.publicHoliday)
        EventTag(label: s.category_(event.category)),
      if (event.isVrat) EventTag(label: s.vrat, color: colors.today),
    ];
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(
              event.imagePath ?? 'assets/images/events/${event.id}.png',
              width: 35,
              height: 35,
              radius: AppRadius.xs,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        event.title.resolveFor(lang),
                        style: context.textTheme.titleSmall,
                      ),
                      ...tags,
                    ],
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        EventDateFormat.listLine(
                          event.date,
                          config: context.regionConfig,
                          languageCode: lang,
                          weekdays: s.weekdays,
                          // Leads with the calendar the page's toggle shows.
                          gregorianFirst: context.gregorianLeads,
                        ),
                        style: context.textTheme.labelSmall,
                      ),
                      if (onAddReminder != null)
                        AddReminderButton(onTap: onAddReminder!),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            DaysLeftBadge(days: event.daysLeft(now), stacked: true),
          ],
        ),
      ),
    );
  }
}
