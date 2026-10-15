import 'dart:math' as math;

/// The nine taras, counted from a person's birth star to the star of the day.
enum Tara {
  janma(DayQuality.mixed),
  sampat(DayQuality.good),
  vipat(DayQuality.bad),
  kshema(DayQuality.good),
  pratyari(DayQuality.bad),
  sadhaka(DayQuality.good),
  vadha(DayQuality.bad),
  mitra(DayQuality.good),
  atiMitra(DayQuality.good);

  const Tara(this.quality);

  final DayQuality quality;
}

/// The six seasons of the Hindu year.
enum Ritu { vasanta, grishma, varsha, sharad, hemanta, shishira }

/// The Sun's half-year course. Uttarayana begins at Makara Sankranti.
enum Ayana { uttarayana, dakshinayana }

/// The eight compass points, for Disha Shool.
enum Disha { east, southEast, south, southWest, west, northWest, north, northEast }

/// How a factor reads for the day.
enum DayQuality { good, mixed, bad }

/// Day factors that depend on nothing but the day itself, or on the day and
/// one fact about the person — their birth star or birth sign.
///
/// All of it is table lookup over values the panchanga already carries, which
/// is why it can be computed on the device. Nothing here is guessed: where a
/// tradition is ambiguous the choice is named in the doc comment so an
/// astrologer can overrule it.
abstract final class DayFactors {
  /// Tara bala: count from the birth star to the day's star, then take the
  /// remainder over nine. Indices are 0-based positions in the 27.
  static Tara tara({required int janmaNakshatra, required int todayNakshatra}) {
    final count = (todayNakshatra - janmaNakshatra) % 27;
    return Tara.values[count % 9];
  }

  /// Chandra bala: which house the Moon occupies counted from the birth sign,
  /// 1–12. Indices are 0-based positions in the 12 rashis.
  static int moonHouse({required int janmaRashi, required int moonRashi}) =>
      ((moonRashi - janmaRashi) % 12) + 1;

  /// The Moon in the 1st, 3rd, 6th, 7th, 10th or 11th from the birth sign is
  /// held to be favourable; the 4th, 8th and 12th unfavourable; the rest
  /// middling.
  static DayQuality chandraBala({
    required int janmaRashi,
    required int moonRashi,
  }) => switch (moonHouse(janmaRashi: janmaRashi, moonRashi: moonRashi)) {
    1 || 3 || 6 || 7 || 10 || 11 => DayQuality.good,
    4 || 8 || 12 => DayQuality.bad,
    _ => DayQuality.mixed,
  };

  /// Chandrashtama: the Moon standing in the eighth from the birth sign. It is
  /// the single day of the month people most often ask about, so it is
  /// reported on its own rather than left inside chandra bala.
  static bool isChandrashtama({
    required int janmaRashi,
    required int moonRashi,
  }) => moonHouse(janmaRashi: janmaRashi, moonRashi: moonRashi) == 8;

  /// Ritu from the Sun's sidereal sign, two signs to a season, counting from
  /// Mesha. This is the solar reckoning; almanacs that tie the seasons to the
  /// lunar months instead will differ by up to a fortnight.
  static Ritu ritu(double sunSiderealLongitude) =>
      Ritu.values[(_sign(sunSiderealLongitude) ~/ 2) % 6];

  /// Uttarayana runs from the Sun's entry into Makara to its entry into Karka
  /// — the sidereal reckoning, so it begins at Makar Sankranti in mid-January
  /// and not at the December solstice.
  static Ayana ayana(double sunSiderealLongitude) {
    final sign = _sign(sunSiderealLongitude);
    return sign >= 9 || sign < 3 ? Ayana.uttarayana : Ayana.dakshinayana;
  }

  /// Disha shool: the direction not to set out in on a given weekday
  /// (0 = Sunday).
  static Disha dishaShool(int weekday) => const [
    Disha.west, // Sunday
    Disha.east, // Monday
    Disha.north, // Tuesday
    Disha.north, // Wednesday
    Disha.south, // Thursday
    Disha.west, // Friday
    Disha.east, // Saturday
  ][weekday % 7];

  /// Sidereal longitude of the Sun for [date], derived on the device from its
  /// tropical longitude less the Lahiri ayanamsa.
  ///
  /// Good to a fraction of a degree, which is far more than ritu and ayana
  /// need — they change once in two months and once in six. Do not use it for
  /// anything that turns on a single degree.
  static double sunSidereal(double tropicalLongitude, DateTime date) =>
      (tropicalLongitude - lahiriAyanamsa(date)) % 360;

  /// Lahiri ayanamsa in degrees: 23.85° at the start of 1980, advancing by
  /// 50.29 seconds of arc a year.
  static double lahiriAyanamsa(DateTime date) {
    final years = date.difference(DateTime.utc(1980)).inDays / 365.2422;
    return 23.85 + years * 50.29 / 3600;
  }

  static int _sign(double longitude) =>
      ((longitude % 360 + 360) % 360 ~/ 30).clamp(0, 11);

  /// Index of [name] in [table], or null when the two disagree — which is how
  /// a renamed nakshatra shows up as an absent factor instead of a wrong one.
  static int? indexOf(List<String> table, String name) {
    final i = table.indexOf(name);
    return i < 0 ? null : i;
  }

  /// Degrees the Moon must still travel to reach the eighth sign — used only
  /// for the "chandrashtama ends in N days" estimate, and rounded up.
  static int daysToLeaveSign(double moonLongitude) =>
      math.max(1, ((30 - (moonLongitude % 30)) / 13.2).ceil());
}
