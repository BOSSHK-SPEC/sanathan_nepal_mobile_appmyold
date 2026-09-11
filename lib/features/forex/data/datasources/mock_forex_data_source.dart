import 'dart:math' as math;

import '../../../../core/region/region_all.dart';
import '../../domain/entities/currency.dart';
import '../models/forex_day_model.dart';
import '../models/forex_rate_model.dart';
import 'forex_remote_data_source.dart';

/// Deterministic offline rate tables (no randomness): each currency has a
/// base rate plus a smooth day-of-year wave so 7 / 30 / 365-day charts look
/// realistic.
///
/// Region-aware: the catalogue and base rates follow the local currency of
/// `resolver.config` at call time – NPR-based NRB tables for Nepal (Figma
/// mock: USD 130.85/131.45 …), INR-based ECB tables for India.
class MockForexDataSource
    with RangeForexHistory
    implements ForexRemoteDataSource {
  const MockForexDataSource([
    this._resolver = const FixedRegionResolver(Region.nepal),
  ]);

  final RegionResolver _resolver;

  /// Base *buy* rate in NPR per [Currency.unit] units (NRB catalogue).
  static const Map<String, double> _baseNpr = {
    'INR': 160.00,
    'USD': 130.85,
    'EUR': 139.15,
    'GBP': 163.20,
    'CHF': 146.40,
    'AUD': 87.60,
    'CAD': 96.90,
    'SGD': 97.80,
    'JPY': 9.05,
    'CNY': 18.95,
    'SAR': 34.88,
    'QAR': 35.90,
    'THB': 3.78,
    'AED': 35.62,
    'MYR': 29.40,
    'KRW': 10.10,
    'SEK': 12.60,
    'DKK': 18.70,
    'HKD': 16.70,
    'KWD': 424.60,
    'BHD': 347.08,
    'OMR': 339.90,
  };

  /// Base *buy* rate in INR per [Currency.unit] units (ECB catalogue; JPY and
  /// KRW per 100).
  static const Map<String, double> _baseInr = {
    'USD': 83.50,
    'EUR': 90.60,
    'GBP': 106.20,
    'AUD': 55.40,
    'CAD': 61.10,
    'SGD': 62.30,
    'JPY': 56.40,
    'CHF': 94.60,
    'CNY': 11.60,
    'MYR': 18.90,
    'KRW': 6.20,
    'HKD': 10.70,
    'SEK': 7.90,
    'DKK': 12.15,
    'THB': 2.42,
    'NZD': 50.80,
    'ZAR': 4.60,
  };

  @override
  Future<List<ForexDayModel>> fetchRates({
    required DateTime from,
    required DateTime to,
  }) async {
    final config = _resolver.config;
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);
    final days = <ForexDayModel>[];
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      days.add(dayFor(d, config: config));
    }
    return days;
  }

  /// Rates for a single [date] in the given region – exposed for tests.
  static ForexDayModel dayFor(
    DateTime date, {
    RegionConfig config = RegionConfig.nepal,
  }) {
    final t = date.difference(DateTime(date.year)).inDays.toDouble();
    final catalogue = Currency.catalogueFor(config.currencyCode);
    final base = config.currencyCode == Currency.inr.iso3 ? _baseInr : _baseNpr;
    return ForexDayModel(
      date: date,
      publishedOn: date,
      rates: [for (final c in catalogue) _rate(c, base[c.iso3] ?? 100, t)],
    );
  }

  static ForexRateModel _rate(Currency c, double base, double t) {
    // Slow yearly drift + weekly wobble, amplitude ≈ 1.2 % of the base.
    final wave = math.sin(t / 58) * 0.008 + math.sin(t / 3.7) * 0.004;
    final buy = base * (1 + wave);
    final spread = base * 0.0046;
    return ForexRateModel(
      currency: ForexCurrencyModel.fromEntity(c),
      buy: double.parse(buy.toStringAsFixed(2)),
      sell: double.parse((buy + spread).toStringAsFixed(2)),
    );
  }
}
