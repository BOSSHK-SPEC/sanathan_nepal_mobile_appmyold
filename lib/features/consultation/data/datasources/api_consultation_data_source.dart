import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/utils/localized_text.dart';
import '../../../../core/utils/ulid.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/astrologer_session.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/consult_intake.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/entities/session_summary.dart';
import 'consultation_data_source.dart';

/// Live consultations, served by the backend.
///
/// The billing clock lives entirely on the server: `startedAt`, `endedAt`,
/// `billedSeconds` and `amountCharged` all come from it and are written once,
/// at completion. The client renders a timer for the user's benefit but never
/// reports one — a client-supplied duration is a client-supplied bill.
class ApiConsultationDataSource implements ConsultationDataSource {
  const ApiConsultationDataSource(this._client);

  final ApiClient _client;

  @override
  Future<Consultation> start(ConsultIntake intake) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consultations,
      data: {
        'astrologerId': intake.astrologerId,
        'channel': intake.channel.name,
        'question': intake.question,
        'intake': {
          'name': intake.name,
          'birthDate': intake.birthDate?.toIso8601String(),
          'birthTime': intake.birthTimeUnknown ? null : intake.birthTime,
          'birthPlace': intake.birthPlace,
        },
      },
    );
    return _toConsultation(asJsonMap(response));
  });

  @override
  Future<Consultation> get(String consultationId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consultation(consultationId),
    );
    return _toConsultation(asJsonMap(response));
  });

  /// Polling the same resource.
  ///
  /// Identical to [get] on purpose: the app calls this on a timer while a
  /// session is queued or live, and having it hit a different endpoint would
  /// mean two shapes to keep in step. When the WebSocket gateway lands, only
  /// this method changes.
  @override
  Future<Consultation> refresh(String consultationId) => get(consultationId);

  @override
  Future<List<Consultation>> history() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.consultations);
    return asJsonList(response).map(_toConsultation).toList(growable: false);
  });

  @override
  Future<Consultation?> activeSession() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.activeConsultation,
    );
    // The endpoint answers `null` when nothing is live, which is a normal
    // state rather than a 404.
    final body = response.data;
    if (body == null) return null;
    return _toConsultation(asJsonMap(response));
  });

  @override
  Future<List<ChatMessage>> messages(String consultationId) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.consultationMessages(consultationId),
        );
        return asJsonList(response).map(_toMessage).toList(growable: false);
      });

  @override
  Future<ChatMessage> send({
    required String consultationId,
    required String text,
  }) => _send(consultationId, text);

  /// Same endpoint for both sides.
  ///
  /// The server infers the sender from the token — an astrologer posting to
  /// their own session is recorded as the astrologer. Letting the client
  /// declare which side it is would let a seeker post as the astrologer.
  @override
  Future<ChatMessage> sendAsAstrologer({
    required String consultationId,
    required String text,
  }) => _send(consultationId, text);

  Future<ChatMessage> _send(String consultationId, String text) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.consultationMessages(consultationId),
          data: {
            // Client-supplied so a retry after a dropped connection collapses
            // onto one row instead of posting the message twice.
            'messageId': Ulid.generate(),
            'body': text,
          },
        );
        return _toMessage(asJsonMap(response));
      });

  @override
  Future<Consultation> end(String consultationId) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consultationEnd(consultationId),
      data: {'reason': 'ended'},
    );
    return _toConsultation(asJsonMap(response));
  });

  @override
  Future<Consultation> cancel(String consultationId) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.consultationCancel(consultationId),
    );
    return _toConsultation(asJsonMap(response));
  });

  @override
  Future<SessionSummary> summary(String consultationId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.consultationSummary(consultationId),
    );
    final body = response.data;
    if (body == null) return SessionSummary(consultationId: consultationId);
    return _toSummary(asJsonMap(response), consultationId);
  });

  @override
  Future<Consultation> acceptFromQueue(QueueAcceptRequest request) =>
      guardApi(() async {
        // The queue entry id *is* the consultation id — the server creates
        // both together and the console is handed the consultation.
        final response = await _client.post<dynamic>(
          ApiEndpoints.consultationAccept(request.queueEntryId),
        );
        return _toConsultation(asJsonMap(response));
      });

  @override
  Future<List<Consultation>> astrologerSessions() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.astrologerSessions,
    );
    return asJsonList(response).map(_toConsultation).toList(growable: false);
  });

  @override
  Future<SessionSummary> saveNotes(SessionNotesDraft draft) =>
      guardApi(() async {
        if (!draft.isValid) {
          throw const ValidationException(
            'Add a few lines or a remedy before saving',
            'notes',
          );
        }

        final response = await _client.post<dynamic>(
          ApiEndpoints.consultationSummary(draft.consultationId),
          data: {
            'notes': draft.notes,
            'remedies': draft.remedies
                .map(
                  (r) => {
                    'kind': r.kind.name,
                    'title': {'en': r.title.en, 'ne': r.title.ne},
                    'description': {
                      'en': r.description.en,
                      'ne': r.description.ne,
                    },
                    'productId': r.productId,
                  },
                )
                .toList(),
          },
        );
        return _toSummary(asJsonMap(response), draft.consultationId);
      });

  Consultation _toConsultation(Map<String, dynamic> json) => Consultation(
    id: json['id'] as String? ?? '',
    astrologerId: json['astrologerId'] as String? ?? '',
    astrologerName: _text(json['astrologerName']),
    astrologerAvatar: json['astrologerAvatar'] as String?,
    channel: ConsultChannel.fromName(json['channel'] as String?),
    status: ConsultationStatus.fromName(json['status'] as String?),
    ratePerMinute: ApiMoney.toMajor(json['ratePerMinuteMinor']),
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    question: json['question'] as String? ?? '',
    startedAt: ApiTime.instant(json['startedAt']),
    endedAt: ApiTime.instant(json['endedAt']),
    billedSeconds: (json['billedSeconds'] as num?)?.toInt() ?? 0,
    amountCharged: ApiMoney.toMajor(json['amountChargedMinor']),
    queuePosition: (json['queuePosition'] as num?)?.toInt() ?? 0,
  );

  ChatMessage _toMessage(Map<String, dynamic> json) => ChatMessage(
    id: json['id'] as String? ?? '',
    consultationId: json['consultationId'] as String? ?? '',
    sender: switch (json['sender']) {
      'astrologer' => ChatSender.astrologer,
      'system' => ChatSender.system,
      _ => ChatSender.seeker,
    },
    sentAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    kind: json['attachmentKey'] == null ? MessageKind.text : MessageKind.image,
    text: json['body'] as String? ?? '',
    // A message the server acknowledged is at least delivered; `readAt` moves
    // it to read.
    status: json['readAt'] == null
        ? MessageStatus.delivered
        : MessageStatus.read,
    attachment: json['attachmentKey'] as String?,
  );

  SessionSummary _toSummary(Map<String, dynamic> json, String consultationId) {
    final remedies = json['remedies'];
    return SessionSummary(
      consultationId: json['consultationId'] as String? ?? consultationId,
      notes: json['notes'] as String? ?? '',
      remedies: remedies is List
          ? remedies
                .whereType<Map>()
                .map(
                  (r) => Remedy(
                    kind: RemedyKind.values.firstWhere(
                      (k) => k.name == r['kind'],
                      orElse: () => RemedyKind.values.first,
                    ),
                    title: _text(r['title']),
                    description: _text(r['description']),
                    productId: r['productId'] as String?,
                  ),
                )
                .toList(growable: false)
          : const [],
      hasTranscript: json['hasTranscript'] as bool? ?? false,
      recordingUrl: json['recordingUrl'] as String?,
    );
  }

  static LocalizedText _text(Object? raw) {
    if (raw is String) return LocalizedText(en: raw, ne: raw);
    if (raw is! Map) return const LocalizedText(en: '', ne: '');
    final en = raw['en'] as String? ?? '';
    return LocalizedText(
      en: en,
      ne: raw['ne'] as String? ?? en,
      hi: raw['hi'] as String? ?? '',
    );
  }
}
