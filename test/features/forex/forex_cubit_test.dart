import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/mock_forex_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/entities/currency.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/entities/forex_history_point.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/entities/forex_range.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/entities/forex_rate.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/convert_currency.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/get_latest_rates.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/get_rate_history.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/domain/usecases/manage_favourite_currencies.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/presentation/cubit/forex_cubit.dart';

class _MockGetLatest extends Mock implements GetLatestRates {}

class _MockGetHistory extends Mock implements GetRateHistory {}

class _MockGetFavs extends Mock implements GetFavouriteCurrencies {}

class _MockSaveFavs extends Mock implements SaveFavouriteCurrencies {}

void main() {
  late _MockGetLatest getLatest;
  late _MockGetHistory getHistory;
  late _MockGetFavs getFavs;
  late _MockSaveFavs saveFavs;
  late List<ForexRate> rates;
  final history = [
    ForexHistoryPoint(date: DateTime(2024, 3, 1), buy: 130, sell: 131),
    ForexHistoryPoint(date: DateTime(2024, 3, 2), buy: 131, sell: 132),
  ];

  setUpAll(() {
    registerFallbackValue(
      const GetRateHistoryParams(iso3: 'USD', range: ForexRange.week),
    );
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    getLatest = _MockGetLatest();
    getHistory = _MockGetHistory();
    getFavs = _MockGetFavs();
    saveFavs = _MockSaveFavs();
    rates = MockForexDataSource.dayFor(DateTime(2024, 3, 7)).toEntities();
    when(
      () => getFavs(),
    ).thenAnswer((_) async => const Result.success(['USD', 'GBP']));
    when(
      () => saveFavs(any()),
    ).thenAnswer((_) async => const Result.success(null));
    when(
      () => getHistory(any()),
    ).thenAnswer((_) async => Result.success(history));
  });

  ForexCubit build({Region region = Region.nepal}) => ForexCubit(
    getLatestRates: getLatest,
    getRateHistory: getHistory,
    convertCurrency: const ConvertCurrency(),
    getFavourites: getFavs,
    saveFavourites: saveFavs,
    resolver: FixedRegionResolver(region),
  );

  blocTest<ForexCubit, ForexState>(
    'load emits loading → favourites → rates → history + conversion',
    build: () {
      when(() => getLatest()).thenAnswer((_) async => Result.success(rates));
      return build();
    },
    act: (c) => c.load(),
    verify: (c) {
      final s = c.state;
      expect(s.rates, LoadState.loaded(rates));
      expect(s.favourites, ['USD', 'GBP']);
      expect(s.rateList, rates);
      expect(s.history, LoadState.loaded(history));
      expect(s.historyPoints, history);
      expect(s.conversion, isNotNull);
      expect(s.conversion!.buyResult, s.rateFor('USD')!.buy);
      verify(
        () => getHistory(
          const GetRateHistoryParams(iso3: 'USD', range: ForexRange.week),
        ),
      ).called(1);
    },
  );

  blocTest<ForexCubit, ForexState>(
    'load emits failure when rates cannot be loaded',
    build: () {
      when(
        () => getLatest(),
      ).thenAnswer((_) async => const Result.failure(ServerFailure('boom')));
      return build();
    },
    act: (c) => c.load(),
    expect: () => const [
      ForexState(rates: LoadState.loading()),
      ForexState(rates: LoadState.loading(), favourites: ['USD', 'GBP']),
      ForexState(
        rates: LoadState.failed(ServerFailure('boom')),
        favourites: ['USD', 'GBP'],
      ),
    ],
    verify: (c) => expect(c.state.rates.errorMessage, 'boom'),
  );

  blocTest<ForexCubit, ForexState>(
    'India region converts to INR and resets the NPR target',
    build: () {
      final inrRates = MockForexDataSource.dayFor(
        DateTime(2024, 3, 7),
        config: RegionConfig.india,
      ).toEntities();
      when(() => getLatest()).thenAnswer((_) async => Result.success(inrRates));
      return build(region: Region.india);
    },
    act: (c) => c.load(),
    verify: (c) {
      final s = c.state;
      expect(s.local, Currency.inr);
      expect(s.toIso3, 'INR');
      expect(s.currency('INR').unit, 1);
      expect(s.rateFor('INR'), isNull); // INR is the quote currency in India
      expect(s.rateFor('AED'), isNull); // not in the ECB catalogue
      expect(s.conversion!.to, Currency.inr);
      expect(s.conversion!.buyResult, s.rateFor('USD')!.buy);
    },
  );

  blocTest<ForexCubit, ForexState>(
    'selectRange reloads history for the new range',
    build: build,
    seed: () => ForexState(rates: LoadState.loaded(rates)),
    act: (c) => c.selectRange(ForexRange.month),
    verify: (c) {
      expect(c.state.range, ForexRange.month);
      verify(
        () => getHistory(
          const GetRateHistoryParams(iso3: 'USD', range: ForexRange.month),
        ),
      ).called(1);
    },
  );

  blocTest<ForexCubit, ForexState>(
    'setAmount recomputes the conversion',
    build: build,
    seed: () => ForexState(rates: LoadState.loaded(rates)),
    act: (c) => c.setAmount(10),
    verify: (c) {
      expect(c.state.amount, 10);
      expect(c.state.conversion!.buyResult, 10 * c.state.rateFor('USD')!.buy);
    },
  );

  blocTest<ForexCubit, ForexState>(
    'toggleFavourite adds up to 4 then refuses',
    build: build,
    seed: () => ForexState(
      rates: LoadState.loaded(rates),
      favourites: const ['USD', 'GBP', 'AUD', 'EUR'],
    ),
    act: (c) async {
      expect(await c.toggleFavourite('INR'), isFalse);
      expect(await c.toggleFavourite('AUD'), isTrue);
    },
    verify: (c) {
      expect(c.state.favourites, ['USD', 'GBP', 'EUR']);
      verify(() => saveFavs(['USD', 'GBP', 'EUR'])).called(1);
    },
  );
}
