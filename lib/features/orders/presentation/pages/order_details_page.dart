import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/order_tracking.dart';
import '../cubit/order_tracking_cubit.dart';
import '../l10n/order_strings.dart';
import '../widgets/order_stage_chip.dart';

/// One order: timeline, items, totals and the return entry point.
class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({required this.orderId, super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<OrderTrackingCubit>(param1: orderId)..load(),
    child: const _OrderDetailsView(),
  );
}

class _OrderDetailsView extends StatelessWidget {
  const _OrderDetailsView();

  @override
  Widget build(BuildContext context) {
    final s = OrderStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
      builder: (context, state) {
        final cubit = context.read<OrderTrackingCubit>();
        final order = state.tracked;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: order == null
                ? s.orderDetails
                : '${s.orderReference} ${order.reference}',
            showBack: true,
          ),
          body: SafeArea(
            top: false,
            child: order == null
                ? (state.order.isFailed
                      ? ErrorView(
                          message: state.order.errorMessage,
                          onRetry: cubit.load,
                        )
                      : const LoadingView())
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.pageGutter),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OrderStageChip(
                          stage: order.stage,
                          strings: s,
                          dense: false,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppCard(
                        child: AppTimeline(
                          steps: _timelineSteps(context, order, s),
                        ),
                      ),
                      if (order.courierName != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        AppCard(
                          child: KeyValueList(
                            divided: true,
                            children: [
                              KeyValueRow(
                                label: s.courier,
                                value: order.courierName!,
                                icon: Icons.local_shipping_outlined,
                              ),
                              if (order.trackingNumber != null)
                                KeyValueRow(
                                  label: s.trackingNumber,
                                  value: order.trackingNumber!,
                                ),
                              if (order.expectedBy != null)
                                KeyValueRow(
                                  label: s.expectedBy,
                                  value: DateFormat.yMMMEd(
                                    context.languageCode,
                                  ).format(order.expectedBy!),
                                ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      Text(s.items, style: context.textTheme.titleSmall),
                      const SizedBox(height: AppSpacing.sm),
                      AppCard(
                        child: Column(
                          children: [
                            for (final item in order.items)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${item.quantity} × ${item.name}',
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ),
                                    MoneyText(
                                      item.lineTotal,
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            Divider(color: colors.divider),
                            KeyValueRow(
                              label: s.subtotal,
                              valueWidget: MoneyText(
                                order.subtotal,
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                            KeyValueRow(
                              label: s.shipping,
                              valueWidget: MoneyText(
                                order.shipping,
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                            if (order.discount > 0)
                              KeyValueRow(
                                label: s.discount,
                                valueWidget: MoneyText(
                                  -order.discount,
                                  signed: true,
                                  style: context.textTheme.bodyMedium,
                                  color: colors.success,
                                ),
                              ),
                            KeyValueRow(
                              label: s.total,
                              emphasised: true,
                              valueWidget: MoneyText(
                                order.total,
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppCard(
                        child: KeyValueRow(
                          label: s.deliverTo,
                          value: order.deliveryAddress,
                          icon: Icons.place_outlined,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      // Delivered is the moment a buyer has an opinion; the
                      // prompt belongs here, not only in a separate list.
                      if (order.isDelivered) ...[
                        SecondaryButton(
                          label: s.rateThisOrder,
                          onPressed: () =>
                              context.push(AppRoutes.pendingReviews),
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                      if (order.canRequestReturn())
                        PrimaryButton(
                          label: s.requestReturn,
                          height: 46,
                          onPressed: () =>
                              context.push(AppRoutes.orderReturnPath(order.id)),
                        )
                      else if (order.isDelivered && !order.hasReturn)
                        Text(
                          s.returnWindowClosed,
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  /// Fulfilment stages as the timeline, with the return branch appended
  /// rather than folded into the forward path.
  List<TimelineStep> _timelineSteps(
    BuildContext context,
    TrackedOrder order,
    OrderStrings s,
  ) {
    DateTime? at(OrderStage stage) => order.events
        .where((e) => e.stage == stage)
        .map((e) => e.at)
        .firstOrNull;

    final reached = order.fulfilmentIndex;
    final steps = <TimelineStep>[
      for (var i = 0; i < OrderStage.fulfilment.length; i++)
        TimelineStep(
          title: s.stageName(OrderStage.fulfilment[i]),
          timestamp: at(OrderStage.fulfilment[i]) == null
              ? null
              : DateFormat.MMMd(
                  context.languageCode,
                ).format(at(OrderStage.fulfilment[i])!),
          state: order.stage == OrderStage.cancelled
              ? TimelineStepState.pending
              : i < reached
              ? TimelineStepState.done
              : i == reached
              ? TimelineStepState.current
              : TimelineStepState.pending,
        ),
    ];

    if (order.hasReturn) {
      for (final stage in [
        OrderStage.returnRequested,
        OrderStage.returnPickedUp,
        OrderStage.refunded,
      ]) {
        steps.add(
          TimelineStep(
            title: s.stageName(stage),
            timestamp: at(stage) == null
                ? null
                : DateFormat.MMMd(context.languageCode).format(at(stage)!),
            state: at(stage) != null
                ? (order.stage == stage
                      ? TimelineStepState.current
                      : TimelineStepState.done)
                : TimelineStepState.pending,
          ),
        );
      }
    }
    return steps;
  }
}
