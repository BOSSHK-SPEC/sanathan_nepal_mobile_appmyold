import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/consult_channel.dart';
import '../../domain/entities/specialty.dart';

/// Nepal catalogue. Rates are in NPR per minute.
///
/// Deliberately varied across every filter axis — presence, price, rating,
/// experience, language and channel mix — so discovery, sorting and the
/// filter sheet all have something real to act on.
const List<Astrologer> nepalAstrologers = [
  Astrologer(
    id: 'np-uttam',
    name: LocalizedText(
      ne: 'पण्डित उत्तम उपाध्याय',
      en: 'Pandit Uttam Upadhyaya',
      hi: 'पंडित उत्तम उपाध्याय',
    ),
    headline: LocalizedText(
      ne: 'वैदिक ज्योतिष र वास्तु विशेषज्ञ',
      en: 'Vedic astrology & Vaastu expert',
      hi: 'वैदिक ज्योतिष एवं वास्तु विशेषज्ञ',
    ),
    about: LocalizedText(
      ne:
          'काठमाडौंमा २२ वर्षदेखि जन्मकुण्डली, ग्रहशान्ति र वास्तु परामर्श '
          'गर्दै आएका छन् । चिना टिप्पन र विवाह मिलान उहाँको विशेषता हो ।',
      en:
          'Twenty-two years of birth-chart reading, Graha Shanti and Vaastu '
          'consultation in Kathmandu. Known for Cheena Tippan and marriage '
          'matching.',
      hi:
          'काठमांडू में बाईस वर्षों से जन्मपत्री, ग्रह शांति और वास्तु परामर्श। '
          'चीना टिप्पन और विवाह मिलान में विशेषज्ञ।',
    ),
    specialties: [
      Specialty.vedic,
      Specialty.vaastu,
      Specialty.kundliMatching,
      Specialty.muhurta,
    ],
    languageCodes: ['ne', 'hi', 'en'],
    experienceYears: 22,
    rating: 4.8,
    reviewCount: 1240,
    ratePerMinute: {
      ConsultChannel.chat: 25,
      ConsultChannel.voice: 40,
      ConsultChannel.video: 60,
    },
    consultationCount: 9800,
    followers: 12400,
    recommendedPercent: 96,
    isOnline: true,
    isVerified: true,
    queueLength: 3,
    avatarAsset: 'assets/images/appointment/provider_uttam.png',
    location: LocalizedText(ne: 'काठमाडौं', en: 'Kathmandu', hi: 'काठमांडू'),
    ratingBreakdown: {5: 980, 4: 190, 3: 45, 2: 15, 1: 10},
  ),
  Astrologer(
    id: 'np-sarita',
    name: LocalizedText(
      ne: 'सरिता ज्ञवाली',
      en: 'Sarita Gyawali',
      hi: 'सरिता ज्ञवाली',
    ),
    headline: LocalizedText(
      ne: 'टेरो कार्ड र अंकज्योतिष',
      en: 'Tarot & numerology',
      hi: 'टैरो और अंक ज्योतिष',
    ),
    about: LocalizedText(
      ne:
          'सम्बन्ध, करियर र निर्णयका प्रश्नमा टेरो पढाइ । स्पष्ट र '
          'व्यावहारिक सल्लाहका लागि चिनिन्छिन् ।',
      en:
          'Tarot readings for relationship, career and decision questions. '
          'Known for direct, practical guidance.',
      hi:
          'रिश्ते, करियर और निर्णय के प्रश्नों पर टैरो पठन। स्पष्ट और '
          'व्यावहारिक सलाह के लिए जानी जाती हैं।',
    ),
    specialties: [Specialty.tarot, Specialty.numerology],
    languageCodes: ['ne', 'en'],
    experienceYears: 8,
    rating: 4.6,
    reviewCount: 486,
    ratePerMinute: {ConsultChannel.chat: 18, ConsultChannel.voice: 30},
    consultationCount: 3100,
    followers: 4200,
    recommendedPercent: 92,
    isOnline: true,
    isVerified: true,
    location: LocalizedText(ne: 'पोखरा', en: 'Pokhara', hi: 'पोखरा'),
    ratingBreakdown: {5: 340, 4: 96, 3: 30, 2: 12, 1: 8},
  ),
  Astrologer(
    id: 'np-hari',
    name: LocalizedText(
      ne: 'आचार्य हरि पौडेल',
      en: 'Acharya Hari Poudel',
      hi: 'आचार्य हरि पौडेल',
    ),
    headline: LocalizedText(
      ne: 'नाडी ज्योतिष र ग्रहशान्ति',
      en: 'Nadi astrology & Graha Shanti',
      hi: 'नाड़ी ज्योतिष एवं ग्रह शांति',
    ),
    about: LocalizedText(
      ne: 'परम्परागत नाडी पद्धतिमा आधारित फलादेश र दोष निवारणका उपाय ।',
      en:
          'Predictions in the traditional Nadi method, with remedies for '
          'planetary afflictions.',
      hi: 'पारंपरिक नाड़ी पद्धति पर आधारित फलादेश और दोष निवारण के उपाय।',
    ),
    specialties: [Specialty.nadi, Specialty.vedic, Specialty.prashna],
    languageCodes: ['ne', 'hi'],
    experienceYears: 31,
    rating: 4.9,
    reviewCount: 2010,
    ratePerMinute: {ConsultChannel.voice: 55, ConsultChannel.video: 80},
    consultationCount: 15200,
    followers: 21000,
    recommendedPercent: 98,
    isVerified: true,
    location: LocalizedText(ne: 'भक्तपुर', en: 'Bhaktapur', hi: 'भक्तपुर'),
    ratingBreakdown: {5: 1760, 4: 180, 3: 40, 2: 20, 1: 10},
  ),
  Astrologer(
    id: 'np-anjali',
    name: LocalizedText(ne: 'अञ्जली श्रेष्ठ', en: 'Anjali Shrestha'),
    headline: LocalizedText(
      ne: 'हस्तरेखा र रत्न परामर्श',
      en: 'Palmistry & gemstone guidance',
      hi: 'हस्तरेखा और रत्न परामर्श',
    ),
    about: LocalizedText(
      ne: 'हस्तरेखा अध्ययन र उपयुक्त रत्न छनोटमा विशेषज्ञता ।',
      en: 'Palm reading and matching the right gemstone to a chart.',
      hi: 'हस्तरेखा अध्ययन और उपयुक्त रत्न चयन में विशेषज्ञता।',
    ),
    specialties: [Specialty.palmistry, Specialty.gemstone],
    languageCodes: ['ne', 'en'],
    experienceYears: 6,
    rating: 4.3,
    reviewCount: 210,
    ratePerMinute: {ConsultChannel.chat: 12, ConsultChannel.video: 28},
    consultationCount: 1400,
    followers: 1600,
    recommendedPercent: 88,
    isOnline: true,
    queueLength: 1,
    location: LocalizedText(ne: 'ललितपुर', en: 'Lalitpur', hi: 'ललितपुर'),
    ratingBreakdown: {5: 120, 4: 55, 3: 20, 2: 9, 1: 6},
  ),
  Astrologer(
    id: 'np-bishnu',
    name: LocalizedText(ne: 'विष्णु अधिकारी', en: 'Bishnu Adhikari'),
    headline: LocalizedText(
      ne: 'विवाह मिलान विशेषज्ञ',
      en: 'Marriage matching specialist',
      hi: 'विवाह मिलान विशेषज्ञ',
    ),
    about: LocalizedText(
      ne: 'गुण मिलान, मंगल दोष र विवाहको साइत निर्धारण ।',
      en:
          'Gun Milan, Manglik analysis and choosing an auspicious wedding '
          'date.',
      hi: 'गुण मिलान, मंगल दोष विश्लेषण और विवाह मुहूर्त निर्धारण।',
    ),
    specialties: [Specialty.kundliMatching, Specialty.muhurta, Specialty.vedic],
    languageCodes: ['ne', 'hi', 'en'],
    experienceYears: 14,
    rating: 4.7,
    reviewCount: 830,
    ratePerMinute: {
      ConsultChannel.chat: 20,
      ConsultChannel.voice: 35,
      ConsultChannel.video: 50,
    },
    consultationCount: 6400,
    followers: 7800,
    recommendedPercent: 94,
    isOnline: true,
    isVerified: true,
    queueLength: 7,
    location: LocalizedText(ne: 'चितवन', en: 'Chitwan', hi: 'चितवन'),
    ratingBreakdown: {5: 640, 4: 130, 3: 35, 2: 15, 1: 10},
  ),
  Astrologer(
    id: 'np-kamala',
    name: LocalizedText(ne: 'कमला भट्टराई', en: 'Kamala Bhattarai'),
    headline: LocalizedText(
      ne: 'प्रश्न ज्योतिष',
      en: 'Prashna (horary) astrology',
      hi: 'प्रश्न ज्योतिष',
    ),
    about: LocalizedText(
      ne: 'जन्म समय थाहा नभएकाहरूका लागि प्रश्न कुण्डलीबाट उत्तर ।',
      en:
          'Answers drawn from a Prashna chart — useful when the birth time '
          'is unknown.',
      hi: 'जन्म समय ज्ञात न होने पर प्रश्न कुंडली से उत्तर।',
    ),
    specialties: [Specialty.prashna, Specialty.vedic],
    languageCodes: ['ne'],
    experienceYears: 11,
    rating: 4.4,
    reviewCount: 390,
    ratePerMinute: {ConsultChannel.chat: 15, ConsultChannel.voice: 25},
    consultationCount: 2700,
    followers: 3100,
    recommendedPercent: 90,
    location: LocalizedText(ne: 'धरान', en: 'Dharan', hi: 'धरान'),
    ratingBreakdown: {5: 250, 4: 90, 3: 30, 2: 12, 1: 8},
  ),
];
