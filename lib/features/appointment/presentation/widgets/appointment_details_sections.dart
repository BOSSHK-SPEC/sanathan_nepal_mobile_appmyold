import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../l10n/appointment_strings.dart';
import 'appointment_format.dart';
import 'payment_info.dart';

/// Small "label over value" block used in the details sections.
class DetailsKeyValue extends StatelessWidget {
  const DetailsKeyValue(this.label, this.value, {super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(value, style: context.textTheme.bodyMedium),
      ],
    ),
  );
}

/// Basic Info section: service, quantity, date (traditional | AD), time and
/// the region time zone (NST / IST).
class AppointmentBasicInfoSection extends StatelessWidget {
  const AppointmentBasicInfoSection({required this.appointment, super.key});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final fmt = AppointmentFormat.of(context);
    final languageCode = context.languageCode;
    final a = appointment;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsKeyValue(
          strings.service,
          '${a.service.name.forLanguage(languageCode)} '
          '(${fmt.money(a.service.price)})',
        ),
        DetailsKeyValue(strings.quantity, fmt.number(a.quantity)),
        DetailsKeyValue(
          '${strings.date} (${fmt.eraLabel} | ${strings.ad})',
          fmt.dateLine(a.date),
        ),
        DetailsKeyValue(strings.time, fmt.slotLabel(a.slot)),
        DetailsKeyValue(strings.timeZone, context.regionConfig.timeZoneLabel),
      ],
    );
  }
}

/// Details section: customer + birth details.
class AppointmentDetailsSection extends StatelessWidget {
  const AppointmentDetailsSection({required this.appointment, super.key});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final fmt = AppointmentFormat.of(context);
    final a = appointment;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsKeyValue(strings.fullName, a.customerName),
        DetailsKeyValue(strings.phoneNumber, fmt.phone(a.phone)),
        if (a.email.isNotEmpty) DetailsKeyValue(strings.email, a.email),
        DetailsKeyValue(strings.country, a.country),
        if (a.birthPlace != null)
          DetailsKeyValue(strings.birthPlace, a.birthPlace!),
        if (a.birthDate != null)
          DetailsKeyValue(strings.birthDate, fmt.adIso(a.birthDate!)),
        if (a.birthTime != null)
          DetailsKeyValue(
            strings.birthTime,
            fmt.time(
              int.parse(a.birthTime!.split(':').first),
              int.parse(a.birthTime!.split(':').last),
            ),
          ),
        // The server sends an empty string rather than null for a booking
        // with no note, which rendered as a labelled blank.
        if ((a.notes ?? '').trim().isNotEmpty)
          DetailsKeyValue(strings.notes, a.notes!.trim()),
        // The file itself is private and read through a signed link, so this
        // confirms it arrived rather than trying to draw it.
        if (a.cheenaMediaId != null)
          DetailsKeyValue(strings.cheenaAttachment, strings.fileAttached),
      ],
    );
  }
}

/// Payment section: summary lines, method and bank instructions.
class AppointmentPaymentSection extends StatelessWidget {
  const AppointmentPaymentSection({required this.appointment, super.key});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final fmt = AppointmentFormat.of(context);
    final languageCode = context.languageCode;
    final a = appointment;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentSummaryRow(
          label: strings.time,
          value: '${fmt.traditionalDate(a.date)} ${fmt.slotLabel(a.slot)}',
        ),
        PaymentSummaryRow(
          label:
              '${a.service.name.forLanguage(languageCode)} '
              '(x${fmt.number(a.quantity)})',
          value: fmt.money(a.totalAmount),
        ),
        Divider(color: context.colors.divider),
        PaymentSummaryRow(
          label: strings.total,
          value: fmt.money(a.totalAmount),
          bold: true,
        ),
        const SizedBox(height: AppSpacing.sm),
        DetailsKeyValue(
          strings.paymentMethod,
          PaymentInfo.label(a.paymentMethod, strings, context.regionConfig),
        ),
        PaymentInstructions(method: a.paymentMethod),
        if (a.receiptMediaId != null)
          DetailsKeyValue(strings.receiptAttachment, strings.fileAttached),
      ],
    );
  }
}

/// Who the sitting is with, and a way back to their profile.
///
/// It used to offer Call and Chat, which copied a centre's landline and
/// e-mail to the clipboard. An astrologer has neither: you reach them through
/// the app at the appointed time, so the honest action is to open their
/// profile.
class AppointmentAstrologerCard extends StatelessWidget {
  const AppointmentAstrologerCard({required this.astrologer, super.key});

  final BookableAstrologer astrologer;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final languageCode = context.languageCode;
    return AppCard(
      radius: AppRadius.md,
      child: Row(
        children: [
          ClipOval(
            child: AppImage(
              astrologer.avatarAsset ?? '',
              width: 48,
              height: 48,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.astrologer,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                Text(
                  astrologer.name.forLanguage(languageCode),
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  astrologer.title.forLanguage(languageCode),
                  style: context.textTheme.labelSmall,
                ),
              ],
            ),
          ),
          _ActionChip(
            icon: Icons.person_outline,
            label: strings.viewProfile,
            onTap: () =>
                context.push(AppRoutes.astrologerProfilePath(astrologer.id)),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          gradient: colors.primaryGradient,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: colors.onPrimary),
            const SizedBox(width: 3),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
