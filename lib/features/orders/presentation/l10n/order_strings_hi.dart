part of 'order_strings.dart';

class _Hi extends OrderStrings {
  const _Hi();
  @override
  String get myOrders => 'मेरे ऑर्डर';
  @override
  String get sellerOrders => 'पूरे करने वाले ऑर्डर';
  @override
  String get orderDetails => 'ऑर्डर विवरण';
  @override
  String get filterActive => 'सक्रिय';
  @override
  String get filterDelivered => 'डिलीवर हुआ';
  @override
  String get filterReturns => 'वापसी';
  @override
  String get filterAll => 'सभी';
  @override
  String get noOrders => 'यहाँ कोई ऑर्डर नहीं';
  @override
  String get noOrdersBody => 'आपके ऑर्डर की प्रगति यहाँ दिखेगी।';
  @override
  String get noSellerOrdersBody => 'आपको मिले ऑर्डर यहाँ दिखेंगे।';
  @override
  String get stagePlaced => 'ऑर्डर किया';
  @override
  String get stageConfirmed => 'पुष्टि हुई';
  @override
  String get stagePacked => 'पैक हुआ';
  @override
  String get stageShipped => 'भेजा गया';
  @override
  String get stageOutForDelivery => 'डिलीवरी पर';
  @override
  String get stageDelivered => 'डिलीवर हुआ';
  @override
  String get stageCancelled => 'रद्द हुआ';
  @override
  String get stageReturnRequested => 'वापसी अनुरोध';
  @override
  String get stageReturnPickedUp => 'उठाया गया';
  @override
  String get stageRefunded => 'रिफ़ंड हुआ';
  @override
  String get items => 'सामान';
  @override
  String get subtotal => 'उप-योग';
  @override
  String get shipping => 'शिपिंग';
  @override
  String get discount => 'छूट';
  @override
  String get total => 'कुल';
  @override
  String get deliverTo => 'यहाँ भेजें';
  @override
  String get courier => 'कूरियर';
  @override
  String get trackingNumber => 'ट्रैकिंग नंबर';
  @override
  String get expectedBy => 'अपेक्षित तिथि';
  @override
  String get orderReference => 'ऑर्डर';
  @override
  String get rateThisOrder => 'ख़रीदी वस्तु को रेट करें';

  @override
  String get requestReturn => 'वापसी माँगें';
  @override
  String get returnWindowClosed =>
      'इस ऑर्डर की सात दिन की वापसी अवधि समाप्त हो गई।';
  @override
  String get returnTitle => 'सामान वापसी';
  @override
  String get selectItems => 'कौन-सा सामान?';
  @override
  String get returnReason => 'वापसी का कारण?';
  @override
  String get returnDetails => 'विवरण';
  @override
  String get returnDetailsHint => 'क्या हुआ?';
  @override
  String get submitReturn => 'वापसी भेजें';
  @override
  String get returnSubmitted => 'वापसी अनुरोध भेजा गया';
  @override
  String get reasonDamaged => 'क्षतिग्रस्त आया';
  @override
  String get reasonWrongItem => 'गलत सामान आया';
  @override
  String get reasonNotAsDescribed => 'बताए अनुसार नहीं';
  @override
  String get reasonQualityIssue => 'गुणवत्ता समस्या';
  @override
  String get reasonNoLongerNeeded => 'अब आवश्यकता नहीं';
  @override
  String get reasonOther => 'अन्य';
  @override
  String get markConfirmed => 'ऑर्डर पुष्टि';
  @override
  String get markPacked => 'पैक चिह्नित करें';
  @override
  String get markShipped => 'भेजा चिह्नित करें';
  @override
  String get markOutForDelivery => 'डिलीवरी पर';
  @override
  String get markDelivered => 'डिलीवर चिह्नित करें';
  @override
  String get shippingDetails => 'शिपिंग विवरण';
  @override
  String get courierHint => 'कूरियर का नाम';
  @override
  String get trackingHint => 'ट्रैकिंग नंबर';
  @override
  String get confirm => 'पुष्टि';
  @override
  String get cancel => 'रद्द करें';
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
