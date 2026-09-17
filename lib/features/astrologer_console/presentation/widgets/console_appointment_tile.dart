import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/console_appointment.dart';
import '../l10n/console_strings.dart';
import 'console_appointment_format.dart';

/// One booked sitting in a list: the day, the client, the time, the status.
class ConsoleAppointmentTile extends StatelessWidget {
  const ConsoleAppointmentTile({
    required this.appointment,
    required this.onTap,
    super.key,
  });

  final ConsoleAppointment appointment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final fmt = ConsoleAppointmentFormat.of(context);
    final colors = context.colors;
    final a = appointment;
    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.chipBackground,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              children: [
                Text(
                  fmt.dayOfMonth(a.startsAt),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                    height: 1.1,
                  ),
                ),
                Text(
                  fmt.month(a.startsAt),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.clientName.isEmpty ? a.reference : a.clientName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  a.isSession
                      ? '${fmt.timeRange(a.startsAt, a.endsAt)} · '
                            '${s.apptChannel(a.channel)}'
                      : fmt.timeRange(a.startsAt, a.endsAt),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                if (a.quantity > 1)
                  Text(
                    s.apptSeats(fmt.number(a.quantity)),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          StatusChip(
            label: s.apptStatus(a.status),
            tone: consoleAppointmentTone(a.status),
            dense: true,
          ),
        ],
      ),
    );
  }
}
