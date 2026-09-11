import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/purchased_report.dart';
import '../../domain/entities/report_product.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_data_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  const ReportRepositoryImpl(this._source);

  final ReportDataSource _source;

  @override
  Future<Result<List<ReportProduct>>> catalogue() => guard(_source.catalogue);

  @override
  Future<Result<ReportProduct>> product(String productId) =>
      guard(() => _source.product(productId));

  @override
  Future<Result<PurchasedReport>> purchase(ReportOrder order) =>
      guard(() => _source.purchase(order));

  @override
  Future<Result<List<PurchasedReport>>> myReports() => guard(_source.myReports);

  @override
  Future<Result<PurchasedReport>> report(String reportId) =>
      guard(() => _source.report(reportId));
}
