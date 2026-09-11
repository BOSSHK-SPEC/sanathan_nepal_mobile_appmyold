import '../../../../core/utils/result.dart';
import '../entities/forex_history_point.dart';
import '../entities/forex_range.dart';
import '../entities/forex_rate.dart';

/// Contract for NRB exchange-rate data and the user's favourite currencies.
abstract interface class ForexRepository {
  /// Most recent published rates for every currency.
  Future<Result<List<ForexRate>>> getLatestRates();

  /// Daily history for [iso3] over [range], oldest first.
  Future<Result<List<ForexHistoryPoint>>> getRateHistory(
    String iso3,
    ForexRange range,
  );

  /// ISO codes of currencies pinned to the home page (max 4).
  Future<Result<List<String>>> getFavouriteCurrencies();

  Future<Result<void>> saveFavouriteCurrencies(List<String> iso3s);
}
