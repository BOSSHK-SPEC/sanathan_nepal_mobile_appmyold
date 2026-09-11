import 'dart:convert';
import 'dart:math';

import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/refund_request.dart';
import '../../domain/entities/topup_option.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/entities/wallet_balance.dart';
import '../../domain/entities/wallet_transaction.dart';
import 'wallet_data_source.dart';

/// In-memory wallet backed by [KeyValueStore].
///
/// Models the parts of a real payment integration that shape the UI, so the
/// screens are built against realistic behaviour rather than an optimistic
/// happy path:
///
/// * a top-up starts **unsettled** and settles a moment later, so the status
///   screen has a genuine pending state to poll;
/// * roughly one attempt in eight fails, so the failure and retry paths are
///   exercised rather than theoretical;
/// * a debit larger than the balance is rejected here, not pre-checked in
///   the UI, so there is one authority on affordability;
/// * promotional credit is spent before real credit, which is what makes
///   bonus balance worth tracking separately.
class MockWalletDataSource implements WalletDataSource {
  MockWalletDataSource(this._store, this._regions, {Random? random})
    : _random = random ?? Random(20260903);

  final KeyValueStore _store;
  final RegionResolver _regions;
  final Random _random;

  static const _ledgerKey = 'wallet.ledger';
  static const _intentsKey = 'wallet.intents';
  static const _refundsKey = 'wallet.refunds';
  static const _seededKey = 'wallet.seeded';

  static const Duration _latency = Duration(milliseconds: 200);

  /// How long a created intent stays pending before it settles.
  static const Duration settleAfter = Duration(seconds: 3);

  /// One in this many attempts fails, so the failure path is reachable.
  static const int failureOdds = 8;

  // --- Balance & ledger -------------------------------------------------

  @override
  Future<WalletBalance> getBalance() async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    final ledger = _readLedger();
    return WalletBalance(
      available: _availableFrom(ledger),
      promotional: _promotionalFrom(ledger),
      recent: ledger.take(5).toList(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<List<WalletTransaction>> getTransactions(
    TransactionFilter filter,
  ) async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    final cutoff = filter.range.duration == null
        ? null
        : DateTime.now().subtract(filter.range.duration!);

    return _readLedger().where((t) {
      if (cutoff != null && t.createdAt.isBefore(cutoff)) return false;
      if (filter.categories.isNotEmpty &&
          !filter.categories.contains(t.category)) {
        return false;
      }
      if (filter.direction != null) {
        final direction = t.isCredit
            ? TransactionDirection.credit
            : TransactionDirection.debit;
        if (direction != filter.direction) return false;
      }
      return true;
    }).toList();
  }

  // --- Top-up -----------------------------------------------------------

  @override
  Future<List<TopUpOption>> getTopUpOptions() async {
    await Future<void>.delayed(_latency);
    // Nepal quotes NPR, India INR; the tiers differ because the currencies
    // are not interchangeable at these magnitudes.
    return switch (_regions.region) {
      Region.nepal => const [
        TopUpOption(amount: 200),
        TopUpOption(amount: 500, bonus: 25),
        TopUpOption(amount: 1000, bonus: 100, popular: true),
        TopUpOption(amount: 2000, bonus: 250),
        TopUpOption(amount: 5000, bonus: 750),
      ],
      Region.india => const [
        TopUpOption(amount: 100),
        TopUpOption(amount: 300, bonus: 15),
        TopUpOption(amount: 500, bonus: 50, popular: true),
        TopUpOption(amount: 1000, bonus: 130),
        TopUpOption(amount: 2500, bonus: 400),
      ],
    };
  }

  @override
  Future<PaymentIntent> createTopUp({
    required double amount,
    required PaymentRail rail,
  }) async {
    await Future<void>.delayed(_latency);
    if (amount <= 0) {
      throw const ValidationException('Enter an amount to add');
    }
    if (!_regions.config.paymentRails.contains(rail)) {
      throw const ValidationException(
        'That payment method is not available in your region',
      );
    }

    final options = await getTopUpOptions();
    final bonus = options
        .where((o) => o.amount == amount)
        .fold<double>(0, (_, o) => o.bonus);

    final intent = PaymentIntent(
      id: 'pi-${DateTime.now().microsecondsSinceEpoch}',
      amount: amount,
      bonus: bonus,
      rail: rail,
      status: PaymentStatus.pending,
      createdAt: DateTime.now(),
      idempotencyKey: 'idem-${_random.nextInt(1 << 32)}',
    );
    await _writeIntent(intent);
    return intent;
  }

  /// Settles on read once [settleAfter] has elapsed, the way polling a real
  /// gateway behaves — the client never decides the outcome itself.
  @override
  Future<PaymentIntent> getPaymentIntent(String intentId) async {
    await Future<void>.delayed(_latency);
    final intents = _readIntents();
    final intent = intents[intentId];
    if (intent == null) {
      throw NotFoundException('No payment with id "$intentId"');
    }
    if (intent.isSettled) return intent;

    final elapsed = DateTime.now().difference(intent.createdAt);
    if (elapsed < settleAfter) return intent;

    final failed = intentId.hashCode.abs() % failureOdds == 0;
    final settled = failed
        ? intent.copyWith(
            status: PaymentStatus.failed,
            failureReason: 'The bank declined this payment',
          )
        : intent.copyWith(
            status: PaymentStatus.succeeded,
            gatewayReference: 'REF${intent.id.hashCode.abs()}',
          );
    await _writeIntent(settled);

    if (settled.status == PaymentStatus.succeeded) {
      await _credit(
        amount: settled.amount,
        category: TransactionCategory.topUp,
        description: _railLabel(settled.rail),
        referenceId: settled.id,
      );
      if (settled.bonus > 0) {
        await _credit(
          amount: settled.bonus,
          category: TransactionCategory.bonus,
          description: 'Top-up bonus',
          referenceId: settled.id,
        );
      }
    }
    return settled;
  }

  // --- Spending ---------------------------------------------------------

  @override
  Future<WalletTransaction> debit({
    required double amount,
    required TransactionCategory category,
    required String description,
    String? referenceId,
  }) async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    if (amount <= 0) {
      throw const ValidationException('Amount must be greater than zero');
    }
    final ledger = _readLedger();
    final spendable = _availableFrom(ledger) + _promotionalFrom(ledger);
    if (amount > spendable) {
      throw const ValidationException('Not enough balance');
    }

    final entry = WalletTransaction(
      id: 'tx-${DateTime.now().microsecondsSinceEpoch}',
      category: category,
      amount: amount,
      description: description,
      referenceId: referenceId,
      createdAt: DateTime.now(),
      balanceAfter: spendable - amount,
    );
    await _writeLedger([entry, ...ledger]);
    return entry;
  }

  // --- Refunds ----------------------------------------------------------

  @override
  Future<RefundRequest> requestRefund(RefundDraft draft) async {
    await Future<void>.delayed(_latency);
    // The ledger is what a refund is raised against, so it has to exist even
    // if the user reached this screen by deep link without opening the
    // wallet first.
    await _seedOnce();
    if (draft.reason == RefundReason.other && draft.details.trim().isEmpty) {
      throw const ValidationException(
        'Tell us what happened so we can review it',
      );
    }
    final ledger = _readLedger();
    final matches = ledger.where((t) => t.id == draft.transactionId);
    if (matches.isEmpty) {
      throw const NotFoundException('That transaction no longer exists');
    }

    final existing = _readRefunds();
    if (existing.any(
      (r) => r.transactionId == draft.transactionId && r.isOpen,
    )) {
      throw const ValidationException(
        'A refund for this payment is already being reviewed',
      );
    }

    final request = RefundRequest(
      id: 'rf-${DateTime.now().microsecondsSinceEpoch}',
      transactionId: draft.transactionId,
      reason: draft.reason,
      details: draft.details,
      status: RefundStatus.submitted,
      amount: matches.first.amount,
      createdAt: DateTime.now(),
    );
    await _writeRefunds([request, ...existing]);
    return request;
  }

  @override
  Future<List<RefundRequest>> getRefunds() async {
    await Future<void>.delayed(_latency);
    return _readRefunds();
  }

  // --- Internals --------------------------------------------------------

  String _railLabel(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => 'eSewa',
    PaymentRail.khalti => 'Khalti',
    PaymentRail.upi => 'UPI',
    PaymentRail.card => 'Card',
    PaymentRail.netBanking => 'Net banking',
    PaymentRail.bankTransfer => 'Bank transfer',
    PaymentRail.cashOnDelivery => 'Cash',
  };

  /// Replays the ledger oldest-first into two buckets.
  ///
  /// Real and promotional credit are separate rights: both can be spent on a
  /// consultation, only real credit could ever be withdrawn. Debits drain
  /// the promotional bucket first — the user-favourable order, and the one
  /// that keeps withdrawable credit intact for as long as possible.
  ({double real, double promo}) _buckets(List<WalletTransaction> ledger) {
    var real = 0.0;
    var promo = 0.0;
    for (final t in ledger.reversed) {
      if (t.isCredit) {
        if (t.category == TransactionCategory.bonus) {
          promo += t.amount;
        } else {
          real += t.amount;
        }
        continue;
      }
      final fromPromo = t.amount <= promo ? t.amount : promo;
      promo -= fromPromo;
      real = (real - (t.amount - fromPromo)).clamp(0, double.infinity);
    }
    return (real: real, promo: promo);
  }

  double _availableFrom(List<WalletTransaction> ledger) =>
      _buckets(ledger).real;

  double _promotionalFrom(List<WalletTransaction> ledger) =>
      _buckets(ledger).promo;

  Future<void> _credit({
    required double amount,
    required TransactionCategory category,
    required String description,
    String? referenceId,
  }) async {
    final ledger = _readLedger();
    final spendable = _availableFrom(ledger) + _promotionalFrom(ledger);
    await _writeLedger([
      WalletTransaction(
        id: 'tx-${DateTime.now().microsecondsSinceEpoch}-${category.name}',
        category: category,
        amount: amount,
        description: description,
        referenceId: referenceId,
        createdAt: DateTime.now(),
        balanceAfter: spendable + amount,
      ),
      ...ledger,
    ]);
  }

  /// Seeds a small history the first time the wallet is opened, so the
  /// ledger, filters and refund flow are not empty on a fresh install.
  ///
  /// The running balance is derived while building, not hand-written, so the
  /// seed cannot drift from the bucket arithmetic above.
  Future<void> _seedOnce() async {
    if (_store.getBool(_seededKey) ?? false) return;
    final now = DateTime.now();
    final scale = _regions.region == Region.nepal ? 1.0 : 0.6;

    // (daysAgo, category, amount, description) oldest first.
    final script = <(int, TransactionCategory, double, String)>[
      (12, TransactionCategory.topUp, 1000, 'eSewa'),
      (12, TransactionCategory.bonus, 100, 'Top-up bonus'),
      (9, TransactionCategory.consultation, 250, 'Chat · 10 min'),
      (5, TransactionCategory.report, 199, 'Detailed Kundli report'),
      (3, TransactionCategory.refund, 199, 'Refund · report not delivered'),
      (2, TransactionCategory.consultation, 120, 'Voice call · 4 min'),
      (1, TransactionCategory.bonus, 150, 'Festival bonus'),
    ];

    final built = <WalletTransaction>[];
    var running = 0.0;
    for (var i = 0; i < script.length; i++) {
      final (daysAgo, category, rawAmount, description) = script[i];
      final amount = rawAmount * scale;
      final credit = category.direction == TransactionDirection.credit;
      running += credit ? amount : -amount;
      built.add(
        WalletTransaction(
          id: 'tx-seed-${i + 1}',
          category: category,
          amount: amount,
          description: description,
          createdAt: now.subtract(Duration(days: daysAgo, minutes: i)),
          balanceAfter: running,
        ),
      );
    }

    await _writeLedger(built);
    await _store.setBool(_seededKey, true);
  }

  List<WalletTransaction> _readLedger() {
    final raw = _store.getString(_ledgerKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        WalletTransaction(
          id: e['id'] as String,
          category: TransactionCategory.fromName(e['category'] as String?),
          amount: (e['amount'] as num).toDouble(),
          description: e['description'] as String? ?? '',
          referenceId: e['referenceId'] as String?,
          forceDebit: e['forceDebit'] as bool? ?? false,
          balanceAfter: (e['balanceAfter'] as num).toDouble(),
          createdAt: DateTime.parse(e['createdAt'] as String),
        ),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> _writeLedger(List<WalletTransaction> ledger) => _store.setString(
    _ledgerKey,
    jsonEncode([
      for (final t in ledger)
        {
          'id': t.id,
          'category': t.category.name,
          'amount': t.amount,
          'description': t.description,
          'referenceId': t.referenceId,
          'forceDebit': t.forceDebit,
          'balanceAfter': t.balanceAfter,
          'createdAt': t.createdAt.toIso8601String(),
        },
    ]),
  );

  Map<String, PaymentIntent> _readIntents() {
    final raw = _store.getString(_intentsKey);
    if (raw == null || raw.isEmpty) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return {
      for (final entry in decoded.entries)
        entry.key: _intentFromJson(entry.value as Map<String, dynamic>),
    };
  }

  PaymentIntent _intentFromJson(Map<String, dynamic> e) => PaymentIntent(
    id: e['id'] as String,
    amount: (e['amount'] as num).toDouble(),
    bonus: (e['bonus'] as num?)?.toDouble() ?? 0,
    rail: PaymentRail.values.firstWhere(
      (r) => r.name == e['rail'],
      orElse: () => PaymentRail.card,
    ),
    status: PaymentStatus.values.firstWhere(
      (s) => s.name == e['status'],
      orElse: () => PaymentStatus.created,
    ),
    gatewayReference: e['gatewayReference'] as String?,
    failureReason: e['failureReason'] as String?,
    idempotencyKey: e['idempotencyKey'] as String?,
    createdAt: DateTime.parse(e['createdAt'] as String),
  );

  Future<void> _writeIntent(PaymentIntent intent) async {
    final intents = _readIntents()..[intent.id] = intent;
    await _store.setString(
      _intentsKey,
      jsonEncode({
        for (final e in intents.entries)
          e.key: {
            'id': e.value.id,
            'amount': e.value.amount,
            'bonus': e.value.bonus,
            'rail': e.value.rail.name,
            'status': e.value.status.name,
            'gatewayReference': e.value.gatewayReference,
            'failureReason': e.value.failureReason,
            'idempotencyKey': e.value.idempotencyKey,
            'createdAt': e.value.createdAt.toIso8601String(),
          },
      }),
    );
  }

  List<RefundRequest> _readRefunds() {
    final raw = _store.getString(_refundsKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        RefundRequest(
          id: e['id'] as String,
          transactionId: e['transactionId'] as String,
          reason: RefundReason.fromName(e['reason'] as String?),
          status: RefundStatus.values.firstWhere(
            (s) => s.name == e['status'],
            orElse: () => RefundStatus.submitted,
          ),
          amount: (e['amount'] as num).toDouble(),
          details: e['details'] as String? ?? '',
          createdAt: DateTime.parse(e['createdAt'] as String),
        ),
    ];
  }

  Future<void> _writeRefunds(List<RefundRequest> refunds) => _store.setString(
    _refundsKey,
    jsonEncode([
      for (final r in refunds)
        {
          'id': r.id,
          'transactionId': r.transactionId,
          'reason': r.reason.name,
          'status': r.status.name,
          'amount': r.amount,
          'details': r.details,
          'createdAt': r.createdAt.toIso8601String(),
        },
    ]),
  );
}
