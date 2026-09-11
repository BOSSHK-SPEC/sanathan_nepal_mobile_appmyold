import 'package:freezed_annotation/freezed_annotation.dart';

import 'report_product.dart';

part 'purchased_report.freezed.dart';

/// Where a paid report is in its lifecycle.
///
/// [generating] is a real state, not a spinner: the money has already been
/// taken, so the purchase must be visible and recoverable even if the app is
/// closed while the PDF is being built.
enum ReportStatus { generating, ready, failed, refunded }

@freezed
abstract class PurchasedReport with _$PurchasedReport {
  const PurchasedReport._();

  const factory PurchasedReport({
    required String id,
    required String productId,
    required ReportKind kind,
    required String title,
    required String profileName,
    required double pricePaid,
    required DateTime purchasedAt,
    @Default(ReportStatus.generating) ReportStatus status,

    /// Present once [status] is ready.
    String? fileRef,
    int? pageCount,
    DateTime? readyAt,

    /// Why generation failed, shown instead of a generic error so support
    /// has something to act on.
    String? failureReason,

    /// The second profile, for matching reports.
    String? partnerName,
  }) = _PurchasedReport;

  bool get isReady => status == ReportStatus.ready && fileRef != null;

  bool get isGenerating => status == ReportStatus.generating;

  /// A failed report is refundable; a delivered one is not, which is the
  /// same rule the wallet applies to consultations.
  bool get isRefundable => status == ReportStatus.failed;
}
