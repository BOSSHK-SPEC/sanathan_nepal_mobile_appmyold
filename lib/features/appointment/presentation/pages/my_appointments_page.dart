import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/appointment.dart';
import '../cubit/appointment_list_cubit.dart';
import '../l10n/appointment_strings.dart';
import '../widgets/appointment_summary_card.dart';

/// The user's own appointments — what `/appointments` should have opened all
/// along.
///
/// It previously landed on one arbitrary astrologer's profile with "My
/// Appointments" buried as the fifth tab, so tapping Appointment showed
/// somebody's bio instead of your bookings. The astrologer profile now lives
/// at its own route and is reached by choosing a astrologer.
class MyAppointmentsPage extends StatelessWidget {
  const MyAppointmentsPage({super.key, this.initialTab = 0});

  /// 0 Upcoming · 1 Past.
  final int initialTab;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AppointmentListCubit>()..load(),
    child: MyAppointmentsView(initialTab: initialTab),
  );
}

/// Widget-testable body of [MyAppointmentsPage].
class MyAppointmentsView extends StatefulWidget {
  const MyAppointmentsView({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<MyAppointmentsView> createState() => _MyAppointmentsViewState();
}

class _MyAppointmentsViewState extends State<MyAppointmentsView> {
  late int _tab = widget.initialTab;

  Future<void> _open(Appointment appointment) async {
    await context.push(AppRoutes.appointmentDetailsPath(appointment.id));
    if (!mounted) return;
    // Cancelling or rescheduling happens on the details screen, so the list
    // is stale by the time we come back.
    await context.read<AppointmentListCubit>().refreshAppointments();
  }

  Future<void> _book() async {
    await context.push(AppRoutes.appointmentAstrologers);
    if (!mounted) return;
    await context.read<AppointmentListCubit>().refreshAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppointmentStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<AppointmentListCubit, AppointmentListState>(
      builder: (context, state) {
        final cubit = context.read<AppointmentListCubit>();
        final list = _tab == 0 ? state.upcoming : state.past;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.myAppointments, showBack: true),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.sm,
                  ),
                  child: PillTabs(
                    labels: [s.upcoming, s.past],
                    selectedIndex: _tab,
                    filled: false,
                    onChanged: (i) => setState(() => _tab = i),
                  ),
                ),
                Expanded(
                  child: switch (state.appointments) {
                    Idle() || Loading(previous: null) =>
                      const AppSkeletonList.tiles(count: 3),
                    Failed(:final failure, previous: null) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.load,
                    ),
                    // Upcoming and past are different kinds of empty: one is
                    // an invitation, the other is simply a fact.
                    _ when list.isEmpty && _tab == 0 => EmptyViewWithBody(
                      title: s.noUpcomingTitle,
                      body: s.noUpcomingBody,
                      icon: Icons.event_available_outlined,
                      actionLabel: s.bookAppointment,
                      onAction: _book,
                    ),
                    _ when list.isEmpty => EmptyViewWithBody(
                      title: s.noPastTitle,
                      body: s.noPastBody,
                      icon: Icons.history_rounded,
                    ),
                    _ => RefreshIndicator(
                      onRefresh: cubit.refreshAppointments,
                      color: colors.accent,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
                        itemCount: list.length,
                        itemBuilder: (context, i) => AppointmentSummaryCard(
                          appointment: list[i],
                          showDivider: i > 0,
                          onTap: () => _open(list[i]),
                        ),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
          // Booking stays one tap away even when the list is full — the
          // empty-state button cannot be the only route to it.
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _book,
            icon: const Icon(Icons.add_rounded),
            // The short form: `bookNow` is the page-wide CTA on a astrologer
            // profile and is far too long for a floating button.
            label: Text(s.bookAppointment),
          ),
        );
      },
    );
  }
}
