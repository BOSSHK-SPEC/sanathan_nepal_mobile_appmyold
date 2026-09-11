import 'package:freezed_annotation/freezed_annotation.dart';

part 'metal_rates.freezed.dart';

/// Daily gold / silver rate shown on the Home header, quoted in the region's
/// currency per bullion unit (NPR per tola in Nepal, INR per 10 g in India).
@freezed
abstract class MetalRates with _$MetalRates {
  const factory MetalRates({
    required double goldPerUnit,
    required double silverPerUnit,

    /// ISO 4217 code (NPR / INR).
    required String currencyCode,

    /// Bullion unit the prices refer to ("tola" / "10 g").
    required String unit,
    required DateTime date,
  }) = _MetalRates;
}
