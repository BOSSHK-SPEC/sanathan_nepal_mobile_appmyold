import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../../domain/entities/application.dart';
import '../../domain/entities/astrologer_client.dart';
import '../../domain/entities/astrologer_profile.dart';
import '../../domain/entities/compliance_notice.dart';
import '../../domain/entities/work_preferences.dart';
import '../../domain/entities/boost.dart';
import '../../domain/entities/availability.dart';
import '../../domain/entities/console_appointment.dart';
import '../../domain/entities/console_pricing.dart';
import '../../domain/entities/console_stats.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/payout.dart';
import '../../domain/entities/queue_entry.dart';

/// I/O contract for the astrologer console.
abstract interface class ConsoleDataSource {
  Future<AstrologerApplication> application();
  Future<AstrologerApplication> saveApplication(
    AstrologerApplication application,
  );
  Future<AstrologerApplication> uploadDocument({
    required KycDocumentKind kind,
    required String fileRef,
  });

  /// Discards the document in [kind], deleting the stored file with it.
  Future<AstrologerApplication> removeDocument({required KycDocumentKind kind});
  Future<AstrologerApplication> acceptTerms(String version);
  Future<AstrologerApplication> submitApplication();

  Future<DashboardStats> dashboard();
  Future<Availability> availability();
  Future<Availability> saveAvailability(Availability availability);
  Future<Availability> setOnline({required bool online});
  Future<List<QueueEntry>> queue();
  Future<IncomingRequest?> pendingRequest();
  Future<void> respondToRequest({
    required String requestId,
    required bool accept,
  });
  Future<List<AstrologerClient>> clients();
  Future<AstrologerClient> client(String clientId);
  Future<AstrologerClient> saveClientNotes({
    required String clientId,
    required String notes,
  });

  /// Sittings seekers booked with this astrologer.
  Future<List<ConsoleAppointment>> appointments(AppointmentScope scope);

  /// One appointment, with links to what the client attached.
  Future<ConsoleAppointment> appointment(String id);
  Future<ConsoleAppointment> recordAppointmentOutcome(
    String id, {
    required bool completed,
  });
  Future<ConsoleAppointment> cancelAppointment(
    String id, {
    required String reason,
  });

  Future<EarningsSummary> earnings(EarningsRange range);
  Future<PerformanceMetrics> performance(EarningsRange range);
  Future<PayoutAccount?> payoutAccount();
  Future<PayoutAccount> savePayoutAccount(PayoutAccount account);
  Future<List<PayoutRequest>> payouts();
  Future<PayoutRequest> requestPayout(double amount);
  Future<List<TaxDocument>> taxDocuments();
  Future<ConsolePricing> pricing();
  Future<ConsolePricing> savePricing(ConsolePricing pricing);
  Future<List<AstrologerReview>> reviews();
  Future<AstrologerReview> replyToReview({
    required String reviewId,
    required String reply,
  });
  Future<List<BoostPlan>> boostPlans();
  Future<List<BoostCampaign>> boostCampaigns();
  Future<BoostCampaign> buyBoost(String planId);
  Future<List<ComplianceNotice>> complianceNotices();
  Future<ComplianceNotice> acknowledgeNotice(String id);
  Future<ComplianceNotice> appealNotice(String id, String reason);
  Future<WorkPreferences> workPreferences();
  Future<WorkPreferences> saveWorkPreferences(WorkPreferences prefs);
  Future<AstrologerProfileDraft> profile();
  Future<AstrologerProfileDraft> saveProfile(AstrologerProfileDraft profile);
}
