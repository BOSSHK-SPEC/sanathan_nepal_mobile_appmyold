import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/purchased_report.dart';
import '../entities/report_product.dart';
import '../repositories/report_repository.dart';

class GetReportCatalogue implements NoParamsUseCase<List<ReportProduct>> {
  const GetReportCatalogue(this._repo);
  final ReportRepository _repo;

  @override
  Future<Result<List<ReportProduct>>> call() => _repo.catalogue();
}

class GetReportProduct implements UseCase<ReportProduct, String> {
  const GetReportProduct(this._repo);
  final ReportRepository _repo;

  @override
  Future<Result<ReportProduct>> call(String params) => _repo.product(params);
}

class PurchaseReport implements UseCase<PurchasedReport, ReportOrder> {
  const PurchaseReport(this._repo);
  final ReportRepository _repo;

  @override
  Future<Result<PurchasedReport>> call(ReportOrder params) =>
      _repo.purchase(params);
}

class GetMyReports implements NoParamsUseCase<List<PurchasedReport>> {
  const GetMyReports(this._repo);
  final ReportRepository _repo;

  @override
  Future<Result<List<PurchasedReport>>> call() => _repo.myReports();
}

class GetPurchasedReport implements UseCase<PurchasedReport, String> {
  const GetPurchasedReport(this._repo);
  final ReportRepository _repo;

  @override
  Future<Result<PurchasedReport>> call(String params) => _repo.report(params);
}
