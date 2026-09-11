import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/puja_booking.dart';
import '../cubit/my_pujas_cubit.dart';
import '../l10n/puja_strings.dart';

/// The devotee's booked pujas, upcoming first.
class MyPujasPage extends StatelessWidget {
  const MyPujasPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<MyPujasCubit>()..load(),
    child: const _MyPujasView(),
  );
}

class _MyPujasView extends StatelessWidget {
  const _MyPujasView();

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.myPujas, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<MyPujasCubit, MyPujasState>(
          builder: (context, state) {
            final cubit = context.read<MyPujasCubit>();
            return switch (state.bookings) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.refresh,
              ),
              _ when state.isEmpty => EmptyViewWithBody(
                title: s.noPujasTitle,
                body: s.noPujasBody,
                icon: Icons.temple_hindu_outlined,
                actionLabel: s.browsePujas,
                onAction: () => context.push(AppRoutes.pujas),
              ),
              _ => RefreshIndicator(
                onRefresh: cubit.refresh,
                color: colors.accent,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.pageGutter,
                    AppSpacing.md,
                    AppSpacing.pageGutter,
                    AppSpacing.xxxl,
                  ),
                  children: [
                    if (state.upcoming.isNotEmpty) ...[
                      SectionHeader(title: s.upcomingPujas),
                      for (final booking in state.upcoming)
                        _BookingRow(booking: booking),
                    ],
                    if (state.past.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      SectionHeader(title: s.pastPujas),
                      for (final booking in state.past)
                        _BookingRow(booking: booking),
                    ],
                  ],
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  const _BookingRow({required this.booking});

  final PujaBooking booking;

  StatusTone get _tone => switch (booking.status) {
    PujaBookingStatus.pendingPayment => StatusTone.warning,
    PujaBookingStatus.confirmed => StatusTone.info,
    PujaBookingStatus.inProgress => StatusTone.accent,
    PujaBookingStatus.completed => StatusTone.success,
    PujaBookingStatus.cancelled => StatusTone.neutral,
  };

  @override
  Widget build(BuildContext context) {
    final s = PujaStrings.of(context);
    final colors = context.colors;
    final dateFormat = DateFormat.MMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_jm();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        onTap: () => context.push(AppRoutes.pujaBookingPath(booking.id)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.serviceName,
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateFormat.format(booking.scheduledAt),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            // A puja that is running right now is the one thing on this
            // screen worth acting on, so it gets the accent chip.
            StatusChip(
              label: booking.isLive ? s.joinLive : s.statusName(booking.status),
              tone: _tone,
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
