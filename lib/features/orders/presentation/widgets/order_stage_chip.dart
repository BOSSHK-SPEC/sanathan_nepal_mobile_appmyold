import 'package:flutter/material.dart';

import '../../../../core/widgets/status_chip.dart';
import '../../domain/entities/order_tracking.dart';
import '../l10n/order_strings.dart';

/// Status pill for an order stage, with a consistent tone per stage.
class OrderStageChip extends StatelessWidget {
  const OrderStageChip({
    required this.stage,
    required this.strings,
    super.key,
    this.dense = true,
  });

  final OrderStage stage;
  final OrderStrings strings;
  final bool dense;

  StatusTone get _tone => switch (stage) {
    OrderStage.delivered => StatusTone.success,
    OrderStage.cancelled => StatusTone.neutral,
    OrderStage.refunded => StatusTone.info,
    OrderStage.returnRequested ||
    OrderStage.returnPickedUp => StatusTone.warning,
    _ => StatusTone.accent,
  };

  IconData get _icon => switch (stage) {
    OrderStage.placed => Icons.receipt_outlined,
    OrderStage.confirmed => Icons.check_rounded,
    OrderStage.packed => Icons.inventory_2_outlined,
    OrderStage.shipped => Icons.local_shipping_outlined,
    OrderStage.outForDelivery => Icons.delivery_dining_outlined,
    OrderStage.delivered => Icons.done_all_rounded,
    OrderStage.cancelled => Icons.close_rounded,
    OrderStage.returnRequested => Icons.undo_rounded,
    OrderStage.returnPickedUp => Icons.local_shipping_outlined,
    OrderStage.refunded => Icons.savings_outlined,
  };

  @override
  Widget build(BuildContext context) => StatusChip(
    label: strings.stageName(stage),
    tone: _tone,
    icon: _icon,
    dense: dense,
  );
}
