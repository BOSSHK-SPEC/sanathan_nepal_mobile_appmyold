import 'dart:math' as math;

/// Rough NOAA-style sunrise/sunset + mean-motion helpers.
///
/// Defaults to Kathmandu / NST; the mock data source passes the active
/// region's default city and UTC offset (New Delhi / IST for India).
/// Accurate to a few minutes – good enough for the mocked panchanga; a real
/// ephemeris service replaces this class behind [PanchangaDataSource].
abstract final class SunCalculator {
  static const double kathmanduLat = 27.7172;
  static const double kathmanduLon = 85.3240;

  /// Nepal Standard Time offset (UTC+5:45) in hours.
  static const double nptOffsetHours = 5.75;

  static double _rad(double deg) => deg * math.pi / 180;
  static double _deg(double rad) => rad * 180 / math.pi;

  /// Days since J2000.0 (2000-01-01 12:00 UTC) for local midnight of [date]
  /// in a zone [utcOffsetHours] ahead of UTC.
  static double julianDays(
    DateTime date, {
    double utcOffsetHours = nptOffsetHours,
  }) {
    final utc = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(minutes: (utcOffsetHours * 60).round()));
    final j2000 = DateTime.utc(2000, 1, 1, 12);
    return utc.difference(j2000).inMinutes / 1440.0;
  }

  /// Sun's mean ecliptic (tropical) longitude in degrees for [d] days.
  static double sunLongitude(double d) {
    final l = (280.460 + 0.9856474 * d) % 360;
    final g = _rad((357.528 + 0.9856003 * d) % 360);
    return (l + 1.915 * math.sin(g) + 0.020 * math.sin(2 * g) + 360) % 360;
  }

  /// Sun declination (degrees) for [d] days.
  static double declination(double d) {
    final lambda = _rad(sunLongitude(d));
    const obliquity = 23.439;
    return _deg(math.asin(math.sin(_rad(obliquity)) * math.sin(lambda)));
  }

  /// Equation of time in minutes for [d] days.
  static double equationOfTime(double d) {
    final g = _rad((357.528 + 0.9856003 * d) % 360);
    return -7.659 * math.sin(g) + 9.863 * math.sin(2 * g + 3.5932);
  }

  /// Local sunrise (rise = true) or sunset time for [date] at [lat]/[lon]
  /// in a zone [utcOffsetHours] ahead of UTC. Returned as a local
  /// [DateTime] on the same civil day.
  static DateTime sunEvent(
    DateTime date, {
    required bool rise,
    double lat = kathmanduLat,
    double lon = kathmanduLon,
    double utcOffsetHours = nptOffsetHours,
  }) {
    final d = julianDays(date, utcOffsetHours: utcOffsetHours) + 0.5;
    final decl = _rad(declination(d));
    final phi = _rad(lat);
    final zenith = _rad(90.833);
    var cosH =
        (math.cos(zenith) - math.sin(phi) * math.sin(decl)) /
        (math.cos(phi) * math.cos(decl));
    cosH = cosH.clamp(-1.0, 1.0);
    final hourAngle = _deg(math.acos(cosH));
    final solarNoonMinutes =
        720 - 4 * lon - equationOfTime(d) + utcOffsetHours * 60;
    final minutes = rise
        ? solarNoonMinutes - 4 * hourAngle
        : solarNoonMinutes + 4 * hourAngle;
    final whole = minutes.floor();
    final seconds = ((minutes - whole) * 60).round();
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).add(Duration(minutes: whole, seconds: seconds));
  }

  /// Fraction of the synodic month elapsed at [d] days (0 = new moon).
  static double moonPhase(double d) {
    // Reference new moon: 2000-01-06 18:14 UTC ≈ J2000 + 5.26 days.
    const synodic = 29.530588853;
    final f = ((d - 5.26) / synodic) % 1;
    return f < 0 ? f + 1 : f;
  }

  /// Approximate mean longitude of the Moon (tropical, degrees).
  static double moonLongitude(double d) =>
      (sunLongitude(d) + moonPhase(d) * 360) % 360;

  /// Lahiri ayanamsha (degrees) – linear approximation.
  static double ayanamsha(double d) => 23.85 + 0.0000382 * d;

  /// Formats a longitude in degrees as `rashi:deg:min:sec`.
  static String formatLongitude(double lon) {
    final norm = (lon % 360 + 360) % 360;
    final rashi = norm ~/ 30;
    final inSign = norm - rashi * 30;
    final deg = inSign.floor();
    final minF = (inSign - deg) * 60;
    final min = minF.floor();
    final sec = ((minF - min) * 60).floor();
    return '$rashi:$deg:$min:$sec';
  }
}
