import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region_all.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/conversion_result.dart';
import '../../domain/entities/currency.dart';
import '../../domain/entities/forex_history_point.dart';
import '../../domain/entities/forex_range.dart';
import '../../domain/entities/forex_rate.dart';
import '../../domain/usecases/convert_currency.dart';
import '../../domain/usecases/get_latest_rates.dart';
import '../../domain/usecases/get_rate_history.dart';
import '../../domain/usecases/manage_favourite_currencies.dart';
import '../../../../core/state/app_cubit.dart';

part 'forex_cubit.freezed.dart';
part 'forex_state.dart';

/// Drives the forex page and the home section: latest rates, trend history,
/// the converter and the pinned ("favourite") currencies.
///
/// The local (quote) currency – NPR for Nepal, INR for India – is read from
/// [RegionResolver] on every [load] so a region switch is picked up on the
/// next refresh.
class ForexCubit extends AppCubit<ForexState> {
  ForexCubit({
    required GetLatestRates getLatestRates,
    required GetRateHistory getRateHistory,
    required ConvertCurrency convertCurrency,
    required GetFavouriteCurrencies getFavourites,
    required SaveFavouriteCurrencies saveFavourites,
    required RegionResolver resolver,
  }) : _getLatestRates = getLatestRates,
       _getRateHistory = getRateHistory,
       _convert = convertCurrency,
       _getFavourites = getFavourites,
       _saveFavourites = saveFavourites,
       _resolver = resolver,
       super(
         ForexState(local: Currency.localFor(resolver.config.currencyCode)),
       );

  final GetLatestRates _getLatestRates;
  final GetRateHistory _getRateHistory;
  final ConvertCurrency _convert;
  final GetFavouriteCurrencies _getFavourites;
  final SaveFavouriteCurrencies _saveFavourites;
  final RegionResolver _resolver;

  /// Loads favourites, latest rates, then the trend history and conversion.
  Future<void> load() async {
    final local = Currency.localFor(_resolver.config.currencyCode);
    emit(state.copyWith(rates: state.rates.toLoading(), local: local));
    final favs = await _getFavourites();
    favs.fold((_) {}, (list) => emit(state.copyWith(favourites: list)));

    final result = await _getLatestRates();
    switch (result) {
      case ResultFailure(:final failure):
        emit(state.copyWith(rates: state.rates.toFailed(failure)));
      case Success(value: final rates):
        emit(
          state.copyWith(
            rates: LoadState.loaded(rates),
            fromIso3: _valid(state.fromIso3, rates, local) ?? 'USD',
            toIso3: _valid(state.toIso3, rates, local) ?? local.iso3,
            trendIso3: _valid(state.trendIso3, rates, local) ?? 'USD',
          ),
        );
        await Future.wait([_loadHistory(), _recompute()]);
    }
  }

  /// [iso3] when it is quoted in [rates] or is the local currency, else null
  /// (e.g. `NPR` after switching to India).
  static String? _valid(String iso3, List<ForexRate> rates, Currency local) {
    if (iso3 == local.iso3) return iso3;
    for (final r in rates) {
      if (r.currency.iso3 == iso3) return iso3;
    }
    return null;
  }

  Future<void> selectRange(ForexRange range) async {
    if (range == state.range) return;
    emit(state.copyWith(range: range));
    await _loadHistory();
  }

  Future<void> selectTrendCurrency(String iso3) async {
    if (iso3 == state.trendIso3) return;
    emit(state.copyWith(trendIso3: iso3));
    await _loadHistory();
  }

  Future<void> setFromCurrency(String iso3) async {
    emit(state.copyWith(fromIso3: iso3));
    await _recompute();
  }

  Future<void> setToCurrency(String iso3) async {
    emit(state.copyWith(toIso3: iso3));
    await _recompute();
  }

  Future<void> swapCurrencies() async {
    emit(state.copyWith(fromIso3: state.toIso3, toIso3: state.fromIso3));
    await _recompute();
  }

  Future<void> setAmount(double amount) async {
    emit(state.copyWith(amount: amount < 0 ? 0 : amount));
    await _recompute();
  }

  /// Adds or removes [iso3] from the pinned list (max
  /// [SaveFavouriteCurrencies.maxFavourites]); returns false when full.
  Future<bool> toggleFavourite(String iso3) async {
    final list = List<String>.of(state.favourites);
    if (list.contains(iso3)) {
      list.remove(iso3);
    } else if (list.length >= SaveFavouriteCurrencies.maxFavourites) {
      return false;
    } else {
      list.add(iso3);
    }
    emit(state.copyWith(favourites: list));
    await _saveFavourites(list);
    return true;
  }

  Future<void> _loadHistory() async {
    emit(state.copyWith(history: state.history.toLoading()));
    final result = await _getRateHistory(
      GetRateHistoryParams(iso3: state.trendIso3, range: state.range),
    );
    emit(
      state.copyWith(
        history: result.fold(state.history.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> _recompute() async {
    if (!state.hasRates) return;
    final result = await _convert(
      ConvertCurrencyParams(
        amount: state.amount,
        from: state.currency(state.fromIso3),
        to: state.currency(state.toIso3),
        rates: state.rateList,
        localIso3: state.local.iso3,
      ),
    );
    emit(state.copyWith(conversion: result.valueOrNull));
  }
}
