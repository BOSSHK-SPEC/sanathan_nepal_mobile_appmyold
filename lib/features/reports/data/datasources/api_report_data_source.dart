import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_localized.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/purchased_report.dart';
import '../../domain/entities/report_product.dart';
import '../../domain/repositories/report_repository.dart';
import 'report_data_source.dart';

/// The paid-report catalogue and the buyer's library, from the backend.
///
/// Purchase debits the wallet server-side and the PDF is generated there too;
/// the app never sees a price it could change, and a report that failed to
/// generate says why rather than silently disappearing.
class ApiReportDataSource implements ReportDataSource {
  const ApiReportDataSource(this._client, this._languageCode);

  final ApiClient _client;

  /// A purchased report's title is a plain string on the entity, so one
  /// translation is chosen at the boundary; read per call so switching
  /// language re-renders the library correctly.
  final String Function() _languageCode;

  @override
  Future<List<ReportProduct>> catalogue() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.reportCatalogue);
    return asJsonList(response).map(_toProduct).toList(growable: false);
  });

  @override
  Future<ReportProduct> product(String productId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.reportProduct(productId),
    );
    return _toProduct(asJsonMap(response));
  });

  @override
  Future<PurchasedReport> purchase(ReportOrder order) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.reportPurchase,
      data: {
        'productId': order.productId,
        'birthProfileId': order.profileId,
        if (order.partnerProfileId != null)
          'partnerProfileId': order.partnerProfileId,
      },
    );
    return _toReport(asJsonMap(response));
  });

  @override
  Future<List<PurchasedReport>> myReports() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.myReports);
    return asJsonList(response).map(_toReport).toList(growable: false);
  });

  @override
  Future<PurchasedReport> report(String reportId) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.report(reportId));
    return _toReport(asJsonMap(response));
  });

  // ---------------------------------------------------------------- mapping --

  ReportProduct _toProduct(Map<String, dynamic> json) {
    final contents = json['contents'];
    return ReportProduct(
      id: json['id'] as String? ?? '',
      kind: _kind(json['kind'] as String?),
      title: asLocalizedText(json['title']),
      summary: asLocalizedText(json['summary']),
      price: ApiMoney.toMajor(json['priceMinor']),
      pageCount: (json['pageCount'] as num?)?.toInt() ?? 0,
      contents: contents is List
          ? contents.map(asLocalizedText).toList(growable: false)
          : const <LocalizedText>[],
      originalPrice: json['originalPriceMinor'] == null
          ? null
          : ApiMoney.toMajor(json['originalPriceMinor']),
      deliveryTime: Duration(
        minutes: (json['deliveryMinutes'] as num?)?.toInt() ?? 10,
      ),
      needsSecondProfile: json['needsSecondProfile'] as bool? ?? false,
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }

  PurchasedReport _toReport(Map<String, dynamic> json) => PurchasedReport(
    id: json['id'] as String? ?? '',
    productId: json['productId'] as String? ?? '',
    kind: _kind(json['kind'] as String?),
    title: localizedFor(json['title'], _languageCode()),
    profileName: json['profileName'] as String? ?? '',
    pricePaid: ApiMoney.toMajor(json['pricePaidMinor']),
    purchasedAt: ApiTime.instantOr(json['purchasedAt'], DateTime.now()),
    status: switch (json['status']) {
      'ready' => ReportStatus.ready,
      'failed' => ReportStatus.failed,
      'refunded' => ReportStatus.refunded,
      // `pendingPayment` is still "being worked on" as far as the library is
      // concerned — the buyer sees a spinner, not an error.
      _ => ReportStatus.generating,
    },
    fileRef: json['pdfKey'] as String?,
    pageCount: (json['pageCount'] as num?)?.toInt(),
    readyAt: ApiTime.instant(json['readyAt']),
    failureReason: json['failureReason'] as String?,
    partnerName: json['partnerName'] as String?,
  );

  static ReportKind _kind(String? kind) => ReportKind.values.firstWhere(
    (k) => k.name == kind,
    orElse: () => ReportKind.life,
  );
}
