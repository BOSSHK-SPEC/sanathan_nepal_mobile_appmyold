part of 'order_strings.dart';

class _En extends OrderStrings {
  const _En();
  @override
  String get myOrders => 'My orders';
  @override
  String get sellerOrders => 'Orders to fulfil';
  @override
  String get orderDetails => 'Order details';
  @override
  String get filterActive => 'Active';
  @override
  String get filterDelivered => 'Delivered';
  @override
  String get filterReturns => 'Returns';
  @override
  String get filterAll => 'All';
  @override
  String get noOrders => 'No orders here';
  @override
  String get noOrdersBody => 'Orders you place will show their progress here.';
  @override
  String get noSellerOrdersBody =>
      'Orders placed with you will appear here to accept and ship.';
  @override
  String get stagePlaced => 'Order placed';
  @override
  String get stageConfirmed => 'Confirmed';
  @override
  String get stagePacked => 'Packed';
  @override
  String get stageShipped => 'Shipped';
  @override
  String get stageOutForDelivery => 'Out for delivery';
  @override
  String get stageDelivered => 'Delivered';
  @override
  String get stageCancelled => 'Cancelled';
  @override
  String get stageReturnRequested => 'Return requested';
  @override
  String get stageReturnPickedUp => 'Picked up';
  @override
  String get stageRefunded => 'Refunded';
  @override
  String get items => 'Items';
  @override
  String get subtotal => 'Subtotal';
  @override
  String get shipping => 'Shipping';
  @override
  String get discount => 'Discount';
  @override
  String get total => 'Total';
  @override
  String get deliverTo => 'Deliver to';
  @override
  String get courier => 'Courier';
  @override
  String get trackingNumber => 'Tracking number';
  @override
  String get expectedBy => 'Expected by';
  @override
  String get orderReference => 'Order';
  @override
  String get rateThisOrder => 'Rate what you bought';

  @override
  String get requestReturn => 'Request a return';
  @override
  String get returnWindowClosed =>
      'The seven-day return window has closed for this order.';
  @override
  String get returnTitle => 'Return items';
  @override
  String get selectItems => 'Which items?';
  @override
  String get returnReason => 'Why are you returning?';
  @override
  String get returnDetails => 'Details';
  @override
  String get returnDetailsHint => 'What went wrong?';
  @override
  String get submitReturn => 'Submit return';
  @override
  String get returnSubmitted => 'Return requested';
  @override
  String get reasonDamaged => 'Arrived damaged';
  @override
  String get reasonWrongItem => 'Wrong item sent';
  @override
  String get reasonNotAsDescribed => 'Not as described';
  @override
  String get reasonQualityIssue => 'Quality issue';
  @override
  String get reasonNoLongerNeeded => 'No longer needed';
  @override
  String get reasonOther => 'Something else';
  @override
  String get markConfirmed => 'Confirm order';
  @override
  String get markPacked => 'Mark packed';
  @override
  String get markShipped => 'Mark shipped';
  @override
  String get markOutForDelivery => 'Out for delivery';
  @override
  String get markDelivered => 'Mark delivered';
  @override
  String get shippingDetails => 'Shipping details';
  @override
  String get courierHint => 'Courier name';
  @override
  String get trackingHint => 'Tracking number';
  @override
  String get confirm => 'Confirm';
  @override
  String get cancel => 'Cancel';
  @override
  String stageName(OrderStage value) => switch (value) {
    OrderStage.placed => stagePlaced,
    OrderStage.confirmed => stageConfirmed,
    OrderStage.packed => stagePacked,
    OrderStage.shipped => stageShipped,
    OrderStage.outForDelivery => stageOutForDelivery,
    OrderStage.delivered => stageDelivered,
    OrderStage.cancelled => stageCancelled,
    OrderStage.returnRequested => stageReturnRequested,
    OrderStage.returnPickedUp => stageReturnPickedUp,
    OrderStage.refunded => stageRefunded,
  };
  @override
  String reasonName(ReturnReason value) => switch (value) {
    ReturnReason.damaged => reasonDamaged,
    ReturnReason.wrongItem => reasonWrongItem,
    ReturnReason.notAsDescribed => reasonNotAsDescribed,
    ReturnReason.qualityIssue => reasonQualityIssue,
    ReturnReason.noLongerNeeded => reasonNoLongerNeeded,
    ReturnReason.other => reasonOther,
  };
  @override
  String advanceLabel(OrderStage next) => switch (next) {
    OrderStage.confirmed => markConfirmed,
    OrderStage.packed => markPacked,
    OrderStage.shipped => markShipped,
    OrderStage.outForDelivery => markOutForDelivery,
    OrderStage.delivered => markDelivered,
    _ => stageName(next),
  };
}
