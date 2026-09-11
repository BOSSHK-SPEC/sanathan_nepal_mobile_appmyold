part of 'wallet_strings.dart';

class _En extends WalletStrings {
  const _En();
  @override
  String get wallet => 'Wallet';
  @override
  String get availableBalance => 'Available balance';
  @override
  String get bonusCredit => 'Bonus credit';
  @override
  String get bonusNote => 'Spendable on consultations, not withdrawable';
  @override
  String get addMoney => 'Add money';
  @override
  String get recentActivity => 'Recent activity';
  @override
  String get viewAll => 'View all';
  @override
  String get emptyWalletTitle => 'Your wallet is empty';
  @override
  String get emptyWalletBody =>
      'Add money to start a consultation. You are only charged for the '
      'minutes you use.';
  @override
  String get minutesOfChat => 'of chat';
  @override
  String get addMoneyTitle => 'Add money';
  @override
  String get chooseAmount => 'Choose an amount';
  @override
  String get customAmount => 'Or enter your own';
  @override
  String get customAmountHint => 'Amount';
  @override
  String get amountOutOfRange => 'Enter an amount between 50 and 100,000';
  @override
  String get youWillGet => 'You will get';
  @override
  String get includingBonus => 'including bonus';
  @override
  String get continueLabel => 'Continue';
  @override
  String get paymentMethod => 'Payment method';
  @override
  String get choosePaymentMethod => 'How would you like to pay?';
  @override
  String get payNow => 'Pay now';
  @override
  String get popular => 'Popular';
  @override
  String get extra => 'extra';
  @override
  String get paymentStatus => 'Payment';
  @override
  String get processing => 'Confirming your payment';
  @override
  String get processingBody =>
      'This usually takes a few seconds. Keep this screen open.';
  @override
  String get paymentSuccessTitle => 'Money added';
  @override
  String get paymentSuccessBody => 'Your balance has been updated.';
  @override
  String get paymentFailedTitle => 'Payment failed';
  @override
  String get tryAgain => 'Try again';
  @override
  @override
  String get completePayment => 'Complete payment';

  @override
  String get completePaymentHint =>
      'Finish the payment in the window that opens. This screen updates by itself once it goes through.';

  @override
  String get takingLongerTitle => 'Taking longer than usual';
  @override
  String get takingLongerBody =>
      'Your bank has not confirmed yet. No money is lost — check again in a '
      'moment, or come back later.';
  @override
  String get checkAgain => 'Check again';
  @override
  String get backToWallet => 'Back to wallet';
  @override
  String get reference => 'Reference';
  @override
  String get amountAdded => 'Amount added';
  @override
  String get transactions => 'Transactions';
  @override
  String get noTransactions => 'Nothing here yet';
  @override
  String get noTransactionsHint =>
      'Try a wider date range or clear your filters.';
  @override
  String get moneyIn => 'Money in';
  @override
  String get moneyOut => 'Money out';
  @override
  String get all => 'All';
  @override
  String get filters => 'Filters';
  @override
  String get clear => 'Clear';
  @override
  String get balanceAfter => 'Balance after';
  @override
  String get requestRefund => 'Request a refund';
  @override
  String get refundSubtitle =>
      'Tell us what went wrong. Most refunds are reviewed within 48 hours.';
  @override
  String get refundReason => 'Reason';
  @override
  String get refundDetails => 'Details';
  @override
  String get refundDetailsHint => 'What happened?';
  @override
  String get submitRefund => 'Submit request';
  @override
  String get refundSubmittedTitle => 'Request submitted';
  @override
  String get refundSubmittedBody =>
      'We will review it and update you in the wallet.';
  @override
  String get cancel => 'Cancel';
  @override
  String railName(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => 'eSewa',
    PaymentRail.khalti => 'Khalti',
    PaymentRail.upi => 'UPI',
    PaymentRail.card => 'Card',
    PaymentRail.netBanking => 'Net banking',
    PaymentRail.bankTransfer => 'Bank transfer',
    PaymentRail.cashOnDelivery => 'Cash',
  };
  @override
  String category(TransactionCategory value) => switch (value) {
    TransactionCategory.topUp => 'Money added',
    TransactionCategory.bonus => 'Bonus',
    TransactionCategory.consultation => 'Consultation',
    TransactionCategory.report => 'Report',
    TransactionCategory.productPurchase => 'Purchase',
    TransactionCategory.refund => 'Refund',
    TransactionCategory.cashback => 'Cashback',
    TransactionCategory.adjustment => 'Adjustment',
  };
  @override
  String rangeName(LedgerRange value) => switch (value) {
    LedgerRange.last7Days => 'Last 7 days',
    LedgerRange.last30Days => 'Last 30 days',
    LedgerRange.last90Days => 'Last 90 days',
    LedgerRange.all => 'All time',
  };
  @override
  String reasonName(RefundReason value) => switch (value) {
    RefundReason.sessionNotDelivered => 'The session never happened',
    RefundReason.poorConnection => 'The call kept dropping',
    RefundReason.chargedTwice => 'I was charged twice',
    RefundReason.wrongAmount => 'The amount was wrong',
    RefundReason.notAsDescribed => 'Not what was described',
    RefundReason.other => 'Something else',
  };
  @override
  String directionName(TransactionDirection? value) => switch (value) {
    TransactionDirection.credit => moneyIn,
    TransactionDirection.debit => moneyOut,
    null => all,
  };
  @override
  String minutesEstimate(String minutes) => '≈ $minutes min';
}
