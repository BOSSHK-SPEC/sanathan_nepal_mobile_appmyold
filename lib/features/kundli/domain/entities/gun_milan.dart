import 'package:freezed_annotation/freezed_annotation.dart';

import 'dosha.dart';

part 'gun_milan.freezed.dart';

/// The eight kootas of Ashtakoota matching, with their maximum points.
///
/// They total 36, which is why compatibility is quoted out of 36.
enum Koota {
  varna(1),
  vashya(2),
  tara(3),
  yoni(4),
  grahaMaitri(5),
  gana(6),
  bhakoot(7),
  nadi(8);

  const Koota(this.maxPoints);

  final int maxPoints;

  static int get totalPoints => 36;
}

@freezed
abstract class KootaScore with _$KootaScore {
  const KootaScore._();

  const factory KootaScore({required Koota koota, required int points}) =
      _KootaScore;

  int get maxPoints => koota.maxPoints;

  double get ratio => maxPoints == 0 ? 0 : points / maxPoints;

  /// Nadi and Bhakoot carry the most weight, so a zero in either is treated
  /// as a blocking result rather than just a low score.
  bool get isBlocking =>
      points == 0 && (koota == Koota.nadi || koota == Koota.bhakoot);
}

/// Overall verdict, in the terms matchmakers actually use.
enum MatchVerdict { excellent, good, average, poor }

@freezed
abstract class GunMilanResult with _$GunMilanResult {
  const GunMilanResult._();

  const factory GunMilanResult({
    required String brideProfileId,
    required String groomProfileId,
    required List<KootaScore> scores,
    required DoshaReading brideManglik,
    required DoshaReading groomManglik,
  }) = _GunMilanResult;

  int get total => scores.fold<int>(0, (sum, s) => sum + s.points);

  double get ratio => total / Koota.totalPoints;

  /// The conventional bands: 18 is the usual minimum, 26+ is a strong match.
  MatchVerdict get verdict {
    if (blockers.isNotEmpty) return MatchVerdict.poor;
    if (total >= 28) return MatchVerdict.excellent;
    if (total >= 21) return MatchVerdict.good;
    if (total >= 18) return MatchVerdict.average;
    return MatchVerdict.poor;
  }

  List<KootaScore> get blockers => scores.where((s) => s.isBlocking).toList();

  /// Manglik affects a match only when it is one-sided: two Manglik charts
  /// are classically considered to cancel each other.
  bool get manglikMismatch => brideManglik.isPresent != groomManglik.isPresent;
}
