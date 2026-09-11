import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/calendar_month.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../l10n/calendar_strings.dart';
import '../utils/calendar_format.dart';

/// Month title block ("फागुन,२०७९" + "Feb/Mar , 2023 ⌄", or in India
/// "August, 2026" + "Shravana/Bhadrapada , 1948 Saka · Vikram Samvat 2083")
/// with the
/// prev / today / next / picker controls on the right (Figma 320:361).
class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    required this.year,
    required this.month,
    required this.mode,
    required this.onPrevious,
    required this.onNext,
    required this.onToday,
    required this.onPickMonth,
    super.key,
    this.calendarMonth,
    this.compact = false,
    this.showControls = true,
  });

  final int year;
  final int month;
  final CalendarViewMode mode;
  final CalendarMonth? calendarMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;
  final VoidCallback onPickMonth;
  final bool compact;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languageCode = context.languageCode;
    final config = context.regionConfig;
    final strings = CalendarStrings.of(context);
    final title = mode == CalendarViewMode.traditional
        ? CalendarFormat.traditionalMonthTitle(
            config.calendar,
            year,
            month,
            languageCode: languageCode,
          )
        : CalendarFormat.adMonthTitle(year, month, languageCode: languageCode);
    final subtitle = calendarMonth == null
        ? ''
        : CalendarFormat.monthSubtitle(
            calendarMonth!,
            config: config,
            languageCode: languageCode,
          );

    final titleStyle = context.textTheme.titleLarge?.copyWith(
      fontSize: compact ? 16 : 18.5,
      fontWeight: FontWeight.w400,
      height: 1.3,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            onTap: onPickMonth,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: titleStyle),
                if (!compact)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 13.5,
                            color: colors.textSecondary.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xxl),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: colors.iconMuted,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (showControls)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CtrlButton(
                icon: Icons.chevron_left,
                tooltip: '<',
                onTap: onPrevious,
                compact: compact,
              ),
              _CtrlButton(
                icon: Icons.refresh,
                tooltip: strings.today,
                onTap: onToday,
                compact: compact,
              ),
              _CtrlButton(
                icon: Icons.chevron_right,
                tooltip: '>',
                onTap: onNext,
                compact: compact,
              ),
              InkWell(
                onTap: onPickMonth,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: AppImage(
                    AppAssets.icon('calendar/calendar_picker.svg'),
                    width: compact ? 14 : 16,
                    height: compact ? 14 : 16,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _CtrlButton extends StatelessWidget {
  const _CtrlButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.compact,
  });
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    tooltip: tooltip,
    visualDensity: VisualDensity.compact,
    padding: EdgeInsets.zero,
    constraints: BoxConstraints(
      minWidth: compact ? 28 : 36,
      minHeight: compact ? 28 : 36,
    ),
    icon: Icon(icon, size: compact ? 16 : 18, color: context.colors.icon),
  );
}
