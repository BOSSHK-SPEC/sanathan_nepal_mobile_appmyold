import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
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
import '../../domain/repositories/console_repositories.dart';
import '../datasources/console_data_source.dart';

/// All three console repositories share one data source but expose narrow
/// interfaces, so a screen depends only on the slice it uses.
class AstrologerApplicationRepositoryImpl
    implements AstrologerApplicationRepository {
  const AstrologerApplicationRepositoryImpl(this._source);

  final ConsoleDataSource _source;

  @override
  Future<Result<AstrologerApplication>> current() => guard(_source.application);

  @override
  Future<Result<AstrologerApplication>> saveDraft(
    AstrologerApplication application,
  ) => guard(() => _source.saveApplication(application));

  @override
  Future<Result<AstrologerApplication>> uploadDocument({
    required KycDocumentKind kind,
    required String fileRef,
  }) => guard(() => _source.uploadDocument(kind: kind, fileRef: fileRef));

  @override
  Future<Result<AstrologerApplication>> removeDocument({
    required KycDocumentKind kind,
  }) => guard(() => _source.removeDocument(kind: kind));

  @override
  Future<Result<AstrologerApplication>> acceptTerms(String version) =>
      guard(() => _source.acceptTerms(version));

  @override
  Future<Result<AstrologerApplication>> submit() =>
      guard(_source.submitApplication);
}

class AstrologerOpsRepositoryImpl implements AstrologerOpsRepository {
  const AstrologerOpsRepositoryImpl(this._source);

  final ConsoleDataSource _source;

  @override
  Future<Result<DashboardStats>> dashboard() => guard(_source.dashboard);

  @override
  Future<Result<Availability>> availability() => guard(_source.availability);

  @override
  Future<Result<Availability>> saveAvailability(Availability availability) =>
      guard(() => _source.saveAvailability(availability));

  @override
  Future<Result<Availability>> setOnline({required bool online}) =>
      guard(() => _source.setOnline(online: online));

  @override
  Future<Result<List<QueueEntry>>> queue() => guard(_source.queue);

  @override
  Future<Result<IncomingRequest?>> pendingRequest() =>
      guard(_source.pendingRequest);

  @override
  Future<Result<void>> respondToRequest({
    required String requestId,
    required bool accept,
  }) => guard(
    () => _source.respondToRequest(requestId: requestId, accept: accept),
  );

  @override
  Future<Result<List<AstrologerClient>>> clients() => guard(_source.clients);

  @override
  Future<Result<AstrologerClient>> client(String clientId) =>
      guard(() => _source.client(clientId));

  @override
  Future<Result<AstrologerClient>> saveClientNotes({
    required String clientId,
    required String notes,
  }) => guard(() => _source.saveClientNotes(clientId: clientId, notes: notes));

  @override
  Future<Result<List<ConsoleAppointment>>> appointments(
    AppointmentScope scope,
  ) => guard(() => _source.appointments(scope));

  @override
  Future<Result<ConsoleAppointment>> appointment(String id) =>
      guard(() => _source.appointment(id));

  @override
  Future<Result<ConsoleAppointment>> recordAppointmentOutcome(
    String id, {
    required bool completed,
  }) => guard(() => _source.recordAppointmentOutcome(id, completed: completed));

  @override
  Future<Result<ConsoleAppointment>> cancelAppointment(
    String id, {
    required String reason,
  }) => guard(() => _source.cancelAppointment(id, reason: reason));
}

class AstrologerEarningsRepositoryImpl implements AstrologerEarningsRepository {
  const AstrologerEarningsRepositoryImpl(this._source);

  final ConsoleDataSource _source;

  @override
  Future<Result<EarningsSummary>> earnings(EarningsRange range) =>
      guard(() => _source.earnings(range));

  @override
  Future<Result<PerformanceMetrics>> performance(EarningsRange range) =>
      guard(() => _source.performance(range));

  @override
  Future<Result<PayoutAccount?>> payoutAccount() =>
      guard(_source.payoutAccount);

  @override
  Future<Result<PayoutAccount>> savePayoutAccount(PayoutAccount account) =>
      guard(() => _source.savePayoutAccount(account));

  @override
  Future<Result<List<PayoutRequest>>> payouts() => guard(_source.payouts);

  @override
  Future<Result<PayoutRequest>> requestPayout(double amount) =>
      guard(() => _source.requestPayout(amount));

  @override
  Future<Result<List<TaxDocument>>> taxDocuments() =>
      guard(_source.taxDocuments);

  @override
  Future<Result<ConsolePricing>> pricing() => guard(_source.pricing);

  @override
  Future<Result<ConsolePricing>> savePricing(ConsolePricing pricing) =>
      guard(() => _source.savePricing(pricing));

  @override
  Future<Result<List<AstrologerReview>>> reviews() => guard(_source.reviews);

  @override
  Future<Result<AstrologerReview>> replyToReview({
    required String reviewId,
    required String reply,
  }) => guard(() => _source.replyToReview(reviewId: reviewId, reply: reply));

  @override
  Future<Result<List<BoostPlan>>> boostPlans() => guard(_source.boostPlans);

  @override
  Future<Result<List<BoostCampaign>>> boostCampaigns() =>
      guard(_source.boostCampaigns);

  @override
  Future<Result<BoostCampaign>> buyBoost(String planId) =>
      guard(() => _source.buyBoost(planId));
}

/// The astrologer's own public profile.
class AstrologerProfileRepositoryImpl implements AstrologerProfileRepository {
  const AstrologerProfileRepositoryImpl(this._source);

  final ConsoleDataSource _source;

  @override
  Future<Result<AstrologerProfileDraft>> profile() => guard(_source.profile);

  @override
  Future<Result<AstrologerProfileDraft>> saveProfile(
    AstrologerProfileDraft profile,
  ) => guard(() => _source.saveProfile(profile));

  @override
  Future<Result<List<ComplianceNotice>>> complianceNotices() =>
      guard(_source.complianceNotices);

  @override
  Future<Result<ComplianceNotice>> acknowledgeNotice(String id) =>
      guard(() => _source.acknowledgeNotice(id));

  @override
  Future<Result<ComplianceNotice>> appealNotice(String id, String reason) =>
      guard(() => _source.appealNotice(id, reason));

  @override
  Future<Result<WorkPreferences>> workPreferences() =>
      guard(_source.workPreferences);

  @override
  Future<Result<WorkPreferences>> saveWorkPreferences(WorkPreferences prefs) =>
      guard(() => _source.saveWorkPreferences(prefs));
}
