part of 'astrologers_strings.dart';

class _Hi extends AstrologersStrings {
  const _Hi();
  @override
  String get title => 'ज्योतिषी';
  @override
  String get searchHint => 'नाम या विशेषज्ञता से खोजें';
  @override
  String get onlineNow => 'ऑनलाइन';
  @override
  String get offline => 'ऑफ़लाइन';
  @override
  String get busy => 'व्यस्त';
  @override
  String get free => 'उपलब्ध';
  @override
  String get consultNow => 'अभी परामर्श';
  @override
  String get currentlyOffline => 'अभी ऑफ़लाइन';

  @override
  String get bookLater => 'समय बुक करें';
  @override
  String get perMinute => '/मिनट';
  @override
  String get from => 'से';
  @override
  String get yearsExperience => 'वर्ष';
  @override
  String get consultations => 'परामर्श';
  @override
  String get followers => 'फ़ॉलोअर';
  @override
  String get follow => 'फ़ॉलो';
  @override
  String get following => 'फ़ॉलो किया';
  @override
  String get followingTitle => 'आपके फ़ॉलो किए ज्योतिषी';

  @override
  String get noFollowingTitle => 'आपने अभी किसी को फ़ॉलो नहीं किया';

  @override
  String get noFollowingBody =>
      'किसी ज्योतिषी को फ़ॉलो करें, वे यहाँ दिखेंगे और ऑनलाइन आने पर पता चलेगा।';

  @override
  String get browseAstrologers => 'ज्योतिषी देखें';

  @override
  String get followingOnlineNote => 'अभी ऑनलाइन';

  @override
  String get noResults => 'कोई ज्योतिषी नहीं मिला';
  @override
  String get noResultsHint => 'फ़िल्टर बढ़ाएँ या हटा दें।';
  @override
  String get clearFilters => 'फ़िल्टर हटाएँ';
  @override
  String get recentSearches => 'हाल की खोजें';
  @override
  String get clearAll => 'सभी हटाएँ';
  @override
  String get searchEmpty => 'नाम या विशेषज्ञता से ज्योतिषी खोजें।';
  @override
  String get filters => 'फ़िल्टर';
  @override
  String get reset => 'रीसेट';
  @override
  String get speciality => 'विशेषज्ञता';
  @override
  String get language => 'भाषा';
  @override
  String get channel => 'परामर्श का प्रकार';
  @override
  String get maxPricePerMinute => 'प्रति मिनट अधिकतम मूल्य';
  @override
  String get minimumRating => 'न्यूनतम रेटिंग';
  @override
  String get minimumExperience => 'न्यूनतम अनुभव';
  @override
  String get onlyOnline => 'केवल ऑनलाइन';
  @override
  String get sortBy => 'क्रमबद्ध करें';
  @override
  String get anyPrice => 'कोई भी मूल्य';
  @override
  String get any => 'कोई भी';
  @override
  String get about => 'परिचय';
  @override
  String get services => 'सेवाएँ';
  @override
  String get reviews => 'समीक्षाएँ';
  @override
  String get contact => 'संपर्क';
  @override
  String get recommended => 'अनुशंसित';
  @override
  String get basedOn => 'आधारित';
  @override
  String get readMore => 'और पढ़ें';
  @override
  String get readLess => 'कम दिखाएँ';
  @override
  String get report => 'रिपोर्ट';
  @override
  String get block => 'ब्लॉक';
  @override
  String get shareProfile => 'प्रोफ़ाइल साझा करें';
  @override
  String get noReviewsYet => 'अभी कोई समीक्षा नहीं';
  @override
  String get astrologerReplied => 'ज्योतिषी का उत्तर';
  @override
  String get writeReview => 'समीक्षा लिखें';
  @override
  String get rateYourExperience => 'परामर्श कैसा रहा?';
  @override
  String get whatStoodOut => 'क्या अच्छा लगा?';
  @override
  String get commentHint => 'दूसरों के लिए उपयोगी बात लिखें…';
  @override
  String get commentOptional => 'आपकी समीक्षा (वैकल्पिक)';
  @override
  String get submitReview => 'समीक्षा भेजें';
  @override
  String get reviewThanksTitle => 'समीक्षा भेजी गई';
  @override
  String get reviewThanksMessage =>
      'धन्यवाद। आपकी समीक्षा दूसरों को चुनने में मदद करती है।';
  @override
  String get tapAStar => 'रेट करने के लिए तारा दबाएँ';
  @override
  String get reportTitle => 'इस ज्योतिषी की रिपोर्ट करें';
  @override
  String get reportSubtitle => 'बताएँ क्या हुआ। रिपोर्ट गोपनीय रहती है।';
  @override
  String get reportDetailsHint => 'सहायक विवरण जोड़ें…';
  @override
  String get alsoBlock => 'इस ज्योतिषी को मेरी फ़ीड से छिपाएँ';
  @override
  String get submitReport => 'रिपोर्ट भेजें';
  @override
  String get reportThanks => 'रिपोर्ट भेजी गई। धन्यवाद।';
  @override
  String get cancel => 'रद्द करें';
  @override
  String specialty(Specialty value) => switch (value) {
    Specialty.vedic => 'वैदिक',
    Specialty.numerology => 'अंक ज्योतिष',
    Specialty.tarot => 'टैरो',
    Specialty.vaastu => 'वास्तु',
    Specialty.palmistry => 'हस्तरेखा',
    Specialty.kundliMatching => 'कुंडली मिलान',
    Specialty.prashna => 'प्रश्न',
    Specialty.gemstone => 'रत्न',
    Specialty.muhurta => 'मुहूर्त',
    Specialty.nadi => 'नाड़ी',
  };
  @override
  String channelName(ConsultChannel value) => switch (value) {
    ConsultChannel.chat => 'चैट',
    ConsultChannel.voice => 'वॉइस कॉल',
    ConsultChannel.video => 'वीडियो कॉल',
  };
  @override
  String sortName(AstrologerSort value) => switch (value) {
    AstrologerSort.recommended => 'अनुशंसित',
    AstrologerSort.ratingHigh => 'उच्च रेटिंग',
    AstrologerSort.experienceHigh => 'अधिक अनुभवी',
    AstrologerSort.priceLow => 'मूल्य: कम से अधिक',
    AstrologerSort.priceHigh => 'मूल्य: अधिक से कम',
    AstrologerSort.popularity => 'अधिक फ़ॉलोअर',
  };
  @override
  String reportReason(ReportReason value) => switch (value) {
    ReportReason.misleading => 'भ्रामक भविष्यवाणी',
    ReportReason.rude => 'अशिष्ट व्यवहार',
    ReportReason.spam => 'स्पैम या प्रचार',
    ReportReason.pricing => 'दिखाए गए से अलग मूल्य',
    ReportReason.impersonation => 'किसी और का रूप धरना',
    ReportReason.other => 'अन्य',
  };
  @override
  String reviewTag(String key) => switch (key) {
    'accurate' => 'सटीक',
    'patient' => 'धैर्यवान',
    'knowledgeable' => 'ज्ञानी',
    'honest' => 'ईमानदार',
    'quick' => 'तेज़',
    'practical' => 'व्यावहारिक',
    _ => key,
  };
  @override
  String languageName(String code) => switch (code) {
    'ne' => 'नेपाली',
    'hi' => 'हिन्दी',
    'en' => 'अंग्रेज़ी',
    _ => code,
  };
  @override
  String showResults(String count) => '$count ज्योतिषी देखें';
  @override
  String waitingCount(String count, String minutes) =>
      '$count प्रतीक्षा में · ~$minutes मिनट';
  @override
  String yearsLabel(String years) => '$years वर्ष';
}
