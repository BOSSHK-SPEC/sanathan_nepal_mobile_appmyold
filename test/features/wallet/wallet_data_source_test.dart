import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/wallet/data/datasources/mock_wallet_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/wallet/domain/entities/refund_request.dart';
import 'package:sanathan_nepal_mobile_app/features/wallet/domain/entities/transaction_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/wallet/domain/entities/wallet_transaction.dart';

void main() {
  late InMemoryKeyValueStore store;

  MockWalletDataSource sourceFor([Region region = Region.nepal]) =>
      MockWalletDataSource(store, FixedRegionResolver(region));

  setUp(() => store = InMemoryKeyValueStore());

  group('Balance', () {
    test('seeds a starting history on first read', () async {
      final balance = await sourceFor().getBalance();
      expect(balance.spendable, greaterThan(0));
      expect(balance.recent, isNotEmpty);
    });

    test('bonus credit is tracked apart from real credit', () async {
      final balance = await sourceFor().getBalance();
      expect(balance.promotional, greaterThan(0));
      expect(balance.available, greaterThan(0));
      expect(balance.spendable, balance.available + balance.promotional);
    });

    test('minutesAffordable divides by the rate and floors', () async {
      final balance = await sourceFor().getBalance();
      expect(balance.minutesAffordable(20), (balance.spendable / 20).floor());
      // A zero rate must not divide by zero.
      expect(balance.minutesAffordable(0), 0);
    });
  });

  group('Top-up tiers', () {
    test('differ per region', () async {
      final np = await sourceFor().getTopUpOptions();
      final ind = await sourceFor(Region.india).getTopUpOptions();
      expect(np.first.amount, isNot(ind.first.amount));
      expect(np.any((o) => o.popular), isTrue);
      expect(ind.any((o) => o.popular), isTrue);
    });

    test('bonus percent is derived, not stored twice', () async {
      final options = await sourceFor().getTopUpOptions();
      final withBonus = options.firstWhere((o) => o.hasBonus);
      expect(
        withBonus.bonusPercent,
        ((withBonus.bonus / withBonus.amount) * 100).round(),
      );
      expect(withBonus.total, withBonus.amount + withBonus.bonus);
    });
  });

  group('Payment intent', () {
    test(
      'starts unsettled so the status screen has something to poll',
      () async {
        final intent = await sourceFor().createTopUp(
          amount: 500,
          rail: PaymentRail.esewa,
        );
        expect(intent.isPending, isTrue);
        expect(intent.isSettled, isFalse);
        expect(intent.idempotencyKey, isNotNull);
      },
    );

    test('rejects a zero amount', () async {
      expect(
        () => sourceFor().createTopUp(amount: 0, rail: PaymentRail.esewa),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects a rail the region does not offer', () async {
      // UPI is India-only.
      expect(
        () => sourceFor().createTopUp(amount: 500, rail: PaymentRail.upi),
        throwsA(isA<ValidationException>()),
      );
    });

    test('stays pending until the settle window elapses', () async {
      final source = sourceFor();
      final intent = await source.createTopUp(
        amount: 500,
        rail: PaymentRail.esewa,
      );
      final polled = await source.getPaymentIntent(intent.id);
      expect(polled.isSettled, isFalse);
    });

    test('an unknown intent is a not-found error', () async {
      expect(
        () => sourceFor().getPaymentIntent('nope'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('Debit', () {
    test('rejects an overspend rather than going negative', () async {
      final source = sourceFor();
      final balance = await source.getBalance();
      expect(
        () => source.debit(
          amount: balance.spendable + 1,
          category: TransactionCategory.consultation,
          description: 'Chat',
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('reduces the balance and records the entry', () async {
      final source = sourceFor();
      final before = await source.getBalance();
      final entry = await source.debit(
        amount: 50,
        category: TransactionCategory.consultation,
        description: 'Chat · 2 min',
        referenceId: 'c-1',
      );
      final after = await source.getBalance();

      expect(entry.isCredit, isFalse);
      expect(entry.signedAmount, -50);
      expect(after.spendable, closeTo(before.spendable - 50, 0.001));
      expect(after.recent.first.id, entry.id);
    });

    test('rejects a non-positive amount', () async {
      expect(
        () => sourceFor().debit(
          amount: 0,
          category: TransactionCategory.consultation,
          description: 'Chat',
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('Ledger filters', () {
    test('direction splits credits from debits', () async {
      final source = sourceFor();
      final credits = await source.getTransactions(
        const TransactionFilter(
          range: LedgerRange.all,
          direction: TransactionDirection.credit,
        ),
      );
      final debits = await source.getTransactions(
        const TransactionFilter(
          range: LedgerRange.all,
          direction: TransactionDirection.debit,
        ),
      );
      expect(credits, isNotEmpty);
      expect(debits, isNotEmpty);
      expect(credits.every((t) => t.isCredit), isTrue);
      expect(debits.every((t) => !t.isCredit), isTrue);
    });

    test('category filter matches any of the selected values', () async {
      final result = await sourceFor().getTransactions(
        const TransactionFilter(
          range: LedgerRange.all,
          categories: {TransactionCategory.consultation},
        ),
      );
      expect(result, isNotEmpty);
      expect(
        result.every((t) => t.category == TransactionCategory.consultation),
        isTrue,
      );
    });

    test('a narrow range excludes older entries', () async {
      final source = sourceFor();
      final all = await source.getTransactions(
        const TransactionFilter(range: LedgerRange.all),
      );
      final week = await source.getTransactions(
        const TransactionFilter(range: LedgerRange.last7Days),
      );
      expect(week.length, lessThan(all.length));
    });

    test('newest first', () async {
      final result = await sourceFor().getTransactions(
        const TransactionFilter(range: LedgerRange.all),
      );
      for (var i = 1; i < result.length; i++) {
        expect(result[i - 1].createdAt.isBefore(result[i].createdAt), isFalse);
      }
    });
  });

  group('Refunds', () {
    Future<String> aTransactionId(MockWalletDataSource source) async {
      final entries = await source.getTransactions(
        const TransactionFilter(range: LedgerRange.all),
      );
      return entries.first.id;
    }

    test('"other" requires details', () async {
      final source = sourceFor();
      final id = await aTransactionId(source);
      expect(
        () => source.requestRefund(
          RefundDraft(transactionId: id, reason: RefundReason.other),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a specific reason needs no details', () async {
      final source = sourceFor();
      final id = await aTransactionId(source);
      final request = await source.requestRefund(
        RefundDraft(
          transactionId: id,
          reason: RefundReason.sessionNotDelivered,
        ),
      );
      expect(request.isOpen, isTrue);
      expect(request.amount, greaterThan(0));
      expect(await source.getRefunds(), hasLength(1));
    });

    test('a second open request for the same payment is rejected', () async {
      final source = sourceFor();
      final id = await aTransactionId(source);
      await source.requestRefund(
        RefundDraft(transactionId: id, reason: RefundReason.wrongAmount),
      );
      expect(
        () => source.requestRefund(
          RefundDraft(transactionId: id, reason: RefundReason.chargedTwice),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an unknown transaction is a not-found error', () async {
      expect(
        () => sourceFor().requestRefund(
          const RefundDraft(
            transactionId: 'nope',
            reason: RefundReason.wrongAmount,
          ),
        ),
        throwsA(isA<NotFoundException>()),
      );
    });
  });
}
