import '../../../../core/constants/app_assets.dart';
import '../../../../core/region/region.dart';
import '../../domain/entities/article.dart';

// ---- Category / tag catalogue -------------------------------------------

/// Blog categories (Figma: All, Festivals, Information, International Days,
/// Notice, National Days, Sapana ko Fal).
const List<ArticleLabel> blogCategories = [
  ArticleLabel(
    key: 'festivals',
    label: ArticleText(ne: 'चाडपर्व', en: 'Festivals', hi: 'त्योहार'),
  ),
  ArticleLabel(
    key: 'information',
    label: ArticleText(ne: 'जानकारी', en: 'Information', hi: 'जानकारी'),
  ),
  ArticleLabel(
    key: 'international_days',
    label: ArticleText(
      ne: 'अन्तर्राष्ट्रिय दिवस',
      en: 'International Days',
      hi: 'अंतर्राष्ट्रीय दिवस',
    ),
  ),
  ArticleLabel(
    key: 'notice',
    label: ArticleText(ne: 'सूचना', en: 'Notice', hi: 'सूचना'),
  ),
  ArticleLabel(
    key: 'national_days',
    label: ArticleText(
      ne: 'राष्ट्रिय दिवस',
      en: 'National Days',
      hi: 'राष्ट्रीय दिवस',
    ),
  ),
  ArticleLabel(
    key: 'sapana_ko_fal',
    label: ArticleText(ne: 'सपनाको फल', en: 'Sapana ko Fal', hi: 'स्वप्न फल'),
  ),
];

/// News categories (Figma: All, Latest, Trending, Politics, Sports,
/// Technology, Entertainment, World, Literature, Health, Business).
const List<ArticleLabel> newsCategories = [
  ArticleLabel(
    key: 'latest',
    label: ArticleText(ne: 'ताजा', en: 'Latest', hi: 'ताज़ा'),
  ),
  ArticleLabel(
    key: 'trending',
    label: ArticleText(ne: 'चर्चित', en: 'Trending', hi: 'चर्चित'),
  ),
  ArticleLabel(
    key: 'politics',
    label: ArticleText(ne: 'राजनीति', en: 'Politics', hi: 'राजनीति'),
  ),
  ArticleLabel(
    key: 'sports',
    label: ArticleText(ne: 'खेलकुद', en: 'Sports', hi: 'खेल'),
  ),
  ArticleLabel(
    key: 'technology',
    label: ArticleText(ne: 'प्रविधि', en: 'Technology', hi: 'तकनीक'),
  ),
  ArticleLabel(
    key: 'entertainment',
    label: ArticleText(ne: 'मनोरञ्जन', en: 'Entertainment', hi: 'मनोरंजन'),
  ),
  ArticleLabel(
    key: 'world',
    label: ArticleText(ne: 'विश्व', en: 'World', hi: 'विश्व'),
  ),
  ArticleLabel(
    key: 'literature',
    label: ArticleText(ne: 'साहित्य', en: 'Literature', hi: 'साहित्य'),
  ),
  ArticleLabel(
    key: 'health',
    label: ArticleText(ne: 'स्वास्थ्य', en: 'Health', hi: 'स्वास्थ्य'),
  ),
  ArticleLabel(
    key: 'business',
    label: ArticleText(ne: 'व्यापार', en: 'Business', hi: 'व्यापार'),
  ),
];

const ArticleLabel _tagHoli = ArticleLabel(
  key: 'holi',
  label: ArticleText(ne: 'होली', en: 'Holi'),
);
const ArticleLabel _tagTihar = ArticleLabel(
  key: 'tihar',
  label: ArticleText(ne: 'तिहार', en: 'Tihar'),
);
const ArticleLabel _tagDashain = ArticleLabel(
  key: 'dashain',
  label: ArticleText(ne: 'दशैं', en: 'Dashain'),
);
const ArticleLabel _tagEkadashi = ArticleLabel(
  key: 'ekadashi',
  label: ArticleText(ne: 'एकादशी', en: 'Ekadashi'),
);
const ArticleLabel _tagTrending = ArticleLabel(
  key: 'trending',
  label: ArticleText(ne: 'चर्चित', en: 'Trending', hi: 'चर्चित'),
);
const ArticleLabel _tagPolitics = ArticleLabel(
  key: 'politics',
  label: ArticleText(ne: 'राजनीति', en: 'Politics', hi: 'राजनीति'),
);
const ArticleLabel _tagLatest = ArticleLabel(
  key: 'latest',
  label: ArticleText(ne: 'ताजा', en: 'Latest', hi: 'ताज़ा'),
);
const ArticleLabel _tagHealth = ArticleLabel(
  key: 'health',
  label: ArticleText(ne: 'स्वास्थ्य', en: 'Health', hi: 'स्वास्थ्य'),
);

const ArticleText _author = ArticleText(ne: 'सनातन नेपाल', en: 'Sanatan Nepal');
const ArticleText _reporter = ArticleText(ne: 'समाचार डेस्क', en: 'News Desk');

const String _akshaya =
    'वैशाख शुक्ल तृतीया तिथि अक्षय तृतीयाको रूपमा प्रसिद्ध छ । त्रेतायुगको आरम्भ भएको यस '
    'दिन गरिएको दान, जप, तप, यज्ञ र स्नानको फल अक्षय हुन्छ भन्ने शास्त्रीय मान्यता छ ।';

ArticleLabel _cat(List<ArticleLabel> list, String key) =>
    list.firstWhere((c) => c.key == key);

/// Region-aware seed: Nepal keeps [articleSeed]; India gets
/// [indiaArticleSeed] (English + Hindi).
List<Article> articleSeedFor(RegionConfig config) =>
    config.isIndia ? indiaArticleSeed : articleSeed;

/// Nepal seed articles – 5 blogs + 4 news, Nepali + English (Hindi falls
/// back to English).
final List<Article> articleSeed = [
  Article(
    id: 'blog-akshaya-tritiya',
    type: ArticleType.blog,
    title: const ArticleText(ne: 'अक्षय तृतीया', en: 'Akshaya Tritiya'),
    excerpt: const ArticleText(
      ne: 'वैशाख शुक्ल तृतीया तिथि अक्षय तृतीयाको रूपमा प्रसिद्ध छ । त्रेतायुगको आरम्भ भएको..',
      en: 'The third day of the bright half of Baishakh is celebrated as Akshaya Tritiya, the day Treta Yuga began..',
    ),
    body: const [
      ArticleText(
        ne: _akshaya,
        en: 'The third lunar day of the bright fortnight of Baishakh is famous as Akshaya Tritiya. It is believed that Treta Yuga began on this day and that charity, chanting, penance, sacrifice and holy baths performed today bear undiminishing (akshaya) fruit.',
      ),
      ArticleText(
        ne: 'यस दिन जौ, चना, सत्तु र जलको दान गर्ने चलन छ । किसानहरूले खेतीको सुरुवात यसै दिनबाट गर्छन् । सुन किन्ने र नयाँ काम थाल्ने शुभ मुहूर्तका रूपमा पनि अक्षय तृतीयालाई लिइन्छ ।',
        en: 'Donating barley, gram, sattu and water is customary. Farmers begin sowing from this day, and it is regarded as an auspicious moment to buy gold or start new ventures.',
      ),
      ArticleText(
        ne: 'भगवान परशुरामको जन्म पनि यसै दिन भएको मानिन्छ, त्यसैले यसलाई परशुराम जयन्तीका रूपमा पनि मनाइन्छ ।',
        en: 'Lord Parashurama is believed to have been born on this day, so it is also observed as Parashurama Jayanti.',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagEkadashi],
    publishedAt: DateTime(2023, 4, 22),
    author: _author,
    readTimeMinutes: 3,
    imageAsset: AppAssets.image('Rectangle 1059.png'),
    likes: 128,
  ),
  Article(
    id: 'blog-holi',
    type: ArticleType.blog,
    title: const ArticleText(
      ne: 'फागु पूर्णिमा (होली)',
      en: 'Fagu Purnima (Holi)',
    ),
    excerpt: const ArticleText(
      ne: 'रङ र अबिरको पर्व होली फागुन शुक्ल पूर्णिमाका दिन मनाइन्छ । यो असत्यमाथि सत्यको विजयको..',
      en: 'Holi, the festival of colours, falls on the full moon of Falgun and marks the victory of truth over evil..',
    ),
    body: const [
      ArticleText(
        ne: 'फागुन शुक्ल पूर्णिमाका दिन मनाइने होली रङ, अबिर र उमङ्गको पर्व हो । हिरण्यकशिपुकी बहिनी होलिकाको दहन र भक्त प्रह्लादको रक्षाको स्मृतिमा यो पर्व मनाइन्छ ।',
        en: 'Celebrated on the full moon of Falgun, Holi is a festival of colours, powder and joy commemorating the burning of Holika and the protection of devotee Prahlad.',
      ),
      ArticleText(
        ne: 'काठमाडौंको वसन्तपुरमा चीर गाडेर एक हप्ता अघिबाटै होलीको सुरुवात हुन्छ । पहाडमा पूर्णिमाका दिन र तराईमा भोलिपल्ट होली खेलिन्छ ।',
        en: 'In Kathmandu the festival begins a week earlier with the raising of the chir pole at Basantapur. The hills play Holi on the full-moon day and the Terai the day after.',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagHoli],
    publishedAt: DateTime(2023, 3, 6),
    author: _author,
    readTimeMinutes: 2,
    imageAsset: AppAssets.image('Rectangle 1059 (1).png'),
    likes: 96,
  ),
  Article(
    id: 'blog-tihar',
    type: ArticleType.blog,
    title: const ArticleText(
      ne: 'तिहार: यमपञ्चकको महिमा',
      en: 'Tihar: The Five Days of Yama',
    ),
    excerpt: const ArticleText(
      ne: 'काग तिहारदेखि भाइटीकासम्म पाँच दिन मनाइने यमपञ्चकमा काग, कुकुर, गाई, गोरु र भाइको पूजा..',
      en: 'From Kaag Tihar to Bhai Tika, the five days of Yamapanchak honour crows, dogs, cows, oxen and brothers..',
    ),
    body: const [
      ArticleText(
        ne: 'कात्तिक कृष्ण त्रयोदशीदेखि शुक्ल द्वितीयासम्म पाँच दिन मनाइने तिहारलाई यमपञ्चक पनि भनिन्छ । पहिलो दिन काग, दोस्रो दिन कुकुर, तेस्रो दिन गाई र लक्ष्मी, चौथो दिन गोरु र गोवर्धन तथा पाँचौँ दिन भाइटीका मनाइन्छ ।',
        en: 'Tihar, also called Yamapanchak, runs for five days from Kartik Krishna Trayodashi to Shukla Dwitiya: crows on day one, dogs on day two, cows and Lakshmi on day three, oxen and Govardhan on day four, and Bhai Tika on the fifth day.',
      ),
      ArticleText(
        ne: 'घर-आँगन दियो र सयपत्रीको मालाले सजाइन्छ, देउसी-भैलो खेलिन्छ र सेलरोटी बनाइन्छ ।',
        en: 'Homes are decorated with oil lamps and marigold garlands, Deusi-Bhailo songs are sung and sel roti is prepared.',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagTihar],
    publishedAt: DateTime(2022, 10, 24),
    author: _author,
    readTimeMinutes: 4,
    imageAsset: AppAssets.image('Rectangle 2218.png'),
    likes: 210,
  ),
  Article(
    id: 'blog-dashain',
    type: ArticleType.blog,
    title: const ArticleText(
      ne: 'बडादशैंको सांस्कृतिक महत्त्व',
      en: 'Cultural Significance of Dashain',
    ),
    excerpt: const ArticleText(
      ne: 'घटस्थापनादेखि कोजाग्रत पूर्णिमासम्म मनाइने बडादशैं नेपालीहरूको सबैभन्दा ठूलो चाड हो ।..',
      en: 'From Ghatasthapana to Kojagrat Purnima, Dashain is the biggest festival of the Nepali people..',
    ),
    body: const [
      ArticleText(
        ne: 'आश्विन शुक्ल प्रतिपदाका दिन घटस्थापना गरी जमरा राखिन्छ । सप्तमीमा फूलपाती भित्र्याइन्छ, अष्टमी-नवमीमा शक्तिपूजा र दशमीका दिन मान्यजनबाट टीका-जमरा ग्रहण गरिन्छ ।',
        en: 'On Ashwin Shukla Pratipada the sacred vessel is installed and jamara is sown. Phulpati arrives on the seventh day, Shakti is worshipped on the eighth and ninth, and on Vijaya Dashami elders bless the family with tika and jamara.',
      ),
      ArticleText(
        ne: 'दशैं दुर्गाले महिषासुरमाथि र रामले रावणमाथि प्राप्त गरेको विजयको प्रतीक हो ।',
        en: 'Dashain symbolises the victory of Durga over Mahishasura and of Rama over Ravana.',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagDashain],
    publishedAt: DateTime(2022, 9, 26),
    author: _author,
    readTimeMinutes: 3,
    imageAsset: AppAssets.image('Rectangle 1059.png'),
    likes: 342,
  ),
  Article(
    id: 'blog-sapana',
    type: ArticleType.blog,
    title: const ArticleText(
      ne: 'सपनामा साँप देखे के हुन्छ?',
      en: 'What Does Seeing a Snake in a Dream Mean?',
    ),
    excerpt: const ArticleText(
      ne: 'स्वप्नशास्त्र अनुसार सपनामा देखिने प्रत्येक वस्तुको केही न केही सङ्केत हुन्छ । साँप देख्नु..',
      en: 'According to Swapna Shastra every object seen in a dream carries a sign. Seeing a snake..',
    ),
    body: const [
      ArticleText(
        ne: 'स्वप्नशास्त्रमा साँपलाई कुण्डलिनी शक्ति र गुप्त धनको प्रतीक मानिन्छ । सेतो साँप देख्नु शुभ र कालो साँपले टोक्नु शत्रुबाट सावधान रहनुपर्ने सङ्केत हो भनिन्छ ।',
        en: 'Dream lore treats the serpent as a symbol of kundalini energy and hidden wealth. A white snake is auspicious, while being bitten by a black snake warns of enemies.',
      ),
    ],
    category: _cat(blogCategories, 'sapana_ko_fal'),
    tags: const [],
    publishedAt: DateTime(2023, 2, 14),
    author: _author,
    readTimeMinutes: 2,
    imageAsset: AppAssets.image('Rectangle 1059 (2).png'),
    likes: 57,
  ),
  Article(
    id: 'news-poll-code',
    type: ArticleType.news,
    title: const ArticleText(
      ne: 'रवि लामिछानेविरुद्ध आचारसंहिता उल्लङ्घनको उजुरी',
      en: 'Rabi Lamichhane accused of violating poll code, complaint filed',
    ),
    excerpt: const ArticleText(
      ne: 'राष्ट्रिय स्वतन्त्र पार्टीका सभापति तथा उम्मेदवार रवि लामिछानेले निर्वाचन आचारसंहिता उल्लङ्घन गरेको भन्दै चितवन-२ का प्रमुख निर्वाचन अधिकृतको कार्यालयमा उजुरी परेको छ । आइतबार..',
      en: 'A complaint has been lodged with the Office of Chief Returning Officer in Chitwan-2, alleging that Rabi Lamichhane, the President and candidate of Rastriya Swatantra Party, has violated the election code of conduct. On Sunday..',
    ),
    body: const [
      ArticleText(
        ne: 'चितवन-२ का प्रमुख निर्वाचन अधिकृतको कार्यालयमा राष्ट्रिय स्वतन्त्र पार्टीका सभापति रवि लामिछानेविरुद्ध निर्वाचन आचारसंहिता उल्लङ्घन गरेको भन्दै उजुरी परेको छ ।',
        en: 'A complaint has been lodged with the Office of the Chief Returning Officer in Chitwan-2 alleging that Rastriya Swatantra Party President Rabi Lamichhane violated the election code of conduct.',
      ),
      ArticleText(
        ne: 'आइतबार भरतपुरमा आयोजित सभामा मतदातालाई प्रलोभन दिने अभिव्यक्ति दिएको उजुरीमा उल्लेख छ । कार्यालयले स्पष्टीकरण मागेको छ ।',
        en: 'The complaint states that remarks made at a rally in Bharatpur on Sunday amounted to inducing voters. The office has sought a written clarification.',
      ),
    ],
    category: _cat(newsCategories, 'politics'),
    tags: const [_tagTrending, _tagPolitics],
    publishedAt: DateTime(2023, 4, 22),
    author: _reporter,
    readTimeMinutes: 2,
    imageAsset: AppAssets.image('Rectangle 1059 (1).png'),
    likes: 41,
  ),
  Article(
    id: 'news-cricket',
    type: ArticleType.news,
    title: const ArticleText(
      ne: 'नेपाल एसिया कप छनोटको फाइनलमा प्रवेश',
      en: 'Nepal storms into Asia Cup qualifier final',
    ),
    excerpt: const ArticleText(
      ne: 'एसीसी प्रिमियर कप क्रिकेटको सेमिफाइनलमा युएईलाई पराजित गर्दै नेपाल फाइनलमा प्रवेश गरेको छ । कप्तान रोहित पौडेलको..',
      en: 'Nepal beat the UAE in the ACC Premier Cup semi-final to reach the final. Skipper Rohit Paudel..',
    ),
    body: const [
      ArticleText(
        ne: 'कीर्तिपुरमा भएको सेमिफाइनलमा नेपालले युएईलाई ८ विकेटले पराजित गर्‍यो । कप्तान रोहित पौडेलले नाबाद अर्धशतक बनाए ।',
        en: 'In the semi-final at Kirtipur, Nepal defeated the UAE by eight wickets with captain Rohit Paudel scoring an unbeaten half-century.',
      ),
    ],
    category: _cat(newsCategories, 'sports'),
    tags: const [_tagLatest, _tagTrending],
    publishedAt: DateTime(2023, 4, 20),
    author: _reporter,
    readTimeMinutes: 1,
    likes: 88,
  ),
  Article(
    id: 'news-health',
    type: ArticleType.news,
    title: const ArticleText(
      ne: 'गर्मी बढेसँगै डेंगु सतर्कता अपनाउन आग्रह',
      en: 'Health ministry urges dengue precautions as temperatures rise',
    ),
    excerpt: const ArticleText(
      ne: 'स्वास्थ्य मन्त्रालयले लामखुट्टेजन्य रोग फैलिने जोखिम बढेकाले सरसफाइमा ध्यान दिन आग्रह गरेको छ ।..',
      en: 'The Ministry of Health has asked the public to keep surroundings clean as the risk of mosquito-borne diseases grows..',
    ),
    body: const [
      ArticleText(
        ne: 'मन्त्रालयका अनुसार गत वर्ष ५४ हजारभन्दा बढी डेंगु सङ्क्रमित भेटिएका थिए । पानी जम्न नदिन र झुलको प्रयोग गर्न सुझाव दिइएको छ ।',
        en: 'According to the ministry more than 54,000 dengue infections were recorded last year. People are advised to prevent stagnant water and use mosquito nets.',
      ),
    ],
    category: _cat(newsCategories, 'health'),
    tags: const [_tagHealth, _tagLatest],
    publishedAt: DateTime(2023, 4, 18),
    author: _reporter,
    readTimeMinutes: 1,
    likes: 23,
  ),
  Article(
    id: 'news-tech',
    type: ArticleType.news,
    title: const ArticleText(
      ne: 'नेपाल टेलिकमले काठमाडौंमा फाइभजी परीक्षण थाल्यो',
      en: 'Nepal Telecom begins 5G trial in Kathmandu',
    ),
    excerpt: const ArticleText(
      ne: 'नेपाल टेलिकमले काठमाडौं उपत्यकाका चुनिएका स्थानमा फाइभजी सेवाको परीक्षण सुरु गरेको छ ।..',
      en: 'Nepal Telecom has started testing 5G service at selected locations across the Kathmandu valley..',
    ),
    body: const [
      ArticleText(
        ne: 'परीक्षण अवधिमा सीमित प्रयोगकर्ताले फाइभजी सेवा प्रयोग गर्न पाउनेछन् । व्यावसायिक सेवा आगामी वर्षभित्र विस्तार गर्ने लक्ष्य छ ।',
        en: 'A limited number of users will access 5G during the trial period; commercial roll-out is targeted within the coming year.',
      ),
    ],
    category: _cat(newsCategories, 'technology'),
    tags: const [_tagLatest],
    publishedAt: DateTime(2023, 4, 15),
    author: _reporter,
    readTimeMinutes: 1,
    imageAsset: AppAssets.image('Group 2 (1).png'),
    likes: 65,
  ),
];

// ---- India seed ------------------------------------------------------------

const ArticleLabel _tagDiwali = ArticleLabel(
  key: 'diwali',
  label: ArticleText(en: 'Diwali', hi: 'दीपावली'),
);
const ArticleLabel _tagKumbh = ArticleLabel(
  key: 'kumbh_mela',
  label: ArticleText(en: 'Kumbh Mela', hi: 'कुंभ मेला'),
);
const ArticleLabel _tagGanesh = ArticleLabel(
  key: 'ganesh_chaturthi',
  label: ArticleText(en: 'Ganesh Chaturthi', hi: 'गणेश चतुर्थी'),
);
const ArticleLabel _tagNavratri = ArticleLabel(
  key: 'navratri',
  label: ArticleText(en: 'Navratri', hi: 'नवरात्रि'),
);
const ArticleLabel _tagDurgaPuja = ArticleLabel(
  key: 'durga_puja',
  label: ArticleText(en: 'Durga Puja', hi: 'दुर्गा पूजा'),
);
const ArticleLabel _tagOnam = ArticleLabel(
  key: 'onam',
  label: ArticleText(en: 'Onam', hi: 'ओणम'),
);
const ArticleLabel _tagAyodhya = ArticleLabel(
  key: 'ayodhya',
  label: ArticleText(en: 'Ayodhya', hi: 'अयोध्या'),
);
const ArticleLabel _tagUjjain = ArticleLabel(
  key: 'ujjain',
  label: ArticleText(en: 'Ujjain', hi: 'उज्जैन'),
);

const ArticleText _authorIndia = ArticleText(
  en: 'Sanatan Bharat',
  hi: 'सनातन भारत',
);
const ArticleText _reporterIndia = ArticleText(
  en: 'News Desk',
  hi: 'समाचार डेस्क',
);

/// India seed articles – 4 blogs + 3 news, English + Hindi.
final List<Article> indiaArticleSeed = [
  Article(
    id: 'blog-dev-deepawali-varanasi',
    type: ArticleType.blog,
    title: const ArticleText(
      en: 'Dev Deepawali on the Ghats of Varanasi',
      hi: 'वाराणसी के घाटों पर देव दीपावली',
    ),
    excerpt: const ArticleText(
      en: 'Fifteen days after Diwali, on Kartik Purnima, more than a million lamps light up the eighty-four ghats of Kashi..',
      hi: 'दीपावली के पंद्रह दिन बाद कार्तिक पूर्णिमा को काशी के चौरासी घाटों पर दस लाख से अधिक दीये जगमगाते हैं..',
    ),
    body: const [
      ArticleText(
        en: 'Dev Deepawali, the "Diwali of the gods", is celebrated on Kartik Purnima, fifteen days after Diwali. Legend says the gods descend to Kashi to bathe in the Ganga on this night, so from Assi to Rajghat every step of the eighty-four ghats is lined with earthen lamps.',
        hi: 'देव दीपावली, अर्थात् देवताओं की दीपावली, दीपावली के पंद्रह दिन बाद कार्तिक पूर्णिमा को मनाई जाती है। मान्यता है कि इस रात देवता गंगा-स्नान के लिए काशी उतरते हैं, इसलिए अस्सी से राजघाट तक चौरासी घाटों की हर सीढ़ी मिट्टी के दीयों से सज जाती है।',
      ),
      ArticleText(
        en: 'The evening begins with the Ganga aarti at Dashashwamedh Ghat, followed by shobha yatras and a tribute to martyrs at Rajendra Prasad Ghat. Boats drift along the river so visitors can take in the entire crescent of light at once.',
        hi: 'शाम की शुरुआत दशाश्वमेध घाट की गंगा आरती से होती है, फिर शोभायात्राएँ निकलती हैं और राजेंद्र प्रसाद घाट पर शहीदों को श्रद्धांजलि दी जाती है। नावें नदी में धीरे-धीरे तैरती हैं ताकि दर्शक रोशनी का पूरा अर्धचंद्र एक साथ देख सकें।',
      ),
      ArticleText(
        en: 'The festival also marks Tripurari Purnima, the day Shiva defeated the demon Tripurasura, which is why the city of Shiva celebrates it with such devotion.',
        hi: 'यह पर्व त्रिपुरारी पूर्णिमा भी है, जिस दिन शिव ने त्रिपुरासुर का वध किया था; इसीलिए शिव की नगरी इसे इतनी श्रद्धा से मनाती है।',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagDiwali],
    publishedAt: DateTime(2023, 11, 24),
    author: _authorIndia,
    readTimeMinutes: 3,
    imageAsset: AppAssets.image('Rectangle 1059.png'),
    likes: 264,
  ),
  Article(
    id: 'blog-kumbh-mela',
    type: ArticleType.blog,
    title: const ArticleText(
      en: 'Kumbh Mela: The Largest Gathering of Faith on Earth',
      hi: 'कुंभ मेला: धरती पर आस्था का सबसे बड़ा समागम',
    ),
    excerpt: const ArticleText(
      en: 'Held in rotation at Prayagraj, Haridwar, Ujjain and Nashik, the Kumbh draws tens of millions of pilgrims to a single holy dip..',
      hi: 'प्रयागराज, हरिद्वार, उज्जैन और नासिक में बारी-बारी से लगने वाला कुंभ करोड़ों श्रद्धालुओं को एक पवित्र डुबकी के लिए खींच लाता है..',
    ),
    body: const [
      ArticleText(
        en: 'According to the Puranas, drops of amrit fell at four places during the churning of the ocean – Prayagraj, Haridwar, Ujjain and Nashik. The Kumbh Mela rotates between them, with the Purna Kumbh every twelve years and the Maha Kumbh at Prayagraj after twelve Purna Kumbhs.',
        hi: 'पुराणों के अनुसार समुद्र-मंथन के समय अमृत की बूँदें चार स्थानों – प्रयागराज, हरिद्वार, उज्जैन और नासिक – पर गिरी थीं। कुंभ मेला इन्हीं के बीच घूमता है; पूर्ण कुंभ हर बारह वर्ष में और बारह पूर्ण कुंभों के बाद प्रयागराज में महाकुंभ लगता है।',
      ),
      ArticleText(
        en: 'The Shahi Snan (royal bath) days – Makar Sankranti, Mauni Amavasya and Basant Panchami – see the akharas of sadhus lead processions to the Sangam before dawn. Temporary tent cities with roads, hospitals and power grids rise on the riverbed for the duration of the fair.',
        hi: 'शाही स्नान के दिन – मकर संक्रांति, मौनी अमावस्या और बसंत पंचमी – पर साधुओं के अखाड़े भोर से पहले संगम की ओर जुलूस निकालते हैं। मेले भर के लिए नदी की रेत पर सड़कों, अस्पतालों और बिजली व्यवस्था वाला अस्थायी टेंट-नगर बस जाता है।',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagKumbh],
    publishedAt: DateTime(2025, 1, 10),
    author: _authorIndia,
    readTimeMinutes: 4,
    imageAsset: AppAssets.image('Rectangle 1059 (1).png'),
    likes: 512,
  ),
  Article(
    id: 'blog-ganesh-chaturthi-mumbai',
    type: ArticleType.blog,
    title: const ArticleText(
      en: 'Ganesh Chaturthi: Ten Days of Bappa in Mumbai',
      hi: 'गणेश चतुर्थी: मुंबई में बप्पा के दस दिन',
    ),
    excerpt: const ArticleText(
      en: 'From household idols to the towering Lalbaugcha Raja, Mumbai turns into one great pandal for ten days every Bhadrapada..',
      hi: 'घरों की छोटी मूर्तियों से लेकर विशाल लालबागचा राजा तक, हर भाद्रपद में मुंबई दस दिनों के लिए एक विशाल पंडाल बन जाती है..',
    ),
    body: const [
      ArticleText(
        en: 'Ganesh Chaturthi falls on the fourth day of the bright half of Bhadrapada. Lokmanya Tilak turned the household festival into a public celebration in 1893, and Mumbai has never looked back – over ten thousand sarvajanik mandals now install idols across the city.',
        hi: 'गणेश चतुर्थी भाद्रपद शुक्ल चतुर्थी को आती है। लोकमान्य तिलक ने 1893 में इस घरेलू पर्व को सार्वजनिक उत्सव बनाया और तब से मुंबई ने पीछे मुड़कर नहीं देखा – आज दस हज़ार से अधिक सार्वजनिक मंडल शहर भर में मूर्तियाँ स्थापित करते हैं।',
      ),
      ArticleText(
        en: 'Devotees queue for hours at Lalbaugcha Raja and GSB Seva Mandal, offer modaks and durva grass, and on Anant Chaturdashi carry Bappa to Girgaon Chowpatty chanting "Ganpati Bappa Morya, pudhchya varshi lavkar ya".',
        hi: 'भक्त लालबागचा राजा और जीएसबी सेवा मंडल में घंटों कतार में लगते हैं, मोदक और दूर्वा अर्पित करते हैं और अनंत चतुर्दशी को "गणपति बप्पा मोरया, पुढच्या वर्षी लवकर या" के जयघोष के साथ बप्पा को गिरगाँव चौपाटी ले जाते हैं।',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagGanesh],
    publishedAt: DateTime(2023, 9, 15),
    author: _authorIndia,
    readTimeMinutes: 3,
    imageAsset: AppAssets.image('Rectangle 2218.png'),
    likes: 389,
  ),
  Article(
    id: 'blog-durga-puja-kolkata',
    type: ArticleType.blog,
    title: const ArticleText(
      en: 'Navratri to Dashami: Durga Puja in Kolkata',
      hi: 'नवरात्रि से दशमी तक: कोलकाता की दुर्गा पूजा',
    ),
    excerpt: const ArticleText(
      en: 'While much of India fasts and dances through Navratri, Kolkata builds thousands of themed pandals for the homecoming of Maa Durga..',
      hi: 'जब देश का बड़ा हिस्सा नवरात्रि में व्रत और गरबा में डूबा रहता है, कोलकाता माँ दुर्गा के आगमन के लिए हज़ारों थीम-आधारित पंडाल खड़े करता है..',
    ),
    body: const [
      ArticleText(
        en: 'Sharadiya Navratri honours the nine forms of the Goddess from Pratipada to Navami of Ashwin Shukla. In Bengal the last five days – Shashthi to Dashami – are Durga Puja, inscribed by UNESCO on its list of Intangible Cultural Heritage in 2021.',
        hi: 'शारदीय नवरात्रि में आश्विन शुक्ल प्रतिपदा से नवमी तक देवी के नौ रूपों की उपासना होती है। बंगाल में अंतिम पाँच दिन – षष्ठी से दशमी – दुर्गा पूजा कहलाते हैं, जिसे यूनेस्को ने 2021 में अमूर्त सांस्कृतिक धरोहर की सूची में शामिल किया।',
      ),
      ArticleText(
        en: 'Clay idols from Kumartuli, dhak drummers, dhunuchi dance and the sindoor khela of Dashami give the city its unmistakable rhythm before the idols are immersed in the Hooghly.',
        hi: 'कुमारटुली की मिट्टी की प्रतिमाएँ, ढाक की थाप, धुनुची नृत्य और दशमी का सिंदूर खेला शहर को उसकी अनोखी लय देते हैं, फिर प्रतिमाएँ हुगली में विसर्जित की जाती हैं।',
      ),
    ],
    category: _cat(blogCategories, 'festivals'),
    tags: const [_tagNavratri, _tagDurgaPuja],
    publishedAt: DateTime(2023, 10, 18),
    author: _authorIndia,
    readTimeMinutes: 3,
    imageAsset: AppAssets.image('Rectangle 1059 (2).png'),
    likes: 301,
  ),
  Article(
    id: 'news-ayodhya-ram-navami',
    type: ArticleType.news,
    title: const ArticleText(
      en: 'Surya Tilak graces Ram Lalla as lakhs throng Ayodhya on Ram Navami',
      hi: 'राम नवमी पर अयोध्या में लाखों श्रद्धालु, रामलला के मस्तक पर सूर्य तिलक',
    ),
    excerpt: const ArticleText(
      en: 'A beam of sunlight fell on the forehead of the Ram Lalla idol at noon as the first Ram Navami after the temple consecration drew record crowds..',
      hi: 'मंदिर की प्राण-प्रतिष्ठा के बाद पहली राम नवमी पर दोपहर ठीक बारह बजे सूर्य की किरण रामलला के मस्तक पर पड़ी और अयोध्या में रिकॉर्ड भीड़ उमड़ी..',
    ),
    body: const [
      ArticleText(
        en: 'Using a system of mirrors and lenses designed by CSIR-CBRI Roorkee, sunlight was directed onto the forehead of the Ram Lalla idol for about four minutes at noon. The temple trust said darshan continued for nineteen hours to accommodate pilgrims.',
        hi: 'सीएसआईआर-सीबीआरआई रुड़की द्वारा बनाई गई दर्पण और लेंस की प्रणाली से दोपहर बारह बजे लगभग चार मिनट तक सूर्य की किरण रामलला के मस्तक पर डाली गई। मंदिर ट्रस्ट ने बताया कि श्रद्धालुओं के लिए दर्शन उन्नीस घंटे तक जारी रहे।',
      ),
      ArticleText(
        en: 'The district administration set up cooling stations and drinking-water points along the Ram Path and the Saryu ghats.',
        hi: 'ज़िला प्रशासन ने राम पथ और सरयू घाटों पर शीतल छाया और पेयजल केंद्र बनाए।',
      ),
    ],
    category: _cat(newsCategories, 'latest'),
    tags: const [_tagAyodhya, _tagTrending],
    publishedAt: DateTime(2024, 4, 17),
    author: _reporterIndia,
    readTimeMinutes: 2,
    imageAsset: AppAssets.image('Rectangle 1059 (1).png'),
    likes: 173,
  ),
  Article(
    id: 'news-ujjain-mahakal',
    type: ArticleType.news,
    title: const ArticleText(
      en: 'Ujjain readies Mahakal Lok for the Shravan crowds',
      hi: 'श्रावण की भीड़ के लिए उज्जैन में महाकाल लोक तैयार',
    ),
    excerpt: const ArticleText(
      en: 'The Mahakaleshwar temple committee has extended Bhasma Aarti bookings and added a second corridor for the monthly Shravan sawari processions..',
      hi: 'महाकालेश्वर मंदिर समिति ने भस्म आरती की बुकिंग बढ़ाई है और श्रावण की सवारियों के लिए दूसरा गलियारा जोड़ा है..',
    ),
    body: const [
      ArticleText(
        en: 'The Bhasma Aarti at 4 a.m., unique to the Mahakaleshwar Jyotirlinga, will admit an additional five hundred devotees daily through the online quota during Shravan. Baba Mahakal\'s sawari will pass through the 900-metre Mahakal Lok corridor every Monday of the month.',
        hi: 'महाकालेश्वर ज्योतिर्लिंग की अनूठी सुबह चार बजे की भस्म आरती में श्रावण के दौरान ऑनलाइन कोटे से प्रतिदिन पाँच सौ अतिरिक्त श्रद्धालु शामिल हो सकेंगे। बाबा महाकाल की सवारी माह के हर सोमवार 900 मीटर लंबे महाकाल लोक गलियारे से निकलेगी।',
      ),
    ],
    category: _cat(newsCategories, 'trending'),
    tags: const [_tagUjjain, _tagLatest],
    publishedAt: DateTime(2024, 7, 20),
    author: _reporterIndia,
    readTimeMinutes: 1,
    imageAsset: AppAssets.image('Group 2 (1).png'),
    likes: 98,
  ),
  Article(
    id: 'news-onam-boat-race',
    type: ArticleType.news,
    title: const ArticleText(
      en: 'Nehru Trophy boat race returns to Alappuzha as Onam festivities begin',
      hi: 'ओणम उत्सव की शुरुआत के साथ अलप्पुझा में फिर लौटी नेहरू ट्रॉफी नौका दौड़',
    ),
    excerpt: const ArticleText(
      en: 'Snake boats with a hundred oarsmen each raced down Punnamada Lake as Kerala opened its ten-day Onam season with Atham..',
      hi: 'अथम के साथ केरल का दस दिवसीय ओणम उत्सव शुरू हुआ और सौ-सौ नाविकों वाली सर्प-नौकाएँ पुन्नमदा झील में दौड़ीं..',
    ),
    body: const [
      ArticleText(
        en: 'Onam celebrates the annual homecoming of King Mahabali. Over ten days from Atham to Thiruvonam, homes lay flower carpets (pookalam), families share the 26-dish Onasadya on banana leaves and villages compete in vallam kali boat races.',
        hi: 'ओणम राजा महाबलि के वार्षिक आगमन का पर्व है। अथम से तिरुवोणम तक दस दिनों में घरों में फूलों की रंगोली (पूकलम) सजती है, परिवार केले के पत्ते पर 26 व्यंजनों की ओणसद्या साझा करते हैं और गाँव वल्लम कली नौका दौड़ में प्रतिस्पर्धा करते हैं।',
      ),
    ],
    category: _cat(newsCategories, 'sports'),
    tags: const [_tagOnam, _tagTrending],
    publishedAt: DateTime(2023, 8, 26),
    author: _reporterIndia,
    readTimeMinutes: 1,
    likes: 64,
  ),
];
