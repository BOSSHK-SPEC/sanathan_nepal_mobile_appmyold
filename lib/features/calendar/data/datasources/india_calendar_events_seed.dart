import '../models/calendar_event_model.dart';

/// Indian national holidays and major festivals for 2025–2027 (Gregorian
/// dates as gazetted by the Government of India / widely published
/// panchangas). Lunar festival dates for 2027 and the Islamic dates are the
/// published forecasts (moon-sighting may shift them by a day).
///
/// Titles are English + Hindi; the Nepali title reuses the Hindi text.
final List<CalendarEventModel> indiaCalendarEventsSeed = List.unmodifiable([
  for (final (year, month, day, key) in _dates) _event(year, month, day, key),
]);

class _Festival {
  const _Festival(
    this.en,
    this.hi, {
    this.tithiEn = '',
    this.tithiHi = '',
    this.holiday = false,
    this.descEn = '',
    this.descHi = '',
  });
  final String en;
  final String hi;
  final String tithiEn;
  final String tithiHi;
  final bool holiday;
  final String descEn;
  final String descHi;
}

CalendarEventModel _event(int year, int month, int day, String key) {
  final f = _festivals[key]!;
  final ymd =
      '$year-${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';
  return CalendarEventModel(
    id: '$ymd-$key',
    date: DateTime(year, month, day),
    titleEn: f.en,
    titleHi: f.hi,
    titleNe: f.hi,
    descriptionEn: f.descEn,
    descriptionHi: f.descHi,
    descriptionNe: f.descHi,
    tithiEn: f.tithiEn,
    tithiNe: f.tithiHi,
    isHoliday: f.holiday,
  );
}

const Map<String, _Festival> _festivals = {
  'makar-sankranti': _Festival(
    'Makar Sankranti / Pongal',
    'मकर संक्रांति / पोंगल',
    descEn:
        'The sun enters Makara (Capricorn); harvest festival celebrated as '
        'Pongal in Tamil Nadu, Lohri in Punjab and Uttarayan in Gujarat.',
    descHi:
        'सूर्य के मकर राशि में प्रवेश का पर्व – तमिलनाडु में पोंगल, पंजाब '
        'में लोहड़ी और गुजरात में उत्तरायण के रूप में मनाया जाता है।',
  ),
  'republic-day': _Festival(
    'Republic Day',
    'गणतंत्र दिवस',
    holiday: true,
    descEn: 'The Constitution of India came into force on 26 January 1950.',
    descHi: '26 जनवरी 1950 को भारत का संविधान लागू हुआ था।',
  ),
  'vasant-panchami': _Festival(
    'Vasant Panchami',
    'वसंत पंचमी',
    tithiEn: 'Panchami',
    tithiHi: 'पंचमी',
    descEn:
        'Goddess Saraswati is worshipped; the festival marks the arrival '
        'of spring.',
    descHi: 'माँ सरस्वती की पूजा का दिन; वसंत ऋतु के आगमन का पर्व।',
  ),
  'maha-shivaratri': _Festival(
    'Maha Shivaratri',
    'महाशिवरात्रि',
    tithiEn: 'Chaturdashi',
    tithiHi: 'चतुर्दशी',
    holiday: true,
    descEn:
        'The great night of Lord Shiva – fasting, night vigil and '
        'abhishek at Shiva temples across the country.',
    descHi:
        'भगवान शिव की महारात्रि – व्रत, रात्रि जागरण और शिवालयों में '
        'अभिषेक।',
  ),
  'holika-dahan': _Festival(
    'Holika Dahan',
    'होलिका दहन',
    tithiEn: 'Purnima',
    tithiHi: 'पूर्णिमा',
  ),
  'holi': _Festival(
    'Holi',
    'होली',
    tithiEn: 'Pratipada',
    tithiHi: 'प्रतिपदा',
    holiday: true,
    descEn:
        'Festival of colours celebrating the victory of good over evil '
        'and the arrival of spring.',
    descHi:
        'रंगों का त्योहार – बुराई पर अच्छाई की जीत और वसंत के आगमन का '
        'उत्सव।',
  ),
  'ugadi': _Festival(
    'Ugadi / Gudi Padwa',
    'उगादि / गुड़ी पड़वा',
    tithiEn: 'Pratipada',
    tithiHi: 'प्रतिपदा',
    descEn:
        'Lunar new year (Chaitra Shukla Pratipada) in Karnataka, Andhra, '
        'Telangana and Maharashtra; start of Vasanta Navratri.',
    descHi:
        'चैत्र शुक्ल प्रतिपदा – कर्नाटक, आंध्र, तेलंगाना और महाराष्ट्र का '
        'नववर्ष; वासंतिक नवरात्रि का आरंभ।',
  ),
  'ram-navami': _Festival(
    'Ram Navami',
    'राम नवमी',
    tithiEn: 'Navami',
    tithiHi: 'नवमी',
    holiday: true,
    descEn: 'Birth anniversary of Lord Rama.',
    descHi: 'भगवान श्रीराम का जन्मोत्सव।',
  ),
  'mahavir-jayanti': _Festival(
    'Mahavir Jayanti',
    'महावीर जयंती',
    holiday: true,
  ),
  'good-friday': _Festival('Good Friday', 'गुड फ्राइडे', holiday: true),
  'baisakhi': _Festival(
    'Baisakhi',
    'बैसाखी',
    descEn:
        'Punjabi harvest festival and Sikh new year; founding of the '
        'Khalsa (1699).',
    descHi: 'पंजाब का फसल पर्व और सिख नववर्ष; खालसा पंथ की स्थापना (1699)।',
  ),
  'ambedkar-jayanti': _Festival(
    'Ambedkar Jayanti',
    'अम्बेडकर जयंती',
    holiday: true,
    descEn: 'Birth anniversary of Dr. B. R. Ambedkar.',
    descHi: 'डॉ. भीमराव अम्बेडकर की जयंती।',
  ),
  'eid-ul-fitr': _Festival('Eid ul-Fitr', 'ईद-उल-फ़ित्र', holiday: true),
  'buddha-purnima': _Festival(
    'Buddha Purnima',
    'बुद्ध पूर्णिमा',
    tithiEn: 'Purnima',
    tithiHi: 'पूर्णिमा',
    holiday: true,
    descEn: 'Birth, enlightenment and mahaparinirvana of Gautama Buddha.',
    descHi: 'गौतम बुद्ध का जन्म, बोधि और महापरिनिर्वाण दिवस।',
  ),
  'eid-al-adha': _Festival(
    'Eid al-Adha (Bakrid)',
    'ईद-उल-अज़हा (बकरीद)',
    holiday: true,
  ),
  'muharram': _Festival('Muharram', 'मुहर्रम', holiday: true),
  'guru-purnima': _Festival(
    'Guru Purnima',
    'गुरु पूर्णिमा',
    tithiEn: 'Purnima',
    tithiHi: 'पूर्णिमा',
  ),
  'independence-day': _Festival(
    'Independence Day',
    'स्वतंत्रता दिवस',
    holiday: true,
    descEn: 'India became independent on 15 August 1947.',
    descHi: '15 अगस्त 1947 को भारत स्वतंत्र हुआ।',
  ),
  'raksha-bandhan': _Festival(
    'Raksha Bandhan',
    'रक्षाबंधन',
    tithiEn: 'Purnima',
    tithiHi: 'पूर्णिमा',
    descEn: 'Sisters tie a rakhi on their brothers\' wrists.',
    descHi: 'बहनें भाइयों की कलाई पर राखी बाँधती हैं।',
  ),
  'janmashtami': _Festival(
    'Janmashtami',
    'जन्माष्टमी',
    tithiEn: 'Ashtami',
    tithiHi: 'अष्टमी',
    holiday: true,
    descEn: 'Birth of Lord Krishna – midnight celebrations and dahi-handi.',
    descHi: 'भगवान श्रीकृष्ण का जन्मोत्सव – मध्यरात्रि पूजन और दही-हांडी।',
  ),
  'ganesh-chaturthi': _Festival(
    'Ganesh Chaturthi',
    'गणेश चतुर्थी',
    tithiEn: 'Chaturthi',
    tithiHi: 'चतुर्थी',
    descEn:
        'Ten-day festival welcoming Lord Ganesha; grandest in '
        'Maharashtra.',
    descHi:
        'भगवान गणेश के स्वागत का दस दिवसीय उत्सव; महाराष्ट्र में विशेष '
        'धूमधाम।',
  ),
  'onam': _Festival(
    'Onam (Thiruvonam)',
    'ओणम',
    descEn:
        'Kerala harvest festival welcoming King Mahabali – pookalam, '
        'sadya and boat races.',
    descHi:
        'केरल का फसल पर्व – राजा महाबली के स्वागत में पूकलम, साद्या और '
        'नौका दौड़।',
  ),
  'milad-un-nabi': _Festival('Milad-un-Nabi', 'मिलाद-उन-नबी', holiday: true),
  'navratri': _Festival(
    'Sharad Navratri begins',
    'शारदीय नवरात्रि प्रारंभ',
    tithiEn: 'Pratipada',
    tithiHi: 'प्रतिपदा',
    descEn:
        'Nine nights of Goddess Durga worship – Garba, Durga Puja and '
        'Golu across India.',
    descHi: 'माँ दुर्गा की आराधना की नौ रातें – गरबा, दुर्गा पूजा और गोलू।',
  ),
  'gandhi-jayanti': _Festival(
    'Gandhi Jayanti',
    'गांधी जयंती',
    holiday: true,
    descEn: 'Birth anniversary of Mahatma Gandhi.',
    descHi: 'महात्मा गांधी की जयंती।',
  ),
  'dussehra': _Festival(
    'Dussehra (Vijayadashami)',
    'दशहरा (विजयादशमी)',
    tithiEn: 'Dashami',
    tithiHi: 'दशमी',
    holiday: true,
    descEn:
        'Victory of Rama over Ravana and of Durga over Mahishasura – '
        'Ravan Dahan and Ramlila.',
    descHi:
        'रावण पर श्रीराम और महिषासुर पर माँ दुर्गा की विजय – रावण दहन '
        'और रामलीला।',
  ),
  'karwa-chauth': _Festival(
    'Karwa Chauth',
    'करवा चौथ',
    tithiEn: 'Chaturthi',
    tithiHi: 'चतुर्थी',
  ),
  'dhanteras': _Festival(
    'Dhanteras',
    'धनतेरस',
    tithiEn: 'Trayodashi',
    tithiHi: 'त्रयोदशी',
  ),
  'diwali': _Festival(
    'Diwali (Lakshmi Puja)',
    'दीपावली (लक्ष्मी पूजा)',
    tithiEn: 'Amavasya',
    tithiHi: 'अमावस्या',
    holiday: true,
    descEn:
        'Festival of lights – Goddess Lakshmi is worshipped and homes are '
        'lit with diyas.',
    descHi:
        'प्रकाश का पर्व – माँ लक्ष्मी की पूजा और घर-आँगन दीपों से '
        'सजाए जाते हैं।',
  ),
  'govardhan-puja': _Festival(
    'Govardhan Puja',
    'गोवर्धन पूजा',
    tithiEn: 'Pratipada',
    tithiHi: 'प्रतिपदा',
  ),
  'bhai-dooj': _Festival(
    'Bhai Dooj',
    'भाई दूज',
    tithiEn: 'Dwitiya',
    tithiHi: 'द्वितीया',
  ),
  'chhath-puja': _Festival(
    'Chhath Puja',
    'छठ पूजा',
    tithiEn: 'Shashthi',
    tithiHi: 'षष्ठी',
    descEn:
        'Worship of the Sun god and Chhathi Maiya – Bihar, Jharkhand and '
        'eastern UP.',
    descHi:
        'सूर्य देव और छठी मैया की उपासना – बिहार, झारखंड और पूर्वी उत्तर '
        'प्रदेश का महापर्व।',
  ),
  'guru-nanak-jayanti': _Festival(
    'Guru Nanak Jayanti',
    'गुरु नानक जयंती',
    tithiEn: 'Purnima',
    tithiHi: 'पूर्णिमा',
    holiday: true,
    descEn: 'Birth anniversary of Guru Nanak Dev Ji (Kartik Purnima).',
    descHi: 'गुरु नानक देव जी का प्रकाश पर्व (कार्तिक पूर्णिमा)।',
  ),
  'christmas': _Festival('Christmas', 'क्रिसमस', holiday: true),
};

/// (year, month, day, festival key).
const List<(int, int, int, String)> _dates = [
  // ── 2025 ────────────────────────────────────────────────────────────
  (2025, 1, 14, 'makar-sankranti'),
  (2025, 1, 26, 'republic-day'),
  (2025, 2, 2, 'vasant-panchami'),
  (2025, 2, 26, 'maha-shivaratri'),
  (2025, 3, 13, 'holika-dahan'),
  (2025, 3, 14, 'holi'),
  (2025, 3, 30, 'ugadi'),
  (2025, 3, 31, 'eid-ul-fitr'),
  (2025, 4, 6, 'ram-navami'),
  (2025, 4, 10, 'mahavir-jayanti'),
  (2025, 4, 13, 'baisakhi'),
  (2025, 4, 14, 'ambedkar-jayanti'),
  (2025, 4, 18, 'good-friday'),
  (2025, 5, 12, 'buddha-purnima'),
  (2025, 6, 7, 'eid-al-adha'),
  (2025, 7, 6, 'muharram'),
  (2025, 7, 10, 'guru-purnima'),
  (2025, 8, 9, 'raksha-bandhan'),
  (2025, 8, 15, 'independence-day'),
  (2025, 8, 16, 'janmashtami'),
  (2025, 8, 27, 'ganesh-chaturthi'),
  (2025, 9, 5, 'onam'),
  (2025, 9, 5, 'milad-un-nabi'),
  (2025, 9, 22, 'navratri'),
  (2025, 10, 2, 'gandhi-jayanti'),
  (2025, 10, 2, 'dussehra'),
  (2025, 10, 10, 'karwa-chauth'),
  (2025, 10, 18, 'dhanteras'),
  (2025, 10, 20, 'diwali'),
  (2025, 10, 22, 'govardhan-puja'),
  (2025, 10, 23, 'bhai-dooj'),
  (2025, 10, 27, 'chhath-puja'),
  (2025, 11, 5, 'guru-nanak-jayanti'),
  (2025, 12, 25, 'christmas'),
  // ── 2026 ────────────────────────────────────────────────────────────
  (2026, 1, 14, 'makar-sankranti'),
  (2026, 1, 23, 'vasant-panchami'),
  (2026, 1, 26, 'republic-day'),
  (2026, 2, 15, 'maha-shivaratri'),
  (2026, 3, 3, 'holika-dahan'),
  (2026, 3, 4, 'holi'),
  (2026, 3, 19, 'ugadi'),
  (2026, 3, 21, 'eid-ul-fitr'),
  (2026, 3, 26, 'ram-navami'),
  (2026, 3, 31, 'mahavir-jayanti'),
  (2026, 4, 3, 'good-friday'),
  (2026, 4, 14, 'baisakhi'),
  (2026, 4, 14, 'ambedkar-jayanti'),
  (2026, 5, 1, 'buddha-purnima'),
  (2026, 5, 27, 'eid-al-adha'),
  (2026, 6, 26, 'muharram'),
  (2026, 7, 29, 'guru-purnima'),
  (2026, 8, 15, 'independence-day'),
  (2026, 8, 26, 'onam'),
  (2026, 8, 26, 'milad-un-nabi'),
  (2026, 8, 28, 'raksha-bandhan'),
  (2026, 9, 4, 'janmashtami'),
  (2026, 9, 14, 'ganesh-chaturthi'),
  (2026, 10, 2, 'gandhi-jayanti'),
  (2026, 10, 11, 'navratri'),
  (2026, 10, 20, 'dussehra'),
  (2026, 10, 29, 'karwa-chauth'),
  (2026, 11, 6, 'dhanteras'),
  (2026, 11, 8, 'diwali'),
  (2026, 11, 10, 'govardhan-puja'),
  (2026, 11, 11, 'bhai-dooj'),
  (2026, 11, 15, 'chhath-puja'),
  (2026, 11, 24, 'guru-nanak-jayanti'),
  (2026, 12, 25, 'christmas'),
  // ── 2027 ────────────────────────────────────────────────────────────
  (2027, 1, 15, 'makar-sankranti'),
  (2027, 1, 26, 'republic-day'),
  (2027, 2, 11, 'vasant-panchami'),
  (2027, 3, 6, 'maha-shivaratri'),
  (2027, 3, 10, 'eid-ul-fitr'),
  (2027, 3, 21, 'holika-dahan'),
  (2027, 3, 22, 'holi'),
  (2027, 3, 26, 'good-friday'),
  (2027, 4, 7, 'ugadi'),
  (2027, 4, 14, 'baisakhi'),
  (2027, 4, 14, 'ambedkar-jayanti'),
  (2027, 4, 15, 'ram-navami'),
  (2027, 4, 20, 'mahavir-jayanti'),
  (2027, 5, 17, 'eid-al-adha'),
  (2027, 5, 20, 'buddha-purnima'),
  (2027, 6, 16, 'muharram'),
  (2027, 7, 18, 'guru-purnima'),
  (2027, 8, 15, 'independence-day'),
  (2027, 8, 15, 'milad-un-nabi'),
  (2027, 8, 17, 'raksha-bandhan'),
  (2027, 8, 25, 'janmashtami'),
  (2027, 9, 4, 'ganesh-chaturthi'),
  (2027, 9, 14, 'onam'),
  (2027, 9, 30, 'navratri'),
  (2027, 10, 2, 'gandhi-jayanti'),
  (2027, 10, 9, 'dussehra'),
  (2027, 10, 18, 'karwa-chauth'),
  (2027, 10, 26, 'dhanteras'),
  (2027, 10, 29, 'diwali'),
  (2027, 10, 30, 'govardhan-puja'),
  (2027, 10, 31, 'bhai-dooj'),
  (2027, 11, 4, 'chhath-puja'),
  (2027, 11, 14, 'guru-nanak-jayanti'),
  (2027, 12, 25, 'christmas'),
];
