part of 'account_strings.dart';

class _Hi extends AccountStrings {
  const _Hi();
  @override
  String get addresses => 'पते';
  @override
  String get addAddress => 'पता जोड़ें';
  @override
  String get editAddress => 'पता संपादित करें';
  @override
  String get noAddresses => 'कोई सहेजा पता नहीं';
  @override
  String get noAddressesBody => 'एक बार पता सहेजें, चेकआउट फिर नहीं पूछेगा।';
  @override
  String get fullName => 'पूरा नाम';
  @override
  String get phone => 'फ़ोन';
  @override
  String get addressLine1 => 'पता';
  @override
  String get addressLine2 => 'भवन, लैंडमार्क (वैकल्पिक)';
  @override
  String get city => 'शहर';
  @override
  String get district => 'ज़िला';
  @override
  String get state => 'राज्य';
  @override
  String get postalCode => 'पिन कोड';
  @override
  String get labelHome => 'घर';
  @override
  String get labelWork => 'कार्यालय';
  @override
  String get labelOther => 'अन्य';
  @override
  String get setDefault => 'डिफ़ॉल्ट बनाएँ';
  @override
  String get defaultLabel => 'डिफ़ॉल्ट';
  @override
  String get saveAddress => 'पता सहेजें';
  @override
  String get deleteAddress => 'पता हटाएँ';
  @override
  String get deleteAddressBody => 'यह पता चेकआउट से हट जाएगा।';
  @override
  String get delete => 'हटाएँ';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get security => 'सुरक्षा';
  @override
  String get signInDetails => 'साइन-इन विवरण';
  @override
  String get email => 'ईमेल';
  @override
  String get twoFactor => 'दो-चरणीय सत्यापन';
  @override
  String get twoFactorNote =>
      'नए डिवाइस पर साइन-इन करते समय फ़ोन से कोड माँगें।';
  @override
  String get loginAlerts => 'नए साइन-इन की सूचना';
  @override
  String get devices => 'साइन-इन डिवाइस';
  @override
  String get thisDevice => 'यही डिवाइस';
  @override
  String get lastActive => 'अंतिम सक्रिय';
  @override
  String get revoke => 'साइन आउट';
  @override
  String get revokeAll => 'अन्य सभी से साइन आउट';
  @override
  String get revokeAllBody => 'इसके अलावा सभी डिवाइस से साइन आउट हो जाएगा।';
  @override
  String get staleDeviceNote => 'एक महीने से अधिक उपयोग नहीं';
  @override
  String get privacy => 'डेटा और गोपनीयता';
  @override
  String get exportTitle => 'अपना डेटा डाउनलोड';
  @override
  String get exportBody =>
      'आपकी प्रोफ़ाइल, परामर्श और ऑर्डर की प्रति तैयार की जाएगी।';
  @override
  String get deleteTitle => 'खाता हटाएँ';
  @override
  String get deleteBody =>
      'आपकी प्रोफ़ाइल, कुंडली और इतिहास हट जाएँगे। कानूनी और कर कारणों से पूर्ण लेन-देन रखे जाते हैं।';
  @override
  String get requestExport => 'डाउनलोड माँगें';
  @override
  String get requestDeletion => 'हटाने का अनुरोध';
  @override
  String get requestPending => 'प्रक्रिया में';
  @override
  String get requestNote => 'डेटा अनुरोध का उत्तर 30 दिनों में दिया जाता है।';
  @override
  String get confirmDeletion => 'खाता हटाएँ';
  @override
  String get support => 'सहायता';
  @override
  String get myTickets => 'मेरे टिकट';
  @override
  String get newTicket => 'नया टिकट';
  @override
  String get noTickets => 'अभी कोई टिकट नहीं';
  @override
  String get noTicketsBody => 'कुछ गलत हो तो टिकट खोलें, हम देखेंगे।';
  @override
  String get subject => 'विषय';
  @override
  String get subjectHint => 'संक्षिप्त सारांश';
  @override
  String get topic => 'किस बारे में?';
  @override
  String get describe => 'क्या हुआ?';
  @override
  String get describeHint => 'आपके पास मौजूद संदर्भ संख्या भी लिखें।';
  @override
  String get submitTicket => 'टिकट खोलें';
  @override
  String get ticketSubmitted => 'टिकट खोला गया';
  @override
  String get replyHint => 'उत्तर लिखें';
  @override
  String get send => 'भेजें';
  @override
  String get ticketClosed => 'यह टिकट बंद है। अभी भी मदद चाहिए तो नया खोलें।';
  @override
  String get topicPayment => 'भुगतान';
  @override
  String get topicConsultation => 'परामर्श';
  @override
  String get topicOrder => 'ऑर्डर';
  @override
  String get topicAccount => 'खाता';
  @override
  String get topicOther => 'अन्य';
  @override
  String get statusOpen => 'खुला';
  @override
  String get statusWaitingOnYou => 'आपका उत्तर चाहिए';
  @override
  String get statusResolved => 'हल हुआ';
  @override
  String get statusClosed => 'बंद';
  @override
  String get supportTeam => 'सहायता टीम';
  @override
  String get offers => 'ऑफ़र';
  @override
  String get availableOffers => 'उपलब्ध';
  @override
  String get usedOffers => 'उपयोग और समाप्त';
  @override
  String get noOffers => 'अभी कोई ऑफ़र नहीं';
  @override
  String get noOffersBody =>
      'त्योहारों और पहले परामर्श के बाद ऑफ़र यहाँ दिखेंगे।';
  @override
  String get copyCode => 'कोड कॉपी';
  @override
  String get codeCopied => 'कोड कॉपी हुआ';
  @override
  String get expiresIn => 'समाप्ति में';
  @override
  String get expiringSoon => 'जल्द समाप्त';
  @override
  String get usedLabel => 'उपयोग हुआ';
  @override
  String get expiredLabel => 'समाप्त';
  @override
  String get minimumSpend => 'न्यूनतम खर्च';
  @override
  String get referral => 'दोस्तों को बुलाएँ';
  @override
  String get referralBody =>
      'अपना कोड साझा करें। उनके पहले परामर्श के बाद दोनों को क्रेडिट मिलेगा।';
  @override
  String get yourCode => 'आपका कोड';
  @override
  String get invited => 'आमंत्रित';
  @override
  String get joined => 'शामिल हुए';
  @override
  String get earnedLabel => 'कमाया';
  @override
  String get shareCode => 'कोड साझा करें';
  @override
  String get perReferral => 'प्रति मित्र';
  @override
  String labelName(AddressLabel value) => switch (value) {
    AddressLabel.home => labelHome,
    AddressLabel.work => labelWork,
    AddressLabel.other => labelOther,
  };
  @override
  String topicName(TicketTopic value) => switch (value) {
    TicketTopic.payment => topicPayment,
    TicketTopic.consultation => topicConsultation,
    TicketTopic.order => topicOrder,
    TicketTopic.account => topicAccount,
    TicketTopic.other => topicOther,
  };
  @override
  String ticketStatusName(TicketStatus value) => switch (value) {
    TicketStatus.open => statusOpen,
    TicketStatus.waitingOnYou => statusWaitingOnYou,
    TicketStatus.resolved => statusResolved,
    TicketStatus.closed => statusClosed,
  };
  @override
  String daysLabel(String days) => '$days दिन';
}
