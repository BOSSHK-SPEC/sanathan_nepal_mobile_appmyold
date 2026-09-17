import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/console_appointments_cubit.dart';
import '../l10n/console_strings.dart';
import 'console_appointment_tile.dart';

/// The next few booked sittings, on the console home.
///
/// Astrologers had nowhere to see who had booked them; this is where they
/// look first. Owns its cubit so the dashboard's own loading is unaffected.
class UpcomingAppointmentsSection extends StatelessWidget {
  const UpcomingAppointmentsSection({super.key});

  /// Enough to see the day ahead without pushing the live queue off screen.
  static const int _shown = 3;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ConsoleAppointmentsCubit>()..load(),
    child: BlocBuilder<ConsoleAppointmentsCubit, ConsoleAppointmentsState>(
      builder: (context, state) {
        final s = ConsoleStrings.of(context);
        final colors = context.colors;
        final cubit = context.read<ConsoleAppointmentsCubit>();
        final upcoming = state.upcoming.dataOrNull ?? const [];

        Future<void> open(String? id) async {
          await context.push(
            id == null
                ? AppRoutes.astrologerAppointments
                : AppRoutes.astrologerAppointmentPath(id),
          );
          // Closing or cancelling one changes what is still to come.
          await cubit.load();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionHeader(
              title: s.apptUpcomingSection,
              trailing: TextButton(
                onPressed: () => open(null),
                child: Text(s.apptSeeAll),
              ),
            ),
            switch (state.upcoming) {
              Idle() ||
              Loading(previous: null) => const LoadingView(height: 72),
              Failed(:final failure, previous: null) => Row(
                children: [
                  Expanded(
                    child: Text(
                      failure.message,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: cubit.load,
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
              _ when upcoming.isEmpty => AppCard(
                child: Row(
                  children: [
                    Icon(Icons.event_available_outlined, color: colors.icon),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.apptNoUpcoming,
                            style: context.textTheme.titleSmall,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            s.apptNoUpcomingHint,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _ => Column(
                children: [
                  for (final appointment in upcoming.take(_shown))
                    ConsoleAppointmentTile(
                      appointment: appointment,
                      onTap: () => open(appointment.id),
                    ),
                ],
              ),
            },
          ],
        );
      },
    ),
  );
}
