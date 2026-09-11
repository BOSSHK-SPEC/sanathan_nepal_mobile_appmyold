part of 'forex_cubit.dart';

/// UI state shared by the forex page and the home `ForexSection`.
@freezed
abstract class ForexState with _$ForexState {
  const ForexState._();

  const factory ForexState({
    /// Latest published rates (all currencies of the region's catalogue).
    @Default(LoadState.idle()) LoadState<List<ForexRate>> rates,

    /// Currency shown in the trend chart.
    @Default('USD') String trendIso3,
    @Default(ForexRange.week) ForexRange range,

    /// Daily history of [trendIso3] over [range].
    @Default(LoadState.idle()) LoadState<List<ForexHistoryPoint>> history,

    // Converter
    @Default('USD') String fromIso3,
    @Default('NPR') String toIso3,
    @Default(1) double amount,

    /// Result of the converter; `null` until rates are loaded or when a
    /// selected currency has no quote.
    ConversionResult? conversion,

    /// ISO codes pinned to the home page (max 4).
    @Default(['USD', 'GBP', 'AUD']) List<String> favourites,

    /// Local (quote) currency of the active region – NPR / INR.
    @Default(Currency.npr) Currency local,
  }) = _ForexState;

  /// Loaded rates (or the stale ones kept while refreshing); empty before
  /// the first successful load.
  List<ForexRate> get rateList => rates.dataOrNull ?? const [];

  /// Loaded history points (or the stale ones kept while refreshing).
  List<ForexHistoryPoint> get historyPoints => history.dataOrNull ?? const [];

  bool get isLoading => rates.isLoading;
  bool get hasRates => rateList.isNotEmpty;

  /// Publication date of the loaded rates (null before load).
  DateTime? get ratesDate => hasRates ? rateList.first.date : null;

  ForexRate? rateFor(String iso3) {
    for (final r in rateList) {
      if (r.currency.iso3 == iso3) return r;
    }
    return null;
  }

  Currency get trendCurrency => currency(trendIso3);

  /// Resolves [iso3] to the local currency, a loaded rate's currency, or a
  /// catalogue entry (falling back to the local currency).
  Currency currency(String iso3) {
    if (iso3 == local.iso3) return local;
    return rateFor(iso3)?.currency ??
        Currency.byIso3(iso3, catalogue: Currency.catalogueFor(local.iso3)) ??
        local;
  }

  /// Rates for the pinned currencies, in favourite order.
  List<ForexRate> get favouriteRates => [
    for (final iso in favourites) ?rateFor(iso),
  ];
}
