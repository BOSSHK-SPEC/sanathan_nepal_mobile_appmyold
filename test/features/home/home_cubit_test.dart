import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/home/data/datasources/metal_rates_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/home/data/repositories/metal_rates_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/home/domain/usecases/get_metal_rates.dart';
import 'package:sanathan_nepal_mobile_app/features/home/presentation/cubit/home_cubit.dart';

class _SwitchableResolver implements RegionResolver {
  _SwitchableResolver(this.region);
  @override
  Region region;
  @override
  RegionConfig get config => region.config;
}

void main() {
  final fixed = DateTime(2023, 2, 23, 14, 27);
  final repo = MetalRatesRepositoryImpl(
    MockMetalRatesDataSource(
      const FixedRegionResolver(Region.nepal),
      now: () => fixed,
    ),
  );

  blocTest<HomeCubit, HomeState>(
    'load emits metal rates for today',
    build: () => HomeCubit(
      getMetalRates: GetMetalRates(repo),
      clock: () => fixed,
      tick: const Duration(hours: 1),
    ),
    act: (c) => c.load(),
    expect: () => [
      isA<HomeState>().having((s) => s.metalRates.isLoading, 'loading', true),
      isA<HomeState>()
          .having(
            (s) => s.metalRates.dataOrNull?.goldPerUnit,
            'gold',
            greaterThan(100000),
          )
          .having(
            (s) => s.metalRates.dataOrNull?.currencyCode,
            'currency',
            'NPR',
          )
          .having((s) => s.metalRates.dataOrNull?.unit, 'unit', 'tola')
          .having((s) => s.now, 'now', fixed),
    ],
  );

  test('MockMetalRatesDataSource quotes the active region market', () async {
    final resolver = _SwitchableResolver(Region.nepal);
    final source = MockMetalRatesDataSource(resolver, now: () => fixed);
    final nepal = (await source.fetchToday()).toEntity();
    expect(nepal.currencyCode, 'NPR');
    expect(nepal.unit, 'tola');
    expect(nepal.goldPerUnit, inInclusiveRange(101000, 103000));

    resolver.region = Region.india;
    final india = (await source.fetchToday()).toEntity();
    expect(india.currencyCode, 'INR');
    expect(india.unit, '10 g');
    expect(india.goldPerUnit, inInclusiveRange(105000, 107000));
    expect(india.silverPerUnit, inInclusiveRange(1250, 1300));
    expect(india.date, DateTime(2023, 2, 23));
  });
}
