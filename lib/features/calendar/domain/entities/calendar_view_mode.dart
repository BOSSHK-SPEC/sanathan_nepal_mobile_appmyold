import '../../../../core/region/region.dart';

/// Which calendar system drives the month grid.
enum CalendarViewMode {
  /// The region's traditional calendar (Bikram Sambat in Nepal, Indian
  /// national / Saka calendar in India) – its months and day numbers are
  /// primary.
  traditional,

  /// Gregorian (ई.सं. / A.D.) months and Latin day numbers are primary; the
  /// traditional day number is shown small.
  gregorian,
}

extension CalendarViewModeRegion on RegionConfig {
  /// View mode a calendar opens in for this region: Nepal reads dates in
  /// Bikram Sambat, India in Gregorian (Saka secondary).
  CalendarViewMode get defaultCalendarViewMode =>
      isIndia ? CalendarViewMode.gregorian : CalendarViewMode.traditional;

  /// True when the traditional calendar is the *secondary* one, i.e. its
  /// dates should carry an era label ("Saka") wherever they are printed.
  bool get labelsTraditionalEra =>
      defaultCalendarViewMode == CalendarViewMode.gregorian;
}
