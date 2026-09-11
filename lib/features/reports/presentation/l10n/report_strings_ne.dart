part of 'report_strings.dart';

class _Ne extends ReportStrings {
  const _Ne();

  @override
  String get reports => 'ज्योतिष रिपोर्ट';

  @override
  String get reportsSubtitle => 'विस्तृत लिखित विश्लेषण, PDF मा।';

  @override
  String get myReports => 'मेरा रिपोर्ट';

  @override
  String get whatsInside => 'के-के समावेश छ';

  @override
  String get pages => 'पृष्ठ';

  @override
  String get deliveredIn => 'प्राप्त हुने समय';

  @override
  String get popular => 'सबैभन्दा धेरै किनिएको';

  @override
  String get buyNow => 'रिपोर्ट किन्नुहोस्';

  @override
  String get forWhom => 'यो कसको कुण्डलीको हो?';

  @override
  String get partnerProfile => 'जोडी';

  @override
  String get choosePartner => 'दोस्रो कुण्डली छान्नुहोस्';

  @override
  String get addBirthProfile => 'जन्म विवरण थप्नुहोस्';

  @override
  String get noProfilesTitle => 'जन्म विवरण सुरक्षित छैन';

  @override
  String get noProfilesBody =>
      'रिपोर्ट जन्मकुण्डलीबाट बन्छ। पहिले जन्म मिति, समय र स्थान थप्नुहोस्।';

  @override
  String get walletBalance => 'वालेट ब्यालेन्स';

  @override
  String get topUpFirst => 'वालेट टप-अप गर्नुहोस्';

  @override
  String get payAndGenerate => 'भुक्तानी गरी बनाउनुहोस्';

  @override
  String get purchaseTitle => 'खरिद पुष्टि';

  @override
  String get generatingTitle => 'तपाईंको रिपोर्ट तयार हुँदैछ';

  @override
  String get generatingBody =>
      'केही मिनेट लाग्छ। एप बन्द गर्न सक्नुहुन्छ — रिपोर्ट "मेरा रिपोर्ट" मा रहनेछ।';

  @override
  String get readyTitle => 'तपाईंको रिपोर्ट तयार छ';

  @override
  String get failedTitle => 'रिपोर्ट बन्न सकेन';

  @override
  String get retryGeneration => 'पुनः प्रयास';

  @override
  String get downloadPdf => 'PDF डाउनलोड';

  @override
  String get openReport => 'रिपोर्ट खोल्नुहोस्';

  @override
  String get downloadUnavailable => 'यस संस्करणमा PDF डाउनलोड उपलब्ध छैन।';

  @override
  String get noReportsTitle => 'अहिलेसम्म रिपोर्ट छैन';

  @override
  String get noReportsBody =>
      'किनेका रिपोर्ट यहाँ देखिनेछन्, जुनसुकै बेला खोल्न सकिने।';

  @override
  String get browseReports => 'रिपोर्ट हेर्नुहोस्';

  @override
  String get purchasedOn => 'खरिद मिति';

  @override
  String get amountPaid => 'भुक्तानी';

  @override
  String get requestRefund => 'फिर्ता माग्नुहोस्';

  @override
  String reportKind(ReportKind kind) => switch (kind) {
    ReportKind.life => 'जीवन रिपोर्ट',
    ReportKind.career => 'करियर',
    ReportKind.marriage => 'विवाह',
    ReportKind.yearAhead => 'वर्षफल',
    ReportKind.matchMaking => 'कुण्डली मिलान',
    ReportKind.remedies => 'उपाय',
  };

  @override
  String reportStatus(ReportStatus status) => switch (status) {
    ReportStatus.generating => 'तयार हुँदै',
    ReportStatus.ready => 'तयार',
    ReportStatus.failed => 'असफल',
    ReportStatus.refunded => 'फिर्ता',
  };

  @override
  String pageCount(int value) =>
      '${value.toString().toDevanagariDigits()} पृष्ठ';

  @override
  String minutes(int value) => '${value.toString().toDevanagariDigits()} मिनेट';

  @override
  String discountPercent(int value) =>
      '${value.toString().toDevanagariDigits()}% छुट';
}
