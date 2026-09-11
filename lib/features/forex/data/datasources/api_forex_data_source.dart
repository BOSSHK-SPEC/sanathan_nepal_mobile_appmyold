import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../models/forex_day_model.dart';
import '../models/forex_rate_model.dart';
import 'forex_remote_data_source.dart';

/// Exchange rates as our backend publishes them.
///
/// The backend already normalises NRB (Nepal) and ECB (India) into one shape
/// and caches the result, so the app makes one call to one origin instead of
/// reaching out to a different central bank per region. The public-API sources
/// stay wired as the fallback: if our API is down the rates still render.
class ApiForexDataSource implements ForexRemoteDataSource {
  const ApiForexDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<ForexDayModel>> fetchRates({
    required DateTime from,
    required DateTime to,
  }) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.forex);
    return _group(asJsonList(response), from: from, to: to);
  });

  @override
  Future<List<ForexDayModel>> fetchHistory({
    required String iso3,
    required DateTime from,
    required DateTime to,
  }) => guardApi(() async {
    // Inclusive of both ends, which is how the repository counts a range.
    final days = to.difference(from).inDays + 1;
    final response = await _client.get<dynamic>(
      ApiEndpoints.forexHistory,
      query: {'iso3': iso3.toUpperCase(), 'days': days.clamp(1, 365)},
    );
    return _group(asJsonList(response), from: from, to: to);
  });

  /// Folds the flat `[{quoteIso3, buyMinor, asOf, …}]` wire format into the
  /// day-keyed shape the repository works in.
  List<ForexDayModel> _group(
    List<Map<String, dynamic>> rows, {
    required DateTime from,
    required DateTime to,
  }) {
    final byDate = <DateTime, List<ForexRateModel>>{};

    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);

    for (final row in rows) {
      final asOf = ApiTime.date(row['asOf']);
      if (asOf == null) continue;
      final date = DateTime(asOf.year, asOf.month, asOf.day);
      // The caller asked for a window; a cache that hands back one extra day
      // must not widen the chart behind its back.
      if (date.isBefore(start) || date.isAfter(end)) continue;

      (byDate[date] ??= []).add(
        ForexRateModel(
          currency: ForexCurrencyModel(
            iso3: row['quoteIso3'] as String? ?? '',
            unit: (row['unit'] as num?)?.toInt() ?? 1,
          ),
          buy: ApiMoney.toMajor(row['buyMinor']),
          sell: ApiMoney.toMajor(row['sellMinor']),
        ),
      );
    }

    if (byDate.isEmpty) throw const NotFoundException('No rates published');

    final days =
        byDate.entries
            .map(
              (e) => ForexDayModel(
                date: e.key,
                publishedOn: e.key,
                rates: e.value,
              ),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));
    return days;
  }
}
