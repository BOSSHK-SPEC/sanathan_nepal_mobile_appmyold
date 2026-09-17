import '../../../core/utils/repository_guard.dart';
import '../../../core/utils/result.dart';
import '../../domain/entities/abuse_report.dart';
import '../../domain/entities/astrologer_application.dart';
import '../../domain/entities/audit_entry.dart';
import '../../domain/entities/feature_flag.dart';
import '../../domain/entities/financial_summary.dart';
import '../../domain/entities/pending_payout.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_data_source.dart';

/// Orchestrates the staff API.
///
/// Every call goes through `guard()`, so nothing throws across the layer
/// boundary and each cubit gets a `Result` it must handle. There is no mock
/// counterpart on purpose: a moderation console backed by seed data is a
/// console that lies about what is waiting for review, and the one time that
/// matters is the time someone trusts it.
class AdminRepositoryImpl implements AdminRepository {
  const AdminRepositoryImpl(this._remote);

  final AdminRemoteDataSource _remote;

  @override
  Future<Result<List<AstrologerApplication>>> pendingApplications() =>
      guard(_remote.pendingApplications);

  @override
  Future<Result<AstrologerApplication>> decideApplication({
    required String applicationId,
    required bool approve,
    required String note,
  }) => guard(
    () => _remote.decideApplication(
      applicationId: applicationId,
      approve: approve,
      note: note,
    ),
  );

  @override
  Future<Result<List<AbuseReport>>> reports({required bool resolved}) =>
      guard(() => _remote.reports(resolved: resolved));

  @override
  Future<Result<AbuseReport>> resolveReport(String reportId) =>
      guard(() => _remote.resolveReport(reportId));

  @override
  Future<Result<List<AuditEntry>>> auditLog({int limit = 100}) =>
      guard(() => _remote.auditLog(limit: limit));

  @override
  Future<Result<List<FeatureFlag>>> featureFlags() =>
      guard(_remote.featureFlags);

  @override
  Future<Result<FeatureFlag>> setFeatureFlag(
    String key, {
    bool? enabled,
    int? rolloutPct,
  }) => guard(
    () => _remote.setFeatureFlag(key, enabled: enabled, rolloutPct: rolloutPct),
  );

  @override
  Future<Result<FinancialSummary>> financialSummary({int days = 30}) =>
      guard(() => _remote.financialSummary(days: days));

  @override
  Future<Result<List<PendingPayout>>> pendingPayouts() =>
      guard(_remote.pendingPayouts);

  @override
  Future<Result<DecisionOutcome>> decidePayout({
    required String payoutId,
    required bool approve,
    required String note,
    String? reference,
  }) => guard(
    () => _remote.decidePayout(
      payoutId: payoutId,
      approve: approve,
      note: note,
      reference: reference,
    ),
  );

  @override
  Future<Result<DecisionOutcome>> decideRefund({
    required String refundId,
    required bool approve,
    required String note,
  }) => guard(
    () =>
        _remote.decideRefund(refundId: refundId, approve: approve, note: note),
  );
}
