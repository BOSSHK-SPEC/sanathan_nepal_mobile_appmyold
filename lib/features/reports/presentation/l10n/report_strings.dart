import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/purchased_report.dart';
import '../../domain/entities/report_product.dart';

part 'report_strings_en.dart';
part 'report_strings_hi.dart';
part 'report_strings_ne.dart';

/// Feature-local strings for paid PDF reports.
abstract class ReportStrings {
  const ReportStrings();

  static ReportStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  String get reports;
  String get reportsSubtitle;
  String get myReports;
  String get whatsInside;
  String get pages;
  String get deliveredIn;
  String get popular;
  String get buyNow;
  String get forWhom;
  String get partnerProfile;
  String get choosePartner;
  String get addBirthProfile;
  String get noProfilesTitle;
  String get noProfilesBody;
  String get walletBalance;
  String get topUpFirst;
  String get payAndGenerate;
  String get purchaseTitle;
  String get generatingTitle;
  String get generatingBody;
  String get readyTitle;
  String get failedTitle;
  String get retryGeneration;
  String get downloadPdf;
  String get openReport;
  String get downloadUnavailable;
  String get noReportsTitle;
  String get noReportsBody;
  String get browseReports;
  String get purchasedOn;
  String get amountPaid;
  String get requestRefund;

  String reportKind(ReportKind kind);
  String reportStatus(ReportStatus status);
  String pageCount(int value);
  String minutes(int value);
  String discountPercent(int value);
}
