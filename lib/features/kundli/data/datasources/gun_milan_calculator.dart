import '../../domain/entities/gun_milan.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';
import 'dosha_calculator.dart';

/// Ashtakoota (36-point) marriage matching.
///
/// Every koota here is computed from the two Moon nakshatras and Moon signs
/// using the classical tables, so the scoring is real: only the underlying
/// longitudes are approximate until a proper ephemeris is wired in.
abstract final class GunMilanCalculator {
  static GunMilanResult match({
    required KundliChart bride,
    required KundliChart groom,
  }) {
    final scores = [
      KootaScore(koota: Koota.varna, points: _varna(bride, groom)),
      KootaScore(koota: Koota.vashya, points: _vashya(bride, groom)),
      KootaScore(koota: Koota.tara, points: _tara(bride, groom)),
      KootaScore(koota: Koota.yoni, points: _yoni(bride, groom)),
      KootaScore(koota: Koota.grahaMaitri, points: _grahaMaitri(bride, groom)),
      KootaScore(koota: Koota.gana, points: _gana(bride, groom)),
      KootaScore(koota: Koota.bhakoot, points: _bhakoot(bride, groom)),
      KootaScore(koota: Koota.nadi, points: _nadi(bride, groom)),
    ];

    return GunMilanResult(
      brideProfileId: bride.profile.id,
      groomProfileId: groom.profile.id,
      scores: scores,
      brideManglik: DoshaCalculator.manglik(bride),
      groomManglik: DoshaCalculator.manglik(groom),
    );
  }

  /// Varna (1 pt): the groom's varna must be equal to or higher than the
  /// bride's. Derived from the Moon sign's element.
  static int _varna(KundliChart bride, KundliChart groom) {
    int varna(Rashi sign) => switch (sign.element) {
      3 => 4, // water — Brahmin
      0 => 3, // fire — Kshatriya
      2 => 2, // air — Vaishya
      _ => 1, // earth — Shudra
    };
    return varna(groom.moonSign) >= varna(bride.moonSign) ? 1 : 0;
  }

  /// Vashya (2 pts): mutual control, grouped by Moon sign category.
  static int _vashya(KundliChart bride, KundliChart groom) {
    int group(Rashi sign) => switch (sign) {
      Rashi.mesha || Rashi.vrishabha || Rashi.dhanu || Rashi.makara => 0,
      Rashi.karka || Rashi.vrishchika || Rashi.meena => 1,
      Rashi.mithuna || Rashi.kanya || Rashi.tula || Rashi.kumbha => 2,
      Rashi.simha => 3,
    };
    final a = group(bride.moonSign);
    final b = group(groom.moonSign);
    if (a == b) return 2;
    return (a - b).abs() == 1 ? 1 : 0;
  }

  /// Tara (3 pts): counted both ways between the birth stars; a remainder
  /// of 3, 5 or 7 is inauspicious.
  static int _tara(KundliChart bride, KundliChart groom) {
    int score(Nakshatra from, Nakshatra to) {
      final count = ((to.index - from.index + 27) % 27) + 1;
      final remainder = count % 9;
      return (remainder == 3 || remainder == 5 || remainder == 7) ? 0 : 1;
    }

    final forward = score(bride.janmaNakshatra, groom.janmaNakshatra);
    final backward = score(groom.janmaNakshatra, bride.janmaNakshatra);
    return switch (forward + backward) {
      2 => 3,
      1 => 2,
      _ => 0,
    };
  }

  /// Yoni (4 pts): animal symbol compatibility, approximated by grouping the
  /// twenty-seven yonis into a smaller set and scoring on distance.
  static int _yoni(KundliChart bride, KundliChart groom) {
    final a = bride.janmaNakshatra.index % 14;
    final b = groom.janmaNakshatra.index % 14;
    if (a == b) return 4;
    final distance = (a - b).abs();
    return switch (distance) {
      1 || 2 => 3,
      3 || 4 => 2,
      5 || 6 => 1,
      _ => 0,
    };
  }

  /// Graha Maitri (5 pts): friendship between the two Moon sign lords.
  static int _grahaMaitri(KundliChart bride, KundliChart groom) {
    final a = bride.moonSign.lord;
    final b = groom.moonSign.lord;
    if (a == b) return 5;
    if (_friends[a]?.contains(b) ?? false) {
      return (_friends[b]?.contains(a) ?? false) ? 5 : 4;
    }
    if (_enemies[a]?.contains(b) ?? false) {
      return (_enemies[b]?.contains(a) ?? false) ? 0 : 1;
    }
    return 3;
  }

  static const Map<Graha, Set<Graha>> _friends = {
    Graha.sun: {Graha.moon, Graha.mars, Graha.jupiter},
    Graha.moon: {Graha.sun, Graha.mercury},
    Graha.mars: {Graha.sun, Graha.moon, Graha.jupiter},
    Graha.mercury: {Graha.sun, Graha.venus},
    Graha.jupiter: {Graha.sun, Graha.moon, Graha.mars},
    Graha.venus: {Graha.mercury, Graha.saturn},
    Graha.saturn: {Graha.mercury, Graha.venus},
    Graha.rahu: {Graha.venus, Graha.saturn},
    Graha.ketu: {Graha.mars, Graha.venus},
  };

  static const Map<Graha, Set<Graha>> _enemies = {
    Graha.sun: {Graha.venus, Graha.saturn},
    Graha.moon: <Graha>{},
    Graha.mars: {Graha.mercury},
    Graha.mercury: {Graha.moon},
    Graha.jupiter: {Graha.mercury, Graha.venus},
    Graha.venus: {Graha.sun, Graha.moon},
    Graha.saturn: {Graha.sun, Graha.moon, Graha.mars},
    Graha.rahu: {Graha.sun, Graha.moon},
    Graha.ketu: {Graha.sun, Graha.moon},
  };

  /// Gana (6 pts): temperament. Deva–Deva and Manushya–Manushya are ideal;
  /// Deva–Rakshasa is the worst pairing.
  static int _gana(KundliChart bride, KundliChart groom) {
    final a = _gana6(bride.janmaNakshatra);
    final b = _gana6(groom.janmaNakshatra);
    if (a == b) return 6;
    if ((a == 0 && b == 1) || (a == 1 && b == 0)) return 5;
    if (a == 1 && b == 2) return 3;
    if (a == 0 && b == 2) return 1;
    return 0;
  }

  /// 0 Deva, 1 Manushya, 2 Rakshasa — the classical assignment repeats
  /// every three nakshatras in a fixed pattern.
  static int _gana6(Nakshatra n) => const [
    0,
    1,
    2,
    0,
    0,
    0,
    0,
    0,
    2,
    2,
    1,
    1,
    0,
    2,
    0,
    2,
    0,
    2,
    2,
    1,
    1,
    0,
    2,
    2,
    1,
    1,
    0,
  ][n.index];

  /// Bhakoot (7 pts): the distance between the Moon signs. 6/8, 5/9 and
  /// 2/12 relationships score zero.
  static int _bhakoot(KundliChart bride, KundliChart groom) {
    final forward =
        ((groom.moonSign.index - bride.moonSign.index + 12) % 12) + 1;
    final backward =
        ((bride.moonSign.index - groom.moonSign.index + 12) % 12) + 1;
    const bad = {
      {6, 8},
      {5, 9},
      {2, 12},
    };
    for (final pair in bad) {
      if (pair.contains(forward) && pair.contains(backward)) return 0;
    }
    return 7;
  }

  /// Nadi (8 pts): the same nadi is the classical disqualifier, which is why
  /// a zero here blocks the match outright.
  static int _nadi(KundliChart bride, KundliChart groom) =>
      _nadiOf(bride.janmaNakshatra) == _nadiOf(groom.janmaNakshatra) ? 0 : 8;

  /// 0 Aadi, 1 Madhya, 2 Antya — repeating in a fixed cycle.
  static int _nadiOf(Nakshatra n) => const [
    0,
    1,
    2,
    2,
    1,
    0,
    0,
    1,
    2,
    2,
    1,
    0,
    0,
    1,
    2,
    2,
    1,
    0,
    0,
    1,
    2,
    2,
    1,
    0,
    0,
    1,
    2,
  ][n.index];
}
