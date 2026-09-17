import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/domain/entities/calendar_view_mode.dart';
import '../../../calendar/presentation/utils/calendar_format.dart';

/// The Patro entry at the top of the quick menu: a small calendar page with
/// today's day and month, the full date in the region's calendar and in A.D.,
/// opening the Patro page on tap.
///
/// Patro used to be a tile in the menu's primary row drawn with a house icon,
/// so it read as "Home" and nobody found the calendar. It is now the first
/// thing the menu shows, and looks like what it opens.
class PatroQuickCard extends StatelessWidget {
  const PatroQuickCard({required this.today, required this.onTap, super.key});

  final DateTime today;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final config = context.regionConfig;
    final calendar = context.traditionalCalendar;
    final traditional = calendar.fromGregorian(today);

    final month = calendar.monthName(traditional.month, languageCode: lang);
    final day = CalendarFormat.digits(traditional.day, devanagari: devanagari);
    final fullDate = CalendarFormat.traditionalDate(
      traditional,
      calendar: calendar,
      languageCode: lang,
      era: config.labelsTraditionalEra,
    );
    final weekday = CalendarFormat.weekdayFull(today, languageCode: lang);
    final adDate = CalendarFormat.adDate(
      today,
      languageCode: devanagari ? lang : 'en',
    );

    return Semantics(
      button: true,
      excludeSemantics: true,
      label: '${l10n.menuPatro}. ${l10n.today}: $fullDate, $weekday',
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.accent.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                // A calendar page: this month on top, today's day beneath.
                Container(
                  width: 54,
                  height: 58,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    gradient: colors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          month,
                          maxLines: 1,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                      Text(
                        day,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 16,
                            color: colors.accent,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              l10n.menuPatro,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: colors.chipBackground,
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              l10n.today,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$fullDate · $weekday',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall,
                      ),
                      Text(
                        adDate,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: colors.accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
