import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../utils/event_date_format.dart';

/// Right-hand date column of a "My Events" / "To-Do" row (Figma
/// "Group 35911", 66×39): highlighted tithi, then the primary and secondary
/// calendar dates. Nepal: BS primary / AD secondary; India: AD primary /
/// Saka (+ VS) secondary.
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
    final traditional = EventDateFormat.traditionalLine(
      date,
      config: config,
      languageCode: context.languageCode,
    );
    final gregorian = EventDateFormat.adMedium(date);
    final primary = config.isIndia ? gregorian : traditional;
    final secondary = config.isIndia ? traditional : gregorian;
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
