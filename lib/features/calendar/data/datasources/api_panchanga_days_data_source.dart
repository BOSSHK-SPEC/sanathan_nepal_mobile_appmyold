import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/bounded_json_cache.dart';
import '../models/day_panchanga_model.dart';
import 'panchanga_days_data_source.dart';

/// Day panchanga from `GET /almanac/panchanga/range`.
///
/// The server computes every day from an ephemeris. A month fetched once is
/// kept in [cache] — a computed day never changes — so it shows exactly
/// offline. Only a month that was never fetched, while offline, falls back to
/// [fallback], whose days are marked approximate.
class ApiPanchangaDaysDataSource implements PanchangaDaysDataSource {
  ApiPanchangaDaysDataSource({
    required ApiClient client,
    required BoundedJsonCache cache,
    required RegionResolver resolver,
    required PanchangaDaysDataSource fallback,
  }) : _client = client,
       _cache = cache,
       _resolver = resolver,
       _fallback = fallback;

  final ApiClient _client;
  final BoundedJsonCache _cache;
  final RegionResolver _resolver;
  final PanchangaDaysDataSource _fallback;

  @override
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  }) async {
    final fromIso = _isoDate(from);
    final toIso = _isoDate(to);
    // Region is part of the key: Kathmandu's sunrise tithi is not New Delhi's.
    final key = '${_resolver.region.name}.$fromIso.$toIso';

    try {
      final response = await guardApi(
        () => _client.get<dynamic>(
          ApiEndpoints.almanacPanchangaRange,
          query: {'from': fromIso, 'to': toIso},
        ),
      );
      final rows = asJsonList(response);
      final days = _parse(rows);
      if (days.isNotEmpty) {
        await _cache.write(key, rows);
        return days;
      }
    } catch (_) {
      // Fall through to the cached copy.
    }

    final cached = _cache.readList(key);
    if (cached != null) {
      final days = _parse(cached);
      if (days.isNotEmpty) return days;
    }
    return _fallback.fetchRange(from: from, to: to);
  }

  static List<DayPanchangaModel> _parse(List<Map<String, dynamic>> rows) => [
    for (final row in rows) ?DayPanchangaModel.fromWire(row),
  ];

  static String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
