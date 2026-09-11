import '../../../../core/utils/result.dart';
import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../entities/application.dart';
import '../entities/astrologer_client.dart';
import '../entities/astrologer_profile.dart';
import '../entities/compliance_notice.dart';
import '../entities/work_preferences.dart';
import '../entities/boost.dart';
import '../entities/availability.dart';
import '../entities/console_pricing.dart';
import '../entities/console_stats.dart';
import '../entities/earnings.dart';
import '../entities/payout.dart';
import '../entities/queue_entry.dart';

/// Joining the platform: the KYC application and its review.
///
/// Split from the operational and financial repositories (ISP) — an
/// approved astrologer never touches this again, and an applicant has no
/// earnings to read.
abstract interface class AstrologerApplicationRepository {
  Future<Result<AstrologerApplication>> current();

  /// Saves progress without submitting, so a five-step wizard can be left
  /// and resumed.
  Future<Result<AstrologerApplication>> saveDraft(
    AstrologerApplication application,
  );

  Future<Result<AstrologerApplication>> uploadDocument({
    required KycDocumentKind kind,
    required String fileRef,
  });

  /// Discards an uploaded document. The stored file goes with it, so this is
  /// not undoable — the applicant re-uploads rather than restores.
  Future<Result<AstrologerApplication>> removeDocument({
    required KycDocumentKind kind,
  });

  Future<Result<AstrologerApplication>> acceptTerms(String version);

  Future<Result<AstrologerApplication>> submit();
}

/// Day-to-day operation: dashboard, queue, schedule and clients.
abstract interface class AstrologerOpsRepository {
  Future<Result<DashboardStats>> dashboard();

  Future<Result<Availability>> availability();

  Future<Result<Availability>> saveAvailability(Availability availability);

  /// Flipping the online switch. Separate from saving the schedule because
  /// it happens dozens of times a day and must not rewrite the whole record.
  Future<Result<Availability>> setOnline({required bool online});

  Future<Result<List<QueueEntry>>> queue();

  /// The request currently being offered, if any.
  Future<Result<IncomingRequest?>> pendingRequest();

  Future<Result<void>> respondToRequest({
    required String requestId,
    required bool accept,
  });

  Future<Result<List<AstrologerClient>>> clients();

  Future<Result<AstrologerClient>> client(String clientId);

  Future<Result<AstrologerClient>> saveClientNotes({
    required String clientId,
    required String notes,
  });
}

/// Money and reputation: earnings, payouts, pricing, reviews, analytics.
abstract interface class AstrologerEarningsRepository {
  Future<Result<EarningsSummary>> earnings(EarningsRange range);

  Future<Result<PerformanceMetrics>> performance(EarningsRange range);

  Future<Result<PayoutAccount?>> payoutAccount();

  Future<Result<PayoutAccount>> savePayoutAccount(PayoutAccount account);

  Future<Result<List<PayoutRequest>>> payouts();

  Future<Result<PayoutRequest>> requestPayout(double amount);

  Future<Result<List<TaxDocument>>> taxDocuments();

  Future<Result<ConsolePricing>> pricing();

  Future<Result<ConsolePricing>> savePricing(ConsolePricing pricing);

  /// Reviews left for this astrologer, newest first.
  Future<Result<List<AstrologerReview>>> reviews();

  Future<Result<AstrologerReview>> replyToReview({
    required String reviewId,
    required String reply,
  });

  /// Visibility packages the astrologer can buy.
  Future<Result<List<BoostPlan>>> boostPlans();

  Future<Result<List<BoostCampaign>>> boostCampaigns();

  /// Buys a plan. Paid out of the available earnings balance, so it fails
  /// when that balance will not cover it.
  Future<Result<BoostCampaign>> buyBoost(String planId);
}

/// The astrologer's own public profile — living content, unlike the
/// application record it is first seeded from.
abstract interface class AstrologerProfileRepository {
  Future<Result<AstrologerProfileDraft>> profile();

  Future<Result<AstrologerProfileDraft>> saveProfile(
    AstrologerProfileDraft profile,
  );

  /// Alerting and request-routing preferences.
  /// Warnings, penalties and policy notices, newest first.
  Future<Result<List<ComplianceNotice>>> complianceNotices();

  Future<Result<ComplianceNotice>> acknowledgeNotice(String id);

  Future<Result<ComplianceNotice>> appealNotice(String id, String reason);

  Future<Result<WorkPreferences>> workPreferences();

  Future<Result<WorkPreferences>> saveWorkPreferences(WorkPreferences prefs);
}
