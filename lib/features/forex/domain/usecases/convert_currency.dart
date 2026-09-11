import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/conversion_result.dart';
import '../entities/currency.dart';
import '../entities/forex_rate.dart';

part 'convert_currency.freezed.dart';

/// Parameters for [ConvertCurrency].
@freezed
abstract class ConvertCurrencyParams with _$ConvertCurrencyParams {
  const factory ConvertCurrencyParams({
    required double amount,
    required Currency from,
    required Currency to,

    /// Latest rates quoted in the local currency (which itself needs no entry).
    required List<ForexRate> rates,

    /// ISO code of the quote (local) currency – `NPR` for Nepal, `INR` for
    /// India. Comes from `RegionConfig.currencyCode`.
    @Default('NPR') String localIso3,
  }) = _ConvertCurrencyParams;
}

/// Pure conversion via the local currency: `amount × rate(from) ÷ rate(to)`,
/// computed once with buying rates and once with selling rates.
class ConvertCurrency
    implements UseCase<ConversionResult, ConvertCurrencyParams> {
  const ConvertCurrency();

  @override
  Future<Result<ConversionResult>> call(ConvertCurrencyParams p) async {
    final from = _find(p.rates, p.from, p.localIso3);
    final to = _find(p.rates, p.to, p.localIso3);
    if (from == null || to == null) {
      return const Result.failure(
        ValidationFailure('Rate not available for the selected currency'),
      );
    }
    if (p.amount.isNaN || p.amount < 0) {
      return const Result.failure(ValidationFailure('Invalid amount'));
    }
    return Result.success(
      ConversionResult(
        amount: p.amount,
        from: p.from,
        to: p.to,
        buyResult: p.amount * from.$1 / to.$1,
        sellResult: p.amount * from.$2 / to.$2,
      ),
    );
  }

  /// `(buyPerUnit, sellPerUnit)` in the local currency; the local currency
  /// itself is 1/1.
  static (double, double)? _find(
    List<ForexRate> rates,
    Currency c,
    String localIso3,
  ) {
    if (c.iso3 == localIso3.toUpperCase()) return (1, 1);
    for (final r in rates) {
      if (r.currency.iso3 == c.iso3) return (r.buyPerUnit, r.sellPerUnit);
    }
    return null;
  }
}
