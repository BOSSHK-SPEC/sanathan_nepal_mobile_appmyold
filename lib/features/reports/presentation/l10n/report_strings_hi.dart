part of 'report_strings.dart';

class _Hi extends ReportStrings {
  const _Hi();

  @override
  String get reports => 'ज्योतिष रिपोर्ट';

  @override
  String get reportsSubtitle => 'विस्तृत लिखित विश्लेषण, PDF में।';

  @override
  String get myReports => 'मेरी रिपोर्ट';

  @override
  String get whatsInside => 'इसमें क्या है';

  @override
  String get pages => 'पृष्ठ';

  @override
  String get deliveredIn => 'प्राप्ति का समय';

  @override
  String get popular => 'सबसे ज़्यादा ख़रीदी';

  @override
  String get buyNow => 'रिपोर्ट ख़रीदें';

  @override
  String get forWhom => 'यह किसकी कुंडली के लिए है?';

  @override
  String get partnerProfile => 'साथी';

  @override
  String get choosePartner => 'दूसरी कुंडली चुनें';

  @override
  String get addBirthProfile => 'जन्म विवरण जोड़ें';

  @override
  String get noProfilesTitle => 'जन्म विवरण सहेजा नहीं है';

  @override
  String get noProfilesBody =>
      'रिपोर्ट जन्मकुंडली से बनती है। पहले जन्म तिथि, समय और स्थान जोड़ें।';

  @override
  String get walletBalance => 'वॉलेट शेष';

  @override
  String get topUpFirst => 'वॉलेट टॉप-अप करें';

  @override
  String get payAndGenerate => 'भुगतान कर बनाएँ';

  @override
  String get purchaseTitle => 'ख़रीद की पुष्टि';

  @override
  String get generatingTitle => 'आपकी रिपोर्ट तैयार हो रही है';

  @override
  String get generatingBody =>
      'कुछ मिनट लगते हैं। ऐप बंद कर सकते हैं — रिपोर्ट "मेरी रिपोर्ट" में रहेगी।';

  @override
  String get readyTitle => 'आपकी रिपोर्ट तैयार है';

  @override
  String get failedTitle => 'रिपोर्ट नहीं बन सकी';

  @override
  String get retryGeneration => 'फिर कोशिश करें';

  @override
  String get downloadPdf => 'PDF डाउनलोड';

  @override
  String get openReport => 'रिपोर्ट खोलें';

  @override
  String get downloadUnavailable =>
      'इस संस्करण में PDF डाउनलोड उपलब्ध नहीं है।';

  @override
  String get noReportsTitle => 'अभी कोई रिपोर्ट नहीं';

  @override
  String get noReportsBody =>
      'ख़रीदी गई रिपोर्ट यहाँ दिखेंगी, कभी भी खोलने के लिए।';

  @override
  String get browseReports => 'रिपोर्ट देखें';

  @override
  String get purchasedOn => 'ख़रीद तिथि';

  @override
  String get amountPaid => 'भुगतान';

  @override
  String get requestRefund => 'रिफ़ंड माँगें';

  @override
  String reportKind(ReportKind kind) => switch (kind) {
    ReportKind.life => 'जीवन रिपोर्ट',
    ReportKind.career => 'करियर',
    ReportKind.marriage => 'विवाह',
    ReportKind.yearAhead => 'वर्षफल',
    ReportKind.matchMaking => 'कुंडली मिलान',
    ReportKind.remedies => 'उपाय',
  };

  @override
  String reportStatus(ReportStatus status) => switch (status) {
    ReportStatus.generating => 'तैयार हो रही',
    ReportStatus.ready => 'तैयार',
    ReportStatus.failed => 'विफल',
    ReportStatus.refunded => 'रिफ़ंड',
  };

  @override
  String pageCount(int value) =>
      '${value.toString().toDevanagariDigits()} पृष्ठ';

  @override
  String minutes(int value) => '${value.toString().toDevanagariDigits()} मिनट';

  @override
  String discountPercent(int value) =>
      '${value.toString().toDevanagariDigits()}% छूट';
}
