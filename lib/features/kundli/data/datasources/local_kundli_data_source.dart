import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/dasha.dart';
import '../../domain/entities/dosha.dart';
import '../../domain/entities/gun_milan.dart';
import '../../domain/entities/kundli_chart.dart';
import 'dasha_calculator.dart';
import 'dosha_calculator.dart';
import 'ephemeris.dart';
import 'gun_milan_calculator.dart';
import 'kundli_data_source.dart';

/// Casts charts locally and persists saved birth profiles.
///
/// Local rather than remote on purpose: a chart is a pure function of birth
/// data, so computing it on the device is instant, works offline and keeps
/// birth details — which are sensitive — off the wire until there is a
/// reason to send them.
class LocalKundliDataSource implements KundliDataSource {
  const LocalKundliDataSource(this._store, this._ephemeris);

  final KeyValueStore _store;
  final Ephemeris _ephemeris;

  static const _profilesKey = 'kundli.profiles';
  static const Duration _latency = Duration(milliseconds: 140);

  @override
  Future<List<BirthProfile>> profiles() async {
    await Future<void>.delayed(_latency);
    return _read();
  }

  @override
  Future<BirthProfile> saveProfile(BirthProfile profile) async {
    await Future<void>.delayed(_latency);
    if (profile.name.trim().isEmpty) {
      throw const ValidationException('Enter a name');
    }
    if (profile.birthPlace.trim().isEmpty) {
      throw const ValidationException('Enter a birth place');
    }
    if (profile.birthDateTime.isAfter(DateTime.now())) {
      throw const ValidationException('Birth date cannot be in the future');
    }

    final existing = _read();
    final saved = profile.id.isEmpty
        ? profile.copyWith(
            id: 'bp-${DateTime.now().microsecondsSinceEpoch}',
            createdAt: DateTime.now(),
          )
        : profile;

    final next = [saved, ...existing.where((p) => p.id != saved.id)];
    await _write(next);
    return saved;
  }

  @override
  Future<void> deleteProfile(String profileId) async {
    await Future<void>.delayed(_latency);
    await _write(_read().where((p) => p.id != profileId).toList());
  }

  @override
  Future<KundliChart> chart(String profileId) async {
    await Future<void>.delayed(_latency);
    return _castFor(_require(profileId));
  }

  @override
  Future<List<DashaPeriod>> dashas(String profileId) async {
    await Future<void>.delayed(_latency);
    return DashaCalculator.forChart(_castFor(_require(profileId)));
  }

  @override
  Future<List<DoshaReading>> doshas(String profileId) async {
    await Future<void>.delayed(_latency);
    return DoshaCalculator.forChart(_castFor(_require(profileId)));
  }

  @override
  Future<GunMilanResult> match({
    required String brideProfileId,
    required String groomProfileId,
  }) async {
    await Future<void>.delayed(_latency);
    if (brideProfileId == groomProfileId) {
      throw const ValidationException('Choose two different charts');
    }
    return GunMilanCalculator.match(
      bride: _castFor(_require(brideProfileId)),
      groom: _castFor(_require(groomProfileId)),
    );
  }

  KundliChart _castFor(BirthProfile profile) {
    final cast = _ephemeris.cast(profile);
    return KundliChart(
      profile: profile,
      ascendantLongitude: cast.ascendant,
      positions: cast.positions,
    );
  }

  BirthProfile _require(String id) {
    final matches = _read().where((p) => p.id == id);
    if (matches.isEmpty) {
      throw NotFoundException('No saved chart with id "$id"');
    }
    return matches.first;
  }

  List<BirthProfile> _read() {
    final raw = _store.getString(_profilesKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        BirthProfile(
          id: e['id'] as String,
          name: e['name'] as String,
          birthDateTime: DateTime.parse(e['birthDateTime'] as String),
          birthPlace: e['birthPlace'] as String,
          relation: ChartRelation.values.firstWhere(
            (r) => r.name == e['relation'],
            orElse: () => ChartRelation.other,
          ),
          isFemale: e['isFemale'] as bool? ?? false,
          timeUnknown: e['timeUnknown'] as bool? ?? false,
          createdAt: e['createdAt'] == null
              ? null
              : DateTime.parse(e['createdAt'] as String),
        ),
    ];
  }

  Future<void> _write(List<BirthProfile> profiles) => _store.setString(
    _profilesKey,
    jsonEncode([
      for (final p in profiles)
        {
          'id': p.id,
          'name': p.name,
          'birthDateTime': p.birthDateTime.toIso8601String(),
          'birthPlace': p.birthPlace,
          'relation': p.relation.name,
          'isFemale': p.isFemale,
          'timeUnknown': p.timeUnknown,
          'createdAt': p.createdAt?.toIso8601String(),
        },
    ]),
  );
}
