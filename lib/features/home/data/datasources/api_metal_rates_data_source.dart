import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/region/region_resolver.dart';
import '../models/metal_rates_model.dart';
import 'metal_rates_data_source.dart';

/// Bullion rates as published by our backend.
///
/// The unit differs by market — tola in Nepal, 10 g in India — and the server
/// already quotes in the region's own unit and currency, so the app renders
/// `unitLabel` as given instead of converting and risking a wrong price on a
/// jeweller's screen.
class ApiMetalRatesDataSource implements MetalRatesDataSource {
  const ApiMetalRatesDataSource(this._client, this._resolver);

  final ApiClient _client;
  final RegionResolver _resolver;

  static const String _gold = 'gold';
  static const String _silver = 'silver';

  @override
  Future<MetalRatesModel> fetchToday() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.metals);
    final rows = asJsonList(response);

    final gold = _rateFor(rows, _gold);
    final silver = _rateFor(rows, _silver);
    if (gold == null || silver == null) {
      throw const NotFoundException('No metal rates published today');
    }

    final asOf = ApiTime.date(gold['asOf']);
    return MetalRatesModel(
      gold: ApiMoney.toMajor(gold['priceMinor']),
      silver: ApiMoney.toMajor(silver['priceMinor']),
      currency: _resolver.config.currencyCode,
      unit: gold['unitLabel'] as String? ?? _resolver.config.metalUnitEn,
      date: asOf == null ? _today() : DateTime(asOf.year, asOf.month, asOf.day),
    );
  });

  static Map<String, dynamic>? _rateFor(
    List<Map<String, dynamic>> rows,
    String metalKey,
  ) {
    for (final row in rows) {
      if (row['metalKey'] == metalKey) return row;
    }
    return null;
  }

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
