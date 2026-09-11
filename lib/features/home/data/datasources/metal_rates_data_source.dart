import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../models/metal_rates_model.dart';

abstract interface class MetalRatesDataSource {
  Future<MetalRatesModel> fetchToday();
}

/// Deterministic mock (no public bullion API without a key). Quotes the
/// active region's market: NPR per tola in Nepal, INR per 10 g in India.
class MockMetalRatesDataSource implements MetalRatesDataSource {
  const MockMetalRatesDataSource(this._resolver, {this.now});
  final RegionResolver _resolver;
  final DateTime Function()? now;

  @override
  Future<MetalRatesModel> fetchToday() async {
    final config = _resolver.config;
    final today = (now ?? DateTime.now)();
    // Small deterministic day-to-day drift so the UI isn't static.
    final drift = (today.day % 7) * 250;
    final (gold, silver) = switch (config.region) {
      // NPR per tola (≈ रु. 1,01,000 gold / रु. 1,220 silver).
      Region.nepal => (101000 + drift.toDouble(), 1220 + drift / 50),
      // INR per 10 g (≈ ₹1,05,000 gold; silver ≈ ₹1,25,000/kg → ₹1,250/10 g).
      Region.india => (105000 + drift.toDouble(), 1250 + drift / 50),
    };
    return MetalRatesModel(
      gold: gold,
      silver: silver,
      currency: config.currencyCode,
      unit: config.metalUnitEn,
      date: DateTime(today.year, today.month, today.day),
    );
  }
}
