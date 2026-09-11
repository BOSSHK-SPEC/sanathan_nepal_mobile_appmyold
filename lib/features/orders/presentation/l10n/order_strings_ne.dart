part of 'order_strings.dart';

class _Ne extends OrderStrings {
  const _Ne();
  @override
  String get myOrders => 'मेरा अर्डर';
  @override
  String get sellerOrders => 'पूरा गर्नुपर्ने अर्डर';
  @override
  String get orderDetails => 'अर्डर विवरण';
  @override
  String get filterActive => 'चलिरहेको';
  @override
  String get filterDelivered => 'डेलिभर भयो';
  @override
  String get filterReturns => 'फिर्ता';
  @override
  String get filterAll => 'सबै';
  @override
  String get noOrders => 'यहाँ अर्डर छैन';
  @override
  String get noOrdersBody => 'तपाईंले गर्नुभएका अर्डरको प्रगति यहाँ देखिनेछ ।';
  @override
  String get noSellerOrdersBody => 'तपाईंलाई आएका अर्डर यहाँ देखिनेछन् ।';
  @override
  String get stagePlaced => 'अर्डर गरियो';
  @override
  String get stageConfirmed => 'पुष्टि भयो';
  @override
  String get stagePacked => 'प्याक भयो';
  @override
  String get stageShipped => 'पठाइयो';
  @override
  String get stageOutForDelivery => 'डेलिभरीमा';
  @override
  String get stageDelivered => 'डेलिभर भयो';
  @override
  String get stageCancelled => 'रद्द भयो';
  @override
  String get stageReturnRequested => 'फिर्ता अनुरोध';
  @override
  String get stageReturnPickedUp => 'उठाइयो';
  @override
  String get stageRefunded => 'फिर्ता भयो';
  @override
  String get items => 'सामान';
  @override
  String get subtotal => 'उप-जम्मा';
  @override
  String get shipping => 'ढुवानी';
  @override
  String get discount => 'छुट';
  @override
  String get total => 'जम्मा';
  @override
  String get deliverTo => 'यहाँ पठाउने';
  @override
  String get courier => 'कुरियर';
  @override
  String get trackingNumber => 'ट्र्याकिङ नम्बर';
  @override
  String get expectedBy => 'अपेक्षित मिति';
  @override
  String get orderReference => 'अर्डर';
  @override
  String get rateThisOrder => 'किनेको वस्तुको मूल्याङ्कन';

  @override
  String get requestReturn => 'फिर्ता माग्नुहोस्';
  @override
  String get returnWindowClosed => 'यो अर्डरको सात दिने फिर्ता अवधि सकियो ।';
  @override
  String get returnTitle => 'सामान फिर्ता';
  @override
  String get selectItems => 'कुन सामान ?';
  @override
  String get returnReason => 'किन फिर्ता गर्दै ?';
  @override
  String get returnDetails => 'विवरण';
  @override
  String get returnDetailsHint => 'के भयो ?';
  @override
  String get submitReturn => 'फिर्ता पठाउनुहोस्';
  @override
  String get returnSubmitted => 'फिर्ता अनुरोध पठाइयो';
  @override
  String get reasonDamaged => 'बिग्रेको आयो';
  @override
  String get reasonWrongItem => 'गलत सामान आयो';
  @override
  String get reasonNotAsDescribed => 'भनिएजस्तो छैन';
  @override
  String get reasonQualityIssue => 'गुणस्तर समस्या';
  @override
  String get reasonNoLongerNeeded => 'अब चाहिएन';
  @override
  String get reasonOther => 'अन्य';
  @override
  String get markConfirmed => 'अर्डर पुष्टि';
  @override
  String get markPacked => 'प्याक भयो';
  @override
  String get markShipped => 'पठाइयो';
  @override
  String get markOutForDelivery => 'डेलिभरीमा';
  @override
  String get markDelivered => 'डेलिभर भयो';
  @override
  String get shippingDetails => 'ढुवानी विवरण';
  @override
  String get courierHint => 'कुरियरको नाम';
  @override
  String get trackingHint => 'ट्र्याकिङ नम्बर';
  @override
  String get confirm => 'पुष्टि';
  @override
  String get cancel => 'रद्द';
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
