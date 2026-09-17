import '../models/day_panchanga_model.dart';

/// Per-day panchanga for a span of dates (a month grid, or a single day).
abstract interface class PanchangaDaysDataSource {
  /// Every day in `[from, to]`, ascending.
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  });
}
