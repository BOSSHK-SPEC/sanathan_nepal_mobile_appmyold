import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/models/product_model.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_boost_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/order.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_boosted_products.dart';

import '../helpers/test_helpers.dart';

class _MockProductDataSource extends Mock implements ProductDataSource {}

void main() {
  late _MockProductDataSource source;
  late ProductRepositoryImpl repo;

  setUpAll(() => registerFallbackValue(const ProductFilter()));
  setUp(() {
    source = _MockProductDataSource();
    repo = ProductRepositoryImpl(source);
  });

  test('getById maps NotFoundException to NotFoundFailure', () async {
    when(() => source.fetchById('zz')).thenThrow(const NotFoundException());
    final result = await repo.getById('zz');
    expect(result.failureOrNull, isA<NotFoundFailure>());
  });

  test('GetBoostedProducts asks for boostedOnly listings', () async {
    final model = ProductModel.fromEntity(sampleProduct());
    when(() => source.fetchProducts(any())).thenAnswer((_) async => [model]);
    final result = await GetBoostedProducts(repo)();
    expect(result.valueOrNull, [model.toEntity()]);
    final filter =
        verify(() => source.fetchProducts(captureAny())).captured.single
            as ProductFilter;
    expect(filter.boostedOnly, isTrue);
  });

  test('ProductModel JSON round-trip preserves the entity', () {
    final product = sampleProduct();
    final model = ProductModel.fromEntity(product);
    final json = model.toJson();
    expect(json.keys, contains('title_ne'));
    expect(ProductModel.fromJson(json), model);
    expect(ProductModel.fromJson(json).toEntity(), product);
  });

  test('MockProductDataSource is deterministic and searchable', () async {
    final a = MockProductDataSource(clock: () => kTestNow);
    final b = MockProductDataSource(clock: () => kTestNow);
    final all = await a.fetchProducts(const ProductFilter());
    expect(all.length, 16);
    expect(all, await b.fetchProducts(const ProductFilter()));
    final gems = await a.fetchProducts(const ProductFilter(query: 'pearl'));
    expect(gems.map((p) => p.id), contains('p4'));
    final boosted = await a.fetchProducts(
      const ProductFilter(boostedOnly: true),
    );
    expect(boosted.every((p) => p.isBoosted), isTrue);
  });

  group('India region', () {
    const india = FixedRegionResolver(Region.india);

    test(
      'repository serves the India seed for FixedRegionResolver(india)',
      () async {
        final indiaRepo = ProductRepositoryImpl(
          MockProductDataSource(clock: () => kTestNow, resolver: india),
        );
        final result = await GetProducts(indiaRepo)(const ProductFilter());
        final all = result.valueOrNull!;
        expect(all.length, 12);
        expect(all.every((p) => p.id.startsWith('ip')), isTrue);
        expect(
          all.every((p) => p.seller.phone?.startsWith('+91') ?? true),
          isTrue,
        );
        final locations = all.map((p) => p.location);
        expect(locations, contains('Connaught Place, New Delhi'));
        expect(locations, contains('Andheri, Mumbai'));
        expect(locations, contains('Koramangala, Bengaluru'));
        expect(locations, isNot(contains(contains('Kathmandu'))));
        // Hindi text lives in the local (Devanagari) fields.
        final delhiCar = all.firstWhere((p) => p.id == 'ip1');
        expect(delhiCar.titleFor(languageCode: 'hi'), contains('स्विफ्ट'));
        expect(delhiCar.titleFor(languageCode: 'en'), contains('Swift'));
        expect(
          delhiCar.locationFor(languageCode: 'hi'),
          'कनॉट प्लेस, नई दिल्ली',
        );
        // Nepal is untouched.
        final nepalRepo = ProductRepositoryImpl(
          MockProductDataSource(clock: () => kTestNow),
        );
        final nepal = (await GetProducts(nepalRepo)(
          const ProductFilter(),
        )).valueOrNull!;
        expect(nepal.length, 16);
        expect(nepal.first.id, startsWith('p'));
      },
    );

    test(
      'data source switches seed when the region changes at runtime',
      () async {
        final switching = _SwitchingResolver(Region.nepal);
        final source = MockProductDataSource(
          clock: () => kTestNow,
          resolver: switching,
        );
        expect((await source.fetchProducts(const ProductFilter())).length, 16);
        switching.region = Region.india;
        expect((await source.fetchProducts(const ProductFilter())).length, 12);
        final phone = await source.fetchById('ip3');
        expect(phone.seller.name, 'Mumbai Gadget Store');
      },
    );

    test('boost plans and payment methods follow the region', () async {
      final plans = await MockBoostDataSource(
        clock: () => kTestNow,
        resolver: india,
      ).fetchPlans();
      expect(plans.map((p) => p.pricePerProduct), [499, 999, 1799, 2499]);
      expect(
        (await MockBoostDataSource(
          clock: () => kTestNow,
        ).fetchPlans()).first.pricePerProduct,
        1000,
      );
      expect(PaymentMethod.forRegion(RegionConfig.india), [
        PaymentMethod.upi,
        PaymentMethod.card,
        PaymentMethod.netBanking,
        PaymentMethod.cashOnDelivery,
      ]);
      expect(PaymentMethod.forRegion(RegionConfig.nepal), [
        PaymentMethod.esewa,
        PaymentMethod.khalti,
        PaymentMethod.bankTransfer,
        PaymentMethod.cashOnDelivery,
      ]);
    });
  });
}

class _SwitchingResolver implements RegionResolver {
  _SwitchingResolver(this.region);
  @override
  Region region;
  @override
  RegionConfig get config => region.config;
}
