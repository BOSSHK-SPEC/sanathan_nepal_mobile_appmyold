import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/order_summary.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';
import '../../../../core/widgets/rating_stars.dart';
import 'relative_time.dart';
import 'small_gradient_button.dart';

/// Order card for purchases and sales with status pill, product row,
/// Call/Chat buttons, rating stars and "Visit Seller Profile".
class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.order,
    super.key,
    this.onAction,
    this.pending = false,
    this.onRate,
    this.onVisitSeller,
    this.onCall,
    this.onChat,
  });

  final OrderSummary order;

  /// Runs one of [OrderSummary.availableActions]. A single callback rather
  /// than one per action, so adding a step to the fulfilment flow does not
  /// mean threading another closure through three widgets.
  final ValueChanged<OrderAction>? onAction;

  /// True while this order has a request in flight; its buttons are disabled.
  final bool pending;
  final ValueChanged<int>? onRate;
  final VoidCallback? onVisitSeller;
  final VoidCallback? onCall;
  final VoidCallback? onChat;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ProfileStrings.of(context);
    final t = context.textTheme;
    final isBuyer = order.role == OrderRole.buyer;
    final ago = relativeTime(context, order.updatedAt);

    final String headline = switch ((order.role, order.status)) {
      (OrderRole.buyer, OrderStatus.placed) => s.orderPlaced,
      // Paid, and the shop has not answered yet — a different thing from
      // "placed", and the state a buyer most wants named.
      (OrderRole.buyer, OrderStatus.confirmed) => s.awaitingSeller,
      (OrderRole.buyer, OrderStatus.processing) => s.orderApproved,
      (OrderRole.buyer, OrderStatus.shipped) => s.shipped,
      (OrderRole.buyer, OrderStatus.outForDelivery) => s.outForDelivery,
      (OrderRole.buyer, OrderStatus.completed) => s.purchaseCompleted,
      (OrderRole.seller, OrderStatus.placed) ||
      (OrderRole.seller, OrderStatus.confirmed) => s.newOrderReceived,
      (OrderRole.seller, OrderStatus.processing) =>
        '${s.processingOrderTo} ${order.counterpartyName.split(' ').first}',
      (OrderRole.seller, OrderStatus.shipped) => s.shipped,
      (OrderRole.seller, OrderStatus.outForDelivery) => s.outForDelivery,
      (OrderRole.seller, OrderStatus.completed) =>
        '${s.soldTo} ${order.counterpartyName.split(' ').first}',
      (_, OrderStatus.cancelled) => s.orderCancelled,
    };

    return ProfileSectionCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(text: headline),
                      TextSpan(
                        text: '  $ago',
                        style: t.labelSmall?.copyWith(color: colors.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              ..._trailingActions(context, s),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: colors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: order.imageUrl == null
                    ? Icon(Icons.phone_iphone, color: colors.iconMuted)
                    : AppImage(order.imageUrl!),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            order.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: t.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (order.status == OrderStatus.completed && isBuyer)
                          Flexible(
                            child: GestureDetector(
                              onTap: onVisitSeller,
                              child: Text(
                                s.visitSellerProfile,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: t.labelSmall?.copyWith(
                                  color: colors.accent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: colors.accent,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (order.status == OrderStatus.completed && isBuyer)
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.xs,
                        children: [
                          Text(s.rateThisProduct, style: t.labelSmall),
                          RatingStars(
                            rating: (order.rating ?? 0).toDouble(),
                            size: 14,
                            onChanged: onRate,
                          ),
                        ],
                      )
                    else ...[
                      Row(
                        children: [
                          Text(
                            formatMoney(context, order.price),
                            style: t.titleSmall?.copyWith(
                              color: colors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (order.sellingPrice != null) ...[
                            const SizedBox(width: AppSpacing.md),
                            Flexible(
                              child: Text(
                                '${s.sellingPrice}: ${formatMoney(context, order.sellingPrice!)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: t.labelSmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${isBuyer || order.status != OrderStatus.processing ? s.from : s.to} : ${order.counterpartyName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: t.labelSmall?.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ),
                          SmallGradientButton(
                            label: s.call,
                            icon: Icons.call,
                            height: 22,
                            onPressed: onCall,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          SmallGradientButton(
                            label: s.chat,
                            icon: Icons.mark_chat_unread_outlined,
                            height: 22,
                            onPressed: onChat,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _trailingActions(BuildContext context, ProfileStrings s) {
    final colors = context.colors;
    Widget statusPill(String label, Color color) => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: colors.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // Buttons come from the order itself, not from a switch restated here.
    // The old switch offered a seller "Complete" on a freshly placed order —
    // a jump the server refuses — and drew Accept for `placed`, a state where
    // payment has not even settled.
    final actions = order.availableActions;
    if (actions.isEmpty) {
      return switch (order.status) {
        OrderStatus.completed => [statusPill(s.completed, colors.success)],
        OrderStatus.cancelled => [statusPill(s.cancelled, colors.error)],
        OrderStatus.shipped => [statusPill(s.shipped, colors.primary)],
        OrderStatus.outForDelivery => [
          statusPill(s.outForDelivery, colors.primary),
        ],
        _ => [statusPill(s.processing, colors.primary)],
      };
    }

    String label(OrderAction action) => switch (action) {
      OrderAction.accept => s.accept,
      OrderAction.ship => s.markShipped,
      OrderAction.deliver => s.markDelivered,
      // "Cancel Order" for the buyer, whose card has room for it; the seller's
      // row carries two buttons, so it gets the short form.
      OrderAction.cancel => order.role == OrderRole.buyer
          ? s.cancelOrder
          : s.cancel,
    };

    return [
      for (final (index, action) in actions.indexed) ...[
        if (index > 0) const SizedBox(width: AppSpacing.xs),
        SmallGradientButton(
          label: label(action),
          // Cancel is the destructive one, so it never gets the filled
          // treatment that invites a tap.
          outlined: action == OrderAction.cancel,
          height: 22,
          // Disabled while a request is in flight: two taps on Accept sent two
          // transitions, and the second failed with a message about a move
          // nobody asked for.
          onPressed: pending ? null : () => onAction?.call(action),
        ),
      ],
    ];
  }
}
