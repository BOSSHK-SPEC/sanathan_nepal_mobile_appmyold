import 'package:freezed_annotation/freezed_annotation.dart';

import 'currency.dart';

part 'forex_rate.freezed.dart';

/// Buy / sell quote for one currency on one date, in the local currency
/// (NPR / INR) per [Currency.unit] units.
@freezed
abstract class ForexRate with _$ForexRate {
  const ForexRate._();

  const factory ForexRate({
    required Currency currency,
    required double buy,
    required double sell,
    required DateTime date,
  }) = _ForexRate;

  /// Buy price for a single unit of the currency.
  double get buyPerUnit => buy / currency.unit;

  /// Sell price for a single unit of the currency.
  double get sellPerUnit => sell / currency.unit;
}
