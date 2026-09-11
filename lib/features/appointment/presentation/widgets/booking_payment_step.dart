import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/appointment.dart';
import '../cubit/book_appointment_cubit.dart';
import '../l10n/appointment_strings.dart';
import 'appointment_format.dart';
import 'payment_info.dart';
import 'upload_box.dart';

/// Step 3 – summary + payment method + receipt upload
/// (Figma `757:2802` third state). Payment options are the active region's
/// rails (`context.regionConfig.paymentRails`: eSewa / Khalti / bank in
/// Nepal, UPI / card / net banking in India).
class BookingPaymentStep extends StatelessWidget {
  const BookingPaymentStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookAppointmentCubit>();
    final state = context.watch<BookAppointmentCubit>().state;
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final textTheme = context.textTheme;
    final fmt = AppointmentFormat.of(context);
    final languageCode = context.languageCode;
    final config = context.regionConfig;
    final slot = state.slot;
    final timeLine = slot == null
        ? '-'
        : '${fmt.traditionalDate(state.date)} ${fmt.slotLabel(slot)}';
    final methods = config.paymentRails.map(PaymentMethod.fromRail).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            children: [
              PaymentSummaryRow(label: strings.time, value: timeLine),
              PaymentSummaryRow(
                label:
                    '${state.service.name.forLanguage(languageCode)} '
                    '(x${fmt.number(state.quantity)})',
                value: fmt.money(state.total),
              ),
              Divider(color: colors.divider),
              PaymentSummaryRow(
                label: strings.total,
                value: fmt.money(state.total),
                bold: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(strings.paymentMethod, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        for (final m in methods)
          AppRadioOption<PaymentMethod>(
            value: m,
            groupValue: state.paymentMethod,
            label: PaymentInfo.label(m, strings, config),
            textStyle: textTheme.bodyMedium,
            onChanged: cubit.setPaymentMethod,
          ),
        const SizedBox(height: AppSpacing.sm),
        PaymentInstructions(method: state.paymentMethod),
        const SizedBox(height: AppSpacing.lg),
        Text(
          strings.receiptNote,
          style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        UploadBox(
          label: strings.uploadReceipt,
          mediaId: state.receiptMediaId,
          onChanged: cubit.setReceipt,
        ),
        if (state.submission case Failed(:final failure)) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            failure.message,
            style: textTheme.bodySmall?.copyWith(color: colors.error),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: strings.back,
                height: 34,
                onPressed: cubit.previousStep,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              flex: 2,
              child: PrimaryButton(
                label: strings.confirmBooking,
                height: 34,
                isLoading: state.submission.isLoading,
                onPressed: cubit.submit,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
