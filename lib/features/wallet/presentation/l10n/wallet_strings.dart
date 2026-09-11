import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../domain/entities/refund_request.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/entities/wallet_transaction.dart';

part 'wallet_strings_en.dart';
part 'wallet_strings_hi.dart';
part 'wallet_strings_ne.dart';

/// Feature-local strings for the wallet.
abstract class WalletStrings {
  const WalletStrings();

  static WalletStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  // Wallet home
  String get wallet;
  String get availableBalance;
  String get bonusCredit;
  String get bonusNote;
  String get addMoney;
  String get recentActivity;
  String get viewAll;
  String get emptyWalletTitle;
  String get emptyWalletBody;
  String get minutesOfChat;

  // Top-up
  String get addMoneyTitle;
  String get chooseAmount;
  String get customAmount;
  String get customAmountHint;
  String get amountOutOfRange;
  String get youWillGet;
  String get includingBonus;
  String get continueLabel;
  String get paymentMethod;
  String get choosePaymentMethod;
  String get payNow;
  String get popular;
  String get extra;

  // Payment status
  String get paymentStatus;
  String get processing;
  String get processingBody;
  String get paymentSuccessTitle;
  String get paymentSuccessBody;
  String get paymentFailedTitle;
  String get tryAgain;
  /// Sends the payer to the gateway's hosted checkout.
  String get completePayment;

  /// Shown while the payer is away completing it.
  String get completePaymentHint;

  String get takingLongerTitle;
  String get takingLongerBody;
  String get checkAgain;
  String get backToWallet;
  String get reference;
  String get amountAdded;

  // Ledger
  String get transactions;
  String get noTransactions;
  String get noTransactionsHint;
  String get moneyIn;
  String get moneyOut;
  String get all;
  String get filters;
  String get clear;
  String get balanceAfter;

  // Refund
  String get requestRefund;
  String get refundSubtitle;
  String get refundReason;
  String get refundDetails;
  String get refundDetailsHint;
  String get submitRefund;
  String get refundSubmittedTitle;
  String get refundSubmittedBody;
  String get cancel;

  String railName(PaymentRail rail);
  String category(TransactionCategory value);
  String rangeName(LedgerRange value);
  String reasonName(RefundReason value);
  String directionName(TransactionDirection? value);

  /// "≈ 42 min of chat" on the balance card.
  String minutesEstimate(String minutes);
}
