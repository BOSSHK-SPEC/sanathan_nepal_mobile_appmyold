import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../cubit/book_appointment_cubit.dart';
import '../l10n/appointment_strings.dart';
import '../widgets/appointment_format.dart';
import '../widgets/booking_basic_info_step.dart';
import '../widgets/booking_details_step.dart';
import '../widgets/booking_payment_step.dart';
import '../widgets/booking_step_header.dart';

/// 3-step booking wizard (Figma "Appointment Details Page" `757:2802` /
/// dark `773:2443`): Basic Info → Details → Payment.
///
/// Opened from the astrologer profile via [BookAppointmentPage.open]; on
/// success it pops with the new appointment id (caller opens details).
class BookAppointmentPage extends StatelessWidget {
  const BookAppointmentPage({
    required this.astrologer,
    super.key,
    this.initialServiceId,
  });

  final BookableAstrologer astrologer;
  final String? initialServiceId;

  /// Pushes the wizard on the root navigator and resolves with the booked
  /// appointment id (or null when dismissed).
  static Future<String?> open(
    BuildContext context, {
    required BookableAstrologer astrologer,
    String? initialServiceId,
  }) => Navigator.of(context, rootNavigator: true).push<String>(
    MaterialPageRoute(
      builder: (_) => BookAppointmentPage(
        astrologer: astrologer,
        initialServiceId: initialServiceId,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // A astrologer can exist with nothing bookable — newly approved, or with
    // every service withdrawn. The wizard is built entirely around "the
    // selected service", so it is not opened at all rather than opened onto
    // an empty one.
    if (astrologer.services.isEmpty) {
      final strings = AppointmentStrings.of(context);
      return Scaffold(
        appBar: AppTopBar(title: strings.appointment, showBack: true),
        body: SafeArea(
          child: EmptyViewWithBody(
            title: strings.noServicesTitle,
            body: strings.noServicesBody,
            icon: Icons.event_busy_outlined,
          ),
        ),
      );
    }

    return BlocProvider(
      create: (_) =>
          GetIt.I<BookAppointmentCubit>(
              param1: astrologer,
              param2: initialServiceId,
            )
            ..openOnFirstFreeDay()
            ..prefillFromProfile(),
      child: const _BookAppointmentView(),
    );
  }
}

class _BookAppointmentView extends StatelessWidget {
  const _BookAppointmentView();

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final textTheme = context.textTheme;
    final fmt = AppointmentFormat.of(context);
    final languageCode = context.languageCode;
    return BlocConsumer<BookAppointmentCubit, BookAppointmentState>(
      listenWhen: (p, c) => p.submission != c.submission,
      listener: (context, state) {
        if (state.submission case Loaded(data: final booked)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(strings.bookingSuccess)));
          Navigator.of(context).pop(booked.id);
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookAppointmentCubit>();
        return Scaffold(
          appBar: AppTopBar(
            title: strings.appointment,
            showBack: true,
            onBack: () => Navigator.of(context).pop(),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              children: [
                BookingStepHeader(
                  currentStep: state.step.index,
                  completedThrough: state.step.index,
                  onStepTap: cubit.goToStep,
                ),
                Divider(color: colors.divider, height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${state.service.name.forLanguage(languageCode)} '
                          '${strings.appointment}',
                          style: textTheme.headlineSmall,
                        ),
                      ),
                      // The total, with the sum that produced it underneath.
                      // The astrologer's own profile advertises a per-minute
                      // rate; landing on a four-figure total with no bridge
                      // between the two is what made this look wrong.
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            fmt.money(state.total),
                            style: textTheme.headlineSmall?.copyWith(
                              color: colors.accent,
                            ),
                          ),
                          if (state.service.ratePerMinute > 0)
                            Text(
                              strings.rateBreakdown(
                                fmt.money(state.service.ratePerMinute),
                                fmt.digits('${state.service.durationMinutes}'),
                              ),
                              style: textTheme.labelSmall?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                switch (state.step) {
                  BookingStep.basicInfo => const BookingBasicInfoStep(),
                  BookingStep.details => const BookingDetailsStep(),
                  BookingStep.payment => const BookingPaymentStep(),
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
