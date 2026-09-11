import 'dart:convert';

import '../../../../core/billing/spending_account.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/purchased_report.dart';
import '../../domain/entities/report_product.dart';
import '../../domain/repositories/report_repository.dart';
import 'report_catalogue.dart';
import 'report_data_source.dart';

/// In-memory report store.
///
/// The rules that matter live here, not in the screens: the wallet is
/// charged before a purchase exists at all, and generation completes on a
/// clock rather than instantly so the generating → ready transition the UI
/// has to handle is actually exercised.
class MockReportDataSource implements ReportDataSource {
  MockReportDataSource(this._store, this._regions, this._wallet);

  final KeyValueStore _store;
  final RegionResolver _regions;
  final SpendingAccount _wallet;

  static const _reportsKey = 'reports.purchased';
  static const Duration _latency = Duration(milliseconds: 200);

  /// Compressed from the catalogue's stated delivery time so the flow is
  /// walkable end to end; the copy still promises the real duration.
  static const Duration generationTime = Duration(seconds: 25);

  @override
  Future<List<ReportProduct>> catalogue() async {
    await Future<void>.delayed(_latency);
    return ReportCatalogue.forRegion(_regions.region);
  }

  @override
  Future<ReportProduct> product(String productId) async {
    await Future<void>.delayed(_latency);
    return ReportCatalogue.forRegion(_regions.region).firstWhere(
      (p) => p.id == productId,
      orElse: () => throw NotFoundException('No report product "$productId"'),
    );
  }

  @override
  Future<PurchasedReport> purchase(ReportOrder order) async {
    final product = await this.product(order.productId);
    if (product.needsSecondProfile && order.partnerProfileId == null) {
      throw const ValidationException(
        'A matching report needs both birth profiles.',
      );
    }

    // Charge first. A purchase record that exists without a matching debit
    // is a free report; the reverse is a refundable failure, which is the
    // recoverable direction.
    await _wallet.charge(
      amount: product.price,
      category: SpendCategory.report,
      description: product.title.en,
      referenceId: product.id,
    );

    final report = PurchasedReport(
      id: 'rep-${DateTime.now().millisecondsSinceEpoch}',
      productId: product.id,
      kind: product.kind,
      title: product.title.en,
      profileName: order.profileName,
      partnerName: order.partnerName,
      pricePaid: product.price,
      purchasedAt: DateTime.now(),
      pageCount: product.pageCount,
    );
    await _write([report, ..._read()]);
    return report;
  }

  @override
  Future<List<PurchasedReport>> myReports() async {
    await Future<void>.delayed(_latency);
    return [for (final r in _read()) _readyIfDue(r)]
      ..sort((a, b) => b.purchasedAt.compareTo(a.purchasedAt));
  }

  @override
  Future<PurchasedReport> report(String reportId) async {
    await Future<void>.delayed(_latency);
    final found = _read().firstWhere(
      (r) => r.id == reportId,
      orElse: () => throw NotFoundException('No report "$reportId"'),
    );
    return _readyIfDue(found);
  }

  /// Generation is driven by the purchase timestamp rather than a timer, so
  /// a report finishes even if the app was closed the whole time.
  PurchasedReport _readyIfDue(PurchasedReport report) {
    if (!report.isGenerating) return report;
    final due = report.purchasedAt.add(generationTime);
    if (DateTime.now().isBefore(due)) return report;
    return report.copyWith(
      status: ReportStatus.ready,
      readyAt: due,
      fileRef: 'local://reports/${report.id}.pdf',
    );
  }

  List<PurchasedReport> _read() {
    final raw = _store.getString(_reportsKey);
    if (raw == null || raw.isEmpty) return const [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        _fromJson(e as Map<String, dynamic>),
    ];
  }

  Future<void> _write(List<PurchasedReport> reports) => _store.setString(
    _reportsKey,
    jsonEncode([for (final r in reports) _toJson(r)]),
  );

  PurchasedReport _fromJson(Map<String, dynamic> e) => PurchasedReport(
    id: e['id'] as String,
    productId: e['productId'] as String,
    kind: ReportKind.values.firstWhere(
      (k) => k.name == e['kind'],
      orElse: () => ReportKind.life,
    ),
    title: e['title'] as String,
    profileName: e['profileName'] as String,
    partnerName: e['partnerName'] as String?,
    pricePaid: (e['pricePaid'] as num).toDouble(),
    purchasedAt: DateTime.parse(e['purchasedAt'] as String),
    status: ReportStatus.values.firstWhere(
      (s) => s.name == e['status'],
      orElse: () => ReportStatus.generating,
    ),
    fileRef: e['fileRef'] as String?,
    pageCount: e['pageCount'] as int?,
    readyAt: e['readyAt'] == null
        ? null
        : DateTime.parse(e['readyAt'] as String),
    failureReason: e['failureReason'] as String?,
  );

  Map<String, dynamic> _toJson(PurchasedReport r) => {
    'id': r.id,
    'productId': r.productId,
    'kind': r.kind.name,
    'title': r.title,
    'profileName': r.profileName,
    'partnerName': r.partnerName,
    'pricePaid': r.pricePaid,
    'purchasedAt': r.purchasedAt.toIso8601String(),
    'status': r.status.name,
    'fileRef': r.fileRef,
    'pageCount': r.pageCount,
    'readyAt': r.readyAt?.toIso8601String(),
    'failureReason': r.failureReason,
  };
}
