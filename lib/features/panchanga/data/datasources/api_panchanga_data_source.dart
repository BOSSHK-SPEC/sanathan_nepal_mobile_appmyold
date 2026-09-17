import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/bounded_json_cache.dart';
import '../models/panchanga_model.dart';
import '../models/suva_sait_model.dart';
import 'panchanga_data_source.dart';
import 'panchanga_server_overlay.dart';

/// Panchanga from our server, over the on-device calculation.
///
/// The server computes every day from an ephemeris (checked against Drik
/// Panchang); the device's [local] calculation is a mean-motion estimate that
/// can put the tithi a day out. So the server's day replaces the estimate
/// field by field (see [PanchangaServerOverlay]), and the estimate only shows
/// when neither the server nor an earlier copy of that day is available — in
/// which case the day says it is approximate.
///
/// A computed day never changes, so each one fetched is kept in [cache] and
/// shown offline afterwards.
///
/// Suva saits are editorial — dates a panel chooses — and come straight from
/// the server.
class ApiPanchangaDataSource implements PanchangaDataSource {
  ApiPanchangaDataSource({
    required ApiClient client,
    required PanchangaDataSource local,
    required BoundedJsonCache cache,
    required RegionResolver resolver,
  }) : _client = client,
       _local = local,
       _cache = cache,
       _resolver = resolver;

  final ApiClient _client;
  final PanchangaDataSource _local;
  final BoundedJsonCache _cache;
  final RegionResolver _resolver;

  @override
  Future<PanchangaModel> fetchPanchanga(DateTime date) async {
    final computed = await _local.fetchPanchanga(date);
    // Region is part of the key: Kathmandu's day is not New Delhi's.
    final key = '${_resolver.region.name}.${_isoDate(date)}';

    Map<String, dynamic>? payload;
    try {
      final response = await guardApi(
        () => _client.get<dynamic>(
          ApiEndpoints.almanacPanchanga,
          query: {'date': _isoDate(date)},
        ),
      );
      final raw = asJsonMap(response)['payload'];
      if (raw is Map) {
        payload = Map<String, dynamic>.from(raw);
        await _cache.write(key, payload);
      }
    } catch (_) {
      // Offline or unreachable: an earlier copy of this day is still exact.
      payload = _cache.readMap(key);
    }

    if (payload == null) return computed;
    return PanchangaModel.fromEntity(
      PanchangaServerOverlay.apply(computed.toEntity(), payload),
    );
  }

  @override
  Future<List<SuvaSaitModel>> fetchSuvaSaits() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.almanacSuvaSaits);

    // The server stores one row per window; the app shows one card per
    // occasion with all of its dates, so rows are grouped by title.
    final byTitle = <String, SuvaSaitModel>{};
    for (final json in asJsonList(response)) {
      final title = _localized(json['title']);
      final detail = _localized(json['detail']);
      final key = title['en'] ?? title.values.firstOrNull ?? '';
      final startsAt = ApiTime.instant(json['startsAt']);
      if (startsAt == null) continue;

      final existing = byTitle[key];
      byTitle[key] = existing == null
          ? SuvaSaitModel(
              id: json['id'] as String? ?? '',
              titleEn: title['en'] ?? '',
              titleNe: title['ne'] ?? title['en'] ?? '',
              dates: [startsAt.toLocal()],
              noteEn: detail['en'] ?? '',
              noteNe: detail['ne'] ?? detail['en'] ?? '',
            )
          : existing.copyWith(
              dates: [...existing.dates, startsAt.toLocal()]
                ..sort((a, b) => a.compareTo(b)),
            );
    }
    return byTitle.values.toList(growable: false);
  });

  static Map<String, String> _localized(Object? raw) {
    if (raw is String) return {'en': raw};
    if (raw is! Map) return const {};
    return {
      for (final entry in raw.entries) entry.key.toString(): '${entry.value}',
    };
  }

  static String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
