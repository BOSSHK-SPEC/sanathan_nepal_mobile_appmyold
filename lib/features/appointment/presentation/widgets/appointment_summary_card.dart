import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/appointment.dart';
import '../l10n/appointment_strings.dart';
import 'appointment_format.dart';

/// Compact appointment row (Figma profile "My Appointments" section):
///
/// ```
/// CHEENA READING APPOINTMENT                         ┌──────┐
/// Chaitra 16, 2079 | 30 Mar, 2023, Wednesday         │ 8:30 │
/// You have Cheena Reading Appointment with Dr. Uttam │  PM  │
/// ```
///
/// Public API (used by the Profile feature):
/// * [appointment] – the domain entity to render.
/// * [onTap] – usually `context.push(AppRoutes.appointmentDetailsPath(id))`.
/// * [showDivider] – draws the thin top rule used inside the profile card.
/// * [padding] – outer padding (defaults to 16h/12v).
///
/// The date line uses the region's traditional calendar (Bikram Sambat in
/// Nepal, Saka in India) next to the Gregorian date; Nepali / Hindi render
/// Devanagari digits and localised month / weekday names.
class AppointmentSummaryCard extends StatelessWidget {
  const AppointmentSummaryCard({
    required this.appointment,
    super.key,
    this.onTap,
    this.showDivider = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
  });

  final Appointment appointment;
  final VoidCallback? onTap;
  final bool showDivider;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final strings = AppointmentStrings.of(context);
    final fmt = AppointmentFormat.of(context);
    final languageCode = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final serviceName = appointment.service.name.forLanguage(languageCode);
    final astrologerName = appointment.astrologerName.forLanguage(languageCode);
    final title = devanagari
        ? '$serviceName ${strings.appointment}'
        : '$serviceName ${strings.appointment}'.toUpperCase();
    // Devanagari languages put the astrologer first: "<astrologer> सँग/के साथ
    // तपाईंको/आपका <service> अपोइन्टमेन्ट छ/है ।"
    final description = switch (languageCode) {
      'ne' =>
        '$astrologerName${strings.withAstrologer} '
            '${strings.youHave} $serviceName ${strings.appointment} छ ।',
      'hi' =>
        '$astrologerName ${strings.withAstrologer} '
            '${strings.youHave} $serviceName ${strings.appointment} है।',
      _ =>
        '${strings.youHave} $serviceName ${strings.appointment} '
            '${strings.withAstrologer} $astrologerName.',
    };
    final (hour, meridiem) = fmt.timeParts(appointment.slot);
    final cancelled = appointment.status == AppointmentStatus.cancelled;

    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showDivider) Divider(height: 1, color: colors.divider),
          Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: devanagari ? 0 : 0.3,
                          decoration: cancelled
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        fmt.dateLine(appointment.date),
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        description,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 44,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    color: colors.chipBackground,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        hour,
                        style: textTheme.titleSmall?.copyWith(
                          color: colors.accent,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        meridiem,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.accent,
                          fontSize: 9,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
