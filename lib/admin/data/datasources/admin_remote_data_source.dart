import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/api_money.dart';
import '../../../core/network/api_time.dart';
import '../../domain/entities/abuse_report.dart';
import '../../domain/entities/astrologer_application.dart';
import '../../domain/entities/audit_entry.dart';
import '../../domain/entities/feature_flag.dart';
import '../../domain/entities/financial_summary.dart';
import '../../domain/entities/pending_payout.dart';

/// The console's one door to the staff API.
///
/// Maps wire JSON straight onto entities rather than through a `Model` layer.
/// That layer exists elsewhere in this app because those features cache to
/// disk and need a second, serialisable representation; nothing here is ever
/// persisted — a moderation queue read from a stale cache is worse than a
/// spinner — so a model would be a byte-for-byte copy of the entity and one
/// more place for the two to drift. The wire format still stops here: no
/// caller above this file sees a `Map`.
///
/// Every method is wrapped in [guardApi], which turns transport errors into
/// the domain exceptions the repository's `guard()` maps to `Failure`s — so a
/// 403 from a missing permission arrives at the UI as `PermissionFailure`,
/// with the server's message intact.
abstract interface class AdminRemoteDataSource {
  Future<List<AstrologerApplication>> pendingApplications();
  Future<AstrologerApplication> decideApplication({
    required String applicationId,
    required bool approve,
    required String note,
  });

  Future<List<AbuseReport>> reports({required bool resolved});
  Future<AbuseReport> resolveReport(String reportId);

  Future<List<AuditEntry>> auditLog({required int limit});

  Future<List<FeatureFlag>> featureFlags();
  Future<FeatureFlag> setFeatureFlag(
    String key, {
    bool? enabled,
    int? rolloutPct,
  });

  Future<FinancialSummary> financialSummary({required int days});

  Future<List<PendingPayout>> pendingPayouts();
  Future<DecisionOutcome> decidePayout({
    required String payoutId,
    required bool approve,
    required String note,
    String? reference,
  });

  Future<DecisionOutcome> decideRefund({
    required String refundId,
    required bool approve,
    required String note,
  });
}

class ApiAdminDataSource implements AdminRemoteDataSource {
  const ApiAdminDataSource(this._client);

  final ApiClient _client;

  // --- astrologer applications ---------------------------------------------

  @override
  Future<List<AstrologerApplication>> pendingApplications() =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.adminApplications,
        );
        return asJsonList(response).map(_toApplication).toList(growable: false);
      });

  @override
  Future<AstrologerApplication> decideApplication({
    required String applicationId,
    required bool approve,
    required String note,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.adminApplicationDecision(applicationId),
      data: {'approve': approve, 'note': note},
    );
    return _toApplication(asJsonMap(response));
  });

  // --- moderation -----------------------------------------------------------

  @override
  Future<List<AbuseReport>> reports({required bool resolved}) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.adminReports,
          // Sent as a string: the server parses `resolved === 'true'`, so a
          // JSON boolean would serialise to `true` and work by luck rather
          // than by contract.
          query: {'resolved': resolved.toString()},
        );
        return asJsonList(response).map(_toReport).toList(growable: false);
      });

  @override
  Future<AbuseReport> resolveReport(String reportId) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.adminResolveReport(reportId),
    );
    return _toReport(asJsonMap(response));
  });

  // --- audit ----------------------------------------------------------------

  @override
  Future<List<AuditEntry>> auditLog({required int limit}) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.adminAuditLog,
      query: {'limit': limit},
    );
    return asJsonList(response).map(_toAuditEntry).toList(growable: false);
  });

  // --- feature flags --------------------------------------------------------

  @override
  Future<List<FeatureFlag>> featureFlags() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.adminFeatureFlags);
    return asJsonList(response).map(_toFlag).toList(growable: false);
  });

  @override
  Future<FeatureFlag> setFeatureFlag(
    String key, {
    bool? enabled,
    int? rolloutPct,
  }) => guardApi(() async {
    final response = await _client.patch<dynamic>(
      ApiEndpoints.adminFeatureFlag(key),
      // Only what changed. Sending `enabled: null` would be a field the server
      // has to interpret; omitting it says "leave it alone", which is what a
      // reviewer nudging a rollout percentage actually means.
      data: {'enabled': ?enabled, 'rolloutPct': ?rolloutPct},
    );
    return _toFlag(asJsonMap(response));
  });

  // --- finance --------------------------------------------------------------

  @override
  Future<FinancialSummary> financialSummary({required int days}) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.adminFinanceSummary,
          query: {'days': days},
        );
        return _toSummary(asJsonMap(response), days);
      });

  // --- payouts and refunds --------------------------------------------------

  @override
  Future<List<PendingPayout>> pendingPayouts() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.adminPayouts);
    return asJsonList(response).map(_toPayout).toList(growable: false);
  });

  @override
  Future<DecisionOutcome> decidePayout({
    required String payoutId,
    required bool approve,
    required String note,
    String? reference,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.adminPayoutDecision(payoutId),
      data: {
        'approve': approve,
        'note': note,
        if (reference != null && reference.isNotEmpty) 'reference': reference,
      },
    );
    return _toOutcome(asJsonMap(response));
  });

  @override
  Future<DecisionOutcome> decideRefund({
    required String refundId,
    required bool approve,
    required String note,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.adminRefundDecision(refundId),
      data: {'approve': approve, 'note': note},
    );
    return _toOutcome(asJsonMap(response));
  });

  // --- mappers --------------------------------------------------------------
  //
  // Defensive by design: a console that throws on one malformed row shows an
  // error page instead of the other nineteen rows a reviewer needs.

  static AstrologerApplication _toApplication(Map<String, dynamic> json) =>
      AstrologerApplication(
        id: json['id'] as String? ?? '',
        userId: json['userId'] as String? ?? '',
        fullName: json['fullName'] as String? ?? 'Unnamed applicant',
        status: ApplicationStatus.fromName(json['status'] as String?),
        experienceYears: _asInt(json['experienceYears']),
        submittedAt: ApiTime.instant(json['submittedAt']),
        documents: _asStringMap(json['documents']),
      );

  static AbuseReport _toReport(Map<String, dynamic> json) => AbuseReport(
    id: json['id'] as String? ?? '',
    reporterId: json['reporterId'] as String? ?? '',
    targetType: json['targetType'] as String? ?? 'unknown',
    targetId: json['targetId'] as String? ?? '',
    reason: ReportReason.fromName(json['reason'] as String?),
    detail: json['detail'] as String? ?? '',
    resolved: json['resolved'] as bool? ?? false,
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
  );

  static AuditEntry _toAuditEntry(Map<String, dynamic> json) => AuditEntry(
    id: json['id'] as String? ?? '',
    actorId: json['actorId'] as String?,
    action: json['action'] as String? ?? 'unknown',
    targetType: json['targetType'] as String? ?? '',
    targetId: json['targetId'] as String?,
    traceId: json['traceId'] as String?,
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
  );

  static FeatureFlag _toFlag(Map<String, dynamic> json) => FeatureFlag(
    key: json['key'] as String? ?? '',
    description: json['description'] as String? ?? '',
    enabled: json['enabled'] as bool? ?? false,
    region: json['region'] as String?,
    rolloutPct: _asInt(json['rolloutPct']),
  );

  static FinancialSummary _toSummary(Map<String, dynamic> json, int days) =>
      FinancialSummary(
        grossRevenue: ApiMoney.toMajor(json['grossRevenueMinor']),
        consultationRevenue: ApiMoney.toMajor(json['consultationRevenueMinor']),
        marketplaceRevenue: ApiMoney.toMajor(json['marketplaceRevenueMinor']),
        walletTopUps: ApiMoney.toMajor(json['walletTopUpsMinor']),
        refunds: ApiMoney.toMajor(json['refundsMinor']),
        pendingPayouts: ApiMoney.toMajor(json['pendingPayoutsMinor']),
        orderCount: _asInt(json['orderCount']),
        consultationCount: _asInt(json['consultationCount']),
        days: days,
      );

  static PendingPayout _toPayout(Map<String, dynamic> json) => PendingPayout(
    id: json['id'] as String? ?? '',
    userId: json['userId'] as String? ?? '',
    amount: ApiMoney.toMajor(json['amountMinor']),
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
  );

  static DecisionOutcome _toOutcome(Map<String, dynamic> json) =>
      DecisionOutcome(
        id: json['id'] as String? ?? '',
        status: json['status'] as String? ?? 'unknown',
      );

  /// Counts arrive as JSON numbers, but a server that switches to strings for
  /// large values should not blank the dashboard.
  static int _asInt(Object? raw) => switch (raw) {
    final int value => value,
    final num value => value.round(),
    final String value => int.tryParse(value) ?? 0,
    _ => 0,
  };

  static Map<String, String> _asStringMap(Object? raw) {
    if (raw is! Map) return const {};
    return {
      for (final entry in raw.entries)
        if (entry.value != null) '${entry.key}': '${entry.value}',
    };
  }
}
