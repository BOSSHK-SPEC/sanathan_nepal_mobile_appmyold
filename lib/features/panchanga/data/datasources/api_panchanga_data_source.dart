import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../models/panchanga_element_model.dart';
import '../models/panchanga_model.dart';
import '../models/suva_sait_model.dart';
import 'panchanga_data_source.dart';

/// Panchanga from the almanac panel, over the on-device calculation.
///
/// The two halves of this screen have genuinely different owners. Tithi,
/// nakshatra, sunrise and the rest are astronomy: deterministic, dependent on
/// the viewer's own location, and correct offline — so they are computed on
/// the device by [local]. But a published almanac is also an editorial
/// document: when the panel prints a tithi ending at a particular ghati, that
/// is the number people expect to see, and it must be able to differ from the
/// calculation without an app release.
///
/// So the calculation is the base, and whatever the server publishes for the
/// day is laid over it. A day the panel has not published still renders in
/// full rather than showing an empty card.
///
/// Suva saits are editorial outright — dates a panel chooses — and come
/// straight from the server.
class ApiPanchangaDataSource implements PanchangaDataSource {
  const ApiPanchangaDataSource({
    required ApiClient client,
    required PanchangaDataSource local,
  }) : _client = client,
       _local = local;

  final ApiClient _client;
  final PanchangaDataSource _local;

  @override
  Future<PanchangaModel> fetchPanchanga(DateTime date) async {
    final computed = await _local.fetchPanchanga(date);

    try {
      final response = await guardApi(
        () => _client.get<dynamic>(
          ApiEndpoints.almanacPanchanga,
          query: {'date': _isoDate(date)},
        ),
      );
      if (response.data == null) return computed;

      final payload = asJsonMap(response)['payload'];
      if (payload is! Map) return computed;
      return _overlay(computed, Map<String, dynamic>.from(payload));
    } catch (_) {
      // The published almanac is an enhancement, not a dependency: if it
      // cannot be reached the calculated panchanga is still correct.
      return computed;
    }
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

  /// Replaces only the fields the panel actually published.
  PanchangaModel _overlay(PanchangaModel computed, Map<String, dynamic> p) =>
      computed.copyWith(
        tithi: _element(computed.tithi, p['tithi'], computed.date),
        nakshatra: _element(computed.nakshatra, p['nakshatra'], computed.date),
        yoga: _element(computed.yoga, p['yoga'], computed.date),
        karana: _element(computed.karana, p['karana'], computed.date),
        sunrise: _timeOn(computed.date, p['sunrise']) ?? computed.sunrise,
        sunset: _timeOn(computed.date, p['sunset']) ?? computed.sunset,
        moonrise: _timeOn(computed.date, p['moonrise']) ?? computed.moonrise,
        moonset: _timeOn(computed.date, p['moonset']) ?? computed.moonset,
      );

  PanchangaElementModel _element(
    PanchangaElementModel computed,
    Object? raw,
    DateTime date,
  ) {
    if (raw is! Map) return computed;
    final published = Map<String, dynamic>.from(raw);
    final name = published['name'] as String?;
    final endsAt = _timeOn(date, published['endsAt']);

    return computed.copyWith(
      nameEn: name ?? computed.nameEn,
      // The published name is a single string; Nepali readers keep the
      // calculated Devanagari name rather than being shown a transliteration.
      nameNe: published['nameNe'] as String? ?? computed.nameNe,
      endsAt: endsAt ?? computed.endsAt,
    );
  }

  /// `"14:32"` on [date], in the device's own zone — the panchanga is read as
  /// local wall-clock time, which is what a printed almanac prints.
  static DateTime? _timeOn(DateTime date, Object? raw) {
    if (raw is! String) return null;
    final parts = raw.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

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
