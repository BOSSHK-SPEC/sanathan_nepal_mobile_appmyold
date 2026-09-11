import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';

/// A quoted currency with trilingual names (English / Nepali / Hindi) and the
/// ISO country code used to render its flag.
@freezed
abstract class Currency with _$Currency {
  const Currency._();

  const factory Currency({
    /// ISO 4217 code, e.g. `USD`.
    required String iso3,
    required String nameEn,
    required String nameNe,

    /// ISO 3166-1 alpha-2 country code (or `EU`) for the flag.
    required String countryCode,

    /// Hindi name; falls back to [nameNe] (both Devanagari) when null.
    String? nameHi,

    /// Some sources quote a currency per 10 / 100 units.
    @Default(1) int unit,
  }) = _Currency;

  /// Nepalese rupee – the quote currency for every NRB rate (Nepal region).
  static const Currency npr = Currency(
    iso3: 'NPR',
    nameEn: 'Nepalese Rupee',
    nameNe: 'नेपाली रुपैयाँ',
    nameHi: 'नेपाली रुपया',
    countryCode: 'NP',
  );

  /// Indian rupee as the *local* quote currency (India region, unit 1). Not
  /// to be confused with the NRB catalogue entry, which quotes INR per 100.
  static const Currency inr = Currency(
    iso3: 'INR',
    nameEn: 'Indian Rupee',
    nameNe: 'भारतीय रुपैयाँ',
    nameHi: 'भारतीय रुपया',
    countryCode: 'IN',
  );

  /// Local (quote) currency for a region's ISO code – `NPR` → [npr],
  /// `INR` → [inr]. Unknown codes fall back to [npr].
  static Currency localFor(String iso3) => switch (iso3.toUpperCase()) {
    'INR' => inr,
    _ => npr,
  };

  /// True when [iso3] is one of the supported local (quote) currencies.
  static bool isLocalCode(String iso3) =>
      iso3.toUpperCase() == npr.iso3 || iso3.toUpperCase() == inr.iso3;

  static const Currency _usd = Currency(
    iso3: 'USD',
    nameEn: 'U.S. Dollar',
    nameNe: 'अमेरिकी डलर',
    nameHi: 'अमेरिकी डॉलर',
    countryCode: 'US',
  );
  static const Currency _eur = Currency(
    iso3: 'EUR',
    nameEn: 'European Euro',
    nameNe: 'युरोपियन युरो',
    nameHi: 'यूरो',
    countryCode: 'EU',
  );
  static const Currency _gbp = Currency(
    iso3: 'GBP',
    nameEn: 'UK Pound Sterling',
    nameNe: 'बेलायती पाउण्ड',
    nameHi: 'ब्रिटिश पाउंड',
    countryCode: 'GB',
  );
  static const Currency _chf = Currency(
    iso3: 'CHF',
    nameEn: 'Swiss Franc',
    nameNe: 'स्विस फ्रयाङ्क',
    nameHi: 'स्विस फ़्रैंक',
    countryCode: 'CH',
  );
  static const Currency _aud = Currency(
    iso3: 'AUD',
    nameEn: 'Australian Dollar',
    nameNe: 'अष्ट्रेलियन डलर',
    nameHi: 'ऑस्ट्रेलियाई डॉलर',
    countryCode: 'AU',
  );
  static const Currency _cad = Currency(
    iso3: 'CAD',
    nameEn: 'Canadian Dollar',
    nameNe: 'क्यानेडियन डलर',
    nameHi: 'कनाडाई डॉलर',
    countryCode: 'CA',
  );
  static const Currency _sgd = Currency(
    iso3: 'SGD',
    nameEn: 'Singapore Dollar',
    nameNe: 'सिंगापुर डलर',
    nameHi: 'सिंगापुर डॉलर',
    countryCode: 'SG',
  );
  static const Currency _cny = Currency(
    iso3: 'CNY',
    nameEn: 'Chinese Yuan',
    nameNe: 'चिनियाँ युआन',
    nameHi: 'चीनी युआन',
    countryCode: 'CN',
  );
  static const Currency _thb = Currency(
    iso3: 'THB',
    nameEn: 'Thai Baht',
    nameNe: 'थाई भाट',
    nameHi: 'थाई बात',
    countryCode: 'TH',
  );
  static const Currency _myr = Currency(
    iso3: 'MYR',
    nameEn: 'Malaysian Ringgit',
    nameNe: 'मलेसियन रिङ्गिट',
    nameHi: 'मलेशियाई रिंगित',
    countryCode: 'MY',
  );
  static const Currency _sek = Currency(
    iso3: 'SEK',
    nameEn: 'Swedish Krona',
    nameNe: 'स्विडिस क्रोना',
    nameHi: 'स्वीडिश क्रोना',
    countryCode: 'SE',
  );
  static const Currency _dkk = Currency(
    iso3: 'DKK',
    nameEn: 'Danish Krone',
    nameNe: 'डेनिस क्रोन',
    nameHi: 'डेनिश क्रोन',
    countryCode: 'DK',
  );
  static const Currency _hkd = Currency(
    iso3: 'HKD',
    nameEn: 'Hong Kong Dollar',
    nameNe: 'हङकङ डलर',
    nameHi: 'हांगकांग डॉलर',
    countryCode: 'HK',
  );
  static const Currency _nzd = Currency(
    iso3: 'NZD',
    nameEn: 'New Zealand Dollar',
    nameNe: 'न्युजिल्याण्ड डलर',
    nameHi: 'न्यूज़ीलैंड डॉलर',
    countryCode: 'NZ',
  );
  static const Currency _zar = Currency(
    iso3: 'ZAR',
    nameEn: 'South African Rand',
    nameNe: 'दक्षिण अफ्रिकी र्‍यान्ड',
    nameHi: 'दक्षिण अफ़्रीकी रैंड',
    countryCode: 'ZA',
  );

  /// Catalogue of currencies published by Nepal Rastra Bank (order = display
  /// order). Used for the Nepal region.
  static const List<Currency> known = [
    Currency(
      iso3: 'INR',
      nameEn: 'Indian Rupee',
      nameNe: 'भारतीय रुपैयाँ',
      nameHi: 'भारतीय रुपया',
      countryCode: 'IN',
      unit: 100,
    ),
    _usd,
    _eur,
    _gbp,
    _chf,
    _aud,
    _cad,
    _sgd,
    Currency(
      iso3: 'JPY',
      nameEn: 'Japanese Yen',
      nameNe: 'जापानी येन',
      nameHi: 'जापानी येन',
      countryCode: 'JP',
      unit: 10,
    ),
    _cny,
    Currency(
      iso3: 'SAR',
      nameEn: 'Saudi Arabian Riyal',
      nameNe: 'साउदी रियाल',
      nameHi: 'सऊदी रियाल',
      countryCode: 'SA',
    ),
    Currency(
      iso3: 'QAR',
      nameEn: 'Qatari Riyal',
      nameNe: 'कतारी रियाल',
      nameHi: 'क़तरी रियाल',
      countryCode: 'QA',
    ),
    _thb,
    Currency(
      iso3: 'AED',
      nameEn: 'UAE Dirham',
      nameNe: 'यूएई दिरहाम',
      nameHi: 'यूएई दिरहम',
      countryCode: 'AE',
    ),
    _myr,
    Currency(
      iso3: 'KRW',
      nameEn: 'South Korean Won',
      nameNe: 'कोरियन वन',
      nameHi: 'दक्षिण कोरियाई वॉन',
      countryCode: 'KR',
      unit: 100,
    ),
    _sek,
    _dkk,
    _hkd,
    Currency(
      iso3: 'KWD',
      nameEn: 'Kuwaiti Dinar',
      nameNe: 'कुवेती दिनार',
      nameHi: 'कुवैती दीनार',
      countryCode: 'KW',
    ),
    Currency(
      iso3: 'BHD',
      nameEn: 'Bahraini Dinar',
      nameNe: 'बहराइनी दिनार',
      nameHi: 'बहरीनी दीनार',
      countryCode: 'BH',
    ),
    Currency(
      iso3: 'OMR',
      nameEn: 'Omani Rial',
      nameNe: 'ओमानी रियाल',
      nameHi: 'ओमानी रियाल',
      countryCode: 'OM',
    ),
  ];

  /// Catalogue for the India region – limited to the ECB reference
  /// currencies served by the key-less Frankfurter API (Gulf currencies such
  /// as AED / SAR / QAR are not published by the ECB). JPY and KRW are
  /// quoted per 100 units, RBI-style.
  static const List<Currency> ecb = [
    _usd,
    _eur,
    _gbp,
    _aud,
    _cad,
    _sgd,
    Currency(
      iso3: 'JPY',
      nameEn: 'Japanese Yen',
      nameNe: 'जापानी येन',
      nameHi: 'जापानी येन',
      countryCode: 'JP',
      unit: 100,
    ),
    _chf,
    _cny,
    _myr,
    Currency(
      iso3: 'KRW',
      nameEn: 'South Korean Won',
      nameNe: 'कोरियन वन',
      nameHi: 'दक्षिण कोरियाई वॉन',
      countryCode: 'KR',
      unit: 100,
    ),
    _hkd,
    _sek,
    _dkk,
    _thb,
    _nzd,
    _zar,
  ];

  /// Catalogue quoted against the given local currency code
  /// (`NPR` → [known] / NRB, `INR` → [ecb] / Frankfurter).
  static List<Currency> catalogueFor(String localIso3) =>
      localIso3.toUpperCase() == inr.iso3 ? ecb : known;

  /// Looks a currency up by ISO code (case-insensitive) in [catalogue]
  /// (defaults to the NRB list); `null` if unknown. `NPR` always resolves
  /// to [npr].
  static Currency? byIso3(String iso3, {List<Currency> catalogue = known}) {
    final code = iso3.toUpperCase();
    if (code == npr.iso3) return npr;
    for (final c in catalogue) {
      if (c.iso3 == code) return c;
    }
    return null;
  }

  /// Name for [languageCode] (`en` / `ne` / `hi`), with the unit suffix when
  /// it is not 1 (e.g. "Indian Rupee (100)").
  String displayName({required String languageCode, bool withUnit = true}) {
    final base = switch (languageCode) {
      'ne' => nameNe,
      'hi' => nameHi ?? nameNe,
      _ => nameEn,
    };
    return unit == 1 || !withUnit ? base : '$base ($unit)';
  }

  /// Emoji flag built from [countryCode] (regional indicator symbols).
  String get flagEmoji => String.fromCharCodes(
    countryCode.toUpperCase().codeUnits.map((c) => 0x1F1E6 + (c - 65)),
  );
}
