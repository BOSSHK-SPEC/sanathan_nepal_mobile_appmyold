part of 'wallet_strings.dart';

class _Hi extends WalletStrings {
  const _Hi();
  @override
  String get wallet => 'वॉलेट';
  @override
  String get availableBalance => 'उपलब्ध शेष';
  @override
  String get bonusCredit => 'बोनस क्रेडिट';
  @override
  String get bonusNote => 'परामर्श पर खर्च योग्य, निकाला नहीं जा सकता';
  @override
  String get addMoney => 'पैसे जोड़ें';
  @override
  String get recentActivity => 'हाल की गतिविधि';
  @override
  String get viewAll => 'सभी देखें';
  @override
  String get emptyWalletTitle => 'आपका वॉलेट खाली है';
  @override
  String get emptyWalletBody =>
      'परामर्श शुरू करने के लिए पैसे जोड़ें। शुल्क केवल उपयोग किए गए मिनटों का लगता है।';
  @override
  String get minutesOfChat => 'चैट';
  @override
  String get addMoneyTitle => 'पैसे जोड़ें';
  @override
  String get chooseAmount => 'राशि चुनें';
  @override
  String get customAmount => 'या अपनी राशि लिखें';
  @override
  String get customAmountHint => 'राशि';
  @override
  String get amountOutOfRange => '50 से 1,00,000 के बीच की राशि लिखें';
  @override
  String get youWillGet => 'आपको मिलेगा';
  @override
  String get includingBonus => 'बोनस सहित';
  @override
  String get continueLabel => 'आगे बढ़ें';
  @override
  String get paymentMethod => 'भुगतान का तरीका';
  @override
  String get choosePaymentMethod => 'आप कैसे भुगतान करेंगे?';
  @override
  String get payNow => 'अभी भुगतान करें';
  @override
  String get popular => 'लोकप्रिय';
  @override
  String get extra => 'अतिरिक्त';
  @override
  String get paymentStatus => 'भुगतान';
  @override
  String get processing => 'भुगतान की पुष्टि हो रही है';
  @override
  String get processingBody =>
      'आमतौर पर कुछ सेकंड लगते हैं। यह स्क्रीन खुली रखें।';
  @override
  String get paymentSuccessTitle => 'पैसे जुड़ गए';
  @override
  String get paymentSuccessBody => 'आपका शेष अपडेट हो गया है।';
  @override
  String get paymentFailedTitle => 'भुगतान विफल';
  @override
  String get tryAgain => 'फिर कोशिश करें';
  @override
  @override
  String get completePayment => 'भुगतान पूरा करें';

  @override
  String get completePaymentHint =>
      'खुलने वाली विंडो में भुगतान पूरा करें। सफल होते ही यह स्क्रीन अपने आप अपडेट हो जाएगी।';

  @override
  String get takingLongerTitle => 'सामान्य से अधिक समय लग रहा है';
  @override
  String get takingLongerBody =>
      'बैंक से पुष्टि नहीं आई है। पैसा सुरक्षित है — थोड़ी देर बाद फिर जाँचें।';
  @override
  String get checkAgain => 'फिर जाँचें';
  @override
  String get backToWallet => 'वॉलेट पर लौटें';
  @override
  String get reference => 'संदर्भ';
  @override
  String get amountAdded => 'जोड़ी गई राशि';
  @override
  String get transactions => 'लेन-देन';
  @override
  String get noTransactions => 'अभी कुछ नहीं';
  @override
  String get noTransactionsHint => 'तिथि सीमा बढ़ाएँ या फ़िल्टर हटाएँ।';
  @override
  String get moneyIn => 'आय';
  @override
  String get moneyOut => 'व्यय';
  @override
  String get all => 'सभी';
  @override
  String get filters => 'फ़िल्टर';
  @override
  String get clear => 'हटाएँ';
  @override
  String get balanceAfter => 'शेष';
  @override
  String get requestRefund => 'रिफ़ंड माँगें';
  @override
  String get refundSubtitle =>
      'बताएँ क्या गलत हुआ। अधिकांश रिफ़ंड 48 घंटे में देखे जाते हैं।';
  @override
  String get refundReason => 'कारण';
  @override
  String get refundDetails => 'विवरण';
  @override
  String get refundDetailsHint => 'क्या हुआ?';
  @override
  String get submitRefund => 'अनुरोध भेजें';
  @override
  String get refundSubmittedTitle => 'अनुरोध भेजा गया';
  @override
  String get refundSubmittedBody => 'हम समीक्षा करके वॉलेट में जानकारी देंगे।';
  @override
  String get cancel => 'रद्द करें';
  @override
  String railName(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => 'ईसेवा',
    PaymentRail.khalti => 'खल्ती',
    PaymentRail.upi => 'यूपीआई',
    PaymentRail.card => 'कार्ड',
    PaymentRail.netBanking => 'नेट बैंकिंग',
    PaymentRail.bankTransfer => 'बैंक ट्रांसफ़र',
    PaymentRail.cashOnDelivery => 'नकद',
  };
  @override
  String category(TransactionCategory value) => switch (value) {
    TransactionCategory.topUp => 'पैसे जोड़े',
    TransactionCategory.bonus => 'बोनस',
    TransactionCategory.consultation => 'परामर्श',
    TransactionCategory.report => 'रिपोर्ट',
    TransactionCategory.productPurchase => 'खरीद',
    TransactionCategory.refund => 'रिफ़ंड',
    TransactionCategory.cashback => 'कैशबैक',
    TransactionCategory.adjustment => 'समायोजन',
  };
  @override
  String rangeName(LedgerRange value) => switch (value) {
    LedgerRange.last7Days => 'पिछले 7 दिन',
    LedgerRange.last30Days => 'पिछले 30 दिन',
    LedgerRange.last90Days => 'पिछले 90 दिन',
    LedgerRange.all => 'सभी समय',
  };
  @override
  String reasonName(RefundReason value) => switch (value) {
    RefundReason.sessionNotDelivered => 'परामर्श हुआ ही नहीं',
    RefundReason.poorConnection => 'कॉल बार-बार कटी',
    RefundReason.chargedTwice => 'दो बार शुल्क लगा',
    RefundReason.wrongAmount => 'राशि गलत थी',
    RefundReason.notAsDescribed => 'जैसा बताया गया वैसा नहीं',
    RefundReason.other => 'अन्य',
  };
  @override
  String directionName(TransactionDirection? value) => switch (value) {
    TransactionDirection.credit => moneyIn,
    TransactionDirection.debit => moneyOut,
    null => all,
  };
  @override
  String minutesEstimate(String minutes) => '≈ $minutes मिनट';
}
