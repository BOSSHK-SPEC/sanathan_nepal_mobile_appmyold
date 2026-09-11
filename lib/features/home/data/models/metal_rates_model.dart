import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/metal_rates.dart';

part 'metal_rates_model.freezed.dart';
part 'metal_rates_model.g.dart';

/// Wire/persistence shape of [MetalRates].
@freezed
abstract class MetalRatesModel with _$MetalRatesModel {
  const MetalRatesModel._();

  const factory MetalRatesModel({
    required double gold,
    required double silver,
    @Default('NPR') String currency,
    @Default('tola') String unit,
    required DateTime date,
  }) = _MetalRatesModel;

  factory MetalRatesModel.fromJson(Map<String, dynamic> json) =>
      _$MetalRatesModelFromJson(json);

  factory MetalRatesModel.fromEntity(MetalRates e) => MetalRatesModel(
    gold: e.goldPerUnit,
    silver: e.silverPerUnit,
    currency: e.currencyCode,
    unit: e.unit,
    date: e.date,
  );

  MetalRates toEntity() => MetalRates(
    goldPerUnit: gold,
    silverPerUnit: silver,
    currencyCode: currency,
    unit: unit,
    date: date,
  );
}
