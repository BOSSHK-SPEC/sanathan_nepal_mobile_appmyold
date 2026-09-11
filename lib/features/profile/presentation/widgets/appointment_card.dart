import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/appointment_summary.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';

/// Appointment row in "My Appointments" (title, traditional | AD date,
/// description and the large time on the right). The traditional date comes
/// from the active region's calendar (B.S. for Nepal, Saka for India).
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({required this.appointment, super.key, this.onTap});
  final AppointmentSummary appointment;
  final VoidCallback? onTap;

  static const List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ProfileStrings.of(context);
    final ne = context.isNepali;
    final dt = appointment.dateTime;
    final calendar = context.traditionalCalendar;
    final td = calendar.fromGregorian(dt);
    final traditional = localizeDigits(
      context,
      '${calendar.monthName(td.month, languageCode: context.languageCode)} '
      '${td.day}, ${td.year}',
    );
    final ad =
        '${dt.day} ${_months[dt.month - 1]}, ${dt.year}, '
        '${_weekdays[dt.weekday - 1]}';
    final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final time = localizeDigits(
      context,
      '$hour12:${dt.minute.toString().padLeft(2, '0')}',
    );
    final meridiem = dt.hour >= 12 ? 'PM' : 'AM';

    return ProfileSectionCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ne ? appointment.titleNe : appointment.titleEn,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$traditional | $ad',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.accent,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    s.youHaveAppointmentWith(
                      ne ? appointment.serviceNe : appointment.serviceEn,
                      appointment.doctorName,
                    ),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              children: [
                Text(
                  time,
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: colors.accent,
                  ),
                ),
                Text(
                  meridiem,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.accent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
