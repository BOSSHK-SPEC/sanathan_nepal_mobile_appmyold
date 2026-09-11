part of 'wallet_strings.dart';

class _Ne extends WalletStrings {
  const _Ne();
  @override
  String get wallet => 'वालेट';
  @override
  String get availableBalance => 'उपलब्ध ब्यालेन्स';
  @override
  String get bonusCredit => 'बोनस क्रेडिट';
  @override
  String get bonusNote => 'परामर्शमा खर्च गर्न मिल्ने, झिक्न मिल्दैन';
  @override
  String get addMoney => 'पैसा थप्नुहोस्';
  @override
  String get recentActivity => 'हालैका कारोबार';
  @override
  String get viewAll => 'सबै हेर्नुहोस्';
  @override
  String get emptyWalletTitle => 'तपाईंको वालेट खाली छ';
  @override
  String get emptyWalletBody =>
      'परामर्श सुरु गर्न पैसा थप्नुहोस् । प्रयोग गरेको मिनेटको मात्र शुल्क लाग्छ ।';
  @override
  String get minutesOfChat => 'च्याट';
  @override
  String get addMoneyTitle => 'पैसा थप्नुहोस्';
  @override
  String get chooseAmount => 'रकम छान्नुहोस्';
  @override
  String get customAmount => 'वा आफ्नै रकम लेख्नुहोस्';
  @override
  String get customAmountHint => 'रकम';
  @override
  String get amountOutOfRange => '५० देखि १,००,००० बीचको रकम लेख्नुहोस्';
  @override
  String get youWillGet => 'तपाईंले पाउनुहुनेछ';
  @override
  String get includingBonus => 'बोनस सहित';
  @override
  String get continueLabel => 'अगाडि बढ्नुहोस्';
  @override
  String get paymentMethod => 'भुक्तानी विधि';
  @override
  String get choosePaymentMethod => 'कसरी भुक्तानी गर्नुहुन्छ ?';
  @override
  String get payNow => 'अहिले तिर्नुहोस्';
  @override
  String get popular => 'लोकप्रिय';
  @override
  String get extra => 'थप';
  @override
  String get paymentStatus => 'भुक्तानी';
  @override
  String get processing => 'भुक्तानी पुष्टि हुँदैछ';
  @override
  String get processingBody =>
      'सामान्यतया केही सेकेन्ड लाग्छ । यो स्क्रिन खुला राख्नुहोस् ।';
  @override
  String get paymentSuccessTitle => 'पैसा थपियो';
  @override
  String get paymentSuccessBody => 'तपाईंको ब्यालेन्स अद्यावधिक भयो ।';
  @override
  String get paymentFailedTitle => 'भुक्तानी असफल';
  @override
  String get tryAgain => 'पुनः प्रयास';
  @override
  @override
  String get completePayment => 'भुक्तानी पूरा गर्नुहोस्';

  @override
  String get completePaymentHint =>
      'खुल्ने विन्डोमा भुक्तानी पूरा गर्नुहोस्। सफल भएपछि यो स्क्रिन आफैँ अपडेट हुन्छ।';

  @override
  String get takingLongerTitle => 'सामान्यभन्दा बढी समय लाग्दैछ';
  @override
  String get takingLongerBody =>
      'बैंकबाट पुष्टि आएको छैन । पैसा हराउँदैन — केही बेरमा फेरि जाँच्नुहोस् ।';
  @override
  String get checkAgain => 'फेरि जाँच्नुहोस्';
  @override
  String get backToWallet => 'वालेटमा फर्कनुहोस्';
  @override
  String get reference => 'सन्दर्भ';
  @override
  String get amountAdded => 'थपिएको रकम';
  @override
  String get transactions => 'कारोबार';
  @override
  String get noTransactions => 'अहिलेसम्म केही छैन';
  @override
  String get noTransactionsHint =>
      'मिति दायरा बढाउनुहोस् वा फिल्टर हटाउनुहोस् ।';
  @override
  String get moneyIn => 'आम्दानी';
  @override
  String get moneyOut => 'खर्च';
  @override
  String get all => 'सबै';
  @override
  String get filters => 'फिल्टर';
  @override
  String get clear => 'हटाउनुहोस्';
  @override
  String get balanceAfter => 'पछिको ब्यालेन्स';
  @override
  String get requestRefund => 'फिर्ता माग्नुहोस्';
  @override
  String get refundSubtitle =>
      'के भयो बताउनुहोस् । अधिकांश फिर्ता ४८ घण्टाभित्र हेरिन्छ ।';
  @override
  String get refundReason => 'कारण';
  @override
  String get refundDetails => 'विवरण';
  @override
  String get refundDetailsHint => 'के भयो ?';
  @override
  String get submitRefund => 'अनुरोध पठाउनुहोस्';
  @override
  String get refundSubmittedTitle => 'अनुरोध पठाइयो';
  @override
  String get refundSubmittedBody =>
      'हामी समीक्षा गरेर वालेटमा जानकारी दिनेछौं ।';
  @override
  String get cancel => 'रद्द';
  @override
  String railName(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => 'इसेवा',
    PaymentRail.khalti => 'खल्ती',
    PaymentRail.upi => 'यूपीआई',
    PaymentRail.card => 'कार्ड',
    PaymentRail.netBanking => 'नेट ब्यांकिङ',
    PaymentRail.bankTransfer => 'बैंक ट्रान्सफर',
    PaymentRail.cashOnDelivery => 'नगद',
  };
  @override
  String category(TransactionCategory value) => switch (value) {
    TransactionCategory.topUp => 'पैसा थपियो',
    TransactionCategory.bonus => 'बोनस',
    TransactionCategory.consultation => 'परामर्श',
    TransactionCategory.report => 'रिपोर्ट',
    TransactionCategory.productPurchase => 'खरिद',
    TransactionCategory.refund => 'फिर्ता',
    TransactionCategory.cashback => 'क्यासब्याक',
    TransactionCategory.adjustment => 'समायोजन',
  };
  @override
  String rangeName(LedgerRange value) => switch (value) {
    LedgerRange.last7Days => 'पछिल्ला ७ दिन',
    LedgerRange.last30Days => 'पछिल्ला ३० दिन',
    LedgerRange.last90Days => 'पछिल्ला ९० दिन',
    LedgerRange.all => 'सबै समय',
  };
  @override
  String reasonName(RefundReason value) => switch (value) {
    RefundReason.sessionNotDelivered => 'परामर्श भएन',
    RefundReason.poorConnection => 'कल बारम्बार काटियो',
    RefundReason.chargedTwice => 'दुई पटक शुल्क लाग्यो',
    RefundReason.wrongAmount => 'रकम गलत थियो',
    RefundReason.notAsDescribed => 'भनिएजस्तो थिएन',
    RefundReason.other => 'अन्य',
  };
  @override
  String directionName(TransactionDirection? value) => switch (value) {
    TransactionDirection.credit => moneyIn,
    TransactionDirection.debit => moneyOut,
    null => all,
  };
  @override
  String minutesEstimate(String minutes) => '≈ $minutes मिनेट';
}
