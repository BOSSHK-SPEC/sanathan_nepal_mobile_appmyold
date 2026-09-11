import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../l10n/calendar_strings.dart';
import '../utils/calendar_format.dart';

/// "पूर्वनिर्धारित क्यालेन्डर दृश्य  ◉ वि.सं. ○ ई.सं.   फागुन, २०७९ ⌄  ‹ ○ ›"
/// row from the home-page calendar section (Figma 580:2590). The first
/// radio is the region's traditional calendar (B.S. in Nepal, Saka in
/// India), the second Gregorian.
class CalendarViewToggle extends StatelessWidget {
  const CalendarViewToggle({
    required this.mode,
    required this.year,
    required this.month,
    required this.onModeChanged,
    required this.onPrevious,
    required this.onNext,
    required this.onPickMonth,
    super.key,
    this.showLabel = true,
    this.showNavigation = true,
  });

  final CalendarViewMode mode;
  final int year;
  final int month;
  final ValueChanged<CalendarViewMode> onModeChanged;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPickMonth;
  final bool showLabel;
  final bool showNavigation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languageCode = context.languageCode;
    final calendar = context.traditionalCalendar;
    final strings = CalendarStrings.of(context);
    final small = context.textTheme.labelSmall?.copyWith(
      fontSize: 10,
      color: colors.textPrimary,
    );
    final title = mode == CalendarViewMode.traditional
        ? CalendarFormat.traditionalMonthTitle(
            calendar,
            year,
            month,
            languageCode: languageCode,
          ).replaceFirst(RegExp(r',\s*'), ', ')
        : CalendarFormat.adMonthTitle(year, month, languageCode: languageCode);

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 340;
        return Row(
          children: [
            if (showLabel && wide)
              Flexible(
                child: Text(
                  strings.defaultCalendarView,
                  style: small?.copyWith(height: 1.1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            const SizedBox(width: AppSpacing.xs),
            AppRadioOption<CalendarViewMode>(
              value: CalendarViewMode.traditional,
              groupValue: mode,
              label: calendar.eraLabel(languageCode: languageCode),
              onChanged: onModeChanged,
              textStyle: small,
            ),
            AppRadioOption<CalendarViewMode>(
              value: CalendarViewMode.gregorian,
              groupValue: mode,
              label: strings.gregorian,
              onChanged: onModeChanged,
              textStyle: small,
            ),
            const Spacer(),
            if (showNavigation) ...[
              Flexible(
                child: InkWell(
                  onTap: onPickMonth,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: small,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.expand_more,
                        size: 14,
                        color: colors.iconMuted,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              _MiniIcon(icon: Icons.chevron_left, onTap: onPrevious),
              _MiniIcon(icon: Icons.refresh, onTap: onPickMonth, size: 12),
              _MiniIcon(icon: Icons.chevron_right, onTap: onNext),
            ],
          ],
        );
      },
    );
  }
}

class _MiniIcon extends StatelessWidget {
  const _MiniIcon({required this.icon, required this.onTap, this.size = 16});
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.pill),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      child: Icon(icon, size: size, color: context.colors.icon),
    ),
  );
}
