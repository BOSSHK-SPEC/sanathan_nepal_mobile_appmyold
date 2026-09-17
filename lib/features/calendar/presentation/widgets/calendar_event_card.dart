import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../l10n/calendar_strings.dart';
import '../utils/active_calendar_view_mode.dart';
import '../utils/calendar_format.dart';

/// Event list card below the Patro grid (Figma 320:361 bottom):
/// feature-image thumb, the date in both calendars, title with accent left
/// rule, and weekday / tithi / moon-sign chips.
///
/// The tithi and moon-sign chips come from the server's panchanga for the day
/// and are left out when only an estimate is available: a chip carries no
/// "approximate" label, so it must not show a value that may be wrong. The
/// moon sign used to be guessed from "the moon changes sign every 2.25 days".
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
    final config = context.regionConfig;
    final strings = CalendarStrings.of(context);
    final exact = day.exactPanchanga;
    final eventTithi = event.tithi(languageCode: languageCode);
    final tithi = eventTithi.isNotEmpty
        ? eventTithi
        : exact?.tithi.resolve(languageCode);
    final rashi = exact?.moonRashi.resolve(languageCode);
    final gregorianFirst = context.gregorianLeads;
    final dateStyle = context.textTheme.labelSmall?.copyWith(
      fontSize: 10,
      color: colors.textPrimary,
    );
    final traditionalLine = Text(
      CalendarFormat.traditionalDate(
        day.traditional,
        calendar: config.calendar,
        languageCode: languageCode,
        era: config.labelsTraditionalEra,
      ),
      style: dateStyle,
    );
    final adLine = Text(CalendarFormat.adDateLong(day.ad), style: dateStyle);
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
                    // Led by the calendar the grid above is showing, so a
                    // switch to A.D. reorders the cards with it.
                    if (gregorianFirst) adLine else traditionalLine,
                    const SizedBox(height: 4),
                    if (gregorianFirst) traditionalLine else adLine,
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
                        if (tithi != null && tithi.isNotEmpty) _Chip(tithi),
                        if (rashi != null) _Chip(rashi),
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
