import '../../../../core/region/region.dart';
import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/report_product.dart';

/// The report catalogue.
///
/// Prices are region-aware rather than converted at display time: a report
/// that costs 1,100 in Nepal is not sold at the arithmetic conversion in
/// India, it is priced for that market.
abstract final class ReportCatalogue {
  static List<ReportProduct> forRegion(Region region) => [
    ReportProduct(
      id: 'report-life',
      kind: ReportKind.life,
      title: const LocalizedText(
        ne: 'पूर्ण जीवन कुण्डली',
        en: 'Complete life report',
        hi: 'संपूर्ण जीवन कुंडली',
      ),
      summary: const LocalizedText(
        ne: 'जन्मकुण्डली, दशा, योग र उपाय सहितको विस्तृत विश्लेषण।',
        en:
            'Your full birth chart read house by house, with dashas, yogas '
            'and remedies.',
        hi: 'जन्मकुंडली, दशा, योग और उपाय सहित विस्तृत विश्लेषण।',
      ),
      price: region == Region.india ? 899 : 1100,
      originalPrice: region == Region.india ? 1499 : 1800,
      pageCount: 48,
      isPopular: true,
      deliveryTime: const Duration(minutes: 15),
      contents: const [
        LocalizedText(
          ne: 'ग्रह स्थिति र भाव विश्लेषण',
          en: 'Planetary positions and house analysis',
          hi: 'ग्रह स्थिति और भाव विश्लेषण',
        ),
        LocalizedText(
          ne: 'विंशोत्तरी दशा (१२० वर्ष)',
          en: 'Vimshottari dasha across 120 years',
          hi: 'विंशोत्तरी दशा (120 वर्ष)',
        ),
        LocalizedText(
          ne: 'दोष र तिनका उपाय',
          en: 'Doshas present and their remedies',
          hi: 'दोष और उनके उपाय',
        ),
        LocalizedText(
          ne: 'रत्न र मन्त्र सिफारिस',
          en: 'Gemstone and mantra recommendations',
          hi: 'रत्न और मंत्र अनुशंसा',
        ),
      ],
    ),
    ReportProduct(
      id: 'report-match',
      kind: ReportKind.matchMaking,
      title: const LocalizedText(
        ne: 'विवाह मिलान रिपोर्ट',
        en: 'Marriage matching report',
        hi: 'विवाह मिलान रिपोर्ट',
      ),
      summary: const LocalizedText(
        ne: 'अष्टकूट गुण मिलान, मंगल दोष र दाम्पत्य विश्लेषण।',
        en:
            'Ashtakoota guna milan, Mangal dosha and a compatibility reading '
            'for both charts.',
        hi: 'अष्टकूट गुण मिलान, मंगल दोष और दांपत्य विश्लेषण।',
      ),
      price: region == Region.india ? 699 : 850,
      pageCount: 32,
      needsSecondProfile: true,
      deliveryTime: const Duration(minutes: 20),
      contents: const [
        LocalizedText(
          ne: '३६ गुण मिलान विवरण',
          en: 'All 36 gunas scored and explained',
          hi: '36 गुण मिलान विवरण',
        ),
        LocalizedText(
          ne: 'मंगल दोष जाँच',
          en: 'Mangal dosha check for both charts',
          hi: 'मंगल दोष जाँच',
        ),
        LocalizedText(
          ne: 'दाम्पत्य जीवन र सन्तान योग',
          en: 'Married life and progeny indications',
          hi: 'दांपत्य जीवन और संतान योग',
        ),
      ],
    ),
    ReportProduct(
      id: 'report-career',
      kind: ReportKind.career,
      title: const LocalizedText(
        ne: 'करियर र आर्थिक रिपोर्ट',
        en: 'Career and finance report',
        hi: 'करियर और वित्त रिपोर्ट',
      ),
      summary: const LocalizedText(
        ne: 'दशम भाव, धन योग र उपयुक्त पेशाको विश्लेषण।',
        en:
            'The tenth house, wealth yogas and the work that suits your '
            'chart.',
        hi: 'दशम भाव, धन योग और उपयुक्त पेशे का विश्लेषण।',
      ),
      price: region == Region.india ? 499 : 600,
      pageCount: 24,
      contents: const [
        LocalizedText(
          ne: 'उपयुक्त पेशा र क्षेत्र',
          en: 'Suited professions and fields',
          hi: 'उपयुक्त पेशे और क्षेत्र',
        ),
        LocalizedText(
          ne: 'धन योग र आम्दानीका अवधि',
          en: 'Wealth yogas and earning periods',
          hi: 'धन योग और आय की अवधि',
        ),
      ],
    ),
    ReportProduct(
      id: 'report-year',
      kind: ReportKind.yearAhead,
      title: const LocalizedText(
        ne: 'वर्षफल रिपोर्ट',
        en: 'Year ahead report',
        hi: 'वर्षफल रिपोर्ट',
      ),
      summary: const LocalizedText(
        ne: 'आगामी १२ महिनाको महिना-अनुसार भविष्यवाणी।',
        en: 'A month-by-month forecast for the next twelve months.',
        hi: 'अगले 12 महीनों का माह-वार पूर्वानुमान।',
      ),
      price: region == Region.india ? 349 : 450,
      pageCount: 18,
      deliveryTime: const Duration(minutes: 8),
      contents: const [
        LocalizedText(
          ne: 'महिना अनुसार भविष्यवाणी',
          en: 'Month-by-month predictions',
          hi: 'माह-वार भविष्यवाणी',
        ),
        LocalizedText(
          ne: 'शुभ र सावधानीका अवधि',
          en: 'Favourable and cautious periods',
          hi: 'शुभ और सावधानी की अवधि',
        ),
      ],
    ),
    ReportProduct(
      id: 'report-remedies',
      kind: ReportKind.remedies,
      title: const LocalizedText(
        ne: 'उपाय र रत्न रिपोर्ट',
        en: 'Remedies and gemstone report',
        hi: 'उपाय और रत्न रिपोर्ट',
      ),
      summary: const LocalizedText(
        ne: 'तपाईंको कुण्डली अनुसार रत्न, मन्त्र र दानका सिफारिस।',
        en:
            'Gemstones, mantras and charities chosen for your chart, with '
            'when to begin each.',
        hi: 'आपकी कुंडली के अनुसार रत्न, मंत्र और दान की अनुशंसा।',
      ),
      price: region == Region.india ? 299 : 380,
      pageCount: 14,
      deliveryTime: const Duration(minutes: 5),
      contents: const [
        LocalizedText(
          ne: 'रत्न, धारण विधि र मुहूर्त',
          en: 'Gemstones, how to wear them and when',
          hi: 'रत्न, धारण विधि और मुहूर्त',
        ),
        LocalizedText(
          ne: 'मन्त्र र जप संख्या',
          en: 'Mantras with japa counts',
          hi: 'मंत्र और जप संख्या',
        ),
      ],
    ),
  ];
}
