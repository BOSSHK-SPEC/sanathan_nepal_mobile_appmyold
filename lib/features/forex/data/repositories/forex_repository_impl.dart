import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/forex_history_point.dart';
import '../../domain/entities/forex_range.dart';
import '../../domain/entities/forex_rate.dart';
import '../../domain/repositories/forex_repository.dart';
import '../datasources/forex_local_data_source.dart';
import '../datasources/forex_remote_data_source.dart';
import '../models/forex_day_model.dart';

/// Fetches from the primary source, falling back to a second one when it
/// fails or returns nothing (in production: our backend, then the region's
/// central bank directly); favourites live in local key-value storage
/// (per region), so pinning works signed-out and offline.
class ForexRepositoryImpl implements ForexRepository {
  ForexRepositoryImpl({
    required ForexRemoteDataSource remote,
    required ForexRemoteDataSource fallback,
    required ForexLocalDataSource local,
    DateTime Function()? clock,
  }) : _remote = remote,
       _fallback = fallback,
       _local = local,
       _clock = clock ?? DateTime.now;

  final ForexRemoteDataSource _remote;
  final ForexRemoteDataSource _fallback;
  final ForexLocalDataSource _local;
  final DateTime Function() _clock;

  @override
  Future<Result<List<ForexRate>>> getLatestRates() => guard(() async {
    final today = _clock();
    // NRB skips weekends/holidays – look back a week for the last table.
    final days = await _fetch(
      from: today.subtract(const Duration(days: 7)),
      to: today,
    );
    final latest = days.lastWhere(
      (d) => d.rates.isNotEmpty,
      orElse: () => days.last,
    );
    return latest.toEntities();
  });

  @override
  Future<Result<List<ForexHistoryPoint>>> getRateHistory(
    String iso3,
    ForexRange range,
  ) => guard(() async {
    final today = _clock();
    final code = iso3.toUpperCase();
    final days = await _fetch(
      from: today.subtract(Duration(days: range.days - 1)),
      to: today,
      iso3: code,
    );
    final points = <ForexHistoryPoint>[];
    for (final day in days) {
      for (final r in day.rates) {
        if (r.currency.iso3 == code) {
          points.add(
            ForexHistoryPoint(date: day.date, buy: r.buy, sell: r.sell),
          );
          break;
        }
      }
    }
    return points;
  });

  @override
  Future<Result<List<String>>> getFavouriteCurrencies() =>
      guard(_local.readFavourites);

  @override
  Future<Result<void>> saveFavouriteCurrencies(List<String> iso3s) =>
      guard(() => _local.writeFavourites(iso3s));

  /// One window, two sources. [iso3] asks for a single currency's history,
  /// which sources that can answer it directly serve without downloading the
  /// whole table.
  Future<List<ForexDayModel>> _fetch({
    required DateTime from,
    required DateTime to,
    String? iso3,
  }) async {
    try {
      final days = await _read(_remote, from: from, to: to, iso3: iso3);
      if (days.isNotEmpty) return days;
    } catch (_) {
      // fall through to the offline source
    }
    return _read(_fallback, from: from, to: to, iso3: iso3);
  }

  Future<List<ForexDayModel>> _read(
    ForexRemoteDataSource source, {
    required DateTime from,
    required DateTime to,
    String? iso3,
  }) => iso3 == null
      ? source.fetchRates(from: from, to: to)
      : source.fetchHistory(iso3: iso3, from: from, to: to);
}
