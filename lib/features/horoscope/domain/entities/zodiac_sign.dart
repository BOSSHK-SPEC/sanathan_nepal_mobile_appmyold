/// The twelve zodiac signs (राशि) with Nepali/Hindi/English names, the traditional
/// Nepali name-letters (नामाक्षर) and the bundled icon asset.
enum ZodiacSign {
  aries(
    nameNe: 'मेष',
    nameHi: 'मेष',
    nameEn: 'Aries',
    lettersNe: 'चु, चे, चो, ला, लि, लु, ले, लो, अ',
    lettersEn: 'Chu, Che, Cho, La, Li, Lu, Le, Lo, A',
    asset: 'aeries 1.png',
  ),
  taurus(
    nameNe: 'वृष',
    nameHi: 'वृषभ',
    nameEn: 'Taurus',
    lettersNe: 'ई, उ, ए, ओ, वा, वि, वु, वे, वो',
    lettersEn: 'E, U, A, O, Va, Vi, Vu, Ve, Vo',
    asset: 'taurus 1.png',
  ),
  gemini(
    nameNe: 'मिथुन',
    nameHi: 'मिथुन',
    nameEn: 'Gemini',
    lettersNe: 'का, कि, कु, घ, ङ, छ, के, को, हा',
    lettersEn: 'Ka, Ki, Ku, Gha, Nga, Chha, Ke, Ko, Ha',
    asset: 'gemini 1.png',
  ),
  cancer(
    nameNe: 'कर्कट',
    nameHi: 'कर्क',
    nameEn: 'Cancer',
    lettersNe: 'हि, हु, हे, हो, डा, डि, डु, डे, डो',
    lettersEn: 'Hi, Hu, He, Ho, Da, Di, Du, De, Do',
    asset: 'cancer 1.png',
  ),
  leo(
    nameNe: 'सिंह',
    nameHi: 'सिंह',
    nameEn: 'Leo',
    lettersNe: 'मा, मि, मु, मे, मो, टा, टि, टु, टे',
    lettersEn: 'Ma, Mi, Mu, Me, Mo, Ta, Ti, Tu, Te',
    asset: 'leo 1.png',
  ),
  virgo(
    nameNe: 'कन्या',
    nameHi: 'कन्या',
    nameEn: 'Virgo',
    lettersNe: 'टो, पा, पि, पु, ष, ण, ठ, पे, पो',
    lettersEn: 'To, Pa, Pi, Pu, Sha, Na, Tha, Pe, Po',
    asset: 'virgo 1.png',
  ),
  libra(
    nameNe: 'तुला',
    nameHi: 'तुला',
    nameEn: 'Libra',
    lettersNe: 'रा, रि, रु, रे, रो, ता, ति, तु, ते',
    lettersEn: 'Ra, Ri, Ru, Re, Ro, Ta, Ti, Tu, Te',
    asset: 'libra 1.png',
  ),
  scorpio(
    nameNe: 'वृश्चिक',
    nameHi: 'वृश्चिक',
    nameEn: 'Scorpio',
    lettersNe: 'तो, ना, नि, नु, ने, नो, या, यि, यु',
    lettersEn: 'To, Na, Ni, Nu, Ne, No, Ya, Yi, Yu',
    asset: 'scorpio 1.png',
  ),
  sagittarius(
    nameNe: 'धनु',
    nameHi: 'धनु',
    nameEn: 'Sagittarius',
    lettersNe: 'ये, यो, भा, भि, भु, धा, फा, ढा, भे',
    lettersEn: 'Ye, Yo, Bha, Bhi, Bhu, Dha, Pha, Dha, Bhe',
    asset: 'sagittarius 1 (1).png',
  ),
  capricorn(
    nameNe: 'मकर',
    nameHi: 'मकर',
    nameEn: 'Capricorn',
    lettersNe: 'भो, जा, जि, जु, जे, जो, खा, खि, खु, खे, खो, गा, गि',
    lettersEn: 'Bho, Ja, Ji, Ju, Je, Jo, Kha, Khi, Khu, Khe, Kho, Ga, Gi',
    asset: 'capricorn 1.png',
  ),
  aquarius(
    nameNe: 'कुम्भ',
    nameHi: 'कुम्भ',
    nameEn: 'Aquarius',
    lettersNe: 'गु, गे, गो, सा, सि, सु, से, सो, दा',
    lettersEn: 'Gu, Ge, Go, Sa, Si, Su, Se, So, Da',
    asset: 'aquarius 1.png',
  ),
  pisces(
    nameNe: 'मीन',
    nameHi: 'मीन',
    nameEn: 'Pisces',
    lettersNe: 'दि, दु, थ, झ, ञ, दे, दो, चा, चि',
    lettersEn: 'Di, Du, Tha, Jha, Nya, De, Do, Cha, Chi',
    asset: 'pisces 1.png',
  );

  const ZodiacSign({
    required this.nameNe,
    required this.nameHi,
    required this.nameEn,
    required this.lettersNe,
    required this.lettersEn,
    required this.asset,
  });

  /// Nepali display name (e.g. "मेष").
  final String nameNe;

  /// Hindi display name (e.g. "मेष").
  final String nameHi;

  /// English display name (e.g. "Aries").
  final String nameEn;

  /// Nepali first-name letters belonging to this sign.
  final String lettersNe;

  /// Romanised version of [lettersNe].
  final String lettersEn;

  /// Hindi name letters – the Devanagari नामाक्षर are shared with Nepali.
  String get lettersHi => lettersNe;

  /// File name of the legacy zodiac PNG inside `assets/images/`.
  final String asset;

  /// Localised display name.
  String displayName({required bool nepali}) => nepali ? nameNe : nameEn;

  /// Localised name letters.
  String letters({required bool nepali}) => nepali ? lettersNe : lettersEn;

  /// Display name for a language code (`ne`, `hi`, otherwise English).
  String displayNameFor(String languageCode) => switch (languageCode) {
    'ne' => nameNe,
    'hi' => nameHi,
    _ => nameEn,
  };

  /// Name letters for a language code (`ne`, `hi`, otherwise English).
  String lettersFor(String languageCode) => switch (languageCode) {
    'ne' => lettersNe,
    'hi' => lettersHi,
    _ => lettersEn,
  };

  static ZodiacSign fromId(String id) => ZodiacSign.values.firstWhere(
    (s) => s.name == id,
    orElse: () => ZodiacSign.aries,
  );
}
