import '../../../../core/utils/result.dart';
import '../entities/calendar_event.dart';
import '../entities/calendar_month.dart';
import '../entities/calendar_view_mode.dart';

/// Read-side contract for the Patro (calendar) feature.
abstract interface class CalendarRepository {
  /// Builds the 42-cell grid for [year]/[month] in the given [mode]
  /// (traditional-calendar year/month when [mode] is `traditional`,
  /// Gregorian when `gregorian`). The traditional calendar is the active
  /// region's (`RegionConfig.calendar`).
  Future<Result<CalendarMonth>> getMonth({
    required int year,
    required int month,
    CalendarViewMode mode = CalendarViewMode.traditional,
  });

  /// Festivals / holidays of the active region falling in the inclusive
  /// Gregorian range [from]–[to].
  Future<Result<List<CalendarEvent>>> getEvents({
    required DateTime from,
    required DateTime to,
  });
}
