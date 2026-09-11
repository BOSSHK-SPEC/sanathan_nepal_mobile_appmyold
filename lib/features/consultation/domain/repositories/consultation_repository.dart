import '../../../../core/utils/result.dart';
import '../entities/astrologer_session.dart';
import '../entities/chat_message.dart';
import '../entities/consult_intake.dart';
import '../entities/consultation.dart';
import '../entities/session_summary.dart';

/// Live consultation delivery: queueing, messaging, ending and history.
///
/// Deliberately polling-shaped rather than stream-shaped. A real backend will
/// push over a socket, but the screens only need "what is true now", and a
/// polled contract is the one both a mock and a socket can satisfy.
abstract interface class ConsultationRepository {
  /// Creates a session in [ConsultationStatus.queued].
  Future<Result<Consultation>> start(ConsultIntake intake);

  Future<Result<Consultation>> get(String consultationId);

  /// Advances the mock session clock and returns the current state — the
  /// queue screen and the chat screen both poll this.
  Future<Result<Consultation>> refresh(String consultationId);

  Future<Result<List<ChatMessage>>> messages(String consultationId);

  Future<Result<ChatMessage>> send({
    required String consultationId,
    required String text,
  });

  /// Ends the session, fixes the billed duration and charges the wallet.
  Future<Result<Consultation>> end(String consultationId);

  /// Leaves the queue before the session starts. Nothing is charged.
  Future<Result<Consultation>> cancel(String consultationId);

  Future<Result<SessionSummary>> summary(String consultationId);

  Future<Result<List<Consultation>>> history();

  /// The seeker's currently-live session, if there is one.
  ///
  /// Drives the persistent call bar: a paid session that keeps billing while
  /// the user browses elsewhere has to stay visible, or the charge arrives
  /// as a surprise.
  Future<Result<Consultation?>> activeSession();

  /// Spendable wallet balance, for the live meter's low-balance warning.
  Future<Result<double>> spendableBalance();

  // --- Astrologer side --------------------------------------------------

  /// Accepts someone from the astrologer's queue and opens the session.
  ///
  /// Both sides read and write the same [Consultation] record, so the meter
  /// the seeker sees and the duration the astrologer is paid for can never
  /// diverge.
  Future<Result<Consultation>> acceptFromQueue(QueueAcceptRequest request);

  /// Sessions this astrologer has taken, newest first.
  Future<Result<List<Consultation>>> astrologerSessions();

  Future<Result<ChatMessage>> sendAsAstrologer({
    required String consultationId,
    required String text,
  });

  /// Saves the write-up the seeker sees on their summary screen.
  Future<Result<SessionSummary>> saveNotes(SessionNotesDraft draft);
}
