/// Stores the one personal fact the panchanga screens need: the quarter of the
/// nakshatra the reader was born in.
///
/// It is a *pada*, 0–107, not a nakshatra. Nine of the twenty-seven stars
/// straddle a sign boundary — Krittika's first pada is in Mesha and its other
/// three are in Vrishabha — so a nakshatra alone cannot fix the birth sign,
/// and chandra bala counted from the wrong sign is wrong silently.
///
/// It is kept here rather than in the kundli feature so that tara bala works
/// for someone who has never cast a chart — most people know their birth star
/// from their family and will never type a birth time.
abstract interface class BirthStarRepository {
  /// 0-based pada in the 108, or null if never set.
  int? get padaIndex;

  Future<void> save(int padaIndex);

  Future<void> clear();
}
