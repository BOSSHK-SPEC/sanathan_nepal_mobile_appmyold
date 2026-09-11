import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/forex_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/forex_remote_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/frankfurter_forex_remote_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/regional_forex_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/mock_forex_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/models/forex_day_model.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/models/forex_rate_model.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/repositories/forex_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/entities/currency.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/entities/forex_range.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/convert_currency.dart';

class _MockRemote extends Mock implements ForexRemoteDataSource {}

void main() {
  late _MockRemote remote;
  late ForexRepositoryImpl repo;
  final today = DateTime(2024, 3, 7);

  setUp(() {
    remote = _MockRemote();
    repo = ForexRepositoryImpl(
      remote: remote,
      fallback: const MockForexDataSource(),
      local: ForexLocalDataSourceImpl(InMemoryKeyValueStore()),
      clock: () => today,
    );
  });

  test(
    'getLatestRates parses the NRB payload and returns the last day',
    () async {
      final json = <String, dynamic>{
        'data': {
          'payload': [
            {
              'date': '2024-03-06',
              'published_on': '2024-03-06 00:00:00',
              'rates': [
                {
                  'currency': {'iso3': 'USD', 'name': 'U.S. Dollar', 'unit': 1},
                  'buy': '132.50',
                  'sell': '133.10',
                },
              ],
            },
            {
              'date': '2024-03-07',
              'published_on': '2024-03-07 00:00:00',
              'rates': [
                {
                  'currency': {'iso3': 'USD', 'name': 'U.S. Dollar', 'unit': 1},
                  'buy': '132.80',
                  'sell': '133.40',
                },
                {
                  'currency': {
                    'iso3': 'INR',
                    'name': 'Indian Rupee',
                    'unit': 100,
                  },
                  'buy': 160,
                  'sell': 160.15,
                },
              ],
            },
          ],
        },
      };
      when(
        () => remote.fetchRates(
          from: any(named: 'from'),
          to: any(named: 'to'),
        ),
      ).thenAnswer((_) async => ForexDayModel.listFromResponse(json));

      final result = await repo.getLatestRates();

      expect(result.isSuccess, isTrue);
      final rates = result.valueOrNull!;
      expect(rates, hasLength(2));
      final usd = rates.firstWhere((r) => r.currency.iso3 == 'USD');
      expect(usd.buy, 132.80);
      expect(usd.date, DateTime(2024, 3, 7));
      final inr = rates.firstWhere((r) => r.currency.iso3 == 'INR');
      expect(inr.currency.unit, 100);
      expect(inr.currency.nameNe, 'भारतीय रुपैयाँ');
      expect(inr.buyPerUnit, closeTo(1.6, 0.0001));
    },
  );

  test('ForexDayModel keeps the NRB JSON keys and round-trips', () {
    final day = ForexDayModel.fromJson(<String, dynamic>{
      'date': '2024-03-07',
      'published_on': '2024-03-07 00:00:00',
      'rates': [
        {
          'currency': {'iso3': 'INR', 'name': 'Indian Rupee', 'unit': '100'},
          'buy': '160.00',
          'sell': 160.15,
        },
      ],
    });
    expect(day.date, DateTime(2024, 3, 7));
    expect(day.publishedOn, DateTime(2024, 3, 7));
    expect(day.rates.single.currency.unit, 100);
    expect(day.rates.single.buy, 160);

    final json = day.toJson();
    expect(json['date'], '2024-03-07');
    expect(json.containsKey('published_on'), isTrue);
    final rate = (json['rates'] as List).single as Map<String, dynamic>;
    expect(rate['buy'], 160);
    expect((rate['currency'] as Map<String, dynamic>)['iso3'], 'INR');
    expect(ForexDayModel.fromJson(json), day);

    final entity = day.toEntities().single;
    expect(entity.currency.nameNe, 'भारतीय रुपैयाँ');
    expect(ForexRateModel.fromEntity(entity), day.rates.single);
  });

  test('falls back to the deterministic mock when the network fails', () async {
    when(
      () => remote.fetchRates(
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenThrow(const NetworkException());

    final latest = await repo.getLatestRates();
    final history = await repo.getRateHistory('USD', ForexRange.week);
    final year = await repo.getRateHistory('EUR', ForexRange.year);

    expect(latest.valueOrNull, hasLength(Currency.known.length));
    expect(history.valueOrNull, hasLength(7));
    expect(year.valueOrNull, hasLength(365));
    expect(history.valueOrNull!.first.date, DateTime(2024, 3, 1));
    // Deterministic: same input → same output.
    final again = await repo.getRateHistory('USD', ForexRange.week);
    expect(again.valueOrNull, equals(history.valueOrNull));
  });

  test('favourites round-trip through the local store', () async {
    expect((await repo.getFavouriteCurrencies()).valueOrNull, [
      'USD',
      'GBP',
      'AUD',
    ]);
    await repo.saveFavouriteCurrencies(['EUR']);
    expect((await repo.getFavouriteCurrencies()).valueOrNull, ['EUR']);
  });

  test('ConvertCurrency converts via NPR with buy and sell rates', () async {
    final rates = MockForexDataSource.dayFor(today).toEntities();
    const useCase = ConvertCurrency();
    final usd = Currency.byIso3('USD')!;
    final inr = Currency.byIso3('INR')!;

    final toNpr = await useCase(
      ConvertCurrencyParams(
        amount: 2,
        from: usd,
        to: Currency.npr,
        rates: rates,
      ),
    );
    final usdRate = rates.firstWhere((r) => r.currency.iso3 == 'USD');
    expect(toNpr.valueOrNull!.buyResult, closeTo(2 * usdRate.buy, 1e-9));
    expect(toNpr.valueOrNull!.sellResult, closeTo(2 * usdRate.sell, 1e-9));

    final usdToInr = await useCase(
      ConvertCurrencyParams(amount: 1, from: usd, to: inr, rates: rates),
    );
    final inrRate = rates.firstWhere((r) => r.currency.iso3 == 'INR');
    expect(
      usdToInr.valueOrNull!.buyResult,
      closeTo(usdRate.buy / (inrRate.buy / 100), 1e-9),
    );

    final unknown = await useCase(
      ConvertCurrencyParams(
        amount: 1,
        from: usd,
        to: const Currency(
          iso3: 'XXX',
          nameEn: 'x',
          nameNe: 'x',
          countryCode: 'XX',
        ),
        rates: rates,
      ),
    );
    expect(unknown.isFailure, isTrue);
  });

  group('India region', () {
    const india = FixedRegionResolver(Region.india);

    test('Frankfurter payloads become INR-quoted buy/sell days', () {
      final latest = FrankfurterForexRemoteDataSource.parse(<String, dynamic>{
        'amount': 1,
        'base': 'USD',
        'date': '2026-08-17',
        'rates': {'INR': 83.5, 'EUR': 0.92, 'JPY': 148.0, 'GBP': 0.79},
      });
      expect(latest, hasLength(1));
      final day = latest.single;
      expect(day.date, DateTime(2026, 8, 17));
      expect(day.publishedOn, DateTime(2026, 8, 17));
      final rates = day.toEntities();
      final usd = rates.firstWhere((r) => r.currency.iso3 == 'USD');
      expect(usd.date, DateTime(2026, 8, 17));
      expect(usd.buy, closeTo(83.5 * 0.9975, 1e-3));
      expect(usd.sell, closeTo(83.5 * 1.0025, 1e-3));
      final eur = rates.firstWhere((r) => r.currency.iso3 == 'EUR');
      expect(eur.buy, closeTo(83.5 / 0.92 * 0.9975, 1e-3));
      final jpy = rates.firstWhere((r) => r.currency.iso3 == 'JPY');
      expect(jpy.currency.unit, 100);
      expect(jpy.currency.nameHi, 'जापानी येन');
      expect(jpy.buyPerUnit, closeTo(83.5 / 148 * 0.9975, 1e-4));
      // Currencies missing from the payload are skipped, INR is never quoted.
      expect(rates.any((r) => r.currency.iso3 == 'INR'), isFalse);
      expect(rates.any((r) => r.currency.iso3 == 'AUD'), isFalse);

      final range = FrankfurterForexRemoteDataSource.parse(<String, dynamic>{
        'amount': 1,
        'base': 'USD',
        'start_date': '2026-08-14',
        'end_date': '2026-08-17',
        'rates': {
          '2026-08-17': {'INR': 83.6, 'EUR': 0.92},
          '2026-08-14': {'INR': 83.4, 'EUR': 0.91},
        },
      });
      expect(range.map((d) => d.date), [
        DateTime(2026, 8, 14),
        DateTime(2026, 8, 17),
      ]);
    });

    test('mock fallback is INR-based with the ECB catalogue', () async {
      final repo = ForexRepositoryImpl(
        remote: remote,
        fallback: const MockForexDataSource(india),
        local: ForexLocalDataSourceImpl(InMemoryKeyValueStore(), india),
        clock: () => today,
      );
      when(
        () => remote.fetchRates(
          from: any(named: 'from'),
          to: any(named: 'to'),
        ),
      ).thenThrow(const NetworkException());

      final latest = await repo.getLatestRates();
      final rates = latest.valueOrNull!;
      expect(rates, hasLength(Currency.ecb.length));
      expect(rates.any((r) => r.currency.iso3 == 'INR'), isFalse);
      expect(rates.any((r) => r.currency.iso3 == 'AED'), isFalse);
      final usd = rates.firstWhere((r) => r.currency.iso3 == 'USD');
      expect(usd.buy, closeTo(83.5, 2));
      expect((await repo.getFavouriteCurrencies()).valueOrNull, [
        'USD',
        'GBP',
        'EUR',
      ]);
    });

    test('favourites are stored per region', () async {
      final store = InMemoryKeyValueStore();
      final nepal = ForexLocalDataSourceImpl(
        store,
        const FixedRegionResolver(Region.nepal),
      );
      final ind = ForexLocalDataSourceImpl(store, india);
      await nepal.writeFavourites(['EUR']);
      expect(nepal.readFavourites(), ['EUR']);
      expect(ind.readFavourites(), ['USD', 'GBP', 'EUR']);
    });

    test('RegionalForexDataSource picks the source at call time', () async {
      final nrb = _MockRemote();
      final ecb = _MockRemote();
      final day = ForexDayModel(date: today, rates: const []);
      when(
        () => nrb.fetchRates(
          from: any(named: 'from'),
          to: any(named: 'to'),
        ),
      ).thenAnswer((_) async => [day]);
      when(
        () => ecb.fetchRates(
          from: any(named: 'from'),
          to: any(named: 'to'),
        ),
      ).thenAnswer((_) async => [day, day]);
      final switching = _SwitchingResolver(Region.nepal);
      final source = RegionalForexDataSource(
        resolver: switching,
        nepal: nrb,
        india: ecb,
      );
      expect(await source.fetchRates(from: today, to: today), hasLength(1));
      switching.region = Region.india;
      expect(await source.fetchRates(from: today, to: today), hasLength(2));
    });

    test('ConvertCurrency uses INR as the pivot in India', () async {
      final rates = MockForexDataSource.dayFor(
        today,
        config: RegionConfig.india,
      ).toEntities();
      final usd = rates.firstWhere((r) => r.currency.iso3 == 'USD');
      final result = await const ConvertCurrency()(
        ConvertCurrencyParams(
          amount: 2,
          from: usd.currency,
          to: Currency.inr,
          rates: rates,
          localIso3: 'INR',
        ),
      );
      expect(result.valueOrNull!.buyResult, closeTo(2 * usd.buy, 1e-9));
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
