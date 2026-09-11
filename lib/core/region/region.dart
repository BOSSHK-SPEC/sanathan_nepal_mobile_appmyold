import 'package:freezed_annotation/freezed_annotation.dart';

import '../calendar/calendar.dart';

part 'region.freezed.dart';

/// Supported app regions. Everything region-specific (calendar system,
/// currency, forex source, festivals, payments, defaults) is looked up from
/// [RegionConfig] – never from `if (locale == 'ne')` checks.
enum Region {
  nepal('NP'),
  india('IN');

  const Region(this.code);

  /// The value the API speaks: `NP` / `IN`.
  ///
  /// This — never `name`, and never `name.toUpperCase()` — is what goes into
  /// the `X-Region` header and any region field in a request body. The server
  /// treats an unrecognised region as Nepal rather than rejecting it, so the
  /// wrong string produces silently wrong content instead of an error.
  final String code;

  static Region fromCode(String? code) =>
      Region.values.firstWhere((r) => r.code == code, orElse: () => nepal);

  RegionConfig get config => switch (this) {
    Region.nepal => RegionConfig.nepal,
    Region.india => RegionConfig.india,
  };
}

/// Payment rails offered by the marketplace / appointments per region.
enum PaymentRail {
  esewa,
  khalti,
  upi,
  card,
  netBanking,
  bankTransfer,
  cashOnDelivery,
}

@freezed
abstract class GeoPoint with _$GeoPoint {
  const GeoPoint._();

  const factory GeoPoint({
    required double latitude,
    required double longitude,
    required String nameEn,
    required String nameNe,
    required String nameHi,
  }) = _GeoPoint;

  String name(String languageCode) => switch (languageCode) {
    'ne' => nameNe,
    'hi' => nameHi,
    _ => nameEn,
  };
}

/// Immutable per-region configuration (single source of truth).
@freezed
abstract class RegionConfig with _$RegionConfig {
  const RegionConfig._();

  const factory RegionConfig({
    required Region region,
    required String nameEn,
    required String nameNe,
    required String nameHi,
    required String flagEmoji,

    /// ISO 4217 code of the local currency (NPR / INR).
    required String currencyCode,

    /// Display symbol in Devanagari locales (रु. / ₹).
    required String currencySymbol,

    /// Display symbol in Latin-script locales (Rs. / ₹).
    required String currencySymbolLatin,
    required String currencyNameEn,

    /// e.g. `+977`, `+91`.
    required String phonePrefix,

    /// e.g. `NST`, `IST`.
    required String timeZoneLabel,
    required Duration utcOffset,

    /// Default location for weather / panchanga when GPS is unavailable.
    required GeoPoint defaultCity,

    /// UI languages offered for this region (first = default).
    required List<String> languageCodes,
    required String defaultLanguageCode,

    /// Traditional calendar shown alongside Gregorian.
    required TraditionalCalendar calendar,
    required List<PaymentRail> paymentRails,

    /// Bullion unit label ("tola" / "10 g").
    required String metalUnitEn,
    required String metalUnitLocal,

    /// Currency whose trend vs. local currency is charted (USD).
    required String forexBaseCurrency,

    /// Era systems displayed in the panchanga header, in order
    /// (e.g. Nepal: BS, AD, Shaka, Nepal Sambat; India: Vikram, Shaka, AD).
    required List<SamvatKind> samvatLabels,
  }) = _RegionConfig;

  /// Symbol for the given UI language code.
  String symbolFor(String languageCode) =>
      languageCode == 'ne' || languageCode == 'hi'
      ? currencySymbol
      : currencySymbolLatin;

  String name(String languageCode) => switch (languageCode) {
    'ne' => nameNe,
    'hi' => nameHi,
    _ => nameEn,
  };

  bool get isNepal => region == Region.nepal;
  bool get isIndia => region == Region.india;

  /// Weekend/holiday weekday indexes (0 = Sunday … 6 = Saturday).
  List<int> get weekendWeekdays => calendar.weekendWeekdays;

  static const RegionConfig nepal = RegionConfig(
    region: Region.nepal,
    nameEn: 'Nepal',
    nameNe: 'नेपाल',
    nameHi: 'नेपाल',
    flagEmoji: '🇳🇵',
    currencyCode: 'NPR',
    currencySymbol: 'रु.',
    currencySymbolLatin: 'Rs.',
    currencyNameEn: 'Nepalese Rupee',
    phonePrefix: '+977',
    timeZoneLabel: 'NST',
    utcOffset: Duration(hours: 5, minutes: 45),
    defaultCity: GeoPoint(
      latitude: 27.7172,
      longitude: 85.3240,
      nameEn: 'Kathmandu',
      nameNe: 'काठमाडौँ',
      nameHi: 'काठमांडू',
    ),
    languageCodes: ['ne', 'en'],
    defaultLanguageCode: 'ne',
    calendar: BikramSambatCalendar(),
    paymentRails: [
      PaymentRail.esewa,
      PaymentRail.khalti,
      PaymentRail.bankTransfer,
      PaymentRail.cashOnDelivery,
    ],
    metalUnitEn: 'tola',
    metalUnitLocal: 'तोला',
    forexBaseCurrency: 'USD',
    samvatLabels: [
      SamvatKind.bikram,
      SamvatKind.gregorian,
      SamvatKind.shaka,
      SamvatKind.nepalSambat,
    ],
  );

  static const RegionConfig india = RegionConfig(
    region: Region.india,
    nameEn: 'India',
    nameNe: 'भारत',
    nameHi: 'भारत',
    flagEmoji: '🇮🇳',
    currencyCode: 'INR',
    currencySymbol: '₹',
    currencySymbolLatin: '₹',
    currencyNameEn: 'Indian Rupee',
    phonePrefix: '+91',
    timeZoneLabel: 'IST',
    utcOffset: Duration(hours: 5, minutes: 30),
    defaultCity: GeoPoint(
      latitude: 28.6139,
      longitude: 77.2090,
      nameEn: 'New Delhi',
      nameNe: 'नयाँ दिल्ली',
      nameHi: 'नई दिल्ली',
    ),
    languageCodes: ['en', 'hi'],
    defaultLanguageCode: 'en',
    calendar: SakaCalendar(),
    paymentRails: [
      PaymentRail.upi,
      PaymentRail.card,
      PaymentRail.netBanking,
      PaymentRail.cashOnDelivery,
    ],
    metalUnitEn: '10 g',
    metalUnitLocal: '१० ग्राम',
    forexBaseCurrency: 'USD',
    samvatLabels: [SamvatKind.vikram, SamvatKind.shaka, SamvatKind.gregorian],
  );
}

/// Era / year-numbering systems that can be displayed.
enum SamvatKind { bikram, vikram, shaka, nepalSambat, gregorian }
