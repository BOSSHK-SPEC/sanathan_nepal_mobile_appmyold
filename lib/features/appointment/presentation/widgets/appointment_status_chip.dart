import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/appointment.dart';
import '../l10n/appointment_strings.dart';

/// Small coloured pill for [AppointmentStatus].
class AppointmentStatusChip extends StatelessWidget {
  const AppointmentStatusChip({required this.status, super.key});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final strings = AppointmentStrings.of(context);
    final (label, color) = switch (status) {
      AppointmentStatus.booked => (strings.statusBooked, colors.success),
      AppointmentStatus.completed => (strings.statusCompleted, colors.info),
      AppointmentStatus.cancelled => (strings.statusCancelled, colors.error),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
