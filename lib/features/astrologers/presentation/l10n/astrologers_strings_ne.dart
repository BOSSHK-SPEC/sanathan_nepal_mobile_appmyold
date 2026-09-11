part of 'astrologers_strings.dart';

class _Ne extends AstrologersStrings {
  const _Ne();
  @override
  String get title => 'ज्योतिषीहरू';
  @override
  String get searchHint => 'नाम वा विशेषताले खोज्नुहोस्';
  @override
  String get onlineNow => 'अनलाइन';
  @override
  String get offline => 'अफलाइन';
  @override
  String get busy => 'व्यस्त';
  @override
  String get free => 'उपलब्ध';
  @override
  String get consultNow => 'अहिले परामर्श';
  @override
  String get currentlyOffline => 'अहिले अफलाइन';

  @override
  String get bookLater => 'समय बुक गर्नुहोस्';
  @override
  String get perMinute => '/मिनेट';
  @override
  String get from => 'देखि';
  @override
  String get yearsExperience => 'वर्ष';
  @override
  String get consultations => 'परामर्श';
  @override
  String get followers => 'फलोअर';
  @override
  String get follow => 'फलो';
  @override
  String get following => 'फलो गरिएको';
  @override
  String get followingTitle => 'तपाईंले पछ्याउनुभएका ज्योतिषी';

  @override
  String get noFollowingTitle => 'तपाईंले अझै कसैलाई पछ्याउनुभएको छैन';

  @override
  String get noFollowingBody =>
      'ज्योतिषीलाई पछ्याउनुहोस्, उहाँहरू यहाँ देखिनेछन् र अनलाइन हुँदा थाहा पाउनुहुनेछ।';

  @override
  String get browseAstrologers => 'ज्योतिषी हेर्नुहोस्';

  @override
  String get followingOnlineNote => 'अहिले अनलाइन';

  @override
  String get noResults => 'कुनै ज्योतिषी भेटिएन';
  @override
  String get noResultsHint => 'फिल्टर फराकिलो बनाउनुहोस् वा हटाउनुहोस् ।';
  @override
  String get clearFilters => 'फिल्टर हटाउनुहोस्';
  @override
  String get recentSearches => 'हालैका खोजी';
  @override
  String get clearAll => 'सबै हटाउनुहोस्';
  @override
  String get searchEmpty => 'नाम वा विशेषताले ज्योतिषी खोज्नुहोस् ।';
  @override
  String get filters => 'फिल्टर';
  @override
  String get reset => 'रिसेट';
  @override
  String get speciality => 'विशेषता';
  @override
  String get language => 'भाषा';
  @override
  String get channel => 'परामर्शको प्रकार';
  @override
  String get maxPricePerMinute => 'प्रति मिनेट अधिकतम मूल्य';
  @override
  String get minimumRating => 'न्यूनतम रेटिङ';
  @override
  String get minimumExperience => 'न्यूनतम अनुभव';
  @override
  String get onlyOnline => 'अनलाइन मात्र';
  @override
  String get sortBy => 'क्रमबद्ध';
  @override
  String get anyPrice => 'कुनै पनि मूल्य';
  @override
  String get any => 'कुनै पनि';
  @override
  String get about => 'परिचय';
  @override
  String get services => 'सेवाहरू';
  @override
  String get reviews => 'समीक्षा';
  @override
  String get contact => 'सम्पर्क';
  @override
  String get recommended => 'सिफारिस';
  @override
  String get basedOn => 'आधारित';
  @override
  String get readMore => 'थप पढ्नुहोस्';
  @override
  String get readLess => 'कम देखाउनुहोस्';
  @override
  String get report => 'उजुरी';
  @override
  String get block => 'ब्लक';
  @override
  String get shareProfile => 'प्रोफाइल सेयर';
  @override
  String get noReviewsYet => 'अहिलेसम्म समीक्षा छैन';
  @override
  String get astrologerReplied => 'ज्योतिषीको जवाफ';
  @override
  String get writeReview => 'समीक्षा लेख्नुहोस्';
  @override
  String get rateYourExperience => 'परामर्श कस्तो रह्यो ?';
  @override
  String get whatStoodOut => 'के राम्रो लाग्यो ?';
  @override
  String get commentHint => 'अरूलाई उपयोगी हुने कुरा लेख्नुहोस्…';
  @override
  String get commentOptional => 'तपाईंको समीक्षा (ऐच्छिक)';
  @override
  String get submitReview => 'समीक्षा पठाउनुहोस्';
  @override
  String get reviewThanksTitle => 'समीक्षा पठाइयो';
  @override
  String get reviewThanksMessage =>
      'धन्यवाद । तपाईंको समीक्षाले अरूलाई छनोट गर्न सहयोग गर्छ ।';
  @override
  String get tapAStar => 'रेट गर्न तारा थिच्नुहोस्';
  @override
  String get reportTitle => 'यो ज्योतिषीको उजुरी';
  @override
  String get reportSubtitle => 'के भयो बताउनुहोस् । उजुरी गोप्य रहन्छ ।';
  @override
  String get reportDetailsHint => 'सहयोगी हुने विवरण थप्नुहोस्…';
  @override
  String get alsoBlock => 'यो ज्योतिषीलाई मेरो फिडबाट लुकाउनुहोस्';
  @override
  String get submitReport => 'उजुरी पठाउनुहोस्';
  @override
  String get reportThanks => 'उजुरी पठाइयो । धन्यवाद ।';
  @override
  String get cancel => 'रद्द';
  @override
  String specialty(Specialty value) => switch (value) {
    Specialty.vedic => 'वैदिक',
    Specialty.numerology => 'अंकज्योतिष',
    Specialty.tarot => 'टेरो',
    Specialty.vaastu => 'वास्तु',
    Specialty.palmistry => 'हस्तरेखा',
    Specialty.kundliMatching => 'कुण्डली मिलान',
    Specialty.prashna => 'प्रश्न',
    Specialty.gemstone => 'रत्न',
    Specialty.muhurta => 'मुहूर्त',
    Specialty.nadi => 'नाडी',
  };
  @override
  String channelName(ConsultChannel value) => switch (value) {
    ConsultChannel.chat => 'च्याट',
    ConsultChannel.voice => 'भ्वाइस कल',
    ConsultChannel.video => 'भिडियो कल',
  };
  @override
  String sortName(AstrologerSort value) => switch (value) {
    AstrologerSort.recommended => 'सिफारिस गरिएको',
    AstrologerSort.ratingHigh => 'उच्च रेटिङ',
    AstrologerSort.experienceHigh => 'बढी अनुभवी',
    AstrologerSort.priceLow => 'मूल्य: कमदेखि बढी',
    AstrologerSort.priceHigh => 'मूल्य: बढीदेखि कम',
    AstrologerSort.popularity => 'बढी फलोअर',
  };
  @override
  String reportReason(ReportReason value) => switch (value) {
    ReportReason.misleading => 'भ्रामक भविष्यवाणी',
    ReportReason.rude => 'अशिष्ट व्यवहार',
    ReportReason.spam => 'स्प्याम वा प्रचार',
    ReportReason.pricing => 'देखाइएभन्दा फरक मूल्य',
    ReportReason.impersonation => 'अरूको नक्कल',
    ReportReason.other => 'अन्य',
  };
  @override
  String reviewTag(String key) => switch (key) {
    'accurate' => 'सटीक',
    'patient' => 'धैर्यवान',
    'knowledgeable' => 'ज्ञानी',
    'honest' => 'इमानदार',
    'quick' => 'छिटो',
    'practical' => 'व्यावहारिक',
    _ => key,
  };
  @override
  String languageName(String code) => switch (code) {
    'ne' => 'नेपाली',
    'hi' => 'हिन्दी',
    'en' => 'अंग्रेजी',
    _ => code,
  };
  @override
  String showResults(String count) => '$count ज्योतिषी हेर्नुहोस्';
  @override
  String waitingCount(String count, String minutes) =>
      '$count पर्खिरहेका · ~$minutes मिनेट';
  @override
  String yearsLabel(String years) => '$years वर्ष';
}
