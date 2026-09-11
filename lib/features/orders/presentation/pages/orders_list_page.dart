import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/order_tracking.dart';
import '../cubit/orders_list_cubit.dart';
import '../l10n/order_strings.dart';
import '../widgets/order_stage_chip.dart';

/// Buyer orders or seller fulfilment, depending on [scope].
class OrdersListPage extends StatelessWidget {
  const OrdersListPage({required this.scope, super.key});

  final OrdersScope scope;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<OrdersListCubit>(param1: scope)..load(),
    child: const _OrdersListView(),
  );
}

class _OrdersListView extends StatelessWidget {
  const _OrdersListView();

  @override
  Widget build(BuildContext context) {
    final s = OrderStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<OrdersListCubit, OrdersListState>(
      builder: (context, state) {
        final cubit = context.read<OrdersListCubit>();
        final isSeller = state.scope == OrdersScope.seller;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: isSeller ? s.sellerOrders : s.myOrders,
            showBack: true,
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pageGutter,
                    vertical: AppSpacing.md,
                  ),
                  child: AppSegmentedControl(
                    segments: [
                      s.filterActive,
                      s.filterDelivered,
                      s.filterReturns,
                      s.filterAll,
                    ],
                    selectedIndex: OrderFilter.values.indexOf(state.filter),
                    onChanged: (i) => cubit.setFilter(OrderFilter.values[i]),
                  ),
                ),
                Expanded(
                  child: switch (state.orders) {
                    Idle() || Loading(previous: null) =>
                      const AppSkeletonList.tiles(count: 4),
                    Failed(:final failure, previous: null) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.load,
                    ),
                    _ when state.isEmpty => EmptyViewWithBody(
                      title: s.noOrders,
                      body: isSeller ? s.noSellerOrdersBody : s.noOrdersBody,
                      icon: Icons.receipt_long_outlined,
                    ),
                    _ => ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.pageGutter,
                        0,
                        AppSpacing.pageGutter,
                        AppSpacing.xxxl,
                      ),
                      children: [
                        for (final order in state.visible)
                          _OrderCard(
                            order: order,
                            strings: s,
                            isSeller: isSeller,
                          ),
                      ],
                    ),
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    required this.strings,
    required this.isSeller,
  });

  final TrackedOrder order;
  final OrderStrings strings;
  final bool isSeller;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final nextIndex = order.fulfilmentIndex + 1;
    final canAdvance = isSeller && nextIndex < OrderStage.fulfilment.length;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      onTap: () => context.push(AppRoutes.orderDetailsPath(order.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${strings.orderReference} ${order.reference}',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
              OrderStageChip(stage: order.stage, strings: strings),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final item in order.items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${item.quantity} × ${item.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${order.counterpartyName} · '
                  '${relativeTime(context, order.placedAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
              MoneyText(order.total, style: context.textTheme.titleSmall),
            ],
          ),
          if (canAdvance) ...[
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: strings.advanceLabel(OrderStage.fulfilment[nextIndex]),
              height: 36,
              onPressed: () => _advance(context, order, nextIndex),
            ),
          ] else if (!isSeller && order.canRequestReturn()) ...[
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              label: strings.requestReturn,
              height: 34,
              onPressed: () =>
                  context.push(AppRoutes.orderReturnPath(order.id)),
            ),
          ],
        ],
      ),
    );
  }

  /// Shipping needs courier details, so that one transition asks for them
  /// rather than failing after the tap.
  Future<void> _advance(
    BuildContext context,
    TrackedOrder order,
    int nextIndex,
  ) async {
    final cubit = context.read<OrdersListCubit>();
    final next = OrderStage.fulfilment[nextIndex];

    if (next != OrderStage.shipped) {
      final ok = await cubit.advance(order);
      if (!ok && context.mounted) {
        AppSnack.error(
          context,
          cubit.state.advancing.errorMessage ?? context.l10n.somethingWentWrong,
        );
      }
      return;
    }

    // Owned by the sheet so they outlive its exit animation, and returned as
    // a value so nothing is read out of them after it has closed.
    final shipping = await AppBottomSheet.show<({String courier, String tracking})>(
      context,
      builder: (sheetContext) => TextControllerScope(
        count: 2,
        builder: (scopeContext, controllers) => AppBottomSheet(
          title: strings.shippingDetails,
          actions: PrimaryButton(
            label: strings.confirm,
            height: 46,
            // The courier is required, so the button waits for one rather than
            // failing after the tap.
            onPressed: controllers.first.text.trim().isEmpty
                ? null
                : () => Navigator.of(scopeContext).pop((
                    courier: controllers.first.text.trim(),
                    tracking: controllers[1].text.trim(),
                  )),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: controllers.first,
                label: strings.courier,
                hint: strings.courierHint,
                required: true,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: controllers[1],
                label: strings.trackingNumber,
                hint: strings.trackingHint,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (shipping == null || !context.mounted) return;
    final courierName = shipping.courier;
    final trackingNumber = shipping.tracking;

    final ok = await cubit.advance(
      order,
      courierName: courierName,
      trackingNumber: trackingNumber,
    );
    if (!ok && context.mounted) {
      AppSnack.error(
        context,
        cubit.state.advancing.errorMessage ?? context.l10n.somethingWentWrong,
      );
    }
  }
}
