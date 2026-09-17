import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/astrologer_session.dart';
import '../entities/call_credentials.dart';
import '../entities/chat_message.dart';
import '../entities/consult_intake.dart';
import '../entities/consultation.dart';
import '../entities/session_summary.dart';
import '../repositories/consultation_repository.dart';

class StartConsultation implements UseCase<Consultation, ConsultIntake> {
  const StartConsultation(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<Consultation>> call(ConsultIntake params) =>
      _repo.start(params);
}

class GetConsultation implements UseCase<Consultation, String> {
  const GetConsultation(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<Consultation>> call(String params) => _repo.get(params);
}

/// Polled by the queue and chat screens to advance the session state.
class RefreshConsultation implements UseCase<Consultation, String> {
  const RefreshConsultation(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<Consultation>> call(String params) => _repo.refresh(params);
}

class GetMessages implements UseCase<List<ChatMessage>, String> {
  const GetMessages(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<List<ChatMessage>>> call(String params) =>
      _repo.messages(params);
}

class SendMessageParams {
  const SendMessageParams({required this.consultationId, required this.text});
  final String consultationId;
  final String text;
}

class SendMessage implements UseCase<ChatMessage, SendMessageParams> {
  const SendMessage(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<ChatMessage>> call(SendMessageParams params) =>
      _repo.send(consultationId: params.consultationId, text: params.text);
}

class EndConsultation implements UseCase<Consultation, String> {
  const EndConsultation(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<Consultation>> call(String params) => _repo.end(params);
}

class CancelConsultation implements UseCase<Consultation, String> {
  const CancelConsultation(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<Consultation>> call(String params) => _repo.cancel(params);
}

class GetSessionSummary implements UseCase<SessionSummary, String> {
  const GetSessionSummary(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<SessionSummary>> call(String params) => _repo.summary(params);
}

class GetConsultationHistory implements NoParamsUseCase<List<Consultation>> {
  const GetConsultationHistory(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<List<Consultation>>> call() => _repo.history();
}

/// The seeker's currently-live session, if any. Polled by the call bar.
class GetActiveSession implements NoParamsUseCase<Consultation?> {
  const GetActiveSession(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<Consultation?>> call() => _repo.activeSession();
}

/// Spendable balance, for the live meter's low-balance warning.
class GetSpendableBalance implements NoParamsUseCase<double> {
  const GetSpendableBalance(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<double>> call() => _repo.spendableBalance();
}

/// A join token for a live call. Fetched per join — never stored.
class GetCallCredentials implements UseCase<CallCredentials, String> {
  const GetCallCredentials(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<CallCredentials>> call(String params) =>
      _repo.callCredentials(params);
}

/// Whether this deployment carries voice and video at all.
class GetCallsAvailable implements NoParamsUseCase<bool> {
  const GetCallsAvailable(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<bool>> call() => _repo.callsAvailable();
}

// --- Astrologer side ---------------------------------------------------

class AcceptFromQueue implements UseCase<Consultation, QueueAcceptRequest> {
  const AcceptFromQueue(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<Consultation>> call(QueueAcceptRequest params) =>
      _repo.acceptFromQueue(params);
}

class GetAstrologerSessions implements NoParamsUseCase<List<Consultation>> {
  const GetAstrologerSessions(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<List<Consultation>>> call() => _repo.astrologerSessions();
}

class SendAsAstrologer implements UseCase<ChatMessage, SendMessageParams> {
  const SendAsAstrologer(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<ChatMessage>> call(SendMessageParams params) =>
      _repo.sendAsAstrologer(
        consultationId: params.consultationId,
        text: params.text,
      );
}

class SaveSessionNotes implements UseCase<SessionSummary, SessionNotesDraft> {
  const SaveSessionNotes(this._repo);
  final ConsultationRepository _repo;

  @override
  Future<Result<SessionSummary>> call(SessionNotesDraft params) =>
      _repo.saveNotes(params);
}
