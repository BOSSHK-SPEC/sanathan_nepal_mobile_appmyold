part of 'day_periods_cubit.dart';

/// Which division of the day the screen is showing.
enum DayPeriodView { choghadiya, hora, kaal }

@freezed
abstract class DayPeriodsState with _$DayPeriodsState {
  const DayPeriodsState._();

  const factory DayPeriodsState({
    /// Civil day being shown (local midnight).
    required DateTime date,

    /// Where the "now" marker sits. Held in state rather than read at build
    /// time so the highlighted row cannot change between two builds of the
    /// same frame.
    required DateTime now,
    @Default(LoadState.idle()) LoadState<Panchanga> today,
    @Default(LoadState.idle()) LoadState<Panchanga> tomorrow,
    @Default(DayPeriodView.choghadiya) DayPeriodView view,

    /// The reader's birth pada, 0–107, or null until they choose one. Tara
    /// bala and chandra bala are simply absent until then rather than being
    /// counted from an assumed star.
    int? birthPada,
  }) = _DayPeriodsState;

  Panchanga? get panchanga => today.dataOrNull;

  /// 0 = Sunday, matching the weekday tables.
  int get weekday => date.weekday % 7;

  bool get isLoading => today.isLoading;

  /// Tomorrow's sunrise, which the night is measured against.
  DateTime? get nextSunrise => tomorrow.dataOrNull?.sunrise;

  /// True once the night can be drawn from a real second sunrise.
  bool get hasNight => nextSunrise != null && _horas.length == 24;

  List<TimeWindow> get _horas {
    final p = panchanga;
    final next = nextSunrise;
    if (p == null || next == null) return const [];
    return DayPeriods.horas(weekday, p.sunrise, p.sunset, next);
  }

  /// Sunrise → sunset.
  List<TimeWindow> get daySection {
    final p = panchanga;
    if (p == null) return const [];
    return switch (view) {
      DayPeriodView.choghadiya => p.choghadiya,
      DayPeriodView.hora => _horas.take(12).toList(growable: false),
      DayPeriodView.kaal =>
        <TimeWindow>[
          ?p.abhijitMuhurat,
          ?p.rahuKaal,
          ?p.yamaganda,
          ?p.gulikaKaal,
        ]..sort((a, b) => a.start.compareTo(b.start)),
    };
  }

  /// Sunset → tomorrow's sunrise. Empty for the kaal windows, which are
  /// daytime divisions and have no night half to show.
  List<TimeWindow> get nightSection {
    final p = panchanga;
    final next = nextSunrise;
    if (p == null || next == null) return const [];
    return switch (view) {
      DayPeriodView.choghadiya => DayPeriods.nightChoghadiya(
        weekday,
        p.sunset,
        next,
      ),
      DayPeriodView.hora => _horas.skip(12).toList(growable: false),
      DayPeriodView.kaal => const [],
    };
  }

  /// The kaal windows are day-only, so their night half is absent by design,
  /// not for want of data — the screen must not offer to fetch anything.
  bool get expectsNight => view != DayPeriodView.kaal;

  /// Today's nakshatra as a position in the twenty-seven, read back off the
  /// name the panchanga carries. Null if the two tables ever disagree.
  int? get todayNakshatra {
    final p = panchanga;
    if (p == null) return null;
    return DayFactors.indexOf(PanchangaNames.nakshatraEn, p.nakshatra.nameEn);
  }

  /// The Moon's sign as a position in the twelve.
  int? get moonRashi {
    final p = panchanga;
    if (p == null) return null;
    return DayFactors.indexOf(PanchangaNames.rashiEn, p.chandraRashiEn);
  }

  /// Tara bala, once both the birth star and the day's star are known.
  Tara? get tara {
    final janma = birthStar;
    final today = todayNakshatra;
    if (janma == null || today == null) return null;
    return DayFactors.tara(janmaNakshatra: janma, todayNakshatra: today);
  }

  /// The birth star, from the pada.
  int? get birthStar => birthPada == null ? null : birthPada! ~/ 4;

  /// The birth sign: nine padas to a sign. Derived from the pada rather than
  /// the star, because a star that straddles a boundary belongs to two signs.
  int? get janmaRashi => birthPada == null ? null : birthPada! ~/ 9;

  /// Which house the Moon stands in, counted from the birth sign.
  int? get moonHouse {
    final janma = janmaRashi;
    final moon = moonRashi;
    if (janma == null || moon == null) return null;
    return DayFactors.moonHouse(janmaRashi: janma, moonRashi: moon);
  }

  DayQuality? get chandraBala {
    final janma = janmaRashi;
    final moon = moonRashi;
    if (janma == null || moon == null) return null;
    return DayFactors.chandraBala(janmaRashi: janma, moonRashi: moon);
  }

  bool? get isChandrashtama {
    final janma = janmaRashi;
    final moon = moonRashi;
    if (janma == null || moon == null) return null;
    return DayFactors.isChandrashtama(janmaRashi: janma, moonRashi: moon);
  }

  /// Season and half-year, from the Sun's sidereal longitude for the day.
  double get _sunSidereal => DayFactors.sunSidereal(
    SunCalculator.sunLongitude(SunCalculator.julianDays(date)),
    date,
  );

  Ritu get ritu => DayFactors.ritu(_sunSidereal);

  Ayana get ayana => DayFactors.ayana(_sunSidereal);

  Disha get dishaShool => DayFactors.dishaShool(weekday);

  /// The period [now] falls in, across both halves.
  TimeWindow? get currentWindow =>
      DayPeriods.current([...daySection, ...nightSection], now);
}
