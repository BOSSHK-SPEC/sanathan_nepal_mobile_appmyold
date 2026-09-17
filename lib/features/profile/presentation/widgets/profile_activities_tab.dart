import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/appointment_summary.dart';
import '../../domain/entities/order_summary.dart';
import '../cubit/activity_cubit.dart';
import '../l10n/profile_strings.dart';
import 'appointment_card.dart';
import 'order_card.dart';
import 'profile_section_card.dart';
import 'small_gradient_button.dart';
import 'sub_tab_bar.dart';

/// ACTIVITIES tab: "My Appointments | My Orders" with the orders view split
/// into "User: My Purchase | Seller: My Sales".
class ProfileActivitiesTab extends StatefulWidget {
  const ProfileActivitiesTab({super.key});

  @override
  State<ProfileActivitiesTab> createState() => _ProfileActivitiesTabState();
}

class _ProfileActivitiesTabState extends State<ProfileActivitiesTab> {
  int _section = 0;
  int _orderRole = 0;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    return BlocConsumer<ActivityCubit, ActivityState>(
      // An accept or cancel that the server refused used to change nothing on
      // screen — the reason went into a slice this tab only reads when the
      // list is empty, so the button looked broken. Now it is said out loud.
      listenWhen: (p, n) => p.actionError != n.actionError,
      listener: (context, state) {
        final message = state.actionError;
        if (message == null) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        context.read<ActivityCubit>().clearActionError();
      },
      builder: (context, state) {
        final appointments = state.appointments.dataOrNull;
        if (appointments == null && state.orders.dataOrNull == null) {
          // Nothing to show yet: error only when both slices failed.
          if (state.appointments.isFailed && state.orders.isFailed) {
            return ErrorView(
              message: state.orders.errorMessage,
              onRetry: context.read<ActivityCubit>().load,
            );
          }
          return const LoadingView(height: 160);
        }
        return Column(
          children: [
            SubTabBar(
              labels: [s.myAppointments, s.myOrders],
              selectedIndex: _section,
              onChanged: (i) => setState(() => _section = i),
            ),
            const SizedBox(height: AppSpacing.md),
            if (_section == 0)
              _AppointmentsSection(appointments: appointments ?? const [])
            else ...[
              SubTabBar(
                labels: [s.userMyPurchase, s.sellerMySales],
                selectedIndex: _orderRole,
                onChanged: (i) => setState(() => _orderRole = i),
              ),
              const SizedBox(height: AppSpacing.md),
              _OrdersSection(
                orders: _orderRole == 0 ? state.purchases : state.sales,
                errorMessage: state.orders.isFailed
                    ? state.orders.errorMessage
                    : null,
                pendingOrderId: state.pendingOrderId,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _AppointmentsSection extends StatelessWidget {
  const _AppointmentsSection({required this.appointments});
  final List<AppointmentSummary> appointments;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    // The invitation is for people who have nothing booked. It used to be
    // printed above the list unconditionally, so someone with an appointment
    // tomorrow was told they had none, directly above it.
    if (appointments.isEmpty) {
      return ProfileSectionCard(
        child: Column(
          children: [
            Text(s.noAppointments, style: context.textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            SmallGradientButton(
              label: s.bookAppointmentNow,
              height: 30,
              radius: AppRadius.pill,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              onPressed: () => _book(context),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (final a in appointments)
          AppointmentCard(
            appointment: a,
            onTap: () => _openDetails(context, a.id),
          ),
        const SizedBox(height: AppSpacing.md),
        // Booking stays reachable from here: people book again while they
        // already have a sitting on the calendar.
        SmallGradientButton(
          label: s.bookAppointmentNow,
          height: 30,
          radius: AppRadius.pill,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          onPressed: () => _book(context),
        ),
      ],
    );
  }
}

/// Opens one appointment and reloads the tab afterwards.
///
/// Cancelling and rescheduling both happen on the details screen, so the
/// summary here is stale by the time the user comes back — it kept showing
/// the old time for an appointment they had just moved.
Future<void> _openDetails(BuildContext context, String id) async {
  final cubit = context.read<ActivityCubit>();
  await context.push(AppRoutes.appointmentDetailsPath(id));
  await cubit.load();
}

/// Sends the user off to book, and picks up the new appointment on return.
Future<void> _book(BuildContext context) async {
  final cubit = context.read<ActivityCubit>();
  await context.push(AppRoutes.appointmentAstrologers);
  await cubit.load();
}

class _OrdersSection extends StatelessWidget {
  const _OrdersSection({
    required this.orders,
    this.errorMessage,
    this.pendingOrderId,
  });
  final List<OrderSummary> orders;

  /// Set when the orders could not be loaded and there is nothing to show.
  final String? errorMessage;

  /// The order with a request in flight, so its buttons can be disabled.
  final String? pendingOrderId;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final cubit = context.read<ActivityCubit>();
    // A failed load is not an empty history. Saying "No orders yet" to
    // someone whose orders simply did not load sent them hunting for an
    // order that was there all along.
    if (orders.isEmpty && errorMessage != null) {
      return ErrorView(message: errorMessage, onRetry: cubit.load);
    }
    if (orders.isEmpty) {
      return ProfileSectionCard(
        child: Column(
          children: [
            Text(
              s.noOrdersYet,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(s.noOngoingOrders, style: context.textTheme.bodySmall),
            const SizedBox(height: AppSpacing.md),
            SmallGradientButton(
              label: s.browseProducts,
              height: 30,
              radius: AppRadius.pill,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              onPressed: () => context.go(AppRoutes.marketplace),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        for (final o in orders)
          OrderCard(
            order: o,
            onAction: (action) => cubit.act(o, action),
            pending: pendingOrderId == o.id,
            onRate: (r) => cubit.rate(o.id, r),
            onVisitSeller: () =>
                context.push(AppRoutes.businessProfilePath(o.counterpartyId)),
            onCall: () {},
            onChat: () {},
          ),
      ],
    );
  }
}
