import 'package:freezed_annotation/freezed_annotation.dart';

import 'currency.dart';

part 'conversion_result.freezed.dart';

/// Result of converting [amount] of [from] into [to] using NRB buy and sell
/// rates respectively.
@freezed
abstract class ConversionResult with _$ConversionResult {
  const factory ConversionResult({
    required double amount,
    required Currency from,
    required Currency to,

    /// Amount of [to] using buying rates.
    required double buyResult,

    /// Amount of [to] using selling rates.
    required double sellResult,
  }) = _ConversionResult;
}
