import '../../../../core/region/region.dart';

/// Region-specific legal parties: the entity operating the app in that
/// region, its contact block, the governing law and the data-protection
/// framework referenced by the Privacy Policy.
///
/// Selected by the data source through [RegionResolver] – the presentation
/// layer stays region-blind.
class LegalParty {
  const LegalParty({
    required this.countryEn,
    required this.countryNe,
    required this.countryHi,
    required this.companyEn,
    required this.companyNe,
    required this.companyHi,
    required this.addressEn,
    required this.addressNe,
    required this.addressHi,
    required this.email,
    required this.phone,
    required this.jurisdictionEn,
    required this.jurisdictionNe,
    required this.jurisdictionHi,
    required this.governingLawEn,
    required this.governingLawNe,
    required this.governingLawHi,
    required this.dataLawEn,
    required this.dataLawNe,
    required this.dataLawHi,
    this.grievanceOfficerEn,
    this.grievanceOfficerNe,
    this.grievanceOfficerHi,
    this.grievanceEmail,
  });

  final String countryEn;
  final String countryNe;
  final String countryHi;
  final String companyEn;
  final String companyNe;
  final String companyHi;
  final String addressEn;
  final String addressNe;
  final String addressHi;
  final String email;
  final String phone;
  final String jurisdictionEn;
  final String jurisdictionNe;
  final String jurisdictionHi;
  final String governingLawEn;
  final String governingLawNe;
  final String governingLawHi;
  final String dataLawEn;
  final String dataLawNe;
  final String dataLawHi;

  /// India only (DPDP Act 2023 requires a grievance officer).
  final String? grievanceOfficerEn;
  final String? grievanceOfficerNe;
  final String? grievanceOfficerHi;
  final String? grievanceEmail;

  bool get hasGrievanceOfficer => grievanceOfficerEn != null;

  static LegalParty of(RegionConfig config) => config.isIndia ? india : nepal;

  static const LegalParty nepal = LegalParty(
    countryEn: 'Nepal',
    countryNe: 'नेपाल',
    countryHi: 'नेपाल',
    companyEn: 'Sanatan Nepal Pvt. Ltd.',
    companyNe: 'सनातन नेपाल प्रा. लि.',
    companyHi: 'सनातन नेपाल प्रा. लि.',
    addressEn: 'Kathmandu, Nepal',
    addressNe: 'काठमाडौँ, नेपाल',
    addressHi: 'काठमांडू, नेपाल',
    email: 'info@ourvirtualtribes.com',
    phone: '+977 1 4XXXXXX',
    jurisdictionEn: 'the courts of Kathmandu, Nepal',
    jurisdictionNe: 'काठमाडौँ, नेपालका अदालतहरू',
    jurisdictionHi: 'काठमांडू, नेपाल की अदालतें',
    governingLawEn: 'the laws of Nepal',
    governingLawNe: 'नेपालको कानून',
    governingLawHi: 'नेपाल के कानून',
    dataLawEn: 'the Individual Privacy Act, 2075 (2018) of Nepal',
    dataLawNe: 'नेपालको वैयक्तिक गोपनीयता सम्बन्धी ऐन, २०७५',
    dataLawHi: 'नेपाल का वैयक्तिक गोपनीयता अधिनियम, २०७५ (2018)',
  );

  static const LegalParty india = LegalParty(
    countryEn: 'India',
    countryNe: 'भारत',
    countryHi: 'भारत',
    companyEn: 'Sanatan Nepal (India) Pvt. Ltd.',
    companyNe: 'सनातन नेपाल (इन्डिया) प्रा. लि.',
    companyHi: 'सनातन नेपाल (इंडिया) प्रा. लि.',
    addressEn: 'New Delhi, India',
    addressNe: 'नयाँ दिल्ली, भारत',
    addressHi: 'नई दिल्ली, भारत',
    email: 'info.in@ourvirtualtribes.com',
    phone: '+91 11 4XXX XXXX',
    jurisdictionEn: 'the courts of New Delhi, India',
    jurisdictionNe: 'नयाँ दिल्ली, भारतका अदालतहरू',
    jurisdictionHi: 'नई दिल्ली, भारत की अदालतें',
    governingLawEn: 'the laws of India',
    governingLawNe: 'भारतको कानून',
    governingLawHi: 'भारत के कानून',
    dataLawEn:
        'the Digital Personal Data Protection Act, 2023 (DPDP Act) '
        'of India',
    dataLawNe: 'भारतको डिजिटल व्यक्तिगत डाटा संरक्षण ऐन, २०२३ (DPDP Act)',
    dataLawHi:
        'भारत का डिजिटल व्यक्तिगत डेटा संरक्षण अधिनियम, 2023 '
        '(DPDP Act)',
    grievanceOfficerEn: 'Grievance Officer, Sanatan Nepal (India) Pvt. Ltd.',
    grievanceOfficerNe: 'गुनासो अधिकारी, सनातन नेपाल (इन्डिया) प्रा. लि.',
    grievanceOfficerHi: 'शिकायत अधिकारी, सनातन नेपाल (इंडिया) प्रा. लि.',
    grievanceEmail: 'grievance.in@ourvirtualtribes.com',
  );
}
