part of 'console_strings.dart';

class _Hi extends ConsoleStrings {
  const _Hi();
  @override
  String get becomeAstrologer => 'ज्योतिषी बनें';
  @override
  String get applyIntroTitle => 'सनातन पर परामर्श दें';
  @override
  String get applyIntroBody =>
      'अपने समय के अनुसार चैट, वॉइस और वीडियो परामर्श लें। दर और समय आप तय करें; भुगतान और सहायता हम देखते हैं।';
  @override
  String get requirements => 'क्या-क्या चाहिए';
  @override
  String get requirementId => 'सरकारी पहचान पत्र और सेल्फी';
  @override
  String get requirementExperience => 'आपका अनुभव और विशेषज्ञता';
  @override
  String get requirementPricing => 'आप जो दर लेना चाहते हैं';
  @override
  String get requirementTime => 'लगभग 10 मिनट';
  @override
  String get startApplication => 'आवेदन शुरू करें';
  @override
  String get continueApplication => 'आवेदन जारी रखें';
  @override
  String get stepIdentity => 'पहचान';
  @override
  String get stepCredentials => 'अनुभव';
  @override
  String get stepExpertise => 'विशेषज्ञता';
  @override
  String get stepPricing => 'मूल्य';
  @override
  String get stepIntroduction => 'अंतिम';
  @override
  String get fullName => 'पूरा नाम';
  @override
  String get phone => 'फ़ोन नंबर';
  @override
  String get email => 'ईमेल';
  @override
  String get idFront => 'पहचान पत्र — सामने';
  @override
  String get idBack => 'पहचान पत्र — पीछे';
  @override
  String get selfie => 'पहचान पत्र के साथ सेल्फी';
  @override
  String get certificate => 'प्रमाणपत्र (वैकल्पिक)';
  @override
  String get addressProof => 'पता प्रमाण (वैकल्पिक)';
  @override
  String uploadHint(String maxSize) => 'JPG या PNG, $maxSize तक';

  @override
  String get documentAttached => 'दस्तावेज़ संलग्न';
  @override
  String get removeDocumentTitle => 'यह दस्तावेज़ हटाएँ?';
  @override
  String removeDocumentMessage(String label) =>
      '$label आपके आवेदन से हटा दिया जाएगा। आप इसे दोबारा अपलोड कर सकते हैं।';
  @override
  String get removeDocumentConfirm => 'हटाएँ';
  @override
  String get documentRemoved => 'दस्तावेज़ हटा दिया गया';
  @override
  String get yearsExperience => 'अनुभव के वर्ष';
  @override
  String get aboutYou => 'आपके बारे में';
  @override
  String get aboutYouHint =>
      'आप कैसे पठन करते हैं, कहाँ सीखा, किसके लिए जाने जाते हैं। कम से कम 40 अक्षर।';
  @override
  String get specialities => 'विशेषज्ञता';
  @override
  String get languagesYouSpeak => 'परामर्श की भाषाएँ';
  @override
  String get setYourRates => 'प्रति मिनट दर तय करें';
  @override
  String get ratesNote => 'जो माध्यम नहीं देते उसे खाली छोड़ें।';
  @override
  String get youKeep => 'आपको मिलेगा';

  @override
  String bookedSittingCosts(String money, String minutes) =>
      '$minutes मिनट की बुकिंग का मूल्य $money';

  @override
  String rateTooHigh(String max) => 'अधिकतम दर $max/मिनट है';
  @override
  String get compliance => 'सूचनाएँ';

  @override
  String get complianceNeedsAction => 'आपके ध्यान की ज़रूरत';

  @override
  String get compliancePast => 'पुरानी सूचनाएँ';

  @override
  String get noNoticesTitle => 'देखने को कुछ नहीं';

  @override
  String get noNoticesBody => 'चेतावनी, जुर्माना और नीति अपडेट यहाँ दिखेंगे।';

  @override
  String get acknowledge => 'समझ गया';

  @override
  String get acknowledged => 'स्वीकार किया';

  @override
  String get appeal => 'अपील करें';

  @override
  String get appealTitle => 'इस सूचना पर अपील';

  @override
  String get appealBody =>
      'बताइए क्या हुआ। हर अपील एक व्यक्ति देखता है, आमतौर पर तीन कार्यदिवस में।';

  @override
  String get appealReasonHint => 'आपकी ओर से क्या हुआ?';

  @override
  String get submitAppeal => 'अपील भेजें';

  @override
  String get appealSubmitted => 'अपील भेज दी गई।';

  @override
  String get underAppeal => 'अपील में';

  @override
  String get amountWithheld => 'रोकी गई राशि';

  @override
  String get actionRequired => 'आपको क्या करना है';

  @override
  String get dueBy => 'अंतिम तिथि';

  @override
  String get overdue => 'समय बीत गया';

  @override
  String get relatedSession => 'संबंधित सत्र';

  @override
  String noticeKind(ComplianceKind kind) => switch (kind) {
    ComplianceKind.policyUpdate => 'नीति अपडेट',
    ComplianceKind.qualityWarning => 'गुणवत्ता चेतावनी',
    ComplianceKind.lateResponse => 'छूटे अनुरोध',
    ComplianceKind.refundIssued => 'रिफ़ंड जारी',
    ComplianceKind.penalty => 'जुर्माना',
    ComplianceKind.documentExpiring => 'दस्तावेज़ समाप्त हो रहा',
    ComplianceKind.suspension => 'निलंबन',
  };

  @override
  String get workSettings => 'कार्य सेटिंग';

  @override
  String get alerts => 'सूचनाएँ';

  @override
  String get newRequestAlerts => 'नए अनुरोध की सूचना';

  @override
  String get newRequestAlertsNote =>
      'बंद करने पर अनुरोध आप तक पहुँचेंगे ही नहीं।';

  @override
  String get alertSound => 'ध्वनि बजाएँ';

  @override
  String get ringUntilAnswered => 'उत्तर देने तक बजती रहे';

  @override
  String get ringUntilAnsweredNote => 'एक बार की सूचना आसानी से छूट जाती है।';

  @override
  String get scheduleReminders => 'शेड्यूल अनुस्मारक';

  @override
  String get payoutAlerts => 'भुगतान अपडेट';

  @override
  String get reviewAlerts => 'नई समीक्षाएँ';

  @override
  String get marketingAlerts => 'सुझाव और ऑफ़र';

  @override
  String get quietHours => 'शांत घंटे';

  @override
  String get quietHoursNote =>
      'इस अवधि में सूचना नहीं आएगी। तय सत्रों की सूचना फिर भी मिलेगी।';

  @override
  String get quietFrom => 'से';

  @override
  String get quietTo => 'तक';

  @override
  String get requestRouting => 'कौन-से अनुरोध आप तक आएँ';

  @override
  String get channelsYouAccept => 'आप जो माध्यम लेते हैं';

  @override
  String get allChannels => 'सभी माध्यम';

  @override
  String get maxQueueLength => 'क़तार की सीमा';

  @override
  String get maxQueueLengthNote =>
      'इतने लोग प्रतीक्षा में हों तो नए अनुरोध रुक जाते हैं।';

  @override
  String get noQueueCap => 'कोई सीमा नहीं';

  @override
  String get autoDeclineAfter => 'अनुत्तरित अनुरोध अस्वीकार करने का समय';

  @override
  String get autoDeclineAfterNote =>
      'जिस अनुरोध को आपने देखा ही नहीं, उस पर कोई प्रतीक्षा न करे।';

  @override
  String get autoAcceptRepeat => 'लौटे ग्राहकों को स्वतः स्वीकार';

  @override
  String get autoAcceptRepeatNote =>
      'जिनसे पहले परामर्श हो चुका है, उनके अनुरोध सीधे जुड़ जाते हैं।';

  @override
  String seconds(int value) => '${value.toString().toDevanagariDigits()} से.';

  @override
  String peopleWaiting(int value) =>
      '${value.toString().toDevanagariDigits()} प्रतीक्षा में';

  @override
  String get editProfile => 'सार्वजनिक प्रोफ़ाइल संपादित करें';

  @override
  String get profileHeadline => 'शीर्षक';

  @override
  String get profileHeadlineHint => 'आपके नाम के नीचे दिखने वाली एक पंक्ति।';

  @override
  String get profilePhoto => 'प्रोफ़ाइल फ़ोटो';

  @override
  String get profilePhotoHint =>
      'स्पष्ट चेहरे की फ़ोटो। बिना फ़ोटो वाली प्रोफ़ाइल लोग छोड़ देते हैं।';

  @override
  String get profileVisibility => 'दृश्यता';

  @override
  String get hideFromSearch => 'मुझे खोज से छिपाएँ';

  @override
  String get hideFromSearchNote =>
      'मौजूदा ग्राहक फिर भी संपर्क कर सकेंगे। छुट्टी पर इसका उपयोग करें।';

  @override
  String get profileStrength => 'प्रोफ़ाइल पूर्णता';

  @override
  String get publishProfile => 'परिवर्तन प्रकाशित करें';

  @override
  String get profilePublished => 'प्रोफ़ाइल अपडेट हो गई।';

  @override
  String get profilePreview => 'जिज्ञासु की तरह देखें';

  @override
  String get introVideo => 'परिचय वीडियो (वैकल्पिक)';
  @override
  String get introVideoHint => 'छोटा वीडियो लोगों को चुनने में मदद करता है।';
  @override
  String get termsTitle => 'कमीशन और आचरण';
  @override
  String get termsBody =>
      'प्रत्येक पूर्ण परामर्श पर प्लेटफ़ॉर्म कमीशन लेता है। स्वीकृत अनुरोधों का उत्तर देने, ग्राहक विवरण गोपनीय रखने और परिणाम की गारंटी न देने की सहमति।';
  @override
  String get acceptTerms => 'मैं इन शर्तों को स्वीकार करता हूँ';
  @override
  String get submitApplication => 'आवेदन भेजें';
  @override
  String get back => 'पीछे';
  @override
  String get next => 'अगला';
  @override
  String stepIncomplete(String what) => 'जारी रखने के लिए $what जोड़ें';

  @override
  String aboutYouShort(int remaining) => 'आपके बारे में ($remaining और अक्षर)';

  @override
  String get stepIncompleteGeneric => 'जारी रखने के लिए यह चरण पूरा करें';
  @override
  String get submittedTitle => 'आवेदन भेजा गया';
  @override
  String get submittedBody => 'हम दो कार्यदिवसों में समीक्षा कर सूचित करेंगे।';
  @override
  String get applicationStatus => 'आवेदन की स्थिति';
  @override
  String get statusSubmitted => 'भेजा गया';
  @override
  String get statusUnderReview => 'समीक्षा में';
  @override
  String get statusMoreInfo => 'अधिक जानकारी चाहिए';
  @override
  String get statusApproved => 'स्वीकृत';
  @override
  String get statusRejected => 'स्वीकृत नहीं';
  @override
  String get statusDraft => 'ड्राफ़्ट';
  @override
  String get statusNotStarted => 'शुरू नहीं हुआ';
  @override
  String get reviewerNote => 'समीक्षक की टिप्पणी';
  @override
  String get fixAndResubmit => 'सुधारकर फिर भेजें';
  @override
  String get openConsole => 'कंसोल खोलें';
  @override
  String get console => 'कंसोल';
  @override
  String get navQueue => 'कतार';
  @override
  String get navSchedule => 'समय-सारणी';
  @override
  String get navEarnings => 'आय';
  @override
  String get navClients => 'ग्राहक';
  @override
  String get switchToPersonal => 'व्यक्तिगत पर जाएँ';
  @override
  String get switchToAstrologer => 'ज्योतिषी पर जाएँ';
  @override
  String get goOnline => 'ऑनलाइन जाएँ';
  @override
  String get goOffline => 'ऑफ़लाइन जाएँ';
  @override
  String get youAreOnline => 'आप ऑनलाइन हैं';
  @override
  String get youAreOffline => 'आप ऑफ़लाइन हैं';
  @override
  String get setScheduleFirst => 'ऑनलाइन जाने से पहले साप्ताहिक समय तय करें';
  @override
  String get setScheduleAction => 'समय तय करें';
  @override
  String get availabilityUnavailable => 'आपकी उपलब्धता जाँची नहीं जा सकी';
  @override
  String get onlineChangeFailed => 'आपकी स्थिति बदली नहीं जा सकी';
  @override
  String get earningsToday => 'आज';
  @override
  String get earningsWeek => 'इस सप्ताह';
  @override
  String get sessionsToday => 'परामर्श';
  @override
  String get waitingNow => 'प्रतीक्षा में';
  @override
  String get yourRating => 'रेटिंग';
  @override
  String get acceptanceRate => 'स्वीकृति दर';
  @override
  String get responseTime => 'प्रतिक्रिया';
  @override
  String get repeatRate => 'दोहराने वाले ग्राहक';
  @override
  String get acceptanceWarning => 'स्वीकृति दर कम होने पर कम अनुरोध आते हैं';
  @override
  String get ongoingSessions => 'चल रहे परामर्श';

  @override
  String get rejoin => 'फिर से जुड़ें';

  @override
  String get liveQueue => 'अभी प्रतीक्षा में';
  @override
  String get queueEmpty => 'कोई प्रतीक्षा में नहीं';
  @override
  String get queueEmptyOffline => 'अनुरोध पाने के लिए ऑनलाइन जाएँ।';
  @override
  String get queueEmptyOnline => 'जैसे ही कोई आएगा सूचित किया जाएगा।';
  @override
  String get repeatClient => 'दोहराया';
  @override
  String get lowBalanceWarning => 'कम शेष';
  @override
  String get newRequest => 'नया परामर्श अनुरोध';
  @override
  String get accept => 'स्वीकार';
  @override
  String get decline => 'अस्वीकार';
  @override
  String get waitingFor => 'प्रतीक्षा';
  @override
  String get weeklyHours => 'साप्ताहिक घंटे';
  @override
  String get addWindow => 'समय जोड़ें';
  @override
  String get copyToWeekdays => 'सभी कार्यदिवसों पर लागू';
  @override
  String get noWindows => 'समय तय नहीं';
  @override
  String get blackoutDates => 'छुट्टी के दिन';
  @override
  String get addBlackout => 'छुट्टी जोड़ें';
  @override
  String get noBlackouts => 'कोई छुट्टी नहीं';
  @override
  String get bufferBetween => 'परामर्श के बीच विश्राम';
  @override
  String get saveSchedule => 'समय-सारणी सहेजें';
  @override
  String get scheduleSaved => 'समय-सारणी सहेजी गई';
  @override
  String get from => 'से';
  @override
  String get to => 'तक';
  @override
  String get add => 'जोड़ें';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get reason => 'कारण';
  @override
  String get searchClients => 'ग्राहक खोजें';
  @override
  String get noClients => 'अभी कोई ग्राहक नहीं';
  @override
  String get noClientsBody =>
      'आपके परामर्श लेने वाले लोग इतिहास सहित यहाँ दिखेंगे।';
  @override
  String get sortRecent => 'हाल के';
  @override
  String get sortValue => 'अधिक मूल्य';
  @override
  String get sortSessions => 'अधिक परामर्श';
  @override
  String get sessions => 'परामर्श';
  @override
  String get lifetimeValue => 'कुल मूल्य';
  @override
  String get lastSession => 'अंतिम परामर्श';
  @override
  String get birthDetails => 'जन्म विवरण';
  @override
  String get privateNotes => 'आपकी निजी टिप्पणी';
  @override
  String get notesHint => 'यह केवल आप देख सकते हैं।';
  @override
  String get saveNotes => 'टिप्पणी सहेजें';
  @override
  String get earnings => 'आय';
  @override
  String get gross => 'कुल';
  @override
  String get commission => 'कमीशन';
  @override
  String get net => 'आपकी आय';
  @override
  String get pendingBalance => 'प्रक्रिया में';
  @override
  String get availableBalance => 'निकालने योग्य';
  @override
  String get rangeToday => 'आज';
  @override
  String get rangeWeek => 'सप्ताह';
  @override
  String get rangeMonth => 'महीना';
  @override
  String get rangeYear => 'वर्ष';
  @override
  String get noEarnings => 'इस अवधि में कोई आय नहीं';
  @override
  String get withdraw => 'निकालें';
  @override
  String get payoutAccount => 'भुगतान खाता';
  @override
  String get addPayoutAccount => 'भुगतान खाता जोड़ें';
  @override
  String get payoutAccountBody => 'आय भेजने के लिए खाता आवश्यक है।';
  @override
  String get accountHolder => 'खाताधारक का नाम';
  @override
  String get accountNumber => 'खाता संख्या';
  @override
  String get bankName => 'बैंक का नाम';
  @override
  String get walletId => 'वॉलेट आईडी';
  @override
  String get upiId => 'यूपीआई आईडी';
  @override
  String get saveAccount => 'खाता सहेजें';
  @override
  String get verificationPending =>
      'खाता सत्यापित हो रहा है। पुष्टि के बाद निकासी शुरू होगी।';
  @override
  String get verified => 'सत्यापित';
  @override
  String get withdrawAmount => 'निकालने की राशि';
  @override
  String get withdrawAll => 'सभी';
  @override
  String get processingFee => 'प्रक्रिया शुल्क';
  @override
  String get youWillReceive => 'आपको मिलेगा';
  @override
  String get requestPayout => 'भुगतान माँगें';
  @override
  String get payoutRequested => 'भुगतान अनुरोध भेजा गया';
  @override
  String get payoutHistory => 'भुगतान इतिहास';
  @override
  String get noPayouts => 'अभी कोई भुगतान नहीं';
  @override
  String get payoutRequestedStatus => 'अनुरोध किया';
  @override
  String get payoutProcessing => 'प्रक्रिया में';
  @override
  String get payoutPaid => 'भुगतान हुआ';
  @override
  String get payoutFailed => 'विफल';
  @override
  String get taxDocuments => 'कर दस्तावेज़';
  @override
  String get financialYear => 'वित्तीय वर्ष';
  @override
  String get download => 'डाउनलोड';
  @override
  String get pricing => 'मूल्य';
  @override
  String get perMinute => '/मिनट';
  @override
  String get freeFirstMinutes => 'नए ग्राहकों को मुफ़्त मिनट';
  @override
  String get freeMinutesNote => 'छोटा मुफ़्त समय पहला परामर्श बढ़ाता है।';
  @override
  String get savePricing => 'मूल्य सहेजें';
  @override
  String get pricingSaved => 'मूल्य सहेजा गया';
  @override
  String get notOffered => 'उपलब्ध नहीं';
  @override
  String get reviews => 'समीक्षाएँ';
  @override
  String get needsReply => 'उत्तर चाहिए';
  @override
  String get allReviews => 'सभी';
  @override
  String get critical => 'आलोचनात्मक';
  @override
  String get writeReply => 'उत्तर लिखें';
  @override
  String get replyHint => 'शांत और स्पष्ट उत्तर बेहतर लगता है।';
  @override
  String get sendReply => 'उत्तर भेजें';
  @override
  String get replyPosted => 'उत्तर भेजा गया';
  @override
  String get noReviews => 'उत्तर देने को कुछ नहीं';
  @override
  String get analytics => 'प्रदर्शन';
  @override
  String get totalSessions => 'परामर्श';
  @override
  String get totalMinutes => 'मिनट';
  @override
  String get avgSession => 'औसत परामर्श';
  @override
  String get avgEarning => 'प्रति परामर्श औसत';
  @override
  String get byChannel => 'माध्यम अनुसार';
  @override
  String get earningsTrend => 'आय की प्रवृत्ति';
  @override
  String get boost => 'बूस्ट';
  @override
  String get popular => 'लोकप्रिय';
  @override
  String get boostBody =>
      'खोज में ऊपर दिखने के लिए शुल्क दें। उपलब्ध शेष से कटेगा।';
  @override
  String get activeBoosts => 'अभी चल रहा';
  @override
  String get pastBoosts => 'पिछले बूस्ट';
  @override
  String get choosePlan => 'योजना चुनें';
  @override
  String get placementTopOfList => 'खोज में सबसे ऊपर';
  @override
  String get placementHomeRail => 'होम पर विशेष';
  @override
  String get placementTargeted => 'मेल खाते सेवार्थी';
  @override
  String get daysLabel => 'दिन';
  @override
  String get estimatedImpressions => 'अनुमानित दृश्य';
  @override
  String get perDay => 'प्रति दिन';
  @override
  String get buyBoost => 'बूस्ट खरीदें';
  @override
  String get boostBought => 'बूस्ट शुरू हुआ';
  @override
  String get cannotAfford => 'इस योजना के लिए पर्याप्त शेष नहीं है।';
  @override
  String get impressions => 'दृश्य';
  @override
  String get profileViews => 'प्रोफ़ाइल खुले';
  @override
  String get consultationsFromBoost => 'परामर्श';
  @override
  String get costPerConsultation => 'प्रति परामर्श लागत';
  @override
  String get daysLeft => 'शेष';
  @override
  String get noBoosts => 'अभी कोई बूस्ट नहीं';
  @override
  String get noBoostsBody =>
      'बूस्ट एक निश्चित अवधि तक अधिक सेवार्थियों तक पहुँचाता है।';
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
    'गुरु',
    'शुक्र',
    'शनि',
    'रवि',
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
  String minutesLabel(String minutes) => '$minutes मिनट';

  // --- Appointments ---
  @override
  String get apptTitle => 'अपॉइंटमेंट';
  @override
  String get apptUpcomingSection => 'आने वाले अपॉइंटमेंट';
  @override
  String get apptUpcomingTab => 'आने वाले';
  @override
  String get apptPastTab => 'पिछले';
  @override
  String get apptSeeAll => 'सभी देखें';
  @override
  String get apptNoUpcoming => 'कोई आने वाला अपॉइंटमेंट नहीं';
  @override
  String get apptNoUpcomingHint =>
      'जब कोई आपके साथ सत्र बुक करेगा, वह उनकी जानकारी के साथ यहाँ दिखेगा।';
  @override
  String get apptNoPast => 'अभी तक कोई पिछला अपॉइंटमेंट नहीं';
  @override
  String get apptDetails => 'अपॉइंटमेंट';
  @override
  String get apptClient => 'ग्राहक';
  @override
  String get apptPhone => 'फ़ोन';
  @override
  String get apptEmail => 'ईमेल';
  @override
  String get apptCountry => 'देश';
  @override
  String get apptCall => 'कॉल करें';
  @override
  String get apptWhatsapp => 'व्हाट्सऐप';
  @override
  String get apptBirthDetails => 'जन्म विवरण';
  @override
  String get apptBirthDate => 'जन्म तिथि';
  @override
  String get apptBirthTime => 'जन्म समय';
  @override
  String get apptBirthPlace => 'जन्म स्थान';
  @override
  String get apptBirthMissing => 'ग्राहक ने जन्म विवरण नहीं दिया।';
  @override
  String get apptClientNote => 'ग्राहक का नोट';
  @override
  String get apptAttachments => 'संलग्न फ़ाइलें';
  @override
  String get apptBirthChart => 'जन्म कुंडली';
  @override
  String get apptReceipt => 'भुगतान रसीद';
  @override
  String get apptOpenFile => 'खोलें';
  @override
  String get apptFileUnavailable => 'यह फ़ाइल अब उपलब्ध नहीं है।';
  @override
  String get apptSitting => 'सत्र';
  @override
  String get apptType => 'प्रकार';
  @override
  String get apptAdvice => 'आपकी दी गई सलाह';
  @override
  String get apptFollowUp => 'फ़ॉलो-अप';
  @override
  String get apptWhen => 'कब';
  @override
  String get apptLength => 'अवधि';
  @override
  String get apptAmount => 'राशि';
  @override
  String get apptPayment => 'भुगतान';
  @override
  String get apptMarkCompleted => 'पूरा हुआ चिह्नित करें';
  @override
  String get apptMarkNoShow => 'ग्राहक नहीं आए';
  @override
  String get apptCancel => 'अपॉइंटमेंट रद्द करें';
  @override
  String get apptOutcomeAfterStart =>
      'सत्र शुरू होने के बाद ही परिणाम चिह्नित किया जा सकता है।';
  @override
  String get apptCancelTitle => 'यह अपॉइंटमेंट रद्द करें?';
  @override
  String get apptCancelBody =>
      'ग्राहक देखेंगे कि आपने कारण सहित रद्द किया, और यह समय फिर से आपके कैलेंडर में खुल जाएगा।';
  @override
  String get apptCancelReasonHint => 'ग्राहक के लिए कारण';
  @override
  String get apptCancelReasonTooShort => 'कुछ शब्दों में कारण बताएँ।';
  @override
  String get apptConfirmCancel => 'अपॉइंटमेंट रद्द करें';
  @override
  String get apptKeep => 'रहने दें';
  @override
  String get apptMarkedCompleted => 'पूरा हुआ चिह्नित किया गया।';
  @override
  String get apptMarkedNoShow => 'ग्राहक नहीं आए, चिह्नित किया गया।';
  @override
  String get apptCancelled => 'अपॉइंटमेंट रद्द किया गया।';
  @override
  String get apptCouldNotOpen => 'इस फ़ोन पर नहीं खुल सका।';
  @override
  String apptReference(String reference) => 'बुकिंग $reference';
  @override
  String apptSeats(String count) => '$count लोगों के लिए';
  @override
  String apptStatus(ConsoleAppointmentStatus status) => switch (status) {
    ConsoleAppointmentStatus.pending => 'लंबित',
    ConsoleAppointmentStatus.confirmed => 'पुष्ट',
    ConsoleAppointmentStatus.completed => 'पूरा',
    ConsoleAppointmentStatus.cancelled => 'रद्द',
    ConsoleAppointmentStatus.noShow => 'ग्राहक नहीं आए',
    ConsoleAppointmentStatus.rescheduled => 'समय बदला गया',
    ConsoleAppointmentStatus.missed => 'छूट गया',
    ConsoleAppointmentStatus.declined => 'अस्वीकार किया',
  };
  @override
  String apptChannel(String? channel) => switch (channel) {
    'chat' => 'चैट',
    'voice' => 'वॉइस कॉल',
    'video' => 'वीडियो कॉल',
    _ => 'सत्र',
  };
  @override
  String apptRemedyKind(RemedyKind kind) => switch (kind) {
    RemedyKind.gemstone => 'रत्न',
    RemedyKind.mantra => 'मंत्र',
    RemedyKind.puja => 'पूजा',
    RemedyKind.donation => 'दान',
    RemedyKind.fasting => 'व्रत',
    RemedyKind.practice => 'अभ्यास',
  };
}
