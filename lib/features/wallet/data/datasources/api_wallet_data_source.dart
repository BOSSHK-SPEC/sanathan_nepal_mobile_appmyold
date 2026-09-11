import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/region/region.dart';
import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/refund_request.dart';
import '../../domain/entities/topup_option.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/entities/wallet_balance.dart';
import '../../domain/entities/wallet_transaction.dart';
import 'wallet_data_source.dart';

/// The wallet, served by the backend.
///
/// Nothing here computes a balance. Every figure comes from the server's
/// double-entry ledger, which is the only thing that can be right when two
/// devices spend at once — a client-side total would drift the moment a
/// consultation billed in the background.
class ApiWalletDataSource implements WalletDataSource {
  const ApiWalletDataSource(this._client);

  final ApiClient _client;

  @override
  Future<WalletBalance> getBalance() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.walletBalance);
    final json = asJsonMap(response);

    // `spendable` already has reserved funds removed, which is what the user
    // may actually spend; `balance` alone would overstate it while a
    // consultation is live.
    final spendable = ApiMoney.toMajor(json['spendableMinor']);
    final total = ApiMoney.toMajor(json['balanceMinor']);

    // A recent slice makes the wallet screen useful on first paint without a
    // second round trip.
    final recent = await _recentTransactions();

    return WalletBalance(
      available: spendable,
      // Anything held back is shown separately rather than silently hidden.
      promotional: (total - spendable).clamp(0, double.infinity).toDouble(),
      recent: recent,
      updatedAt: DateTime.now(),
    );
  });

  Future<List<WalletTransaction>> _recentTransactions() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.walletTransactions,
      query: {'limit': 5},
    );
    return asPageItems(response).map(_toTransaction).toList(growable: false);
  }

  @override
  Future<List<WalletTransaction>> getTransactions(TransactionFilter filter) =>
      guardApi(() async {
        final duration = filter.range.duration;
        final response = await _client.get<dynamic>(
          ApiEndpoints.walletTransactions,
          query: {
            'limit': 100,
            if (duration != null)
              'from': DateTime.now().subtract(duration).toIso8601String(),
            // The server filters one category per request; several are applied
            // client-side below rather than issuing N requests.
            if (filter.categories.length == 1)
              'category': filter.categories.single.name,
          },
        );

        var items = asPageItems(
          response,
        ).map(_toTransaction).toList(growable: false);

        if (filter.categories.length > 1) {
          items = items
              .where((t) => filter.categories.contains(t.category))
              .toList(growable: false);
        }
        final direction = filter.direction;
        if (direction != null) {
          items = items
              .where(
                (t) =>
                    (t.isCredit
                        ? TransactionDirection.credit
                        : TransactionDirection.debit) ==
                    direction,
              )
              .toList(growable: false);
        }
        return items;
      });

  @override
  Future<List<TopUpOption>> getTopUpOptions() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.walletTopUpOptions,
    );
    return asJsonList(response)
        .map(
          (json) => TopUpOption(
            amount: ApiMoney.toMajor(json['amountMinor']),
            bonus: ApiMoney.toMajor(json['bonusMinor']),
            popular: json['isPopular'] as bool? ?? false,
          ),
        )
        .toList(growable: false);
  });

  /// Starts a top-up.
  ///
  /// Returns an *intent*, not a credit. The wallet moves only when the
  /// gateway's signed webhook reaches the server — so the UI must follow the
  /// returned status rather than assuming success.
  @override
  Future<PaymentIntent> createTopUp({
    required double amount,
    required PaymentRail rail,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.walletTopUp,
      data: {'amountMinor': ApiMoney.toMinorString(amount), 'rail': rail.name},
    );
    return _toIntent(asJsonMap(response));
  });

  @override
  Future<PaymentIntent> getPaymentIntent(String intentId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.walletPayment(intentId),
    );
    return _toIntent(asJsonMap(response));
  });

  /// Spending is never initiated by the client.
  ///
  /// A debit is a side effect of buying something — an order, a report, a
  /// consultation minute — and the server performs it inside the same
  /// transaction as the purchase, under a row lock. Exposing a "take money
  /// from this wallet" call would be a way to charge a user for nothing.
  @override
  Future<WalletTransaction> debit({
    required double amount,
    required TransactionCategory category,
    required String description,
    String? referenceId,
  }) async {
    throw const ValidationException(
      'Wallet debits happen server-side as part of a purchase',
      'debit',
    );
  }

  @override
  Future<RefundRequest> requestRefund(RefundDraft draft) => guardApi(() async {
    // The ledger entry being disputed is the reference; the server resolves it
    // to the order or consultation behind it.
    final response = await _client.post<dynamic>(
      ApiEndpoints.walletRefunds,
      data: {
        'referenceType': 'order',
        'referenceId': draft.transactionId,
        'amountMinor': '0',
        'reason': _reasonText(draft),
      },
    );
    return _toRefund(asJsonMap(response));
  });

  @override
  Future<List<RefundRequest>> getRefunds() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.walletRefunds);
    return asJsonList(response).map(_toRefund).toList(growable: false);
  });

  static String _reasonText(RefundDraft draft) {
    final label = draft.reason.name;
    return draft.details.isEmpty ? label : '$label: ${draft.details}';
  }

  WalletTransaction _toTransaction(Map<String, dynamic> json) {
    final category = TransactionCategory.fromName(json['category'] as String?);
    final isCredit = json['direction'] == 'credit';

    return WalletTransaction(
      id: json['id'] as String? ?? '',
      category: category,
      amount: ApiMoney.toMajor(json['amountMinor']),
      createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
      balanceAfter: ApiMoney.toMajor(json['balanceAfterMinor']),
      description: json['description'] as String? ?? '',
      referenceId: json['referenceId'] as String?,
      // The server is authoritative about direction. An adjustment can go
      // either way, so the category alone cannot be trusted to imply it.
      forceDebit:
          !isCredit && category.direction == TransactionDirection.credit,
    );
  }

  PaymentIntent _toIntent(Map<String, dynamic> json) => PaymentIntent(
    id: json['id'] as String? ?? '',
    amount: ApiMoney.toMajor(json['amountMinor']),
    rail: _rail(json['rail'] as String?),
    status: _status(json['status'] as String?),
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    // `redirectUrl` is where the payer goes, not an identifier. The
    // provider's own reference is not exposed by this endpoint.
    checkoutUrl: json['redirectUrl'] as String?,
    failureReason: json['failureReason'] as String?,
  );

  RefundRequest _toRefund(Map<String, dynamic> json) => RefundRequest(
    id: json['id'] as String? ?? '',
    transactionId: json['referenceId'] as String? ?? '',
    reason: RefundReason.fromName(_leadingReason(json['reason'] as String?)),
    status: _refundStatus(json['status'] as String?),
    amount: ApiMoney.toMajor(json['amountMinor']),
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    details: json['reason'] as String? ?? '',
    resolutionNote: json['decisionNote'] as String?,
  );

  /// Reasons are stored as `"<enum>: <details>"`; recover the enum part.
  static String? _leadingReason(String? raw) => raw?.split(':').first.trim();

  static PaymentRail _rail(String? name) => PaymentRail.values.firstWhere(
    (r) => r.name == name,
    orElse: () => PaymentRail.cashOnDelivery,
  );

  static PaymentStatus _status(String? name) => switch (name) {
    'pending' => PaymentStatus.pending,
    'succeeded' => PaymentStatus.succeeded,
    'failed' => PaymentStatus.failed,
    'cancelled' || 'expired' => PaymentStatus.cancelled,
    _ => PaymentStatus.created,
  };

  static RefundStatus _refundStatus(String? name) => switch (name) {
    'approved' => RefundStatus.approved,
    'rejected' => RefundStatus.rejected,
    'processed' => RefundStatus.credited,
    _ => RefundStatus.submitted,
  };
}
