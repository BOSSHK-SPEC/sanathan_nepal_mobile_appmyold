import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/console_appointment.dart';
import '../cubit/console_appointments_cubit.dart';
import '../l10n/console_strings.dart';
import '../widgets/console_appointment_tile.dart';

/// Every sitting booked with the astrologer: still to come, or already over.
class ConsoleAppointmentsPage extends StatelessWidget {
  const ConsoleAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ConsoleAppointmentsCubit>()..load(),
    child: const _AppointmentsView(),
  );
}

class _AppointmentsView extends StatelessWidget {
  const _AppointmentsView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.apptTitle, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<ConsoleAppointmentsCubit, ConsoleAppointmentsState>(
          builder: (context, state) {
            final cubit = context.read<ConsoleAppointmentsCubit>();
            final list = state.current.dataOrNull ?? const [];

            Future<void> open(ConsoleAppointment appointment) async {
              await context.push(
                AppRoutes.astrologerAppointmentPath(appointment.id),
              );
              await cubit.load();
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                  ),
                  child: AppSegmentedControl(
                    segments: [s.apptUpcomingTab, s.apptPastTab],
                    selectedIndex: state.scope.index,
                    onChanged: (index) =>
                        cubit.selectScope(AppointmentScope.values[index]),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: cubit.load,
                    child: switch (state.current) {
                      Idle() || Loading(previous: null) =>
                        const AppSkeletonList.tiles(count: 4),
                      Failed(:final failure, previous: null) => ErrorView(
                        message: failure.message,
                        onRetry: cubit.load,
                      ),
                      // Scrollable even when empty, so pulling still refreshes.
                      _ when list.isEmpty => ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: AppSpacing.xxxl),
                          state.scope == AppointmentScope.upcoming
                              ? EmptyViewWithBody(
                                  title: s.apptNoUpcoming,
                                  body: s.apptNoUpcomingHint,
                                  icon: Icons.event_available_outlined,
                                )
                              : EmptyView(
                                  message: s.apptNoPast,
                                  icon: Icons.history_rounded,
                                ),
                        ],
                      ),
                      _ => ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.pageGutter,
                          0,
                          AppSpacing.pageGutter,
                          AppSpacing.xxxl,
                        ),
                        children: [
                          for (final appointment in list)
                            ConsoleAppointmentTile(
                              appointment: appointment,
                              onTap: () => open(appointment),
                            ),
                        ],
                      ),
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
