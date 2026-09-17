import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../../../astrologers/domain/entities/astrologer_review.dart';
import '../entities/console_appointment.dart';
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
import '../repositories/console_repositories.dart';

// --- Application -------------------------------------------------------

class GetApplication implements NoParamsUseCase<AstrologerApplication> {
  const GetApplication(this._repo);
  final AstrologerApplicationRepository _repo;

  @override
  Future<Result<AstrologerApplication>> call() => _repo.current();
}

class SaveApplicationDraft
    implements UseCase<AstrologerApplication, AstrologerApplication> {
  const SaveApplicationDraft(this._repo);
  final AstrologerApplicationRepository _repo;

  @override
  Future<Result<AstrologerApplication>> call(AstrologerApplication params) =>
      _repo.saveDraft(params);
}

class UploadKycParams {
  const UploadKycParams({required this.kind, required this.fileRef});
  final KycDocumentKind kind;
  final String fileRef;
}

class UploadKycDocument
    implements UseCase<AstrologerApplication, UploadKycParams> {
  const UploadKycDocument(this._repo);
  final AstrologerApplicationRepository _repo;

  @override
  Future<Result<AstrologerApplication>> call(UploadKycParams params) =>
      _repo.uploadDocument(kind: params.kind, fileRef: params.fileRef);
}

/// Discards an uploaded document. Takes the kind alone: there is nothing else
/// to identify, and the file it points at is the server's to find.
class RemoveKycDocument
    implements UseCase<AstrologerApplication, KycDocumentKind> {
  const RemoveKycDocument(this._repo);
  final AstrologerApplicationRepository _repo;

  @override
  Future<Result<AstrologerApplication>> call(KycDocumentKind params) =>
      _repo.removeDocument(kind: params);
}

class AcceptAstrologerTerms implements UseCase<AstrologerApplication, String> {
  const AcceptAstrologerTerms(this._repo);
  final AstrologerApplicationRepository _repo;

  @override
  Future<Result<AstrologerApplication>> call(String params) =>
      _repo.acceptTerms(params);
}

class SubmitApplication implements NoParamsUseCase<AstrologerApplication> {
  const SubmitApplication(this._repo);
  final AstrologerApplicationRepository _repo;

  @override
  Future<Result<AstrologerApplication>> call() => _repo.submit();
}

// --- Operations --------------------------------------------------------

class GetDashboard implements NoParamsUseCase<DashboardStats> {
  const GetDashboard(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<DashboardStats>> call() => _repo.dashboard();
}

class GetAvailability implements NoParamsUseCase<Availability> {
  const GetAvailability(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<Availability>> call() => _repo.availability();
}

class SaveAvailability implements UseCase<Availability, Availability> {
  const SaveAvailability(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<Availability>> call(Availability params) =>
      _repo.saveAvailability(params);
}

class SetOnline implements UseCase<Availability, bool> {
  const SetOnline(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<Availability>> call(bool params) =>
      _repo.setOnline(online: params);
}

class GetQueue implements NoParamsUseCase<List<QueueEntry>> {
  const GetQueue(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<List<QueueEntry>>> call() => _repo.queue();
}

class GetPendingRequest implements NoParamsUseCase<IncomingRequest?> {
  const GetPendingRequest(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<IncomingRequest?>> call() => _repo.pendingRequest();
}

class RespondParams {
  const RespondParams({required this.requestId, required this.accept});
  final String requestId;
  final bool accept;
}

class RespondToRequest implements UseCase<void, RespondParams> {
  const RespondToRequest(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<void>> call(RespondParams params) => _repo.respondToRequest(
    requestId: params.requestId,
    accept: params.accept,
  );
}

class GetClients implements NoParamsUseCase<List<AstrologerClient>> {
  const GetClients(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<List<AstrologerClient>>> call() => _repo.clients();
}

class GetClient implements UseCase<AstrologerClient, String> {
  const GetClient(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<AstrologerClient>> call(String params) => _repo.client(params);
}

class SaveClientNotesParams {
  const SaveClientNotesParams({required this.clientId, required this.notes});
  final String clientId;
  final String notes;
}

class SaveClientNotes
    implements UseCase<AstrologerClient, SaveClientNotesParams> {
  const SaveClientNotes(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<AstrologerClient>> call(SaveClientNotesParams params) =>
      _repo.saveClientNotes(clientId: params.clientId, notes: params.notes);
}

// --- Money & reputation ------------------------------------------------

class GetEarnings implements UseCase<EarningsSummary, EarningsRange> {
  const GetEarnings(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<EarningsSummary>> call(EarningsRange params) =>
      _repo.earnings(params);
}

class GetPerformance implements UseCase<PerformanceMetrics, EarningsRange> {
  const GetPerformance(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<PerformanceMetrics>> call(EarningsRange params) =>
      _repo.performance(params);
}

class GetPayoutAccount implements NoParamsUseCase<PayoutAccount?> {
  const GetPayoutAccount(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<PayoutAccount?>> call() => _repo.payoutAccount();
}

class SavePayoutAccount implements UseCase<PayoutAccount, PayoutAccount> {
  const SavePayoutAccount(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<PayoutAccount>> call(PayoutAccount params) =>
      _repo.savePayoutAccount(params);
}

class GetPayouts implements NoParamsUseCase<List<PayoutRequest>> {
  const GetPayouts(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<List<PayoutRequest>>> call() => _repo.payouts();
}

class RequestPayout implements UseCase<PayoutRequest, double> {
  const RequestPayout(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<PayoutRequest>> call(double params) =>
      _repo.requestPayout(params);
}

class GetTaxDocuments implements NoParamsUseCase<List<TaxDocument>> {
  const GetTaxDocuments(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<List<TaxDocument>>> call() => _repo.taxDocuments();
}

class GetPricing implements NoParamsUseCase<ConsolePricing> {
  const GetPricing(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<ConsolePricing>> call() => _repo.pricing();
}

class SavePricing implements UseCase<ConsolePricing, ConsolePricing> {
  const SavePricing(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<ConsolePricing>> call(ConsolePricing params) =>
      _repo.savePricing(params);
}

class GetMyReviews implements NoParamsUseCase<List<AstrologerReview>> {
  const GetMyReviews(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<List<AstrologerReview>>> call() => _repo.reviews();
}

class ReplyToReviewParams {
  const ReplyToReviewParams({required this.reviewId, required this.reply});
  final String reviewId;
  final String reply;
}

class ReplyToReview implements UseCase<AstrologerReview, ReplyToReviewParams> {
  const ReplyToReview(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<AstrologerReview>> call(ReplyToReviewParams params) =>
      _repo.replyToReview(reviewId: params.reviewId, reply: params.reply);
}

// --- Boost -------------------------------------------------------------

class GetBoostPlans implements NoParamsUseCase<List<BoostPlan>> {
  const GetBoostPlans(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<List<BoostPlan>>> call() => _repo.boostPlans();
}

class GetBoostCampaigns implements NoParamsUseCase<List<BoostCampaign>> {
  const GetBoostCampaigns(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<List<BoostCampaign>>> call() => _repo.boostCampaigns();
}

class BuyBoost implements UseCase<BoostCampaign, String> {
  const BuyBoost(this._repo);
  final AstrologerEarningsRepository _repo;

  @override
  Future<Result<BoostCampaign>> call(String params) => _repo.buyBoost(params);
}

// --- Public profile -------------------------------------------------------

class GetAstrologerProfile implements NoParamsUseCase<AstrologerProfileDraft> {
  const GetAstrologerProfile(this._repo);
  final AstrologerProfileRepository _repo;

  @override
  Future<Result<AstrologerProfileDraft>> call() => _repo.profile();
}

class SaveAstrologerProfile
    implements UseCase<AstrologerProfileDraft, AstrologerProfileDraft> {
  const SaveAstrologerProfile(this._repo);
  final AstrologerProfileRepository _repo;

  @override
  Future<Result<AstrologerProfileDraft>> call(AstrologerProfileDraft params) =>
      _repo.saveProfile(params);
}

class GetWorkPreferences implements NoParamsUseCase<WorkPreferences> {
  const GetWorkPreferences(this._repo);
  final AstrologerProfileRepository _repo;

  @override
  Future<Result<WorkPreferences>> call() => _repo.workPreferences();
}

class SaveWorkPreferences implements UseCase<WorkPreferences, WorkPreferences> {
  const SaveWorkPreferences(this._repo);
  final AstrologerProfileRepository _repo;

  @override
  Future<Result<WorkPreferences>> call(WorkPreferences params) =>
      _repo.saveWorkPreferences(params);
}

// --- Compliance -----------------------------------------------------------

class GetComplianceNotices implements NoParamsUseCase<List<ComplianceNotice>> {
  const GetComplianceNotices(this._repo);
  final AstrologerProfileRepository _repo;

  @override
  Future<Result<List<ComplianceNotice>>> call() => _repo.complianceNotices();
}

class AcknowledgeNotice implements UseCase<ComplianceNotice, String> {
  const AcknowledgeNotice(this._repo);
  final AstrologerProfileRepository _repo;

  @override
  Future<Result<ComplianceNotice>> call(String params) =>
      _repo.acknowledgeNotice(params);
}

/// An appeal needs the notice and the astrologer's reason together — one
/// without the other is not a submission.
class AppealNoticeParams {
  const AppealNoticeParams({required this.noticeId, required this.reason});
  final String noticeId;
  final String reason;
}

class AppealNotice implements UseCase<ComplianceNotice, AppealNoticeParams> {
  const AppealNotice(this._repo);
  final AstrologerProfileRepository _repo;

  @override
  Future<Result<ComplianceNotice>> call(AppealNoticeParams params) =>
      _repo.appealNotice(params.noticeId, params.reason);
}

// --- Appointments ---------------------------------------------------------

class GetConsoleAppointments
    implements UseCase<List<ConsoleAppointment>, AppointmentScope> {
  const GetConsoleAppointments(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<List<ConsoleAppointment>>> call(AppointmentScope params) =>
      _repo.appointments(params);
}

class GetConsoleAppointment implements UseCase<ConsoleAppointment, String> {
  const GetConsoleAppointment(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<ConsoleAppointment>> call(String params) =>
      _repo.appointment(params);
}

class RecordAppointmentOutcomeParams {
  const RecordAppointmentOutcomeParams({
    required this.id,
    required this.completed,
  });
  final String id;

  /// True for "completed", false for "the client did not come".
  final bool completed;
}

class RecordAppointmentOutcome
    implements UseCase<ConsoleAppointment, RecordAppointmentOutcomeParams> {
  const RecordAppointmentOutcome(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<ConsoleAppointment>> call(
    RecordAppointmentOutcomeParams params,
  ) => _repo.recordAppointmentOutcome(params.id, completed: params.completed);
}

class CancelConsoleAppointmentParams {
  const CancelConsoleAppointmentParams({
    required this.id,
    required this.reason,
  });
  final String id;
  final String reason;
}

class CancelConsoleAppointment
    implements UseCase<ConsoleAppointment, CancelConsoleAppointmentParams> {
  const CancelConsoleAppointment(this._repo);
  final AstrologerOpsRepository _repo;

  @override
  Future<Result<ConsoleAppointment>> call(
    CancelConsoleAppointmentParams params,
  ) => _repo.cancelAppointment(params.id, reason: params.reason);
}
