/// Practice areas an astrologer can be filtered by.
///
/// Deliberately a closed enum rather than free text so the filter sheet,
/// the seed data and (later) the API all agree on the same vocabulary.
enum Specialty {
  vedic,
  numerology,
  tarot,
  vaastu,
  palmistry,
  kundliMatching,
  prashna,
  gemstone,
  muhurta,
  nadi;

  static Specialty fromName(String? name) => Specialty.values.firstWhere(
    (s) => s.name == name,
    orElse: () => Specialty.vedic,
  );
}
