import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../cubit/appointment_details_cubit.dart';
import '../l10n/appointment_strings.dart';
import '../widgets/appointment_details_sections.dart';
import '../widgets/appointment_format.dart';
import '../widgets/appointment_status_chip.dart';
import '../widgets/booking_step_header.dart';
import '../widgets/reschedule_sheet.dart';

/// Appointment details (`/appointments/:id`). Re-uses the Basic Info ·
/// Details · Payment structure of the Figma booking page as read-only
/// sections, plus astrologer card (call / chat) and cancel / reschedule.
class AppointmentDetailsPage extends StatelessWidget {
  const AppointmentDetailsPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AppointmentDetailsCubit>()..load(id),
    child: const _DetailsView(),
  );
}

class _DetailsView extends StatefulWidget {
  const _DetailsView();

  @override
  State<_DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<_DetailsView> {
  int _section = 0;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    return BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
      builder: (context, state) => Scaffold(
        appBar: AppTopBar(title: strings.appointmentDetails, showBack: true),
        body: switch (state.appointment) {
          Idle() || Loading() => const LoadingView(),
          Failed(:final failure) => ErrorView(message: failure.message),
          Loaded(:final data) => _buildBody(
            context,
            data,
            state.astrologer.dataOrNull,
            state.action.isLoading,
          ),
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    Appointment a,
    BookableAstrologer? astrologer,
    bool busy,
  ) {
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final textTheme = context.textTheme;
    final fmt = AppointmentFormat.of(context);
    final languageCode = context.languageCode;
    final cubit = context.read<AppointmentDetailsCubit>();
    final canModify = a.status == AppointmentStatus.booked;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.xxl,
      ),
      children: [
        BookingStepHeader(
          currentStep: _section,
          completedThrough: 2,
          onStepTap: (i) => setState(() => _section = i),
        ),
        Divider(color: colors.divider, height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${a.service.name.forLanguage(languageCode)} ${strings.appointment}',
                  style: textTheme.headlineSmall,
                ),
              ),
              Text(
                fmt.money(a.totalAmount),
                style: textTheme.headlineSmall?.copyWith(color: colors.accent),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text('${strings.status}: ', style: textTheme.titleSmall),
            AppointmentStatusChip(status: a.status),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          radius: AppRadius.md,
          child: switch (_section) {
            0 => AppointmentBasicInfoSection(appointment: a),
            1 => AppointmentDetailsSection(appointment: a),
            _ => AppointmentPaymentSection(appointment: a),
          },
        ),
        if (astrologer != null) ...[
          const SizedBox(height: AppSpacing.md),
          AppointmentAstrologerCard(astrologer: astrologer),
        ],
        if (canModify) ...[
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: strings.reschedule,
                  onPressed: busy
                      ? null
                      : () => RescheduleSheet.show(
                          context,
                          cubit: cubit,
                          appointment: a,
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: OutlinedButton(
                  onPressed: busy ? null : () => _confirmCancel(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.error,
                    side: BorderSide(color: colors.error),
                  ),
                  child: Text(strings.cancelAppointment),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _confirmCancel(BuildContext context) async {
    final strings = AppointmentStrings.of(context);
    final cubit = context.read<AppointmentDetailsCubit>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(strings.cancelConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(strings.keep),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(strings.yesCancel),
          ),
        ],
      ),
    );
    if (!(ok ?? false)) return;
    final failure = await cubit.cancel();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(failure?.message ?? strings.cancelled)),
    );
  }
}
