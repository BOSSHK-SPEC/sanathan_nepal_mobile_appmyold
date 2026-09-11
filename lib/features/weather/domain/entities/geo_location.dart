import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';

part 'geo_location.freezed.dart';

/// A geographic coordinate plus a human readable place name (English with
/// optional Nepali / Hindi variants).
@freezed
abstract class GeoLocation with _$GeoLocation {
  const GeoLocation._();

  const factory GeoLocation({
    required double latitude,
    required double longitude,
    required String name,
    String? nameNe,
    String? nameHi,
  }) = _GeoLocation;

  /// Builds a location from a region's [GeoPoint] (e.g.
  /// `RegionConfig.defaultCity`).
  factory GeoLocation.fromGeoPoint(GeoPoint point) => GeoLocation(
    latitude: point.latitude,
    longitude: point.longitude,
    name: point.nameEn,
    nameNe: point.nameNe,
    nameHi: point.nameHi,
  );

  /// Nepal's default location (used when device location is unavailable in
  /// the Nepal region – see `RegionConfig.nepal.defaultCity`).
  static const GeoLocation kathmandu = GeoLocation(
    latitude: 27.7172,
    longitude: 85.3240,
    name: 'Kathmandu',
    nameNe: 'काठमाडौँ',
    nameHi: 'काठमांडू',
  );

  /// India's default location (see `RegionConfig.india.defaultCity`).
  static const GeoLocation newDelhi = GeoLocation(
    latitude: 28.6139,
    longitude: 77.2090,
    name: 'New Delhi',
    nameNe: 'नयाँ दिल्ली',
    nameHi: 'नई दिल्ली',
  );

  /// Place name for [languageCode] (`ne` / `hi` / other → English), falling
  /// back to English when a translation is missing.
  String displayName({required String languageCode}) => switch (languageCode) {
    'ne' => nameNe ?? name,
    'hi' => nameHi ?? nameNe ?? name,
    _ => name,
  };
}
