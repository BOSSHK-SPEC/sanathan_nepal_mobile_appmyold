/// The nine grahas used in Vedic astrology.
///
/// Rahu and Ketu are the lunar nodes: always exactly opposite each other and
/// always retrograde, which is why they are modelled as first-class grahas
/// rather than derived on the fly.
enum Graha {
  sun,
  moon,
  mars,
  mercury,
  jupiter,
  venus,
  saturn,
  rahu,
  ketu;

  /// Nodes move backwards through the zodiac by definition.
  bool get isAlwaysRetrograde => this == rahu || this == ketu;

  /// Sun and Moon are luminaries, not planets — they never retrograde.
  bool get canRetrograde => switch (this) {
    Graha.sun || Graha.moon || Graha.rahu || Graha.ketu => false,
    _ => true,
  };
}

/// The twelve rashis (zodiac signs), in order from Aries.
enum Rashi {
  mesha,
  vrishabha,
  mithuna,
  karka,
  simha,
  kanya,
  tula,
  vrishchika,
  dhanu,
  makara,
  kumbha,
  meena;

  /// Sign ruler, used for house lords and for dignity.
  Graha get lord => switch (this) {
    Rashi.mesha || Rashi.vrishchika => Graha.mars,
    Rashi.vrishabha || Rashi.tula => Graha.venus,
    Rashi.mithuna || Rashi.kanya => Graha.mercury,
    Rashi.karka => Graha.moon,
    Rashi.simha => Graha.sun,
    Rashi.dhanu || Rashi.meena => Graha.jupiter,
    Rashi.makara || Rashi.kumbha => Graha.saturn,
  };

  /// 0 fire, 1 earth, 2 air, 3 water — repeating from Aries.
  int get element => index % 4;

  static Rashi fromDegrees(double longitude) =>
      Rashi.values[(longitude ~/ 30) % 12];
}

/// The twenty-seven nakshatras (lunar mansions).
///
/// Each spans 13°20'. The Moon's nakshatra fixes the Vimshottari dasha
/// sequence and carries most of the weight in marriage matching, so the
/// ruling graha is part of the definition.
enum Nakshatra {
  ashwini(Graha.ketu),
  bharani(Graha.venus),
  krittika(Graha.sun),
  rohini(Graha.moon),
  mrigashira(Graha.mars),
  ardra(Graha.rahu),
  punarvasu(Graha.jupiter),
  pushya(Graha.saturn),
  ashlesha(Graha.mercury),
  magha(Graha.ketu),
  purvaPhalguni(Graha.venus),
  uttaraPhalguni(Graha.sun),
  hasta(Graha.moon),
  chitra(Graha.mars),
  swati(Graha.rahu),
  vishakha(Graha.jupiter),
  anuradha(Graha.saturn),
  jyeshtha(Graha.mercury),
  mula(Graha.ketu),
  purvaAshadha(Graha.venus),
  uttaraAshadha(Graha.sun),
  shravana(Graha.moon),
  dhanishta(Graha.mars),
  shatabhisha(Graha.rahu),
  purvaBhadrapada(Graha.jupiter),
  uttaraBhadrapada(Graha.saturn),
  revati(Graha.mercury);

  const Nakshatra(this.lord);

  /// Vimshottari dasha ruler for this nakshatra.
  final Graha lord;

  /// Span of one nakshatra in degrees (360 / 27).
  static const double span = 360 / 27;

  static Nakshatra fromDegrees(double longitude) =>
      Nakshatra.values[((longitude % 360) ~/ span).toInt() % 27];

  /// Quarter (1–4) of the nakshatra a longitude falls in.
  static int padaFromDegrees(double longitude) =>
      (((longitude % 360) % span) ~/ (span / 4)).toInt() + 1;
}

/// Vimshottari mahadasha lengths, in years. They total 120.
abstract final class Vimshottari {
  static const Map<Graha, int> years = {
    Graha.ketu: 7,
    Graha.venus: 20,
    Graha.sun: 6,
    Graha.moon: 10,
    Graha.mars: 7,
    Graha.rahu: 18,
    Graha.jupiter: 16,
    Graha.saturn: 19,
    Graha.mercury: 17,
  };

  /// The fixed cycle order. A chart's sequence starts at the Moon's
  /// nakshatra lord and wraps around this list.
  static const List<Graha> order = [
    Graha.ketu,
    Graha.venus,
    Graha.sun,
    Graha.moon,
    Graha.mars,
    Graha.rahu,
    Graha.jupiter,
    Graha.saturn,
    Graha.mercury,
  ];

  static const int totalYears = 120;
}
