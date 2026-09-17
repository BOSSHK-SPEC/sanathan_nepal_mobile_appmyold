import '../../../../core/region/region_resolver.dart';
import '../../domain/services/day_panchanga_estimate.dart';
import '../models/day_panchanga_model.dart';
import 'panchanga_days_data_source.dart';

/// Day panchanga from the on-device estimate ([DayPanchangaEstimate]).
///
/// Every day is marked approximate. Used in mock mode, and by the live source
/// for a month it never fetched while the device is offline.
class ApproximatePanchangaDaysDataSource implements PanchangaDaysDataSource {
  const ApproximatePanchangaDaysDataSource(this._resolver);

  final RegionResolver _resolver;

  @override
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  }) async {
    final config = _resolver.config;
    final end = DateTime(to.year, to.month, to.day);
    return [
      for (
        var d = DateTime(from.year, from.month, from.day);
        !d.isAfter(end);
        d = DateTime(d.year, d.month, d.day + 1)
      )
        DayPanchangaModel.fromEntity(DayPanchangaEstimate.forDate(d, config)),
    ];
  }
}
