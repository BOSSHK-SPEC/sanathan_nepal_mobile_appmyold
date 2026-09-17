import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/presentation/utils/active_calendar_view_mode.dart';
import '../utils/event_date_format.dart';

/// Right-hand date column of a "My Events" / "To-Do" row (Figma
/// "Group 35911", 66×39): highlighted tithi, then the primary and secondary
/// calendar dates, led by whichever calendar the page's toggle shows (the
/// region's default — B.S. in Nepal, A.D. in India — when there is none).
class EventDateColumn extends StatelessWidget {
  const EventDateColumn({
    required this.date,
    super.key,
    this.tithi = '',
    this.width = 74,
  });

  final DateTime date;
  final String tithi;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final config = context.regionConfig;
    // Follows the calendar toggle above the list rather than the region, so a
    // switch to A.D. or Saka reorders every row along with the grid.
    final gregorianFirst = context.gregorianLeads;
    final traditional = EventDateFormat.traditionalLine(
      date,
      config: config,
      languageCode: context.languageCode,
      era: gregorianFirst,
    );
    final gregorian = EventDateFormat.adMedium(date);
    final primary = gregorianFirst ? gregorian : traditional;
    final secondary = gregorianFirst ? traditional : gregorian;
    final small = context.textTheme.labelSmall?.copyWith(
      fontSize: 9,
      height: 1.3,
    );
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tithi.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              margin: const EdgeInsets.only(bottom: 2),
              decoration: BoxDecoration(
                color: colors.chipBackground,
                borderRadius: BorderRadius.circular(AppRadius.xs),
              ),
              child: Text(
                tithi,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: small?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Text(
            primary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: small?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            secondary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: small?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
