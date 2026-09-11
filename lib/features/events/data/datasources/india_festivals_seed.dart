import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';

/// Indian national holidays and major Hindu / Sikh / Muslim / Christian /
/// Jain / Buddhist festivals for 2025–2027 (Gregorian dates as per the
/// Government of India gazetted / restricted holiday lists and standard
/// panchang tables). Each row resolves to the next occurrence on/after
/// `today` (or the last known one).
///
/// Selected by `MockEventsSeed` when the active region is India. The calendar
/// feature keeps its own month-grid festival seed – dedupe later if desired.
abstract final class IndiaFestivalsSeed {
  static List<Event> build(DateTime today) => [
    for (final f in _rows)
      Event(
        id: 'in-${f.id}',
        title: _t(f.en, f.hi),
        description: _t(f.descEn, f.descHi),
        date: _next(today, f.dates),
        category: f.category,
        isHoliday: f.holiday,
        isImportant: f.important,
        isVrat: f.vrat,
        tithi: f.tithiEn == null
            ? LocalizedText.empty
            : _t(f.tithiEn!, f.tithiHi ?? f.tithiEn!),
        howToCelebrate: f.howEn == null
            ? LocalizedText.empty
            : _t(f.howEn!, f.howHi ?? f.howEn!),
        attractionPlaces: f.placesEn == null
            ? LocalizedText.empty
            : _t(f.placesEn!, f.placesHi ?? f.placesEn!),
      ),
  ];

  /// Hindi text doubles as the Nepali (Devanagari) variant – the India seed
  /// is only shown when the region is India (languages: en / hi).
  static LocalizedText _t(String en, String hi) =>
      LocalizedText(ne: hi, en: en, hi: hi);

  static DateTime _next(DateTime today, List<DateTime> dates) {
    for (final d in dates) {
      if (!d.isBefore(today)) return d;
    }
    return dates.last;
  }

  static DateTime _d(int y, int m, int d) => DateTime(y, m, d);

  static final List<_Row> _rows = [
    // ------------------------------------------------ national / public
    _Row(
      id: 'new-year',
      en: "New Year's Day",
      hi: 'नव वर्ष',
      category: EventCategory.publicHoliday,
      dates: [_d(2025, 1, 1), _d(2026, 1, 1), _d(2027, 1, 1)],
      descEn: 'First day of the Gregorian year – a restricted holiday.',
      descHi: 'ग्रेगोरियन वर्ष का पहला दिन – प्रतिबंधित अवकाश।',
    ),
    _Row(
      id: 'republic-day',
      en: 'Republic Day',
      hi: 'गणतंत्र दिवस',
      category: EventCategory.publicHoliday,
      holiday: true,
      important: true,
      dates: [_d(2025, 1, 26), _d(2026, 1, 26), _d(2027, 1, 26)],
      descEn:
          'Commemorates the adoption of the Constitution of India in 1950. '
          'The Republic Day parade is held on Kartavya Path, New Delhi.',
      descHi:
          '1950 में भारत के संविधान को अपनाने की स्मृति में मनाया जाता है। '
          'नई दिल्ली के कर्तव्य पथ पर परेड होती है।',
      placesEn: 'Kartavya Path and India Gate, New Delhi.',
      placesHi: 'कर्तव्य पथ और इंडिया गेट, नई दिल्ली।',
    ),
    _Row(
      id: 'ambedkar-jayanti',
      en: 'Ambedkar Jayanti',
      hi: 'अम्बेडकर जयंती',
      category: EventCategory.publicHoliday,
      holiday: true,
      dates: [_d(2025, 4, 14), _d(2026, 4, 14), _d(2027, 4, 14)],
      descEn:
          'Birth anniversary of Dr. B. R. Ambedkar, chief architect of the '
          'Indian Constitution.',
      descHi: 'भारतीय संविधान के मुख्य शिल्पकार डॉ. भीमराव अम्बेडकर की जयंती।',
    ),
    _Row(
      id: 'independence-day',
      en: 'Independence Day',
      hi: 'स्वतंत्रता दिवस',
      category: EventCategory.publicHoliday,
      holiday: true,
      important: true,
      dates: [_d(2025, 8, 15), _d(2026, 8, 15), _d(2027, 8, 15)],
      descEn:
          "Marks India's independence from British rule in 1947. The Prime "
          'Minister hoists the national flag at the Red Fort.',
      descHi:
          '1947 में ब्रिटिश शासन से भारत की स्वतंत्रता का प्रतीक। प्रधानमंत्री '
          'लाल किले पर तिरंगा फहराते हैं।',
      placesEn: 'Red Fort, Delhi.',
      placesHi: 'लाल किला, दिल्ली।',
    ),
    _Row(
      id: 'gandhi-jayanti',
      en: 'Gandhi Jayanti',
      hi: 'गांधी जयंती',
      category: EventCategory.publicHoliday,
      holiday: true,
      important: true,
      dates: [_d(2025, 10, 2), _d(2026, 10, 2), _d(2027, 10, 2)],
      descEn:
          'Birth anniversary of Mahatma Gandhi, observed worldwide as the '
          'International Day of Non-Violence.',
      descHi:
          'महात्मा गांधी की जयंती, जिसे विश्व भर में अंतर्राष्ट्रीय अहिंसा '
          'दिवस के रूप में मनाया जाता है।',
      placesEn: 'Raj Ghat, New Delhi.',
      placesHi: 'राजघाट, नई दिल्ली।',
    ),
    // ------------------------------------------------------------ hindu
    _Row(
      id: 'lohri',
      en: 'Lohri',
      hi: 'लोहड़ी',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 1, 13), _d(2026, 1, 13), _d(2027, 1, 13)],
      descEn:
          'Punjabi winter harvest festival with bonfires, folk songs and '
          'the first celebration for newly-weds and newborns.',
      descHi: 'अलाव, लोकगीतों और रबी की फसल के स्वागत का पंजाबी पर्व।',
    ),
    _Row(
      id: 'makar-sankranti',
      en: 'Makar Sankranti / Pongal',
      hi: 'मकर संक्रांति / पोंगल',
      category: EventCategory.hinduFestival,
      important: true,
      dates: [_d(2025, 1, 14), _d(2026, 1, 14), _d(2027, 1, 15)],
      descEn:
          "The Sun's transit into Capricorn – kite flying, til-gud sweets, "
          'holy dips and Pongal in the south.',
      descHi:
          'सूर्य का मकर राशि में प्रवेश – पतंगबाज़ी, तिल-गुड़, पवित्र स्नान '
          'और दक्षिण भारत में पोंगल।',
      howEn:
          'Take a holy dip, donate sesame and jaggery, fly kites and share '
          'khichdi with family.',
      howHi:
          'पवित्र स्नान करें, तिल-गुड़ का दान करें, पतंग उड़ाएँ और परिवार के '
          'साथ खिचड़ी बाँटें।',
      placesEn: 'Gangasagar (West Bengal), Prayagraj, Ahmedabad kite festival.',
      placesHi: 'गंगासागर (पश्चिम बंगाल), प्रयागराज, अहमदाबाद पतंग महोत्सव।',
    ),
    _Row(
      id: 'vasant-panchami',
      en: 'Vasant Panchami',
      hi: 'वसंत पंचमी',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 2, 2), _d(2026, 1, 23), _d(2027, 2, 11)],
      tithiEn: 'Panchami, Magha Shukla Paksha',
      tithiHi: 'पंचमी, माघ शुक्ल पक्ष',
      descEn:
          'Worship of Goddess Saraswati and the arrival of spring; yellow '
          'clothes and sweets mark the day.',
      descHi:
          'माँ सरस्वती की पूजा और बसंत ऋतु के आगमन का पर्व; पीले वस्त्र और '
          'मीठे पकवान इस दिन की पहचान हैं।',
    ),
    _Row(
      id: 'maha-shivaratri',
      en: 'Maha Shivaratri',
      hi: 'महाशिवरात्रि',
      category: EventCategory.hinduFestival,
      holiday: true,
      important: true,
      vrat: true,
      dates: [_d(2025, 2, 26), _d(2026, 2, 15), _d(2027, 3, 6)],
      tithiEn: 'Chaturdashi, Phalguna Krishna Paksha',
      tithiHi: 'चतुर्दशी, फाल्गुन कृष्ण पक्ष',
      descEn:
          'The great night of Lord Shiva – night-long vigil, fasting and '
          'abhishek of the Shivalinga.',
      descHi:
          'भगवान शिव की महारात्रि – रात्रि जागरण, व्रत और शिवलिंग का अभिषेक।',
      howEn:
          'Fast through the day, offer bel leaves, milk and water on the '
          'Shivalinga and chant "Om Namah Shivaya" during the four prahars.',
      howHi:
          'दिन भर व्रत रखें, शिवलिंग पर बेलपत्र, दूध और जल अर्पित करें और चारों '
          'प्रहर "ॐ नमः शिवाय" का जाप करें।',
      placesEn:
          'Kashi Vishwanath (Varanasi), Somnath, Ujjain Mahakaleshwar, '
          'Isha Yoga Center (Coimbatore).',
      placesHi:
          'काशी विश्वनाथ (वाराणसी), सोमनाथ, उज्जैन महाकालेश्वर, ईशा योग '
          'केंद्र (कोयंबटूर)।',
    ),
    _Row(
      id: 'holi',
      en: 'Holi',
      hi: 'होली',
      category: EventCategory.hinduFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 3, 14), _d(2026, 3, 4), _d(2027, 3, 22)],
      tithiEn: 'Pratipada, Chaitra Krishna Paksha (day after Holika Dahan)',
      tithiHi: 'प्रतिपदा, चैत्र कृष्ण पक्ष (होलिका दहन के अगले दिन)',
      descEn:
          'The festival of colours celebrating the victory of good over '
          'evil and the arrival of spring.',
      descHi:
          'रंगों का त्योहार – बुराई पर अच्छाई की जीत और बसंत के आगमन का उत्सव।',
      howEn:
          'Light the Holika bonfire on the eve, then play with gulal and '
          'water, share gujiya and thandai with friends and family.',
      howHi:
          'पूर्व संध्या पर होलिका दहन करें, फिर गुलाल और रंगों से खेलें, गुजिया '
          'और ठंडाई परिवार व मित्रों के साथ बाँटें।',
      placesEn: 'Mathura–Vrindavan (Lathmar Holi), Barsana, Shantiniketan.',
      placesHi: 'मथुरा–वृंदावन (लट्ठमार होली), बरसाना, शांतिनिकेतन।',
    ),
    _Row(
      id: 'ugadi',
      en: 'Ugadi / Gudi Padwa',
      hi: 'उगादि / गुड़ी पड़वा',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 3, 30), _d(2026, 3, 19), _d(2027, 4, 7)],
      tithiEn: 'Pratipada, Chaitra Shukla Paksha',
      tithiHi: 'प्रतिपदा, चैत्र शुक्ल पक्ष',
      descEn:
          'Lunar new year of Andhra, Telangana, Karnataka (Ugadi) and '
          'Maharashtra (Gudi Padwa); also Chaitra Navratri begins.',
      descHi:
          'आंध्र, तेलंगाना, कर्नाटक (उगादि) और महाराष्ट्र (गुड़ी पड़वा) का '
          'नववर्ष; चैत्र नवरात्रि का आरंभ।',
    ),
    _Row(
      id: 'ram-navami',
      en: 'Ram Navami',
      hi: 'राम नवमी',
      category: EventCategory.hinduFestival,
      holiday: true,
      important: true,
      vrat: true,
      dates: [_d(2025, 4, 6), _d(2026, 3, 26), _d(2027, 4, 15)],
      tithiEn: 'Navami, Chaitra Shukla Paksha',
      tithiHi: 'नवमी, चैत्र शुक्ल पक्ष',
      descEn:
          'Birth of Lord Rama, seventh avatar of Vishnu. Devotees fast, '
          'recite the Ramcharitmanas and visit Ram temples.',
      descHi:
          'भगवान विष्णु के सातवें अवतार श्रीराम का जन्मोत्सव। भक्त व्रत रखते '
          'हैं, रामचरितमानस का पाठ करते हैं और राम मंदिर जाते हैं।',
      howEn:
          'Bathe the idol of baby Rama, place it in a cradle, sing bhajans, '
          'read the Ramayana and observe a day-long fast.',
      howHi:
          'बाल राम की मूर्ति को स्नान कराकर पालने में रखें, भजन गाएँ, रामायण '
          'पढ़ें और दिन भर व्रत रखें।',
      placesEn: 'Ram Mandir, Ayodhya; Bhadrachalam; Sitamarhi.',
      placesHi: 'राम मंदिर, अयोध्या; भद्राचलम; सीतामढ़ी।',
    ),
    _Row(
      id: 'akshaya-tritiya',
      en: 'Akshaya Tritiya',
      hi: 'अक्षय तृतीया',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 4, 30), _d(2026, 4, 19), _d(2027, 5, 8)],
      tithiEn: 'Tritiya, Vaishakha Shukla Paksha',
      tithiHi: 'तृतीया, वैशाख शुक्ल पक्ष',
      descEn:
          'An eternally auspicious day for new beginnings, charity and '
          'buying gold.',
      descHi: 'नई शुरुआत, दान और स्वर्ण खरीद के लिए अक्षय पुण्य वाला शुभ दिन।',
    ),
    _Row(
      id: 'rath-yatra',
      en: 'Jagannath Rath Yatra',
      hi: 'जगन्नाथ रथ यात्रा',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 6, 27), _d(2026, 7, 16), _d(2027, 7, 5)],
      tithiEn: 'Dwitiya, Ashadha Shukla Paksha',
      tithiHi: 'द्वितीया, आषाढ़ शुक्ल पक्ष',
      descEn:
          'The chariot festival of Lord Jagannath, Balabhadra and Subhadra '
          'from the Puri temple to Gundicha temple.',
      descHi:
          'भगवान जगन्नाथ, बलभद्र और सुभद्रा की पुरी मंदिर से गुंडिचा मंदिर '
          'तक की रथ यात्रा।',
      placesEn: 'Puri (Odisha), Ahmedabad.',
      placesHi: 'पुरी (ओडिशा), अहमदाबाद।',
    ),
    _Row(
      id: 'guru-purnima',
      en: 'Guru Purnima',
      hi: 'गुरु पूर्णिमा',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 7, 10), _d(2026, 7, 29), _d(2027, 7, 18)],
      tithiEn: 'Purnima, Ashadha Shukla Paksha',
      tithiHi: 'पूर्णिमा, आषाढ़ शुक्ल पक्ष',
      descEn:
          'Day of reverence to teachers and gurus; birth anniversary of '
          'Maharshi Veda Vyasa.',
      descHi: 'गुरुजनों के प्रति श्रद्धा का दिन; महर्षि वेदव्यास की जयंती।',
    ),
    _Row(
      id: 'nag-panchami',
      en: 'Nag Panchami',
      hi: 'नाग पंचमी',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 7, 29), _d(2026, 8, 17), _d(2027, 8, 6)],
      tithiEn: 'Panchami, Shravana Shukla Paksha',
      tithiHi: 'पंचमी, श्रावण शुक्ल पक्ष',
      descEn: 'Worship of the serpent deities with milk and flowers.',
      descHi: 'नाग देवता की दूध और पुष्प से पूजा।',
    ),
    _Row(
      id: 'raksha-bandhan',
      en: 'Raksha Bandhan',
      hi: 'रक्षा बंधन',
      category: EventCategory.hinduFestival,
      important: true,
      dates: [_d(2025, 8, 9), _d(2026, 8, 28), _d(2027, 8, 17)],
      tithiEn: 'Purnima, Shravana Shukla Paksha',
      tithiHi: 'पूर्णिमा, श्रावण शुक्ल पक्ष',
      descEn:
          'Sisters tie a rakhi on their brothers\' wrists as a bond of '
          'love and protection.',
      descHi:
          'बहनें भाइयों की कलाई पर राखी बाँधकर स्नेह और रक्षा का बंधन '
          'निभाती हैं।',
      howEn:
          'Tie the rakhi during the Aparahna muhurat (avoid Bhadra), '
          'apply tilak, share sweets and exchange gifts.',
      howHi:
          'अपराह्न मुहूर्त में (भद्रा से बचकर) राखी बाँधें, तिलक करें, मिठाई '
          'खिलाएँ और उपहार दें।',
    ),
    _Row(
      id: 'janmashtami',
      en: 'Krishna Janmashtami',
      hi: 'कृष्ण जन्माष्टमी',
      category: EventCategory.hinduFestival,
      holiday: true,
      important: true,
      vrat: true,
      dates: [_d(2025, 8, 16), _d(2026, 9, 4), _d(2027, 8, 25)],
      tithiEn: 'Ashtami, Bhadrapada Krishna Paksha',
      tithiHi: 'अष्टमी, भाद्रपद कृष्ण पक्ष',
      descEn: 'Birth of Lord Krishna – midnight puja, jhanki and dahi-handi.',
      descHi:
          'भगवान श्रीकृष्ण का जन्मोत्सव – मध्यरात्रि पूजा, झाँकी और दही-हांडी।',
      howEn:
          'Fast till midnight, decorate a cradle for Bal Gopal, sing '
          'bhajans and break the fast after the midnight birth ceremony.',
      howHi:
          'मध्यरात्रि तक व्रत रखें, बाल गोपाल का पालना सजाएँ, भजन गाएँ और '
          'जन्मोत्सव के बाद व्रत खोलें।',
      placesEn:
          'Mathura, Vrindavan, Dwarka, ISKCON temples; dahi-handi in '
          'Mumbai.',
      placesHi: 'मथुरा, वृंदावन, द्वारका, इस्कॉन मंदिर; मुंबई की दही-हांडी।',
    ),
    _Row(
      id: 'hartalika-teej',
      en: 'Hartalika Teej',
      hi: 'हरतालिका तीज',
      category: EventCategory.hinduFestival,
      vrat: true,
      dates: [_d(2025, 8, 26), _d(2026, 9, 13), _d(2027, 9, 3)],
      tithiEn: 'Tritiya, Bhadrapada Shukla Paksha',
      tithiHi: 'तृतीया, भाद्रपद शुक्ल पक्ष',
      descEn:
          'Women observe a nirjala fast and worship Shiva–Parvati for '
          'marital bliss.',
      descHi: 'सुहागिनें निर्जला व्रत रखकर शिव-पार्वती की पूजा करती हैं।',
    ),
    _Row(
      id: 'ganesh-chaturthi',
      en: 'Ganesh Chaturthi',
      hi: 'गणेश चतुर्थी',
      category: EventCategory.hinduFestival,
      important: true,
      dates: [_d(2025, 8, 27), _d(2026, 9, 14), _d(2027, 9, 4)],
      tithiEn: 'Chaturthi, Bhadrapada Shukla Paksha',
      tithiHi: 'चतुर्थी, भाद्रपद शुक्ल पक्ष',
      descEn:
          'Ten-day festival welcoming Lord Ganesha with clay idols, modak '
          'and the grand visarjan.',
      descHi:
          'मिट्टी की प्रतिमाओं, मोदक और भव्य विसर्जन के साथ गणपति बप्पा का '
          'दस दिवसीय उत्सव।',
      placesEn: 'Lalbaugcha Raja (Mumbai), Pune, Hyderabad.',
      placesHi: 'लालबागचा राजा (मुंबई), पुणे, हैदराबाद।',
    ),
    _Row(
      id: 'onam',
      en: 'Onam (Thiruvonam)',
      hi: 'ओणम (तिरुवोणम)',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 9, 5), _d(2026, 8, 26), _d(2027, 9, 14)],
      descEn:
          'Kerala harvest festival honouring King Mahabali – pookalam, '
          'Onasadya and snake-boat races.',
      descHi:
          'राजा महाबली के स्वागत में केरल का फसल उत्सव – पूकलम, ओणसद्या और '
          'नौका दौड़।',
    ),
    _Row(
      id: 'navratri',
      en: 'Sharad Navratri begins',
      hi: 'शारदीय नवरात्रि आरंभ',
      category: EventCategory.hinduFestival,
      important: true,
      vrat: true,
      dates: [_d(2025, 9, 22), _d(2026, 10, 11), _d(2027, 9, 30)],
      tithiEn: 'Pratipada, Ashwin Shukla Paksha',
      tithiHi: 'प्रतिपदा, आश्विन शुक्ल पक्ष',
      descEn:
          'Nine nights of Goddess Durga worship – Ghatasthapana, garba and '
          'dandiya.',
      descHi: 'माँ दुर्गा की नौ रात्रियाँ – घटस्थापना, गरबा और डांडिया।',
    ),
    _Row(
      id: 'durga-ashtami',
      en: 'Durga Ashtami',
      hi: 'दुर्गा अष्टमी',
      category: EventCategory.hinduFestival,
      vrat: true,
      dates: [_d(2025, 9, 30), _d(2026, 10, 19), _d(2027, 10, 7)],
      tithiEn: 'Ashtami, Ashwin Shukla Paksha',
      tithiHi: 'अष्टमी, आश्विन शुक्ल पक्ष',
      descEn: 'Maha Ashtami of Durga Puja – kanya pujan and sandhi puja.',
      descHi: 'दुर्गा पूजा की महाअष्टमी – कन्या पूजन और संधि पूजा।',
      placesEn: 'Kolkata pandals, Kamakhya (Guwahati), Vaishno Devi.',
      placesHi: 'कोलकाता के पंडाल, कामाख्या (गुवाहाटी), वैष्णो देवी।',
    ),
    _Row(
      id: 'dussehra',
      en: 'Dussehra / Vijayadashami',
      hi: 'दशहरा / विजयादशमी',
      category: EventCategory.hinduFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 10, 2), _d(2026, 10, 20), _d(2027, 10, 9)],
      tithiEn: 'Dashami, Ashwin Shukla Paksha',
      tithiHi: 'दशमी, आश्विन शुक्ल पक्ष',
      descEn:
          'Victory of Rama over Ravana and of Durga over Mahishasura – '
          'Ravan Dahan and Ramlila.',
      descHi:
          'रावण पर राम और महिषासुर पर दुर्गा की विजय – रावण दहन और रामलीला।',
      placesEn: 'Mysuru Dasara, Kullu Dussehra, Ramlila Maidan (Delhi).',
      placesHi: 'मैसूर दशहरा, कुल्लू दशहरा, रामलीला मैदान (दिल्ली)।',
    ),
    _Row(
      id: 'karva-chauth',
      en: 'Karva Chauth',
      hi: 'करवा चौथ',
      category: EventCategory.hinduFestival,
      vrat: true,
      dates: [_d(2025, 10, 10), _d(2026, 10, 29), _d(2027, 10, 18)],
      tithiEn: 'Chaturthi, Kartika Krishna Paksha',
      tithiHi: 'चतुर्थी, कार्तिक कृष्ण पक्ष',
      descEn:
          'Married women fast from sunrise to moonrise for the long life '
          'of their husbands.',
      descHi:
          'सुहागिनें पति की दीर्घायु के लिए सूर्योदय से चंद्रोदय तक व्रत रखती '
          'हैं।',
    ),
    _Row(
      id: 'dhanteras',
      en: 'Dhanteras',
      hi: 'धनतेरस',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 10, 18), _d(2026, 11, 6), _d(2027, 10, 27)],
      tithiEn: 'Trayodashi, Kartika Krishna Paksha',
      tithiHi: 'त्रयोदशी, कार्तिक कृष्ण पक्ष',
      descEn:
          'First day of Diwali – worship of Dhanvantari and Kubera; buying '
          'gold, silver and utensils.',
      descHi:
          'दीपावली का पहला दिन – धन्वंतरि और कुबेर की पूजा; सोना-चाँदी और '
          'बर्तन खरीदने की परंपरा।',
    ),
    _Row(
      id: 'diwali',
      en: 'Diwali (Deepavali)',
      hi: 'दीपावली',
      category: EventCategory.hinduFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 10, 20), _d(2026, 11, 8), _d(2027, 10, 29)],
      tithiEn: 'Amavasya, Kartika Krishna Paksha',
      tithiHi: 'अमावस्या, कार्तिक कृष्ण पक्ष',
      descEn:
          'The festival of lights – Lakshmi–Ganesh puja, diyas, rangoli '
          'and sweets celebrating the return of Rama to Ayodhya.',
      descHi:
          'प्रकाश का पर्व – लक्ष्मी-गणेश पूजन, दीये, रंगोली और मिठाइयाँ; '
          'श्रीराम के अयोध्या लौटने का उत्सव।',
      howEn:
          'Clean and decorate the home, draw rangoli, perform Lakshmi puja '
          'in the Pradosh muhurat and light diyas at every doorway.',
      howHi:
          'घर की सफाई और सजावट करें, रंगोली बनाएँ, प्रदोष काल में लक्ष्मी पूजन '
          'करें और हर द्वार पर दीये जलाएँ।',
      placesEn:
          'Ayodhya Deepotsav, Varanasi ghats, Jaipur markets, Amritsar '
          'Golden Temple.',
      placesHi:
          'अयोध्या दीपोत्सव, वाराणसी के घाट, जयपुर के बाज़ार, अमृतसर '
          'स्वर्ण मंदिर।',
    ),
    _Row(
      id: 'chhath',
      en: 'Chhath Puja',
      hi: 'छठ पूजा',
      category: EventCategory.hinduFestival,
      important: true,
      vrat: true,
      dates: [_d(2025, 10, 27), _d(2026, 11, 15), _d(2027, 11, 4)],
      tithiEn: 'Shashthi, Kartika Shukla Paksha',
      tithiHi: 'षष्ठी, कार्तिक शुक्ल पक्ष',
      descEn:
          'Four-day worship of the Sun god and Chhathi Maiya with arghya '
          'at sunset and sunrise – Bihar, Jharkhand and eastern UP.',
      descHi:
          'सूर्य देव और छठी मैया की चार दिवसीय उपासना – अस्ताचल और उदयाचल '
          'सूर्य को अर्घ्य; बिहार, झारखंड और पूर्वी उत्तर प्रदेश।',
      placesEn: 'Patna Ganga ghats, Deo Sun Temple (Aurangabad, Bihar).',
      placesHi: 'पटना के गंगा घाट, देव सूर्य मंदिर (औरंगाबाद, बिहार)।',
    ),
    _Row(
      id: 'kartik-purnima',
      en: 'Kartik Purnima / Dev Deepawali',
      hi: 'कार्तिक पूर्णिमा / देव दीपावली',
      category: EventCategory.hinduFestival,
      dates: [_d(2025, 11, 5), _d(2026, 11, 24), _d(2027, 11, 14)],
      tithiEn: 'Purnima, Kartika Shukla Paksha',
      tithiHi: 'पूर्णिमा, कार्तिक शुक्ल पक्ष',
      descEn:
          'Holy dip in the Ganga; the ghats of Varanasi are lit with lakhs '
          'of lamps for Dev Deepawali.',
      descHi:
          'गंगा स्नान; देव दीपावली पर वाराणसी के घाट लाखों दीयों से जगमगाते '
          'हैं।',
      placesEn: 'Varanasi, Pushkar fair.',
      placesHi: 'वाराणसी, पुष्कर मेला।',
    ),
    // ------------------------------------------------------------- sikh
    _Row(
      id: 'baisakhi',
      en: 'Baisakhi',
      hi: 'बैसाखी',
      category: EventCategory.sikhFestival,
      important: true,
      dates: [_d(2025, 4, 13), _d(2026, 4, 14), _d(2027, 4, 14)],
      descEn:
          'Punjabi harvest new year and the founding of the Khalsa by '
          'Guru Gobind Singh in 1699.',
      descHi:
          'पंजाब का फसल नववर्ष और 1699 में गुरु गोबिंद सिंह द्वारा खालसा '
          'पंथ की स्थापना।',
      placesEn: 'Golden Temple (Amritsar), Anandpur Sahib.',
      placesHi: 'स्वर्ण मंदिर (अमृतसर), आनंदपुर साहिब।',
    ),
    _Row(
      id: 'guru-nanak-jayanti',
      en: 'Guru Nanak Jayanti',
      hi: 'गुरु नानक जयंती',
      category: EventCategory.sikhFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 11, 5), _d(2026, 11, 24), _d(2027, 11, 14)],
      tithiEn: 'Purnima, Kartika Shukla Paksha',
      tithiHi: 'पूर्णिमा, कार्तिक शुक्ल पक्ष',
      descEn:
          'Prakash Utsav – birth anniversary of Guru Nanak Dev Ji, the '
          'first Sikh Guru; nagar kirtan and langar.',
      descHi:
          'प्रकाश उत्सव – प्रथम सिख गुरु, गुरु नानक देव जी की जयंती; नगर '
          'कीर्तन और लंगर।',
      placesEn:
          'Golden Temple (Amritsar), Nankana Sahib, Gurdwara Bangla '
          'Sahib (Delhi).',
      placesHi:
          'स्वर्ण मंदिर (अमृतसर), ननकाना साहिब, गुरुद्वारा बंगला साहिब '
          '(दिल्ली)।',
    ),
    // ----------------------------------------------------------- muslim
    _Row(
      id: 'eid-ul-fitr',
      en: 'Eid ul-Fitr',
      hi: 'ईद-उल-फ़ित्र',
      category: EventCategory.islamicFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 3, 31), _d(2026, 3, 20), _d(2027, 3, 10)],
      descEn:
          'Festival marking the end of Ramadan; date depends on the '
          'sighting of the moon.',
      descHi: 'रमज़ान के समापन का त्योहार; तिथि चाँद दिखने पर निर्भर करती है।',
    ),
    _Row(
      id: 'eid-ul-adha',
      en: 'Eid ul-Adha (Bakrid)',
      hi: 'ईद-उल-अज़हा (बकरीद)',
      category: EventCategory.islamicFestival,
      holiday: true,
      dates: [_d(2025, 6, 7), _d(2026, 5, 27), _d(2027, 5, 16)],
      descEn:
          'Festival of sacrifice commemorating Prophet Ibrahim; date '
          'depends on the sighting of the moon.',
      descHi:
          'हज़रत इब्राहीम की कुर्बानी की याद का पर्व; तिथि चाँद दिखने पर '
          'निर्भर करती है।',
    ),
    _Row(
      id: 'muharram',
      en: 'Muharram (Ashura)',
      hi: 'मुहर्रम (आशूरा)',
      category: EventCategory.islamicFestival,
      holiday: true,
      dates: [_d(2025, 7, 6), _d(2026, 6, 26), _d(2027, 6, 15)],
      descEn:
          'Tenth day of Muharram, mourning the martyrdom of Imam Hussain '
          'at Karbala.',
      descHi: 'मुहर्रम का दसवाँ दिन – कर्बला में इमाम हुसैन की शहादत की याद।',
    ),
    _Row(
      id: 'milad-un-nabi',
      en: 'Milad-un-Nabi',
      hi: 'मिलाद-उन-नबी',
      category: EventCategory.islamicFestival,
      holiday: true,
      dates: [_d(2025, 9, 5), _d(2026, 8, 26), _d(2027, 8, 15)],
      descEn: 'Birth anniversary of Prophet Muhammad.',
      descHi: 'पैगंबर मुहम्मद साहब का जन्मदिन।',
    ),
    // -------------------------------------------------------- christian
    _Row(
      id: 'good-friday',
      en: 'Good Friday',
      hi: 'गुड फ्राइडे',
      category: EventCategory.christianFestival,
      holiday: true,
      dates: [_d(2025, 4, 18), _d(2026, 4, 3), _d(2027, 3, 26)],
      descEn: 'Commemorates the crucifixion of Jesus Christ.',
      descHi: 'प्रभु यीशु मसीह के क्रूस पर चढ़ाए जाने की स्मृति।',
    ),
    _Row(
      id: 'easter',
      en: 'Easter Sunday',
      hi: 'ईस्टर',
      category: EventCategory.christianFestival,
      dates: [_d(2025, 4, 20), _d(2026, 4, 5), _d(2027, 3, 28)],
      descEn: 'Celebrates the resurrection of Jesus Christ.',
      descHi: 'प्रभु यीशु मसीह के पुनरुत्थान का उत्सव।',
    ),
    _Row(
      id: 'christmas',
      en: 'Christmas',
      hi: 'क्रिसमस',
      category: EventCategory.christianFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 12, 25), _d(2026, 12, 25), _d(2027, 12, 25)],
      descEn:
          'Birth of Jesus Christ – midnight mass, carols and Christmas '
          'trees.',
      descHi:
          'प्रभु यीशु का जन्मोत्सव – मध्यरात्रि प्रार्थना, कैरल और क्रिसमस '
          'ट्री।',
      placesEn: 'Goa, Shillong, Kochi, Bandra (Mumbai).',
      placesHi: 'गोवा, शिलांग, कोच्चि, बांद्रा (मुंबई)।',
    ),
    // ------------------------------------------------------------- jain
    _Row(
      id: 'mahavir-jayanti',
      en: 'Mahavir Jayanti',
      hi: 'महावीर जयंती',
      category: EventCategory.jainFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 4, 10), _d(2026, 3, 31), _d(2027, 4, 18)],
      tithiEn: 'Trayodashi, Chaitra Shukla Paksha',
      tithiHi: 'त्रयोदशी, चैत्र शुक्ल पक्ष',
      descEn: 'Birth anniversary of Lord Mahavira, the 24th Tirthankara.',
      descHi: '24वें तीर्थंकर भगवान महावीर की जयंती।',
      placesEn: 'Palitana, Shravanabelagola, Ranakpur.',
      placesHi: 'पालीताना, श्रवणबेलगोला, रणकपुर।',
    ),
    _Row(
      id: 'paryushan',
      en: 'Paryushan Parva begins',
      hi: 'पर्युषण पर्व आरंभ',
      category: EventCategory.jainFestival,
      vrat: true,
      dates: [_d(2025, 8, 21), _d(2026, 9, 9), _d(2027, 8, 30)],
      descEn:
          'Eight-day Jain festival of fasting, forgiveness and '
          'self-reflection, ending with Samvatsari.',
      descHi:
          'उपवास, क्षमा और आत्मचिंतन का आठ दिवसीय जैन पर्व, जिसका समापन '
          'संवत्सरी से होता है।',
    ),
    // --------------------------------------------------------- buddhist
    _Row(
      id: 'buddha-purnima',
      en: 'Buddha Purnima',
      hi: 'बुद्ध पूर्णिमा',
      category: EventCategory.buddhistFestival,
      holiday: true,
      important: true,
      dates: [_d(2025, 5, 12), _d(2026, 5, 1), _d(2027, 5, 20)],
      tithiEn: 'Purnima, Vaishakha Shukla Paksha',
      tithiHi: 'पूर्णिमा, वैशाख शुक्ल पक्ष',
      descEn: 'Birth, enlightenment and mahaparinirvana of Gautama Buddha.',
      descHi: 'गौतम बुद्ध के जन्म, ज्ञान-प्राप्ति और महापरिनिर्वाण का दिन।',
      placesEn: 'Bodh Gaya, Sarnath, Kushinagar.',
      placesHi: 'बोधगया, सारनाथ, कुशीनगर।',
    ),
    _Row(
      id: 'losar',
      en: 'Losar (Tibetan New Year)',
      hi: 'लोसर (तिब्बती नववर्ष)',
      category: EventCategory.buddhistFestival,
      dates: [_d(2025, 2, 28), _d(2026, 2, 18), _d(2027, 2, 7)],
      descEn:
          'Tibetan Buddhist new year celebrated in Ladakh, Sikkim, '
          'Himachal and Arunachal.',
      descHi:
          'लद्दाख, सिक्किम, हिमाचल और अरुणाचल में मनाया जाने वाला तिब्बती '
          'बौद्ध नववर्ष।',
    ),
  ];
}

class _Row {
  const _Row({
    required this.id,
    required this.en,
    required this.hi,
    required this.category,
    required this.dates,
    required this.descEn,
    required this.descHi,
    this.holiday = false,
    this.important = false,
    this.vrat = false,
    this.tithiEn,
    this.tithiHi,
    this.howEn,
    this.howHi,
    this.placesEn,
    this.placesHi,
  });

  final String id;
  final String en;
  final String hi;
  final EventCategory category;

  /// Ascending Gregorian dates (2025, 2026, 2027).
  final List<DateTime> dates;
  final String descEn;
  final String descHi;
  final bool holiday;
  final bool important;
  final bool vrat;
  final String? tithiEn;
  final String? tithiHi;
  final String? howEn;
  final String? howHi;
  final String? placesEn;
  final String? placesHi;
}
