import '../../../../core/billing/spending_account.dart';
import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/astrologer_session.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/consult_intake.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/entities/session_summary.dart';
import '../../domain/repositories/consultation_repository.dart';
import '../datasources/consultation_data_source.dart';

class ConsultationRepositoryImpl implements ConsultationRepository {
  const ConsultationRepositoryImpl({
    required ConsultationDataSource source,
    required SpendingAccount account,
  }) : _source = source,
       _account = account;

  final ConsultationDataSource _source;
  final SpendingAccount _account;

  @override
  Future<Result<Consultation>> start(ConsultIntake intake) =>
      guard(() => _source.start(intake));

  @override
  Future<Result<Consultation>> get(String consultationId) =>
      guard(() => _source.get(consultationId));

  @override
  Future<Result<Consultation>> refresh(String consultationId) =>
      guard(() => _source.refresh(consultationId));

  @override
  Future<Result<List<ChatMessage>>> messages(String consultationId) =>
      guard(() => _source.messages(consultationId));

  @override
  Future<Result<ChatMessage>> send({
    required String consultationId,
    required String text,
  }) => guard(() => _source.send(consultationId: consultationId, text: text));

  @override
  Future<Result<Consultation>> end(String consultationId) =>
      guard(() => _source.end(consultationId));

  @override
  Future<Result<Consultation>> cancel(String consultationId) =>
      guard(() => _source.cancel(consultationId));

  @override
  Future<Result<SessionSummary>> summary(String consultationId) =>
      guard(() => _source.summary(consultationId));

  @override
  Future<Result<List<Consultation>>> history() => guard(_source.history);

  @override
  Future<Result<Consultation?>> activeSession() => guard(_source.activeSession);

  @override
  Future<Result<double>> spendableBalance() => guard(_account.spendable);

  @override
  Future<Result<Consultation>> acceptFromQueue(QueueAcceptRequest request) =>
      guard(() => _source.acceptFromQueue(request));

  @override
  Future<Result<List<Consultation>>> astrologerSessions() =>
      guard(_source.astrologerSessions);

  @override
  Future<Result<ChatMessage>> sendAsAstrologer({
    required String consultationId,
    required String text,
  }) => guard(
    () => _source.sendAsAstrologer(consultationId: consultationId, text: text),
  );

  @override
  Future<Result<SessionSummary>> saveNotes(SessionNotesDraft draft) =>
      guard(() => _source.saveNotes(draft));
}
