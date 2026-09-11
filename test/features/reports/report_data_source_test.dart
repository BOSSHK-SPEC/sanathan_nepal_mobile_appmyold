import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/billing/spending_account.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/reports/data/datasources/mock_report_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/reports/domain/entities/purchased_report.dart';
import 'package:sanathan_nepal_mobile_app/features/reports/domain/repositories/report_repository.dart';

/// Records charges so a test can assert the wallet was hit exactly once.
class _RecordingWallet implements SpendingAccount {
  _RecordingWallet({this.failing = false});

  static const double balance = 100000;
  final bool failing;
  final List<double> charges = [];

  @override
  Future<double> spendable() async => balance;

  @override
  Future<void> charge({
    required double amount,
    required SpendCategory category,
    required String description,
    String? referenceId,
  }) async {
    if (failing) throw const ValidationException('Insufficient balance.');
    charges.add(amount);
  }
}

void main() {
  late InMemoryKeyValueStore store;
  late _RecordingWallet wallet;

  MockReportDataSource sourceFor([Region region = Region.nepal]) =>
      MockReportDataSource(store, FixedRegionResolver(region), wallet);

  ReportOrder orderFor(String productId, {String? partnerId}) => ReportOrder(
    productId: productId,
    profileId: 'p1',
    profileName: 'Asha',
    partnerProfileId: partnerId,
    partnerName: partnerId == null ? null : 'Bikash',
  );

  setUp(() {
    store = InMemoryKeyValueStore();
    wallet = _RecordingWallet();
  });

  group('Catalogue', () {
    test('every product is priced and paginated', () async {
      final products = await sourceFor().catalogue();
      expect(products, isNotEmpty);
      for (final p in products) {
        expect(p.price, greaterThan(0));
        expect(p.pageCount, greaterThan(0));
        expect(p.contents, isNotEmpty, reason: '${p.id} lists no contents');
      }
    });

    test('India is priced separately, not converted', () async {
      final nepal = await sourceFor().catalogue();
      final india = await sourceFor(Region.india).catalogue();
      final nepalById = {for (final p in nepal) p.id: p.price};
      // Not simply a fixed multiple of the Nepal price.
      final ratios = {
        for (final p in india) (p.price / nepalById[p.id]!).toStringAsFixed(3),
      };
      expect(ratios.length, greaterThan(1));
    });

    test('a discounted product reports a sane percentage', () async {
      final products = await sourceFor().catalogue();
      for (final p in products.where((p) => p.isDiscounted)) {
        expect(p.discountPercent, inInclusiveRange(1, 99));
      }
    });
  });

  group('Purchase', () {
    test('charges the wallet exactly once', () async {
      final source = sourceFor();
      final product = (await source.catalogue()).first;
      await source.purchase(orderFor(product.id));
      expect(wallet.charges, [product.price]);
    });

    test('a failed charge leaves no purchase behind', () async {
      wallet = _RecordingWallet(failing: true);
      final source = sourceFor();
      final product = (await source.catalogue()).first;

      await expectLater(
        source.purchase(orderFor(product.id)),
        throwsA(isA<ValidationException>()),
      );
      expect(await source.myReports(), isEmpty);
    });

    test('a matching report without a partner is refused, unpaid', () async {
      final source = sourceFor();
      final matching = (await source.catalogue()).firstWhere(
        (p) => p.needsSecondProfile,
      );

      await expectLater(
        source.purchase(orderFor(matching.id)),
        throwsA(isA<ValidationException>()),
      );
      expect(wallet.charges, isEmpty);
    });

    test('an unknown product is not found', () async {
      await expectLater(
        sourceFor().purchase(orderFor('report-nope')),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('a new purchase starts generating', () async {
      final source = sourceFor();
      final product = (await source.catalogue()).first;
      final report = await source.purchase(orderFor(product.id));

      expect(report.status, ReportStatus.generating);
      expect(report.fileRef, isNull);
      expect(report.isReady, isFalse);
    });
  });

  group('Delivery', () {
    test(
      'a report becomes ready once its generation time has passed',
      () async {
        final source = sourceFor();
        final product = (await source.catalogue()).first;
        final report = await source.purchase(orderFor(product.id));

        // Rewind the stored purchase past the generation window rather than
        // waiting on a timer: generation is driven by the timestamp.
        final raw = store.getString('reports.purchased')!;
        store.setString(
          'reports.purchased',
          raw.replaceFirst(
            report.purchasedAt.toIso8601String(),
            report.purchasedAt
                .subtract(MockReportDataSource.generationTime)
                .subtract(const Duration(seconds: 1))
                .toIso8601String(),
          ),
        );

        final delivered = await source.report(report.id);
        expect(delivered.status, ReportStatus.ready);
        expect(delivered.fileRef, isNotNull);
        expect(delivered.isReady, isTrue);
      },
    );

    test('reports are newest first', () async {
      final source = sourceFor();
      final products = await source.catalogue();
      await source.purchase(orderFor(products[0].id));
      await source.purchase(orderFor(products[2].id));

      final mine = await source.myReports();
      expect(mine.length, 2);
      expect(mine.first.purchasedAt.isBefore(mine.last.purchasedAt), isFalse);
    });

    test('an unknown report is not found', () async {
      await expectLater(
        sourceFor().report('rep-nope'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });
}
