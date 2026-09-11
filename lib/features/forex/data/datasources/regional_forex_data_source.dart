import '../../../../core/region/region_all.dart';
import '../models/forex_day_model.dart';
import 'forex_remote_data_source.dart';

/// Picks the live forex source for the active region **at call time**
/// (Nepal → NRB, India → Frankfurter/ECB) so switching region in settings
/// takes effect on the next fetch without re-wiring DI.
class RegionalForexDataSource implements ForexRemoteDataSource {
  const RegionalForexDataSource({
    required RegionResolver resolver,
    required ForexRemoteDataSource nepal,
    required ForexRemoteDataSource india,
  }) : _resolver = resolver,
       _nepal = nepal,
       _india = india;

  final RegionResolver _resolver;
  final ForexRemoteDataSource _nepal;
  final ForexRemoteDataSource _india;

  /// Source for the region that is active right now.
  ForexRemoteDataSource get current => switch (_resolver.region) {
    Region.nepal => _nepal,
    Region.india => _india,
  };

  @override
  Future<List<ForexDayModel>> fetchRates({
    required DateTime from,
    required DateTime to,
  }) => current.fetchRates(from: from, to: to);

  @override
  Future<List<ForexDayModel>> fetchHistory({
    required String iso3,
    required DateTime from,
    required DateTime to,
  }) => current.fetchHistory(iso3: iso3, from: from, to: to);
}
