import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/order_tracking.dart';

part 'order_strings_en.dart';
part 'order_strings_hi.dart';
part 'order_strings_ne.dart';

/// Feature-local strings for order tracking and returns.
abstract class OrderStrings {
  const OrderStrings();

  static OrderStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  String get myOrders;
  String get sellerOrders;
  String get orderDetails;
  String get filterActive;
  String get filterDelivered;
  String get filterReturns;
  String get filterAll;
  String get noOrders;
  String get noOrdersBody;
  String get noSellerOrdersBody;
  String get stagePlaced;
  String get stageConfirmed;
  String get stagePacked;
  String get stageShipped;
  String get stageOutForDelivery;
  String get stageDelivered;
  String get stageCancelled;
  String get stageReturnRequested;
  String get stageReturnPickedUp;
  String get stageRefunded;
  String get items;
  String get subtotal;
  String get shipping;
  String get discount;
  String get total;
  String get deliverTo;
  String get courier;
  String get trackingNumber;
  String get expectedBy;
  String get orderReference;
  String get rateThisOrder;
  String get requestReturn;
  String get returnWindowClosed;
  String get returnTitle;
  String get selectItems;
  String get returnReason;
  String get returnDetails;
  String get returnDetailsHint;
  String get submitReturn;
  String get returnSubmitted;
  String get reasonDamaged;
  String get reasonWrongItem;
  String get reasonNotAsDescribed;
  String get reasonQualityIssue;
  String get reasonNoLongerNeeded;
  String get reasonOther;
  String get markConfirmed;
  String get markPacked;
  String get markShipped;
  String get markOutForDelivery;
  String get markDelivered;
  String get shippingDetails;
  String get courierHint;
  String get trackingHint;
  String get confirm;
  String get cancel;

  String stageName(OrderStage value);
  String reasonName(ReturnReason value);

  /// The action that moves an order to [next].
  String advanceLabel(OrderStage next);
}
