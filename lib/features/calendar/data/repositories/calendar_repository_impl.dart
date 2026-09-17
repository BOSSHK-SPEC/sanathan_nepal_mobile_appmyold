import '../../../../core/calendar/calendar.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/entities/calendar_month.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../../domain/entities/day_panchanga.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../../domain/services/lunar_calculator.dart';
import '../datasources/calendar_events_data_source.dart';
import '../datasources/panchanga_days_data_source.dart';

/// Builds month grids with the active region's traditional calendar
/// (`RegionResolver.config.calendar`) and decorates them with events from a
/// [CalendarEventsDataSource] and per-day panchanga from a
/// [PanchangaDaysDataSource].
class CalendarRepositoryImpl implements CalendarRepository {
  CalendarRepositoryImpl(
    this._events,
    this._resolver, {
    PanchangaDaysDataSource? panchanga,
    DateTime Function()? now,
  }) : _panchanga = panchanga,
       _now = now ?? DateTime.now;

  final CalendarEventsDataSource _events;
  final RegionResolver _resolver;
  final PanchangaDaysDataSource? _panchanga;
  final DateTime Function() _now;

  static const int _cells = 42;

  @override
  Future<Result<List<CalendarEvent>>> getEvents({
    required DateTime from,
    required DateTime to,
  }) => guard(() async {
    final models = await _events.fetchEvents(from: from, to: to);
    return models.map((m) => m.toEntity()).toList(growable: false);
  });

  @override
  Future<Result<CalendarMonth>> getMonth({
    required int year,
    required int month,
    CalendarViewMode mode = CalendarViewMode.traditional,
  }) => guard(() async {
    // Region config is read per call – the user may switch region.
    final config = _resolver.config;
    final calendar = config.calendar;
    final weekend = config.weekendWeekdays;

    final first = mode == CalendarViewMode.traditional
        ? calendar.toGregorian(TraditionalDate(year, month, 1))
        : DateTime(year, month);
    final firstDate = DateTime(first.year, first.month, first.day);
    final leading = firstDate.weekday % 7; // Sunday → 0
    final gridStart = firstDate.subtract(Duration(days: leading));
    final gridEnd = gridStart.add(const Duration(days: _cells - 1));

    // Both requests at once: a month is one round trip each, not in series.
    final panchangaFuture = _loadPanchanga(gridStart, gridEnd);
    final events = (await _events.fetchEvents(
      from: gridStart,
      to: gridEnd,
    )).map((m) => m.toEntity()).toList(growable: false);
    final panchanga = await panchangaFuture;

    final today = _now();
    final todayKey = _key(today);
    final days = List<CalendarDay>.generate(_cells, (i) {
      final ad = gridStart.add(Duration(days: i));
      final traditional = calendar.fromGregorian(ad);
      final inMonth = mode == CalendarViewMode.traditional
          ? traditional.year == year && traditional.month == month
          : ad.year == year && ad.month == month;
      return CalendarDay(
        traditional: traditional,
        ad: ad,
        isCurrentMonth: inMonth,
        isToday: _key(ad) == todayKey,
        isWeekend: weekend.contains(ad.weekday % 7),
        lunarDay: LunarCalculator.forDate(ad),
        events: events.where((e) => e.isOn(ad)).toList(growable: false),
        panchanga: panchanga[_key(ad)],
      );
    });

    final monthEvents = <CalendarEvent>[
      for (final d in days)
        if (d.isCurrentMonth) ...d.events,
    ];
    return CalendarMonth(
      mode: mode,
      year: year,
      month: month,
      days: days,
      events: monthEvents,
    );
  });

  /// Panchanga by day key. Never fails the month: the grid and its events
  /// are the page, the panchanga decorates it, and the day popup has its own
  /// labelled estimate for a day that has none.
  Future<Map<int, DayPanchanga>> _loadPanchanga(
    DateTime from,
    DateTime to,
  ) async {
    final source = _panchanga;
    if (source == null) return const {};
    try {
      final days = await source.fetchRange(from: from, to: to);
      return {for (final day in days) _key(day.date): day.toEntity()};
    } catch (_) {
      return const {};
    }
  }

  static int _key(DateTime d) => d.year * 10000 + d.month * 100 + d.day;
}
