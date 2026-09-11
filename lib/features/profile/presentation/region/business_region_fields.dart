import '../../../../core/region/region.dart';

/// Region-conditional business-form fields (labels, hints, examples) keyed by
/// [Region]. The form reads everything from here so it never branches on the
/// region itself.
class BusinessRegionFields {
  const BusinessRegionFields({
    required this.region,
    required this.taxIdLabelEn,
    required this.taxIdLabelNe,
    required this.taxIdLabelHi,
    required this.taxIdHint,
    required this.addressHint,
    required this.phoneNational,
    required this.workingHoursHint,
    required this.documentExamples,
  });

  final Region region;
  final String taxIdLabelEn;
  final String taxIdLabelNe;
  final String taxIdLabelHi;
  final String taxIdHint;

  /// Example office address including the local postal code style.
  final String addressHint;

  /// Example national phone number (without the country prefix).
  final String phoneNational;
  final String workingHoursHint;

  /// Typical verification documents for the region (used as mock upload
  /// file names).
  final List<String> documentExamples;

  /// Mock file name for the n-th (0-based) uploaded document.
  String documentFileName(int index) =>
      '${documentExamples[index % documentExamples.length]}.pdf';

  RegionConfig get config => region.config;

  String taxIdLabel(String languageCode) => switch (languageCode) {
    'ne' => taxIdLabelNe,
    'hi' => taxIdLabelHi,
    _ => taxIdLabelEn,
  };

  /// "+977-9841234567" style example for phone / WhatsApp fields.
  String get phoneHint => '${config.phonePrefix}-$phoneNational';

  /// Example fixed price / price range hints for item forms.
  String priceHint(String Function(num amount) money) => money(10000);
  String priceRangeHint(String Function(num amount) money) =>
      '${money(10000)} - ${money(50000)}';

  static const Map<Region, BusinessRegionFields> _byRegion = {
    Region.nepal: BusinessRegionFields(
      region: Region.nepal,
      taxIdLabelEn: 'PAN / VAT No. (optional)',
      taxIdLabelNe: 'PAN / VAT नम्बर (ऐच्छिक)',
      taxIdLabelHi: 'PAN / VAT नंबर (वैकल्पिक)',
      taxIdHint: 'eg: 601234567',
      addressHint: 'eg: Kalopul, Kathmandu 44600, Nepal',
      phoneNational: '9841234567',
      workingHoursHint: 'Sun – Fri, 10:00 AM – 6:00 PM',
      documentExamples: ['PAN Certificate', 'Company Registration'],
    ),
    Region.india: BusinessRegionFields(
      region: Region.india,
      taxIdLabelEn: 'GSTIN (optional)',
      taxIdLabelNe: 'GSTIN (ऐच्छिक)',
      taxIdLabelHi: 'GSTIN (वैकल्पिक)',
      taxIdHint: 'eg: 07AAACS1234A1Z5',
      addressHint: 'eg: Connaught Place, New Delhi 110001 (PIN code)',
      phoneNational: '9810123456',
      workingHoursHint: 'Mon – Sat, 10:00 AM – 7:00 PM',
      documentExamples: ['GST Certificate', 'Udyam Registration'],
    ),
  };

  /// Fields for [config]'s region.
  static BusinessRegionFields of(RegionConfig config) =>
      _byRegion[config.region] ?? _byRegion[Region.nepal]!;
}
