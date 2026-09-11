import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/consult_channel.dart';
import '../../domain/entities/specialty.dart';

/// India catalogue. Rates are in INR per minute.
///
/// Hindi is the primary language here (Nepali is not offered), mirroring the
/// region's `offeredLanguages` in `RegionConfig`.
const List<Astrologer> indiaAstrologers = [
  Astrologer(
    id: 'in-rajesh',
    name: LocalizedText(
      ne: 'पण्डित राजेश शर्मा',
      en: 'Pandit Rajesh Sharma',
      hi: 'पंडित राजेश शर्मा',
    ),
    headline: LocalizedText(
      ne: 'वैदिक ज्योतिष र कुण्डली विश्लेषण',
      en: 'Vedic astrology & chart analysis',
      hi: 'वैदिक ज्योतिष एवं कुंडली विश्लेषण',
    ),
    about: LocalizedText(
      ne: 'वाराणसीमा हुर्किएका, १८ वर्षदेखि कुण्डली विश्लेषण गर्दै ।',
      en:
          'Trained in Varanasi, eighteen years of chart analysis with a '
          'focus on career and business questions.',
      hi:
          'वाराणसी में प्रशिक्षित, अठारह वर्षों से कुंडली विश्लेषण — करियर '
          'और व्यवसाय के प्रश्नों पर विशेष ध्यान।',
    ),
    specialties: [Specialty.vedic, Specialty.muhurta, Specialty.gemstone],
    languageCodes: ['hi', 'en'],
    experienceYears: 18,
    rating: 4.7,
    reviewCount: 3210,
    ratePerMinute: {
      ConsultChannel.chat: 19,
      ConsultChannel.voice: 32,
      ConsultChannel.video: 49,
    },
    consultationCount: 24000,
    followers: 41000,
    recommendedPercent: 95,
    isOnline: true,
    isVerified: true,
    queueLength: 12,
    location: LocalizedText(ne: 'वाराणसी', en: 'Varanasi', hi: 'वाराणसी'),
    ratingBreakdown: {5: 2500, 4: 480, 3: 140, 2: 60, 1: 30},
  ),
  Astrologer(
    id: 'in-meera',
    name: LocalizedText(ne: 'मीरा अय्यर', en: 'Meera Iyer', hi: 'मीरा अय्यर'),
    headline: LocalizedText(
      ne: 'नाडी र दक्षिण भारतीय पद्धति',
      en: 'Nadi & South Indian tradition',
      hi: 'नाड़ी एवं दक्षिण भारतीय पद्धति',
    ),
    about: LocalizedText(
      ne: 'दक्षिण भारतीय चार्ट शैली र नाडी पद्धतिमा विशेषज्ञ ।',
      en:
          'Reads in the South Indian chart style; specialises in Nadi and '
          'Dasha timing.',
      hi: 'दक्षिण भारतीय चार्ट शैली में पठन; नाड़ी और दशा गणना में विशेषज्ञ।',
    ),
    specialties: [Specialty.nadi, Specialty.vedic],
    languageCodes: ['en', 'hi'],
    experienceYears: 25,
    rating: 4.9,
    reviewCount: 1890,
    ratePerMinute: {ConsultChannel.voice: 45, ConsultChannel.video: 70},
    consultationCount: 13400,
    followers: 26000,
    recommendedPercent: 97,
    isVerified: true,
    location: LocalizedText(ne: 'चेन्नई', en: 'Chennai', hi: 'चेन्नई'),
    ratingBreakdown: {5: 1620, 4: 190, 3: 50, 2: 18, 1: 12},
  ),
  Astrologer(
    id: 'in-devika',
    name: LocalizedText(
      ne: 'देविका नायर',
      en: 'Devika Nair',
      hi: 'देविका नायर',
    ),
    headline: LocalizedText(
      ne: 'टेरो र अंकज्योतिष',
      en: 'Tarot & numerology',
      hi: 'टैरो एवं अंक ज्योतिष',
    ),
    about: LocalizedText(
      ne: 'द्रुत टेरो पढाइ र नाम अंकज्योतिष परामर्श ।',
      en: 'Quick tarot pulls and name-numerology consultations.',
      hi: 'त्वरित टैरो पठन और नाम अंक ज्योतिष परामर्श।',
    ),
    specialties: [Specialty.tarot, Specialty.numerology],
    languageCodes: ['en', 'hi'],
    experienceYears: 5,
    rating: 4.2,
    reviewCount: 640,
    ratePerMinute: {ConsultChannel.chat: 9},
    consultationCount: 5200,
    followers: 8900,
    recommendedPercent: 86,
    isOnline: true,
    location: LocalizedText(ne: 'बेंगलुरु', en: 'Bengaluru', hi: 'बेंगलुरु'),
    ratingBreakdown: {5: 380, 4: 160, 3: 60, 2: 25, 1: 15},
  ),
  Astrologer(
    id: 'in-arun',
    name: LocalizedText(
      ne: 'अरुण मल्होत्रा',
      en: 'Arun Malhotra',
      hi: 'अरुण मल्होत्रा',
    ),
    headline: LocalizedText(
      ne: 'वास्तु र व्यापार परामर्श',
      en: 'Vaastu & business consulting',
      hi: 'वास्तु एवं व्यापार परामर्श',
    ),
    about: LocalizedText(
      ne: 'घर र कार्यालयको वास्तु सुधार तथा व्यापारिक निर्णयका लागि परामर्श ।',
      en:
          'Vaastu corrections for homes and offices, plus timing advice for '
          'business decisions.',
      hi:
          'घर और कार्यालय के वास्तु सुधार तथा व्यापारिक निर्णयों के लिए '
          'मुहूर्त परामर्श।',
    ),
    specialties: [Specialty.vaastu, Specialty.muhurta],
    languageCodes: ['hi', 'en'],
    experienceYears: 16,
    rating: 4.5,
    reviewCount: 970,
    ratePerMinute: {ConsultChannel.voice: 38, ConsultChannel.video: 55},
    consultationCount: 7100,
    followers: 11200,
    recommendedPercent: 91,
    isOnline: true,
    isVerified: true,
    queueLength: 2,
    location: LocalizedText(
      ne: 'नयाँ दिल्ली',
      en: 'New Delhi',
      hi: 'नई दिल्ली',
    ),
    ratingBreakdown: {5: 700, 4: 180, 3: 55, 2: 20, 1: 15},
  ),
  Astrologer(
    id: 'in-suresh',
    name: LocalizedText(ne: 'सुरेश जोशी', en: 'Suresh Joshi', hi: 'सुरेश जोशी'),
    headline: LocalizedText(
      ne: 'कुण्डली मिलान',
      en: 'Kundli matching',
      hi: 'कुंडली मिलान',
    ),
    about: LocalizedText(
      ne: 'गुण मिलान र मंगल दोष परीक्षणमा केन्द्रित ।',
      en: 'Focused on Gun Milan and Manglik dosha checks for marriage.',
      hi: 'विवाह हेतु गुण मिलान और मंगल दोष परीक्षण पर केंद्रित।',
    ),
    specialties: [Specialty.kundliMatching, Specialty.vedic],
    languageCodes: ['hi'],
    experienceYears: 9,
    rating: 4.1,
    reviewCount: 288,
    ratePerMinute: {ConsultChannel.chat: 11, ConsultChannel.voice: 21},
    consultationCount: 2200,
    followers: 2600,
    recommendedPercent: 84,
    location: LocalizedText(ne: 'जयपुर', en: 'Jaipur', hi: 'जयपुर'),
    ratingBreakdown: {5: 150, 4: 80, 3: 35, 2: 15, 1: 8},
  ),
  Astrologer(
    id: 'in-lakshmi',
    name: LocalizedText(
      ne: 'लक्ष्मी राव',
      en: 'Lakshmi Rao',
      hi: 'लक्ष्मी राव',
    ),
    headline: LocalizedText(ne: 'हस्तरेखा', en: 'Palmistry', hi: 'हस्तरेखा'),
    about: LocalizedText(
      ne: 'हस्तरेखाबाट स्वास्थ्य, सम्बन्ध र करियरको संकेत ।',
      en: 'Health, relationship and career indications read from the palm.',
      hi: 'हस्तरेखा से स्वास्थ्य, संबंध और करियर के संकेत।',
    ),
    specialties: [Specialty.palmistry],
    languageCodes: ['en', 'hi'],
    experienceYears: 12,
    rating: 4.6,
    reviewCount: 512,
    ratePerMinute: {ConsultChannel.video: 33},
    consultationCount: 3900,
    followers: 6100,
    recommendedPercent: 93,
    isOnline: true,
    isVerified: true,
    location: LocalizedText(ne: 'हैदराबाद', en: 'Hyderabad', hi: 'हैदराबाद'),
    ratingBreakdown: {5: 390, 4: 85, 3: 22, 2: 10, 1: 5},
  ),
];
