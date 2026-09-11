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
    this.onCancel,
    this.onAccept,
    this.onComplete,
    this.onRate,
    this.onVisitSeller,
    this.onCall,
    this.onChat,
  });

  final OrderSummary order;
  final VoidCallback? onCancel;
  final VoidCallback? onAccept;
  final VoidCallback? onComplete;
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
      (OrderRole.buyer, OrderStatus.processing) => s.orderApproved,
      (OrderRole.buyer, OrderStatus.completed) => s.purchaseCompleted,
      (OrderRole.buyer, OrderStatus.sold) => s.purchaseCompleted,
      (OrderRole.seller, OrderStatus.placed) => s.newOrderReceived,
      (OrderRole.seller, OrderStatus.processing) =>
        '${s.processingOrderTo} ${order.counterpartyName.split(' ').first}',
      (OrderRole.seller, OrderStatus.sold) =>
        '${s.soldTo} ${order.counterpartyName.split(' ').first}',
      (OrderRole.seller, OrderStatus.completed) => s.purchaseCompleted,
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
    switch ((order.role, order.status)) {
      case (OrderRole.buyer, OrderStatus.placed):
        return [
          SmallGradientButton(
            label: s.cancelOrder,
            outlined: true,
            height: 22,
            onPressed: onCancel,
          ),
        ];
      case (OrderRole.buyer, OrderStatus.processing):
        return [statusPill(s.processing, colors.primary)];
      case (_, OrderStatus.completed):
        return [statusPill(s.completed, colors.success)];
      case (OrderRole.seller, OrderStatus.placed):
        return [
          SmallGradientButton(label: s.accept, height: 20, onPressed: onAccept),
          const SizedBox(width: AppSpacing.xs),
          SmallGradientButton(
            label: s.cancel,
            outlined: true,
            height: 20,
            onPressed: onCancel,
          ),
        ];
      case (OrderRole.seller, OrderStatus.processing):
        return [
          SmallGradientButton(
            label: s.complete,
            height: 20,
            onPressed: onComplete,
          ),
          const SizedBox(width: AppSpacing.xs),
          SmallGradientButton(
            label: s.cancel,
            outlined: true,
            height: 20,
            onPressed: onCancel,
          ),
        ];
      case (_, OrderStatus.sold):
        return [statusPill(s.sold, colors.success)];
      case (_, OrderStatus.cancelled):
        return [statusPill(s.cancelled, colors.error)];
    }
  }
}
