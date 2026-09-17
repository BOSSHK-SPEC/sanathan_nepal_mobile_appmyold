part of 'console_strings.dart';

class _Ne extends ConsoleStrings {
  const _Ne();
  @override
  String get becomeAstrologer => 'ज्योतिषी बन्नुहोस्';
  @override
  String get applyIntroTitle => 'सनातनमा परामर्श दिनुहोस्';
  @override
  String get applyIntroBody =>
      'आफ्नै समयअनुसार च्याट, भ्वाइस र भिडियो परामर्श लिनुहोस् । दर र समय तपाईंले तय गर्नुहुन्छ; भुक्तानी र सहयोग हामी हेर्छौं ।';
  @override
  String get requirements => 'के-के चाहिन्छ';
  @override
  String get requirementId => 'सरकारी परिचयपत्र र सेल्फी';
  @override
  String get requirementExperience => 'तपाईंको अनुभव र विशेषता';
  @override
  String get requirementPricing => 'तपाईंले लिन चाहनुभएको दर';
  @override
  String get requirementTime => 'करिब १० मिनेट';
  @override
  String get startApplication => 'आवेदन सुरु गर्नुहोस्';
  @override
  String get continueApplication => 'आवेदन जारी राख्नुहोस्';
  @override
  String get stepIdentity => 'परिचय';
  @override
  String get stepCredentials => 'अनुभव';
  @override
  String get stepExpertise => 'विशेषता';
  @override
  String get stepPricing => 'मूल्य';
  @override
  String get stepIntroduction => 'अन्तिम';
  @override
  String get fullName => 'पूरा नाम';
  @override
  String get phone => 'फोन नम्बर';
  @override
  String get email => 'इमेल';
  @override
  String get idFront => 'परिचयपत्र — अगाडि';
  @override
  String get idBack => 'परिचयपत्र — पछाडि';
  @override
  String get selfie => 'परिचयपत्र सहितको सेल्फी';
  @override
  String get certificate => 'प्रमाणपत्र (ऐच्छिक)';
  @override
  String get addressProof => 'ठेगाना प्रमाण (ऐच्छिक)';
  @override
  String uploadHint(String maxSize) => 'JPG वा PNG, $maxSize सम्म';

  @override
  String get documentAttached => 'कागजात संलग्न भयो';
  @override
  String get removeDocumentTitle => 'यो कागजात हटाउने?';
  @override
  String removeDocumentMessage(String label) =>
      '$label तपाईंको आवेदनबाट मेटिनेछ। तपाईं यसलाई फेरि अपलोड गर्न सक्नुहुन्छ।';
  @override
  String get removeDocumentConfirm => 'हटाउनुहोस्';
  @override
  String get documentRemoved => 'कागजात हटाइयो';
  @override
  String get yearsExperience => 'अनुभवका वर्ष';
  @override
  String get aboutYou => 'तपाईंको बारेमा';
  @override
  String get aboutYouHint =>
      'तपाईंले कसरी हेर्नुहुन्छ, कहाँ सिक्नुभयो, केका लागि चिनिनुहुन्छ । कम्तीमा ४० अक्षर ।';
  @override
  String get specialities => 'विशेषता';
  @override
  String get languagesYouSpeak => 'परामर्श दिने भाषा';
  @override
  String get setYourRates => 'प्रति मिनेट दर तय गर्नुहोस्';
  @override
  String get ratesNote => 'नदिने माध्यम खाली छोड्नुहोस् ।';
  @override
  String get youKeep => 'तपाईंले पाउनुहुन्छ';

  @override
  String bookedSittingCosts(String money, String minutes) =>
      '$minutes मिनेटको बुकिङको मूल्य $money';

  @override
  String rateTooHigh(String max) => 'अधिकतम दर $max/मिनेट हो';
  @override
  String get compliance => 'सूचनाहरू';

  @override
  String get complianceNeedsAction => 'तपाईंको ध्यान चाहिन्छ';

  @override
  String get compliancePast => 'पुराना सूचना';

  @override
  String get noNoticesTitle => 'हेर्नुपर्ने केही छैन';

  @override
  String get noNoticesBody => 'चेतावनी, जरिवाना र नीति अपडेट यहाँ देखिनेछन्।';

  @override
  String get acknowledge => 'बुझेँ';

  @override
  String get acknowledged => 'स्वीकार गरियो';

  @override
  String get appeal => 'उजुरी गर्नुहोस्';

  @override
  String get appealTitle => 'यस सूचनामा उजुरी';

  @override
  String get appealBody =>
      'के भयो भन्नुहोस्। हरेक उजुरी व्यक्तिले हेर्छ, सामान्यतया तीन कार्यदिनभित्र।';

  @override
  String get appealReasonHint => 'तपाईंको तर्फबाट के भयो?';

  @override
  String get submitAppeal => 'उजुरी पठाउनुहोस्';

  @override
  String get appealSubmitted => 'उजुरी पठाइयो।';

  @override
  String get underAppeal => 'उजुरीमा';

  @override
  String get amountWithheld => 'रोकिएको रकम';

  @override
  String get actionRequired => 'तपाईंले गर्नुपर्ने';

  @override
  String get dueBy => 'अन्तिम मिति';

  @override
  String get overdue => 'समय नाघ्यो';

  @override
  String get relatedSession => 'सम्बन्धित सत्र';

  @override
  String noticeKind(ComplianceKind kind) => switch (kind) {
    ComplianceKind.policyUpdate => 'नीति अपडेट',
    ComplianceKind.qualityWarning => 'गुणस्तर चेतावनी',
    ComplianceKind.lateResponse => 'छुटेका अनुरोध',
    ComplianceKind.refundIssued => 'फिर्ता गरियो',
    ComplianceKind.penalty => 'जरिवाना',
    ComplianceKind.documentExpiring => 'कागजात म्याद सकिँदै',
    ComplianceKind.suspension => 'निलम्बन',
  };

  @override
  String get workSettings => 'कार्य सेटिङ';

  @override
  String get alerts => 'सूचना';

  @override
  String get newRequestAlerts => 'नयाँ अनुरोधको सूचना';

  @override
  String get newRequestAlertsNote => 'बन्द गरे अनुरोधहरू तपाईंसम्म आउने छैनन्।';

  @override
  String get alertSound => 'आवाज बजाउनुहोस्';

  @override
  String get ringUntilAnswered => 'उत्तर नदिँदासम्म बजिरहोस्';

  @override
  String get ringUntilAnsweredNote => 'एक पटकको सूचना सजिलै छुट्छ।';

  @override
  String get scheduleReminders => 'तालिकाको सम्झना';

  @override
  String get payoutAlerts => 'भुक्तानी अपडेट';

  @override
  String get reviewAlerts => 'नयाँ समीक्षा';

  @override
  String get marketingAlerts => 'सुझाव र अफर';

  @override
  String get quietHours => 'शान्त समय';

  @override
  String get quietHoursNote =>
      'यस अवधिमा सूचना आउँदैन। तय भएका सत्रको सूचना भने आउँछ।';

  @override
  String get quietFrom => 'देखि';

  @override
  String get quietTo => 'सम्म';

  @override
  String get requestRouting => 'कुन अनुरोध तपाईंसम्म आउने';

  @override
  String get channelsYouAccept => 'तपाईंले लिने माध्यम';

  @override
  String get allChannels => 'सबै माध्यम';

  @override
  String get maxQueueLength => 'पालोको सीमा';

  @override
  String get maxQueueLengthNote =>
      'यति जना पर्खिरहेको बेला नयाँ अनुरोध रोकिन्छ।';

  @override
  String get noQueueCap => 'सीमा छैन';

  @override
  String get autoDeclineAfter => 'उत्तर नआएको अनुरोध अस्वीकार गर्ने समय';

  @override
  String get autoDeclineAfterNote =>
      'तपाईंले नदेखेको अनुरोधमा जिज्ञासु पर्खनु हुँदैन।';

  @override
  String get autoAcceptRepeat => 'पुराना ग्राहक स्वतः स्वीकार';

  @override
  String get autoAcceptRepeatNote =>
      'पहिले परामर्श गरिसकेकाहरूको अनुरोध सिधै जोडिन्छ।';

  @override
  String seconds(int value) => '${value.toString().toDevanagariDigits()} से.';

  @override
  String peopleWaiting(int value) =>
      '${value.toString().toDevanagariDigits()} जना पर्खाइमा';

  @override
  String get editProfile => 'सार्वजनिक प्रोफाइल सम्पादन';

  @override
  String get profileHeadline => 'शीर्षक';

  @override
  String get profileHeadlineHint => 'तपाईंको नाम मुनि देखिने एक लाइन।';

  @override
  String get profilePhoto => 'प्रोफाइल फोटो';

  @override
  String get profilePhotoHint =>
      'स्पष्ट अनुहारको फोटो। फोटो नभएका प्रोफाइल जिज्ञासुहरूले छाड्छन्।';

  @override
  String get profileVisibility => 'दृश्यता';

  @override
  String get hideFromSearch => 'खोजबाट लुकाउनुहोस्';

  @override
  String get hideFromSearchNote =>
      'पुराना ग्राहकले भेट्न सक्नेछन्। बाहिर हुँदा प्रयोग गर्नुहोस्।';

  @override
  String get profileStrength => 'प्रोफाइल पूर्णता';

  @override
  String get publishProfile => 'परिवर्तन प्रकाशित गर्नुहोस्';

  @override
  String get profilePublished => 'प्रोफाइल अद्यावधिक भयो।';

  @override
  String get profilePreview => 'जिज्ञासुले देखेजस्तै हेर्नुहोस्';

  @override
  String get introVideo => 'परिचय भिडियो (ऐच्छिक)';
  @override
  String get introVideoHint =>
      'छोटो भिडियोले सेवाग्राहीलाई छान्न सजिलो बनाउँछ ।';
  @override
  String get termsTitle => 'कमिसन र आचरण';
  @override
  String get termsBody =>
      'सम्पन्न प्रत्येक परामर्शमा प्लेटफर्मले कमिसन लिन्छ । स्वीकार गरिएका अनुरोधमा जवाफ दिने, ग्राहकको विवरण गोप्य राख्ने र परिणामको ग्यारेन्टी नदिने सहमति ।';
  @override
  String get acceptTerms => 'म यी सर्त स्वीकार गर्छु';
  @override
  String get submitApplication => 'आवेदन पठाउनुहोस्';
  @override
  String get back => 'पछाडि';
  @override
  String get next => 'अर्को';
  @override
  String stepIncomplete(String what) => 'जारी राख्न $what थप्नुहोस्';

  @override
  String aboutYouShort(int remaining) => 'तपाईंको बारेमा (थप $remaining अक्षर)';

  @override
  String get stepIncompleteGeneric => 'जारी राख्न यो चरण पूरा गर्नुहोस्';
  @override
  String get submittedTitle => 'आवेदन पठाइयो';
  @override
  String get submittedBody =>
      'हामी दुई कार्यदिनभित्र समीक्षा गरी जानकारी दिनेछौं ।';
  @override
  String get applicationStatus => 'आवेदनको स्थिति';
  @override
  String get statusSubmitted => 'पठाइयो';
  @override
  String get statusUnderReview => 'समीक्षामा';
  @override
  String get statusMoreInfo => 'थप जानकारी चाहियो';
  @override
  String get statusApproved => 'स्वीकृत';
  @override
  String get statusRejected => 'स्वीकृत भएन';
  @override
  String get statusDraft => 'मस्यौदा';
  @override
  String get statusNotStarted => 'सुरु भएको छैन';
  @override
  String get reviewerNote => 'समीक्षकको टिप्पणी';
  @override
  String get fixAndResubmit => 'सच्याएर पुनः पठाउनुहोस्';
  @override
  String get openConsole => 'कन्सोल खोल्नुहोस्';
  @override
  String get console => 'कन्सोल';
  @override
  String get navQueue => 'पालो';
  @override
  String get navSchedule => 'तालिका';
  @override
  String get navEarnings => 'आम्दानी';
  @override
  String get navClients => 'ग्राहक';
  @override
  String get switchToPersonal => 'व्यक्तिगतमा जानुहोस्';
  @override
  String get switchToAstrologer => 'ज्योतिषीमा जानुहोस्';
  @override
  String get goOnline => 'अनलाइन जानुहोस्';
  @override
  String get goOffline => 'अफलाइन जानुहोस्';
  @override
  String get youAreOnline => 'तपाईं अनलाइन हुनुहुन्छ';
  @override
  String get youAreOffline => 'तपाईं अफलाइन हुनुहुन्छ';
  @override
  String get setScheduleFirst => 'अनलाइन जानुअघि साप्ताहिक समय तय गर्नुहोस्';
  @override
  String get setScheduleAction => 'समय तय गर्नुहोस्';
  @override
  String get availabilityUnavailable => 'तपाईंको उपलब्धता जाँच्न सकिएन';
  @override
  String get onlineChangeFailed => 'तपाईंको स्थिति बदल्न सकिएन';
  @override
  String get earningsToday => 'आज';
  @override
  String get earningsWeek => 'यो हप्ता';
  @override
  String get sessionsToday => 'परामर्श';
  @override
  String get waitingNow => 'पर्खिरहेका';
  @override
  String get yourRating => 'रेटिङ';
  @override
  String get acceptanceRate => 'स्वीकृति दर';
  @override
  String get responseTime => 'प्रतिक्रिया';
  @override
  String get repeatRate => 'दोहोरिने ग्राहक';
  @override
  String get acceptanceWarning => 'स्वीकृति दर कम भए कम अनुरोध आउँछन्';
  @override
  String get ongoingSessions => 'चलिरहेका परामर्श';

  @override
  String get rejoin => 'फेरि जोडिनुहोस्';

  @override
  String get liveQueue => 'अहिले पर्खिरहेका';
  @override
  String get queueEmpty => 'कोही पर्खिरहेको छैन';
  @override
  String get queueEmptyOffline => 'अनुरोध पाउन अनलाइन जानुहोस् ।';
  @override
  String get queueEmptyOnline => 'कोही आउनेबित्तिकै जानकारी दिइनेछ ।';
  @override
  String get repeatClient => 'दोहोरिएको';
  @override
  String get lowBalanceWarning => 'कम ब्यालेन्स';
  @override
  String get newRequest => 'नयाँ परामर्श अनुरोध';
  @override
  String get accept => 'स्वीकार';
  @override
  String get decline => 'अस्वीकार';
  @override
  String get waitingFor => 'पर्खेको';
  @override
  String get weeklyHours => 'साप्ताहिक घण्टा';
  @override
  String get addWindow => 'समय थप्नुहोस्';
  @override
  String get copyToWeekdays => 'सबै कार्यदिनमा लागू';
  @override
  String get noWindows => 'समय तय भएको छैन';
  @override
  String get blackoutDates => 'बिदाका दिन';
  @override
  String get addBlackout => 'बिदा थप्नुहोस्';
  @override
  String get noBlackouts => 'कुनै बिदा छैन';
  @override
  String get bufferBetween => 'परामर्शबीच विश्राम';
  @override
  String get saveSchedule => 'तालिका सुरक्षित';
  @override
  String get scheduleSaved => 'तालिका सुरक्षित भयो';
  @override
  String get from => 'देखि';
  @override
  String get to => 'सम्म';
  @override
  String get add => 'थप्नुहोस्';
  @override
  String get cancel => 'रद्द';
  @override
  String get reason => 'कारण';
  @override
  String get searchClients => 'ग्राहक खोज्नुहोस्';
  @override
  String get noClients => 'अहिलेसम्म ग्राहक छैन';
  @override
  String get noClientsBody =>
      'तपाईंले परामर्श दिनुभएका व्यक्ति इतिहाससहित यहाँ देखिनेछन् ।';
  @override
  String get sortRecent => 'हालैका';
  @override
  String get sortValue => 'बढी मूल्य';
  @override
  String get sortSessions => 'बढी परामर्श';
  @override
  String get sessions => 'परामर्श';
  @override
  String get lifetimeValue => 'कुल मूल्य';
  @override
  String get lastSession => 'अन्तिम परामर्श';
  @override
  String get birthDetails => 'जन्म विवरण';
  @override
  String get privateNotes => 'तपाईंको निजी टिप्पणी';
  @override
  String get notesHint => 'यो तपाईंले मात्र देख्नुहुन्छ ।';
  @override
  String get saveNotes => 'टिप्पणी सुरक्षित';
  @override
  String get earnings => 'आम्दानी';
  @override
  String get gross => 'कुल';
  @override
  String get commission => 'कमिसन';
  @override
  String get net => 'तपाईंको आम्दानी';
  @override
  String get pendingBalance => 'प्रक्रियामा';
  @override
  String get availableBalance => 'झिक्न मिल्ने';
  @override
  String get rangeToday => 'आज';
  @override
  String get rangeWeek => 'हप्ता';
  @override
  String get rangeMonth => 'महिना';
  @override
  String get rangeYear => 'वर्ष';
  @override
  String get noEarnings => 'यो अवधिमा आम्दानी छैन';
  @override
  String get withdraw => 'झिक्नुहोस्';
  @override
  String get payoutAccount => 'भुक्तानी खाता';
  @override
  String get addPayoutAccount => 'भुक्तानी खाता थप्नुहोस्';
  @override
  String get payoutAccountBody => 'आम्दानी पठाउन खाता चाहिन्छ ।';
  @override
  String get accountHolder => 'खातावालाको नाम';
  @override
  String get accountNumber => 'खाता नम्बर';
  @override
  String get bankName => 'बैंकको नाम';
  @override
  String get walletId => 'वालेट आईडी';
  @override
  String get upiId => 'यूपीआई आईडी';
  @override
  String get saveAccount => 'खाता सुरक्षित';
  @override
  String get verificationPending =>
      'खाता प्रमाणीकरण हुँदैछ । पुष्टि भएपछि झिक्न मिल्नेछ ।';
  @override
  String get verified => 'प्रमाणित';
  @override
  String get withdrawAmount => 'झिक्ने रकम';
  @override
  String get withdrawAll => 'सबै';
  @override
  String get processingFee => 'प्रक्रिया शुल्क';
  @override
  String get youWillReceive => 'तपाईंले पाउनुहुनेछ';
  @override
  String get requestPayout => 'भुक्तानी माग्नुहोस्';
  @override
  String get payoutRequested => 'भुक्तानी अनुरोध पठाइयो';
  @override
  String get payoutHistory => 'भुक्तानी इतिहास';
  @override
  String get noPayouts => 'अहिलेसम्म भुक्तानी छैन';
  @override
  String get payoutRequestedStatus => 'अनुरोध गरिएको';
  @override
  String get payoutProcessing => 'प्रक्रियामा';
  @override
  String get payoutPaid => 'भुक्तानी भयो';
  @override
  String get payoutFailed => 'असफल';
  @override
  String get taxDocuments => 'कर कागजात';
  @override
  String get financialYear => 'आर्थिक वर्ष';
  @override
  String get download => 'डाउनलोड';
  @override
  String get pricing => 'मूल्य';
  @override
  String get perMinute => '/मिनेट';
  @override
  String get freeFirstMinutes => 'नयाँ ग्राहकलाई निःशुल्क मिनेट';
  @override
  String get freeMinutesNote => 'छोटो निःशुल्क समयले पहिलो परामर्श बढाउँछ ।';
  @override
  String get savePricing => 'मूल्य सुरक्षित';
  @override
  String get pricingSaved => 'मूल्य सुरक्षित भयो';
  @override
  String get notOffered => 'उपलब्ध छैन';
  @override
  String get reviews => 'समीक्षा';
  @override
  String get needsReply => 'जवाफ चाहिने';
  @override
  String get allReviews => 'सबै';
  @override
  String get critical => 'आलोचनात्मक';
  @override
  String get writeReply => 'जवाफ लेख्नुहोस्';
  @override
  String get replyHint => 'शान्त र स्पष्ट जवाफ राम्रो देखिन्छ ।';
  @override
  String get sendReply => 'जवाफ पठाउनुहोस्';
  @override
  String get replyPosted => 'जवाफ पठाइयो';
  @override
  String get noReviews => 'जवाफ दिनुपर्ने केही छैन';
  @override
  String get analytics => 'प्रदर्शन';
  @override
  String get totalSessions => 'परामर्श';
  @override
  String get totalMinutes => 'मिनेट';
  @override
  String get avgSession => 'औसत परामर्श';
  @override
  String get avgEarning => 'प्रति परामर्श औसत';
  @override
  String get byChannel => 'माध्यम अनुसार';
  @override
  String get earningsTrend => 'आम्दानीको प्रवृत्ति';
  @override
  String get boost => 'बुस्ट';
  @override
  String get popular => 'लोकप्रिय';
  @override
  String get boostBody =>
      'खोजमा माथि देखिन शुल्क तिर्नुहोस् । झिक्न मिल्ने ब्यालेन्सबाट कट्छ ।';
  @override
  String get activeBoosts => 'हाल चलिरहेको';
  @override
  String get pastBoosts => 'विगतका बुस्ट';
  @override
  String get choosePlan => 'योजना छान्नुहोस्';
  @override
  String get placementTopOfList => 'खोजको माथि';
  @override
  String get placementHomeRail => 'गृहपृष्ठमा विशेष';
  @override
  String get placementTargeted => 'मिल्दा सेवाग्राही';
  @override
  String get daysLabel => 'दिन';
  @override
  String get estimatedImpressions => 'अनुमानित हेराइ';
  @override
  String get perDay => 'प्रति दिन';
  @override
  String get buyBoost => 'बुस्ट किन्नुहोस्';
  @override
  String get boostBought => 'बुस्ट सुरु भयो';
  @override
  String get cannotAfford => 'यो योजनाका लागि पर्याप्त ब्यालेन्स छैन ।';
  @override
  String get impressions => 'हेराइ';
  @override
  String get profileViews => 'प्रोफाइल खुलेको';
  @override
  String get consultationsFromBoost => 'परामर्श';
  @override
  String get costPerConsultation => 'प्रति परामर्श लागत';
  @override
  String get daysLeft => 'बाँकी';
  @override
  String get noBoosts => 'अहिलेसम्म बुस्ट छैन';
  @override
  String get noBoostsBody =>
      'बुस्टले निश्चित अवधिसम्म बढी सेवाग्राहीसामु पुर्‍याउँछ ।';
  @override
  String placementName(BoostPlacement value) => switch (value) {
    BoostPlacement.topOfList => placementTopOfList,
    BoostPlacement.homeRail => placementHomeRail,
    BoostPlacement.targeted => placementTargeted,
  };
  @override
  String weekdayShort(int weekday) => const [
    'सोम',
    'मंगल',
    'बुध',
    'बिहि',
    'शुक्र',
    'शनि',
    'आइत',
  ][(weekday - 1).clamp(0, 6)];
  @override
  String statusName(ApplicationStatus value) => switch (value) {
    ApplicationStatus.notStarted => statusNotStarted,
    ApplicationStatus.draft => statusDraft,
    ApplicationStatus.submitted => statusSubmitted,
    ApplicationStatus.underReview => statusUnderReview,
    ApplicationStatus.moreInfoNeeded => statusMoreInfo,
    ApplicationStatus.approved => statusApproved,
    ApplicationStatus.rejected => statusRejected,
  };
  @override
  String rangeName(EarningsRange value) => switch (value) {
    EarningsRange.today => rangeToday,
    EarningsRange.week => rangeWeek,
    EarningsRange.month => rangeMonth,
    EarningsRange.year => rangeYear,
  };
  @override
  String payoutStatusName(PayoutStatus value) => switch (value) {
    PayoutStatus.requested => payoutRequestedStatus,
    PayoutStatus.processing => payoutProcessing,
    PayoutStatus.paid => payoutPaid,
    PayoutStatus.failed => payoutFailed,
  };
  @override
  String destinationName(PayoutDestination value) => switch (value) {
    PayoutDestination.bankAccount => bankName,
    PayoutDestination.esewa => 'eSewa',
    PayoutDestination.khalti => 'Khalti',
    PayoutDestination.upi => 'UPI',
  };
  @override
  String stepName(KycStep value) => switch (value) {
    KycStep.identity => stepIdentity,
    KycStep.credentials => stepCredentials,
    KycStep.expertise => stepExpertise,
    KycStep.pricing => stepPricing,
    KycStep.introduction => stepIntroduction,
  };
  @override
  String stepCounter(String current, String total) => '$current / $total';
  @override
  String minutesLabel(String minutes) => '$minutes मिनेट';

  // --- Appointments ---
  @override
  String get apptTitle => 'भेटघाटहरू';
  @override
  String get apptUpcomingSection => 'आउँदा भेटघाट';
  @override
  String get apptUpcomingTab => 'आउँदा';
  @override
  String get apptPastTab => 'विगत';
  @override
  String get apptSeeAll => 'सबै हेर्नुहोस्';
  @override
  String get apptNoUpcoming => 'कुनै आउँदा भेटघाट छैन';
  @override
  String get apptNoUpcomingHint =>
      'कसैले तपाईंसँग भेटघाट बुक गरेपछि यहाँ उनको विवरणसहित देखिन्छ।';
  @override
  String get apptNoPast => 'अहिलेसम्म कुनै विगतका भेटघाट छैनन्';
  @override
  String get apptDetails => 'भेटघाट';
  @override
  String get apptClient => 'ग्राहक';
  @override
  String get apptPhone => 'फोन';
  @override
  String get apptEmail => 'इमेल';
  @override
  String get apptCountry => 'देश';
  @override
  String get apptCall => 'फोन गर्नुहोस्';
  @override
  String get apptWhatsapp => 'ह्वाट्सएप';
  @override
  String get apptBirthDetails => 'जन्म विवरण';
  @override
  String get apptBirthDate => 'जन्म मिति';
  @override
  String get apptBirthTime => 'जन्म समय';
  @override
  String get apptBirthPlace => 'जन्म स्थान';
  @override
  String get apptBirthMissing => 'ग्राहकले जन्म विवरण दिनुभएको छैन।';
  @override
  String get apptClientNote => 'ग्राहकको टिप्पणी';
  @override
  String get apptAttachments => 'संलग्न फाइलहरू';
  @override
  String get apptBirthChart => 'चिना';
  @override
  String get apptReceipt => 'भुक्तानी रसिद';
  @override
  String get apptOpenFile => 'खोल्नुहोस्';
  @override
  String get apptFileUnavailable => 'यो फाइल अब उपलब्ध छैन।';
  @override
  String get apptSitting => 'भेटघाट विवरण';
  @override
  String get apptType => 'प्रकार';
  @override
  String get apptAdvice => 'तपाईंले दिनुभएको सल्लाह';
  @override
  String get apptFollowUp => 'फलोअप';
  @override
  String get apptWhen => 'कहिले';
  @override
  String get apptLength => 'अवधि';
  @override
  String get apptAmount => 'रकम';
  @override
  String get apptPayment => 'भुक्तानी';
  @override
  String get apptMarkCompleted => 'सम्पन्न भयो भनी चिन्ह लगाउनुहोस्';
  @override
  String get apptMarkNoShow => 'ग्राहक आउनुभएन';
  @override
  String get apptCancel => 'भेटघाट रद्द गर्नुहोस्';
  @override
  String get apptOutcomeAfterStart =>
      'भेटघाट सुरु भएपछि मात्र परिणाम चिन्ह लगाउन सकिन्छ।';
  @override
  String get apptCancelTitle => 'यो भेटघाट रद्द गर्ने?';
  @override
  String get apptCancelBody =>
      'तपाईंले रद्द गर्नुभएको र कारण ग्राहकले देख्नुहुनेछ, र यो समय फेरि तपाईंको तालिकामा खुल्नेछ।';
  @override
  String get apptCancelReasonHint => 'ग्राहकका लागि कारण';
  @override
  String get apptCancelReasonTooShort => 'छोटकरीमा कारण लेख्नुहोस्।';
  @override
  String get apptConfirmCancel => 'भेटघाट रद्द गर्नुहोस्';
  @override
  String get apptKeep => 'राख्नुहोस्';
  @override
  String get apptMarkedCompleted => 'सम्पन्न भनी चिन्ह लगाइयो।';
  @override
  String get apptMarkedNoShow => 'ग्राहक नआएको भनी चिन्ह लगाइयो।';
  @override
  String get apptCancelled => 'भेटघाट रद्द गरियो।';
  @override
  String get apptCouldNotOpen => 'यो फोनमा खोल्न सकिएन।';
  @override
  String apptReference(String reference) => 'बुकिङ $reference';
  @override
  String apptSeats(String count) => '$count जनाका लागि';
  @override
  String apptStatus(ConsoleAppointmentStatus status) => switch (status) {
    ConsoleAppointmentStatus.pending => 'बाँकी',
    ConsoleAppointmentStatus.confirmed => 'पक्का',
    ConsoleAppointmentStatus.completed => 'सम्पन्न',
    ConsoleAppointmentStatus.cancelled => 'रद्द',
    ConsoleAppointmentStatus.noShow => 'ग्राहक आएनन्',
    ConsoleAppointmentStatus.rescheduled => 'समय सारिएको',
    ConsoleAppointmentStatus.missed => 'छुट्यो',
    ConsoleAppointmentStatus.declined => 'अस्वीकार गरियो',
  };
  @override
  String apptChannel(String? channel) => switch (channel) {
    'chat' => 'च्याट',
    'voice' => 'भ्वाइस कल',
    'video' => 'भिडियो कल',
    _ => 'सत्र',
  };
  @override
  String apptRemedyKind(RemedyKind kind) => switch (kind) {
    RemedyKind.gemstone => 'रत्न',
    RemedyKind.mantra => 'मन्त्र',
    RemedyKind.puja => 'पूजा',
    RemedyKind.donation => 'दान',
    RemedyKind.fasting => 'व्रत',
    RemedyKind.practice => 'अभ्यास',
  };
}
