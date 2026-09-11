import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/appointment.dart';
import '../cubit/appointment_details_cubit.dart';
import '../cubit/book_appointment_cubit.dart';
import '../l10n/appointment_strings.dart';
import 'booking_calendar.dart';
import 'time_slot_grid.dart';

/// Bottom sheet with calendar + slot grid used to reschedule.
class RescheduleSheet extends StatefulWidget {
  const RescheduleSheet({
    required this.cubit,
    required this.appointment,
    super.key,
  });

  final AppointmentDetailsCubit cubit;
  final Appointment appointment;

  static Future<void> show(
    BuildContext context, {
    required AppointmentDetailsCubit cubit,
    required Appointment appointment,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => RescheduleSheet(cubit: cubit, appointment: appointment),
  );

  @override
  State<RescheduleSheet> createState() => _RescheduleSheetState();
}

class _RescheduleSheetState extends State<RescheduleSheet> {
  late DateTime _date = widget.appointment.date;
  String? _slotId;

  @override
  void initState() {
    super.initState();
    widget.cubit.loadSlots(_date);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
        builder: (context, state) => Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  strings.reschedule,
                  style: context.textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                BookingCalendar(
                  selected: _date,
                  mode: context.usesDevanagariDigits
                      ? DateMode.traditional
                      : DateMode.gregorian,
                  minDate: DateTime.now(),
                  onSelected: (d) {
                    setState(() {
                      _date = d;
                      _slotId = null;
                    });
                    widget.cubit.loadSlots(d);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                Text(strings.selectTime, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                switch (state.slots) {
                  Loading() => const LoadingView(height: 60),
                  Loaded(:final data) when data.isNotEmpty => TimeSlotGrid(
                    slots: data,
                    selectedId: _slotId,
                    onSelected: (s) => setState(() => _slotId = s.id),
                  ),
                  Failed(:final failure) => Text(
                    failure.message,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.error,
                    ),
                  ),
                  _ => Text(
                    strings.noSlots,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
                },
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: strings.reschedule,
                  isLoading: state.action.isLoading,
                  onPressed: _slotId == null
                      ? null
                      : () async {
                          final failure = await widget.cubit.reschedule(
                            _date,
                            _slotId!,
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                failure?.message ?? strings.rescheduled,
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
