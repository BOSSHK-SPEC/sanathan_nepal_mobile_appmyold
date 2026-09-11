import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/consult_channel.dart';
import 'session_summary.dart';

part 'astrologer_session.freezed.dart';

/// What the astrologer console hands over when accepting someone from the
/// queue.
///
/// Plain fields rather than the console's own `QueueEntry` so the dependency
/// runs one way only: the console knows about consultations, consultations
/// know nothing about the console.
@freezed
abstract class QueueAcceptRequest with _$QueueAcceptRequest {
  const factory QueueAcceptRequest({
    required String queueEntryId,
    required String seekerName,
    required ConsultChannel channel,
    required double ratePerMinute,
    @Default('') String question,

    /// Birth details the seeker gave at intake, shown in the console's side
    /// panel so the astrologer does not have to ask again.
    String? birthDetails,
  }) = _QueueAcceptRequest;
}

/// The notes and remedies an astrologer writes up after a session.
@freezed
abstract class SessionNotesDraft with _$SessionNotesDraft {
  const SessionNotesDraft._();

  const factory SessionNotesDraft({
    required String consultationId,
    @Default('') String notes,
    @Default(<Remedy>[]) List<Remedy> remedies,
  }) = _SessionNotesDraft;

  /// Notes without substance help nobody, so an empty write-up is refused
  /// rather than silently saved.
  bool get isValid => notes.trim().length >= 20 || remedies.isNotEmpty;
}
