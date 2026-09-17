import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/book_appointment_cubit.dart';
import '../l10n/appointment_strings.dart';
import 'appointment_format.dart';
import 'booking_calendar.dart';
import 'time_slot_grid.dart';

/// Step 1 – sitting channel, date (traditional / Gregorian toggle),
/// calendar + slots (Figma `757:2802` first state). The traditional side is
/// Bikram Sambat in Nepal and Saka in India (`context.traditionalCalendar`);
/// the time-zone label comes from the region config (NST / IST).
class BookingBasicInfoStep extends StatelessWidget {
  const BookingBasicInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookAppointmentCubit>();
    final state = context.watch<BookAppointmentCubit>().state;
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final textTheme = context.textTheme;
    final fmt = AppointmentFormat.of(context);
    final languageCode = context.languageCode;
    final labelStyle = textTheme.labelSmall?.copyWith(
      color: colors.textMuted,
      fontWeight: FontWeight.w600,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.service, style: labelStyle),
                  const SizedBox(height: AppSpacing.xs),
                  DropdownButtonFormField<String>(
                    initialValue: state.serviceId,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    style: textTheme.bodyMedium,
                    items: [
                      for (final s in state.astrologer.services)
                        DropdownMenuItem(
                          value: s.id,
                          // The length is part of what is being bought. Named
                          // here, "₹30,000" stops looking like a mistake and
                          // starts looking like half an hour at ₹1,000/min.
                          child: Text(
                            '${s.name.forLanguage(languageCode)} · '
                            '${strings.minutesLabel(fmt.digits('${s.durationMinutes}'))} '
                            '(${fmt.money(s.price)})',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: (v) => v == null ? null : cubit.selectService(v),
                  ),
                  if (state.service.ratePerMinute > 0) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      strings.rateBreakdown(
                        fmt.money(state.service.ratePerMinute),
                        fmt.digits('${state.service.durationMinutes}'),
                      ),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSpacing.xs,
                children: [
                  Text(strings.selectDate, style: labelStyle),
                  AppRadioOption<DateMode>(
                    value: DateMode.traditional,
                    groupValue: state.dateMode,
                    label: fmt.eraLabel,
                    textStyle: textTheme.labelSmall,
                    onChanged: cubit.setDateMode,
                  ),
                  AppRadioOption<DateMode>(
                    value: DateMode.gregorian,
                    groupValue: state.dateMode,
                    label: strings.ad,
                    textStyle: textTheme.labelSmall,
                    onChanged: cubit.setDateMode,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: colors.border),
                borderRadius: AppRadius.input,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.dateMode == DateMode.traditional
                        ? fmt.traditionalIso(state.date)
                        : fmt.adIso(state.date),
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: colors.accent,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingCalendar(
                selected: state.date,
                mode: state.dateMode,
                minDate: DateTime.now(),
                availableDays: state.availableDays.isEmpty
                    ? null
                    : state.availableDays.toSet(),
                onSelected: cubit.selectDate,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(strings.selectTime, style: labelStyle),
              const SizedBox(height: AppSpacing.sm),
              switch (state.slots) {
                Loading() => const LoadingView(height: 60),
                Loaded(:final data) when data.isNotEmpty => TimeSlotGrid(
                  slots: data,
                  selectedId: state.slotId,
                  onSelected: (s) => cubit.selectSlot(s.id),
                ),
                Failed(:final failure) => Text(
                  failure.message,
                  style: textTheme.bodySmall?.copyWith(color: colors.error),
                ),
                _ => Text(
                  strings.noSlots,
                  style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                ),
              },
              const SizedBox(height: AppSpacing.md),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('${strings.timeZone}: ', style: labelStyle),
                  Text(fmt.timeZoneNow(), style: textTheme.labelSmall),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  label: strings.next,
                  expanded: false,
                  height: 30,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  onPressed: state.canProceedFromBasic ? cubit.nextStep : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
