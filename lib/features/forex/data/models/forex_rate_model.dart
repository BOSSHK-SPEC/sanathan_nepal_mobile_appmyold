import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/currency.dart';
import '../../domain/entities/forex_rate.dart';

part 'forex_rate_model.freezed.dart';
part 'forex_rate_model.g.dart';

/// The `currency` object of one NRB rate entry: `{iso3, name, unit}`.
@freezed
abstract class ForexCurrencyModel with _$ForexCurrencyModel {
  const ForexCurrencyModel._();

  const factory ForexCurrencyModel({
    @JsonKey(name: 'iso3') required String iso3,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'unit', fromJson: _unitFromJson) @Default(1) int unit,
  }) = _ForexCurrencyModel;

  factory ForexCurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$ForexCurrencyModelFromJson(json);

  factory ForexCurrencyModel.fromEntity(Currency e) =>
      ForexCurrencyModel(iso3: e.iso3, name: e.nameEn, unit: e.unit);

  /// Resolves the wire currency against the built-in catalogues (NRB, then
  /// ECB) so trilingual names / flags come from the app; unknown codes get an
  /// English-only fallback. [unit] always comes from the payload.
  Currency toEntity() {
    final code = iso3.toUpperCase();
    final known =
        Currency.byIso3(code) ?? Currency.byIso3(code, catalogue: Currency.ecb);
    if (known != null) return known.copyWith(unit: unit);
    return Currency(
      iso3: code,
      nameEn: name ?? code,
      nameNe: name ?? code,
      countryCode: code.length >= 2 ? code.substring(0, 2) : 'UN',
      unit: unit,
    );
  }
}

/// One entry of the NRB `rates` array:
/// `{currency:{iso3,name,unit}, buy, sell}` (buy / sell arrive as strings or
/// numbers). The quote date lives on the enclosing `ForexDayModel`.
@freezed
abstract class ForexRateModel with _$ForexRateModel {
  const ForexRateModel._();

  const factory ForexRateModel({
    @JsonKey(name: 'currency') required ForexCurrencyModel currency,
    @JsonKey(name: 'buy', fromJson: _doubleFromJson) required double buy,
    @JsonKey(name: 'sell', fromJson: _doubleFromJson) required double sell,
  }) = _ForexRateModel;

  factory ForexRateModel.fromJson(Map<String, dynamic> json) =>
      _$ForexRateModelFromJson(json);

  factory ForexRateModel.fromEntity(ForexRate e) => ForexRateModel(
    currency: ForexCurrencyModel.fromEntity(e.currency),
    buy: e.buy,
    sell: e.sell,
  );

  /// Entity for the publication [date] of the enclosing day.
  ForexRate toEntity(DateTime date) => ForexRate(
    currency: currency.toEntity(),
    buy: buy,
    sell: sell,
    date: date,
  );
}

double _doubleFromJson(Object? v) => switch (v) {
  final num n => n.toDouble(),
  final String s => double.tryParse(s.replaceAll(',', '')) ?? 0,
  _ => 0,
};

int _unitFromJson(Object? v) => switch (v) {
  final num n => n.toInt(),
  final String s => int.tryParse(s) ?? 1,
  _ => 1,
};
