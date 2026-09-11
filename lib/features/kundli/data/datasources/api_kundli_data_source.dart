import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/dasha.dart';
import '../../domain/entities/dosha.dart';
import '../../domain/entities/gun_milan.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';
import 'kundli_data_source.dart';

/// Charts computed by the backend.
///
/// The ephemeris lives on the server on purpose: paid reports built from a
/// calculation shipped inside the APK can be generated for free by anyone who
/// reads it, and a correction to the maths would otherwise need an app-store
/// release to reach anybody.
class ApiKundliDataSource implements KundliDataSource {
  const ApiKundliDataSource(this._client, this._regions);

  final ApiClient _client;
  final RegionResolver _regions;

  @override
  Future<List<BirthProfile>> profiles() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.kundliProfiles);
    return asJsonList(response).map(_toProfile).toList(growable: false);
  });

  @override
  Future<BirthProfile> saveProfile(BirthProfile profile) => guardApi(() async {
    final birth = profile.birthDateTime;
    final response = await _client.put<dynamic>(
      ApiEndpoints.kundliProfiles,
      data: {
        if (profile.id.isNotEmpty) 'id': profile.id,
        'name': profile.name,
        'gender': profile.isFemale ? 'female' : 'male',
        'birthDate': _isoDate(birth),
        // Noon when the time is unknown: it is the least-wrong assumption for
        // the Moon's position, and `timeUnknown` tells the app to hide the
        // houses that a guessed time cannot support.
        'birthTime': profile.timeUnknown ? '12:00' : _isoTime(birth),
        'birthPlace': profile.birthPlace,
        // Coordinates come from the place the user picked; until the geocoder
        // is wired the region's default city is used, which is what the mock
        // assumed too.
        'latitude': _defaultLatitude,
        'longitude': _defaultLongitude,
        'timezoneOffsetMinutes': birth.timeZoneOffset.inMinutes,
        'isSelf': profile.relation == ChartRelation.self,
        'relation': profile.relation.name,
        'timeUnknown': profile.timeUnknown,
      },
    );
    return _toProfile(asJsonMap(response));
  });

  @override
  Future<void> deleteProfile(String profileId) => guardApi(
    () => _client.delete<dynamic>(ApiEndpoints.kundliProfile(profileId)),
  );

  @override
  Future<KundliChart> chart(String profileId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.kundliChart(profileId),
    );
    final json = asJsonMap(response);
    final profiles = await this.profiles();

    return KundliChart(
      profile: profiles.firstWhere(
        (p) => p.id == profileId,
        orElse: () => BirthProfile(
          id: profileId,
          name: '',
          birthDateTime: DateTime.now(),
          birthPlace: '',
        ),
      ),
      ascendantLongitude: _double(_map(json['ascendant'])['longitude']),
      positions: _list(
        json['planets'],
      ).map(_toPosition).whereType<PlanetPosition>().toList(growable: false),
    );
  });

  @override
  Future<List<DashaPeriod>> dashas(String profileId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.kundliDashas(profileId),
    );
    return asJsonList(
      response,
    ).map(_toDasha).whereType<DashaPeriod>().toList(growable: false);
  });

  @override
  Future<List<DoshaReading>> doshas(String profileId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.kundliDoshas(profileId),
    );
    return asJsonList(
      response,
    ).map(_toDosha).whereType<DoshaReading>().toList(growable: false);
  });

  @override
  Future<GunMilanResult> match({
    required String brideProfileId,
    required String groomProfileId,
  }) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.kundliMatch,
      query: {'bride': brideProfileId, 'groom': groomProfileId},
    );
    final json = asJsonMap(response);
    final breakdown = _map(json['breakdown']);

    return GunMilanResult(
      brideProfileId: json['brideProfileId'] as String? ?? brideProfileId,
      groomProfileId: json['groomProfileId'] as String? ?? groomProfileId,
      // Every koota is listed even when the server omits one, so the eight
      // rows of the table always render and a missing score reads as zero
      // rather than as a shorter table.
      scores: Koota.values
          .map(
            (koota) => KootaScore(
              koota: koota,
              points: (breakdown[koota.name] as num?)?.toInt() ?? 0,
            ),
          )
          .toList(growable: false),
      brideManglik:
          _toDosha(_map(json['brideManglik'])) ?? _noDosha(DoshaKind.manglik),
      groomManglik:
          _toDosha(_map(json['groomManglik'])) ?? _noDosha(DoshaKind.manglik),
    );
  });

  // ---------------------------------------------------------------- mapping --

  BirthProfile _toProfile(Map<String, dynamic> json) {
    final date = ApiTime.date(json['birthDate']);
    final time = (json['birthTime'] as String? ?? '12:00').split(':');
    final hour = int.tryParse(time.firstOrNull ?? '') ?? 12;
    final minute = int.tryParse(time.elementAtOrNull(1) ?? '') ?? 0;

    return BirthProfile(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      birthDateTime: DateTime(
        date?.year ?? DateTime.now().year,
        date?.month ?? 1,
        date?.day ?? 1,
        hour,
        minute,
      ),
      birthPlace: json['birthPlace'] as String? ?? '',
      relation: ChartRelation.values.firstWhere(
        (r) => r.name == json['relation'],
        orElse: () =>
            json['isSelf'] == true ? ChartRelation.self : ChartRelation.other,
      ),
      isFemale: json['gender'] == 'female',
      timeUnknown: json['timeUnknown'] as bool? ?? false,
    );
  }

  PlanetPosition? _toPosition(Map<String, dynamic> json) {
    final graha = Graha.values
        .where((g) => g.name == json['planet'])
        .firstOrNull;
    if (graha == null) return null;

    return PlanetPosition(
      graha: graha,
      longitude: _double(json['longitude']),
      // The server counts houses from zero; the chart is drawn 1–12.
      house: ((json['houseIndex'] as num?)?.toInt() ?? 0) + 1,
      retrograde: json['isRetrograde'] as bool? ?? false,
    );
  }

  /// Mahadashas only. The server sends the top-level timeline; antardashas
  /// are a drill-down the API does not expose yet, so [DashaPeriod.children]
  /// stays empty rather than being invented on the device.
  DashaPeriod? _toDasha(Map<String, dynamic> json) {
    final graha = Graha.values
        .where((g) => g.name == (json['lord'] as String? ?? '').toLowerCase())
        .firstOrNull;
    final start = ApiTime.instant(json['startsAt']);
    final end = ApiTime.instant(json['endsAt']);
    if (graha == null || start == null || end == null) return null;
    return DashaPeriod(graha: graha, start: start, end: end);
  }

  DoshaReading? _toDosha(Map<String, dynamic> json) {
    final kind = switch (json['key']) {
      'mangal' => DoshaKind.manglik,
      'kaalSarp' => DoshaKind.kaalSarp,
      'sadeSati' => DoshaKind.sadeSati,
      _ => null,
    };
    if (kind == null) return null;

    final detail = json['detail'] as String? ?? '';
    return DoshaReading(
      kind: kind,
      severity: switch (json['severity']) {
        'mild' => DoshaSeverity.mild,
        'moderate' => DoshaSeverity.moderate,
        // The server's most severe grade; the app calls it "high".
        'severe' => DoshaSeverity.high,
        _ => DoshaSeverity.none,
      },
      factors: detail.isEmpty ? const [] : [detail],
    );
  }

  static DoshaReading _noDosha(DoshaKind kind) =>
      DoshaReading(kind: kind, severity: DoshaSeverity.none);

  double get _defaultLatitude => _regions.config.defaultCity.latitude;

  double get _defaultLongitude => _regions.config.defaultCity.longitude;

  static Map<String, dynamic> _map(Object? raw) =>
      raw is Map ? Map<String, dynamic>.from(raw) : const {};

  static List<Map<String, dynamic>> _list(Object? raw) => raw is List
      ? raw.whereType<Map>().map(Map<String, dynamic>.from).toList()
      : const [];

  static double _double(Object? raw) => (raw as num?)?.toDouble() ?? 0;

  static String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  static String _isoTime(DateTime date) =>
      '${date.hour.toString().padLeft(2, '0')}:'
      '${date.minute.toString().padLeft(2, '0')}';
}
