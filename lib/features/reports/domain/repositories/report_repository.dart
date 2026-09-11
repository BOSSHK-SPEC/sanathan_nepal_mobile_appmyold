import '../../../../core/utils/result.dart';
import '../entities/purchased_report.dart';
import '../entities/report_product.dart';

/// Paid PDF reports: the catalogue and the buyer's own library.
abstract interface class ReportRepository {
  Future<Result<List<ReportProduct>>> catalogue();

  Future<Result<ReportProduct>> product(String productId);

  /// Charges the wallet and queues generation. Fails when the balance is
  /// short — affordability is decided by the wallet, never pre-checked here.
  Future<Result<PurchasedReport>> purchase(ReportOrder order);

  /// The buyer's reports, newest first.
  Future<Result<List<PurchasedReport>>> myReports();

  Future<Result<PurchasedReport>> report(String reportId);
}

/// One purchase request.
class ReportOrder {
  const ReportOrder({
    required this.productId,
    required this.profileId,
    required this.profileName,
    this.partnerProfileId,
    this.partnerName,
  });

  final String productId;
  final String profileId;
  final String profileName;
  final String? partnerProfileId;
  final String? partnerName;
}
