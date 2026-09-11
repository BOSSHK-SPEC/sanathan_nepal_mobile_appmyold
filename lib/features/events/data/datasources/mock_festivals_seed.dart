import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';

/// Festival / public-holiday seed rows for [MockEventsSeed].
///
/// [bs] resolves a Bikram Sambat month/day to the next AD occurrence.
abstract final class MockFestivalsSeed {
  static List<Event> build(
    DateTime today,
    DateTime Function(DateTime, int, int) bs,
  ) => [
    Event(
      id: 'fst-ram-nawami',
      title: const LocalizedText(ne: 'राम नवमी', en: 'Ram Nawami'),
      description: const LocalizedText(
        ne:
            'जसका नूतनकमलदलतुल्य प्रसन्न नयन (दृष्टि) वामभागमा विराजमान श्री '
            'सीताजीका मुखकमलमा अडिएका छन्, उनै आजानुबाहु धनुषबाण धारण गर्नुभएका '
            'बद्धपद्मासनमा विराजमान श्रीरामचन्द्रको जन्मोत्सव चैत्र शुक्ल नवमीका '
            'दिन मनाइन्छ।',
        en:
            'Ram Nawami celebrates the birth of Lord Ram, the seventh avatar '
            'of Vishnu, on the ninth day of the bright fortnight of Chaitra. '
            'Devotees fast, sing bhajans and visit Ram temples.',
      ),
      date: bs(today, 12, 16),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isVrat: true,
      isImportant: true,
      tithi: const LocalizedText(
        ne: 'नवमी चैत्र शुक्लपक्ष',
        en: 'Nawami Chaitra Suklapaksha',
      ),
      howToCelebrate: const LocalizedText(
        ne:
            'भगवान रामको मूर्ति स्नान गराई पालनामा राख्नुहोस्, दीप प्रज्वलन '
            'गर्नुहोस्, रामायण पाठ र भजन कीर्तन गर्नुहोस् र दिनभर व्रत बस्नुहोस्।',
        en:
            'You can bathe and dress up miniature idols of Lord Ram and place '
            'them in a cradle to mark his birth. Light a lamp in front of the '
            'idol, recite the Ramayana, sing bhajans and observe a day-long fast.',
      ),
      attractionPlaces: const LocalizedText(
        ne:
            'जनकपुरको राम जानकी मन्दिर, बत्तीसपुतलीको राम मन्दिर, भक्तपुरको '
            'चाँगुनारायण र बूढानीलकण्ठमा भक्तजनको ठूलो भीड लाग्छ।',
        en:
            'Devotees visit Ram or Vishnu temples across Nepal. The Ram Janaki '
            'Temple in Janakpur is thronged by pilgrims; other important temples '
            'are Ram Mandir in Battisputali, Changu Narayan in Bhaktapur and '
            'Budhanilkantha.',
      ),
      imagePath: 'assets/images/events/ram_nawami.png',
      videoUrl: 'https://www.youtube.com/watch?v=ram-nawami',
    ),
    Event(
      id: 'fst-holi',
      title: const LocalizedText(
        ne: 'फागुपूर्णिमा (होली)',
        en: 'Fagu Purnima (Holi)',
      ),
      description: const LocalizedText(
        ne:
            'विभिन्न रङहरूका माध्यमबाट प्रेम, आत्मीयता र सद्भाव बर्साई संसारलाई हर्ष '
            'र उमङ्ग प्रदान गर्ने रमाइलो पर्व हो। कतै फागु त कतै होलिका उत्सवका '
            'रूपमा यो पर्व मनाइन्छ।',
        en:
            'The festival of colours spreads love, affection and harmony. '
            'Celebrated as Fagu in the hills and a day later in the Terai.',
      ),
      date: bs(today, 11, 15),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isImportant: true,
      tithi: const LocalizedText(
        ne: 'पूर्णिमा फागुन शुक्लपक्ष',
        en: 'Purnima Falgun Suklapaksha',
      ),
    ),
    Event(
      id: 'fst-holi-hills',
      title: const LocalizedText(ne: 'पहाडमा होली', en: 'Holi in the Hills'),
      description: const LocalizedText(
        ne:
            'काठमाडौँ उपत्यका र पहाडी जिल्लामा रङ खेलेर होली मनाइन्छ। ठूलो चीर '
            'गाड्ने परम्परा बसन्तपुरमा हुन्छ।',
        en:
            'Holi is celebrated in Kathmandu valley and the hilly districts a day '
            'before the Terai. The chir pole is erected at Basantapur.',
      ),
      date: bs(today, 11, 14),
      category: EventCategory.hinduFestival,
      isHoliday: true,
    ),
    Event(
      id: 'fst-janmashtami',
      title: const LocalizedText(
        ne: 'श्रीकृष्ण जन्माष्टमी',
        en: 'Krishna Janmashtami',
      ),
      description: const LocalizedText(
        ne:
            'भगवान श्रीकृष्णको जन्मदिन। भक्तजनले व्रत बसी मध्यरातमा कृष्ण जन्मको '
            'उत्सव मनाउँछन्।',
        en:
            'Birthday of Lord Krishna. Devotees fast all day and celebrate his '
            'birth at midnight in temples such as Patan Krishna Mandir.',
      ),
      date: bs(today, 5, 10),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isVrat: true,
      isImportant: true,
      tithi: const LocalizedText(
        ne: 'अष्टमी भाद्र कृष्णपक्ष',
        en: 'Ashtami Bhadra Krishnapaksha',
      ),
    ),
    Event(
      id: 'fst-teej',
      title: const LocalizedText(ne: 'हरितालिका तीज', en: 'Haritalika Teej'),
      description: const LocalizedText(
        ne:
            'महिलाहरूले पतिको दीर्घायु र सुख–समृद्धिका लागि निराहार व्रत बसी '
            'शिवजीको पूजा गर्ने पर्व।',
        en:
            'Women observe a strict fast and worship Lord Shiva for the well-being '
            'of their spouse, dressed in red and dancing to Teej songs.',
      ),
      date: bs(today, 5, 21),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isVrat: true,
      isImportant: true,
      tithi: const LocalizedText(
        ne: 'तृतीया भाद्र शुक्लपक्ष',
        en: 'Tritiya Bhadra Suklapaksha',
      ),
    ),
    Event(
      id: 'fst-indra-jatra',
      title: const LocalizedText(ne: 'इन्द्रजात्रा', en: 'Indra Jatra'),
      description: const LocalizedText(
        ne:
            'काठमाडौँको बसन्तपुरमा मनाइने आठ दिने जात्रा; कुमारी रथयात्रा र लाखे नाच '
            'यसका मुख्य आकर्षण हुन्।',
        en:
            'Eight-day festival of Kathmandu with the Kumari chariot procession, '
            'Lakhe dances and the raising of the Yosin pole at Basantapur.',
      ),
      date: bs(today, 6, 5),
      category: EventCategory.hinduFestival,
      isHoliday: true,
    ),
    Event(
      id: 'fst-ghatasthapana',
      title: const LocalizedText(ne: 'घटस्थापना', en: 'Ghatasthapana'),
      description: const LocalizedText(
        ne: 'बडा दशैंको पहिलो दिन। जमरा राखेर नवरात्रको सुरुवात गरिन्छ।',
        en: 'First day of Dashain – the sacred jamara is sown and Navaratri begins.',
      ),
      date: bs(today, 6, 25),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isImportant: true,
    ),
    Event(
      id: 'fst-dashami',
      title: const LocalizedText(ne: 'विजया दशमी', en: 'Vijaya Dashami'),
      description: const LocalizedText(
        ne: 'दशैंको मुख्य दिन। मान्यजनबाट टीका र जमरा ग्रहण गरी आशीर्वाद लिइन्छ।',
        en:
            'The main day of Dashain – elders put tika and jamara on the younger '
            'members of the family and bless them.',
      ),
      date: bs(today, 7, 3),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isImportant: true,
      tithi: const LocalizedText(
        ne: 'दशमी आश्विन शुक्लपक्ष',
        en: 'Dashami Ashwin Suklapaksha',
      ),
    ),
    Event(
      id: 'fst-laxmi-puja',
      title: const LocalizedText(ne: 'लक्ष्मी पूजा', en: 'Laxmi Puja'),
      description: const LocalizedText(
        ne: 'तिहारको तेस्रो दिन धनकी देवी लक्ष्मीको पूजा गरिन्छ; घर–घरमा दीप र भाइलो।',
        en:
            'Third day of Tihar dedicated to goddess Laxmi – houses glow with '
            'lamps and children sing Bhailo.',
      ),
      date: bs(today, 7, 24),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isImportant: true,
    ),
    Event(
      id: 'fst-chhath',
      title: const LocalizedText(ne: 'छठ पर्व', en: 'Chhath'),
      description: const LocalizedText(
        ne: 'सूर्य देवको आराधना गरिने चार दिने पर्व, विशेषगरी तराई–मधेशमा।',
        en:
            'Four-day festival of the Sun god, observed with great devotion in '
            'the Terai and at Kamal Pokhari, Kathmandu.',
      ),
      date: bs(today, 7, 30),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isVrat: true,
    ),
    Event(
      id: 'fst-maghe-sankranti',
      title: const LocalizedText(ne: 'माघे संक्रान्ति', en: 'Maghe Sankranti'),
      description: const LocalizedText(
        ne: 'माघ महिनाको पहिलो दिन; तिल, चाकु, घिउ र तरुल खाने चलन छ।',
        en: 'First day of Magh – families eat sesame sweets, chaku, ghee and yams.',
      ),
      date: bs(today, 10, 1),
      category: EventCategory.hinduFestival,
      isHoliday: true,
    ),
    Event(
      id: 'fst-shivaratri',
      title: const LocalizedText(ne: 'महाशिवरात्रि', en: 'Maha Shivaratri'),
      description: const LocalizedText(
        ne: 'भगवान शिवको महान् रात्रि; पशुपतिनाथमा लाखौं भक्तजनको उपस्थिति हुन्छ।',
        en:
            'The great night of Shiva – hundreds of thousands of devotees gather '
            'at Pashupatinath.',
      ),
      date: bs(today, 11, 3),
      category: EventCategory.hinduFestival,
      isHoliday: true,
      isVrat: true,
      isImportant: true,
    ),
    Event(
      id: 'fst-buddha-jayanti',
      title: const LocalizedText(ne: 'बुद्ध जयन्ती', en: 'Buddha Jayanti'),
      description: const LocalizedText(
        ne:
            'गौतम बुद्धको जन्म, बुद्धत्व र महापरिनिर्वाणको स्मरण; लुम्बिनी र '
            'स्वयम्भूमा विशेष पूजा।',
        en:
            'Commemorates the birth, enlightenment and passing of Gautam Buddha; '
            'special prayers at Lumbini and Swayambhu.',
      ),
      date: bs(today, 2, 5),
      category: EventCategory.buddhistFestival,
      isHoliday: true,
      isImportant: true,
    ),
    Event(
      id: 'fst-lhosar',
      title: const LocalizedText(ne: 'सोनाम ल्होसार', en: 'Sonam Lhosar'),
      description: const LocalizedText(
        ne: 'तामाङ समुदायको नयाँ वर्ष।',
        en: 'New year of the Tamang community.',
      ),
      date: bs(today, 10, 17),
      category: EventCategory.buddhistFestival,
      isHoliday: true,
    ),
    Event(
      id: 'fst-eid',
      title: const LocalizedText(ne: 'ईद उल फित्र', en: 'Eid ul-Fitr'),
      description: const LocalizedText(
        ne: 'रमजानको समाप्तिमा मुस्लिम समुदायले मनाउने पर्व।',
        en: 'Marks the end of Ramadan for the Muslim community.',
      ),
      date: bs(today, 12, 7),
      category: EventCategory.islamicFestival,
      isHoliday: true,
    ),
    Event(
      id: 'fst-udhauli',
      title: const LocalizedText(ne: 'उधौली पर्व', en: 'Udhauli'),
      description: const LocalizedText(
        ne: 'किराँत समुदायको बाली भित्र्याएपछि मनाइने पर्व; साकेला नाच।',
        en: 'Kirat harvest festival celebrated with the Sakela dance.',
      ),
      date: bs(today, 8, 29),
      category: EventCategory.kiratFestival,
      isHoliday: true,
    ),
    Event(
      id: 'fst-christmas',
      title: const LocalizedText(ne: 'क्रिसमस', en: 'Christmas'),
      description: const LocalizedText(
        ne: 'येशू ख्रीष्टको जन्मोत्सव।',
        en: 'Celebration of the birth of Jesus Christ.',
      ),
      date: bs(today, 9, 10),
      category: EventCategory.christianFestival,
      isHoliday: true,
    ),
    Event(
      id: 'fst-loktantra',
      title: const LocalizedText(ne: 'लोकतन्त्र दिवस', en: 'Democracy Day'),
      description: const LocalizedText(
        ne: '२०६३ सालको जनआन्दोलनको सफलताको सम्झनामा मनाइने राष्ट्रिय दिवस।',
        en: 'National day commemorating the success of the 2006 People\'s Movement.',
      ),
      date: bs(today, 1, 11),
      category: EventCategory.publicHoliday,
      isHoliday: true,
    ),
    Event(
      id: 'fst-ganatantra',
      title: const LocalizedText(ne: 'गणतन्त्र दिवस', en: 'Republic Day'),
      description: const LocalizedText(
        ne: 'नेपाल संघीय लोकतान्त्रिक गणतन्त्र घोषणा भएको दिन।',
        en: 'The day Nepal was declared a Federal Democratic Republic.',
      ),
      date: bs(today, 2, 15),
      category: EventCategory.publicHoliday,
      isHoliday: true,
    ),
    Event(
      id: 'fst-constitution',
      title: const LocalizedText(ne: 'संविधान दिवस', en: 'Constitution Day'),
      description: const LocalizedText(
        ne: 'नेपालको संविधान जारी भएको दिन।',
        en: 'Anniversary of the promulgation of the Constitution of Nepal.',
      ),
      date: bs(today, 6, 3),
      category: EventCategory.publicHoliday,
      isHoliday: true,
    ),
  ];
}
