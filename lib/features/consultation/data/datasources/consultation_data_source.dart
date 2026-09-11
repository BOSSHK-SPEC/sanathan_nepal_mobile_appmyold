import '../../domain/entities/astrologer_session.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/consult_intake.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/entities/session_summary.dart';

abstract interface class ConsultationDataSource {
  Future<Consultation> start(ConsultIntake intake);
  Future<Consultation> get(String consultationId);
  Future<Consultation> refresh(String consultationId);
  Future<List<ChatMessage>> messages(String consultationId);
  Future<ChatMessage> send({
    required String consultationId,
    required String text,
  });
  Future<Consultation> end(String consultationId);
  Future<Consultation> cancel(String consultationId);
  Future<SessionSummary> summary(String consultationId);
  Future<List<Consultation>> history();
  Future<Consultation?> activeSession();

  Future<Consultation> acceptFromQueue(QueueAcceptRequest request);
  Future<List<Consultation>> astrologerSessions();
  Future<ChatMessage> sendAsAstrologer({
    required String consultationId,
    required String text,
  });
  Future<SessionSummary> saveNotes(SessionNotesDraft draft);
}
