import '../../domain/entities/purchased_report.dart';
import '../../domain/entities/report_product.dart';
import '../../domain/repositories/report_repository.dart';

/// I/O contract for paid reports.
abstract interface class ReportDataSource {
  Future<List<ReportProduct>> catalogue();
  Future<ReportProduct> product(String productId);
  Future<PurchasedReport> purchase(ReportOrder order);
  Future<List<PurchasedReport>> myReports();
  Future<PurchasedReport> report(String reportId);
}
