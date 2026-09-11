import '../../../core/utils/result.dart';
import '../entities/abuse_report.dart';
import '../entities/astrologer_application.dart';
import '../entities/audit_entry.dart';
import '../entities/feature_flag.dart';
import '../entities/financial_summary.dart';
import '../entities/pending_payout.dart';

/// Everything the staff console can do, as one contract.
///
/// Deliberately narrow: each method maps to exactly one server endpoint that is
/// guarded by exactly one permission. The console mirrors those permissions to
/// decide what to render — but the server re-authorizes every call, so a
/// tampered client gains nothing.
abstract interface class AdminRepository {
  // --- verifyAstrologer -----------------------------------------------------
  Future<Result<List<AstrologerApplication>>> pendingApplications();

  Future<Result<AstrologerApplication>> decideApplication({
    required String applicationId,
    required bool approve,
    required String note,
  });

  // --- moderateContent ------------------------------------------------------
  Future<Result<List<AbuseReport>>> reports({required bool resolved});

  Future<Result<AbuseReport>> resolveReport(String reportId);

  // --- viewAuditLog ---------------------------------------------------------
  Future<Result<List<AuditEntry>>> auditLog({int limit = 100});

  // --- manageFeatureFlags ---------------------------------------------------
  Future<Result<List<FeatureFlag>>> featureFlags();

  /// Omitted fields are left untouched server-side, so a toggle does not
  /// silently reset a rollout percentage someone else set.
  Future<Result<FeatureFlag>> setFeatureFlag(
    String key, {
    bool? enabled,
    int? rolloutPct,
  });

  // --- viewFinancialReports -------------------------------------------------
  Future<Result<FinancialSummary>> financialSummary({int days = 30});

  // --- runPayouts -----------------------------------------------------------
  Future<Result<List<PendingPayout>>> pendingPayouts();

  Future<Result<DecisionOutcome>> decidePayout({
    required String payoutId,
    required bool approve,
    required String note,
    String? reference,
  });

  // --- issueRefund ----------------------------------------------------------
  Future<Result<DecisionOutcome>> decideRefund({
    required String refundId,
    required bool approve,
    required String note,
  });
}
