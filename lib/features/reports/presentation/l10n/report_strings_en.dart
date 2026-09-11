part of 'report_strings.dart';

class _En extends ReportStrings {
  const _En();

  @override
  String get reports => 'Astrology reports';

  @override
  String get reportsSubtitle =>
      'Detailed written readings, delivered as a PDF.';

  @override
  String get myReports => 'My reports';

  @override
  String get whatsInside => 'What is inside';

  @override
  String get pages => 'pages';

  @override
  String get deliveredIn => 'Delivered in';

  @override
  String get popular => 'Most bought';

  @override
  String get buyNow => 'Buy report';

  @override
  String get forWhom => 'Whose chart is this for?';

  @override
  String get partnerProfile => 'Partner';

  @override
  String get choosePartner => 'Choose the second chart';

  @override
  String get addBirthProfile => 'Add a birth profile';

  @override
  String get noProfilesTitle => 'No birth details saved';

  @override
  String get noProfilesBody =>
      'A report is generated from a birth chart. Add the birth date, time and place first.';

  @override
  String get walletBalance => 'Wallet balance';

  @override
  String get topUpFirst => 'Top up wallet';

  @override
  String get payAndGenerate => 'Pay and generate';

  @override
  String get purchaseTitle => 'Confirm purchase';

  @override
  String get generatingTitle => 'Your report is being prepared';

  @override
  String get generatingBody =>
      'This takes a few minutes. You can close the app — we will keep it in My reports.';

  @override
  String get readyTitle => 'Your report is ready';

  @override
  String get failedTitle => 'Generation failed';

  @override
  String get retryGeneration => 'Try again';

  @override
  String get downloadPdf => 'Download PDF';

  @override
  String get openReport => 'Open report';

  @override
  String get downloadUnavailable =>
      'PDF download is not available in this build yet.';

  @override
  String get noReportsTitle => 'No reports yet';

  @override
  String get noReportsBody =>
      'Reports you buy appear here, ready to open any time.';

  @override
  String get browseReports => 'Browse reports';

  @override
  String get purchasedOn => 'Purchased';

  @override
  String get amountPaid => 'Paid';

  @override
  String get requestRefund => 'Request a refund';

  @override
  String reportKind(ReportKind kind) => switch (kind) {
    ReportKind.life => 'Life report',
    ReportKind.career => 'Career',
    ReportKind.marriage => 'Marriage',
    ReportKind.yearAhead => 'Year ahead',
    ReportKind.matchMaking => 'Matching',
    ReportKind.remedies => 'Remedies',
  };

  @override
  String reportStatus(ReportStatus status) => switch (status) {
    ReportStatus.generating => 'Preparing',
    ReportStatus.ready => 'Ready',
    ReportStatus.failed => 'Failed',
    ReportStatus.refunded => 'Refunded',
  };

  @override
  String pageCount(int value) => '$value pages';

  @override
  String minutes(int value) => '$value minutes';

  @override
  String discountPercent(int value) => '$value% off';
}
