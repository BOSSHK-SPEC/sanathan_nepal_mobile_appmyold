import 'dart:convert';

import '../../../../core/billing/spending_account.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../../../core/utils/localized_text.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/domain/repositories/astrologer_repository.dart';
import '../../domain/entities/astrologer_session.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/consult_intake.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/entities/session_summary.dart';
import 'consultation_data_source.dart';
import 'consultation_script.dart';

/// Drives a believable consultation without a realtime backend.
///
/// The session advances on a clock rather than on a button, so the screens
/// are built against the timing that actually makes them hard: a wait in the
/// queue, an astrologer who takes a moment to reply, a meter that keeps
/// ticking, and a balance that can run out mid-session.
///
/// Everything is derived from timestamps, so state survives a restart and
/// two screens polling at different rates always agree.
class MockConsultationDataSource implements ConsultationDataSource {
  MockConsultationDataSource({
    required KeyValueStore store,
    required AstrologerRepository astrologers,
    required SpendingAccount account,
  }) : _store = store,
       _astrologers = astrologers,
       _account = account;

  final KeyValueStore _store;
  final AstrologerRepository _astrologers;
  final SpendingAccount _account;

  static const _sessionsKey = 'consultation.sessions';
  static const _messagesKey = 'consultation.messages';
  static const Duration _latency = Duration(milliseconds: 180);

  /// How long each person ahead in the queue takes to clear.
  static const Duration perQueuePerson = Duration(seconds: 6);

  /// Grace period before an idle astrologer accepts.
  static const Duration acceptAfter = Duration(seconds: 4);

  @override
  Future<Consultation> start(ConsultIntake intake) async {
    await Future<void>.delayed(_latency);

    final result = await _astrologers.getAstrologer(intake.astrologerId);
    final astrologer = result.valueOrNull;
    if (astrologer == null) {
      throw const NotFoundException('That astrologer is no longer available');
    }
    final rate = astrologer.rateFor(intake.channel);
    if (rate == null) {
      throw const ValidationException(
        'This astrologer does not offer that consultation type',
      );
    }

    // One minute is the smallest chargeable unit, so that is the floor for
    // starting at all — otherwise a session begins and immediately fails.
    final balance = await _account.spendable();
    if (balance < rate) {
      throw const ValidationException(
        'Add money to your wallet to start this consultation',
      );
    }

    final consultation = Consultation(
      id: 'cs-${DateTime.now().microsecondsSinceEpoch}',
      astrologerId: astrologer.id,
      astrologerName: astrologer.name,
      astrologerAvatar: astrologer.avatarAsset,
      channel: intake.channel,
      status: ConsultationStatus.queued,
      ratePerMinute: rate,
      question: intake.question,
      queuePosition: astrologer.queueLength,
      createdAt: DateTime.now(),
    );
    await _save(consultation);
    await _writeMessages(consultation.id, [
      ChatMessage(
        id: 'm-sys-0',
        consultationId: consultation.id,
        sender: ChatSender.system,
        text: 'joined',
        sentAt: DateTime.now(),
      ),
    ]);
    return consultation;
  }

  @override
  Future<Consultation> get(String consultationId) async {
    await Future<void>.delayed(_latency);
    return _require(consultationId);
  }

  /// Advances the session from its own timestamps: the queue drains, the
  /// astrologer accepts, and scripted replies arrive as time passes.
  ///
  /// The stored [Consultation.queuePosition] is the position at creation and
  /// is never overwritten — the whole schedule is derived from it, so
  /// decrementing it in place would erase the information that decides when
  /// the astrologer accepts. What the caller receives is a copy carrying the
  /// *remaining* position, for display only.
  @override
  Future<Consultation> refresh(String consultationId) async {
    await Future<void>.delayed(_latency);
    var session = _require(consultationId);
    if (session.status.isOver) return session;

    final now = DateTime.now();
    final waited = now.difference(session.createdAt);
    final initialQueue = session.queuePosition;
    final queueTime = perQueuePerson * initialQueue;

    if (session.status == ConsultationStatus.queued) {
      if (waited < queueTime) {
        final cleared = waited.inMilliseconds ~/ perQueuePerson.inMilliseconds;
        return session.copyWith(
          queuePosition: (initialQueue - cleared).clamp(0, initialQueue),
        );
      }
      session = session.copyWith(status: ConsultationStatus.ringing);
      await _save(session);
    }

    if (session.status == ConsultationStatus.ringing) {
      if (waited < queueTime + acceptAfter) {
        return session.copyWith(queuePosition: 0);
      }
      session = session.copyWith(
        status: ConsultationStatus.active,
        startedAt: session.createdAt.add(queueTime + acceptAfter),
      );
      await _save(session);
    }

    if (session.status == ConsultationStatus.active) {
      await _appendScripted(session, now);
    }
    return session.copyWith(queuePosition: 0);
  }

  @override
  Future<List<ChatMessage>> messages(String consultationId) async {
    await Future<void>.delayed(_latency);
    return _readMessages(consultationId);
  }

  @override
  Future<ChatMessage> send({
    required String consultationId,
    required String text,
  }) async {
    await Future<void>.delayed(_latency);
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      throw const ValidationException('Type a message first');
    }
    final session = _require(consultationId);
    if (session.status != ConsultationStatus.active) {
      throw const ValidationException('This session is not active');
    }

    final message = ChatMessage(
      id: 'm-${DateTime.now().microsecondsSinceEpoch}',
      consultationId: consultationId,
      sender: ChatSender.seeker,
      text: trimmed,
      status: MessageStatus.delivered,
      sentAt: DateTime.now(),
    );
    final existing = _readMessages(consultationId);
    await _writeMessages(consultationId, [...existing, message]);
    return message;
  }

  @override
  Future<Consultation> end(String consultationId) async {
    await Future<void>.delayed(_latency);
    final session = _require(consultationId);
    if (session.status.isOver) return session;

    if (session.status != ConsultationStatus.active) {
      // Never started, so nothing is owed.
      return cancel(consultationId);
    }

    final endedAt = DateTime.now();
    final seconds = endedAt.difference(session.startedAt!).inSeconds;
    final minutes = seconds == 0 ? 1 : (seconds / 60).ceil();
    final amount = minutes * session.ratePerMinute;

    // Charge before recording completion: if the wallet rejects it, the
    // session must not be filed as paid.
    await _account.charge(
      amount: amount,
      category: SpendCategory.consultation,
      description: '${session.channel.name} · $minutes min',
      referenceId: session.id,
    );

    final completed = session.copyWith(
      status: ConsultationStatus.completed,
      endedAt: endedAt,
      billedSeconds: seconds,
      amountCharged: amount,
    );
    await _save(completed);
    return completed;
  }

  @override
  Future<Consultation> cancel(String consultationId) async {
    await Future<void>.delayed(_latency);
    final session = _require(consultationId);
    if (session.status.isOver) return session;
    final cancelled = session.copyWith(
      status: ConsultationStatus.cancelled,
      endedAt: DateTime.now(),
    );
    await _save(cancelled);
    return cancelled;
  }

  @override
  Future<SessionSummary> summary(String consultationId) async {
    await Future<void>.delayed(_latency);
    final session = _require(consultationId);
    if (session.status != ConsultationStatus.completed) {
      return SessionSummary(consultationId: consultationId);
    }
    // A real write-up from the astrologer always wins over the scripted one.
    final written = _readNotes()[consultationId];
    if (written != null) return written;
    return SessionSummary(
      consultationId: consultationId,
      notes: ConsultationScript.summaryNotes,
      remedies: ConsultationScript.remedies,
      hasTranscript: session.channel == ConsultChannel.chat,
      recordingUrl: session.channel == ConsultChannel.chat
          ? null
          : 'recording://${session.id}',
    );
  }

  @override
  Future<List<Consultation>> history() async {
    await Future<void>.delayed(_latency);
    return _readAll().values.where((c) => c.status.isOver).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<Consultation?> activeSession() async {
    await Future<void>.delayed(_latency);
    // The seeker's own sessions only — the astrologer's carry a prefix.
    final live = _readAll().values.where(
      (c) => !c.status.isOver && !c.id.startsWith(astrologerPrefix),
    );
    if (live.isEmpty) return null;
    return live.reduce((a, b) => a.createdAt.isAfter(b.createdAt) ? a : b);
  }

  // --- Astrologer side --------------------------------------------------

  /// Sessions the astrologer opened are marked so both sides can read the
  /// same store without seeing each other's records.
  static const String astrologerPrefix = 'cs-a-';

  static const _notesKey = 'consultation.notes';

  @override
  Future<Consultation> acceptFromQueue(QueueAcceptRequest request) async {
    await Future<void>.delayed(_latency);

    // Accepted means live: there is no queue to wait through, because the
    // astrologer is the one who just said yes.
    final now = DateTime.now();
    final session = Consultation(
      id: '$astrologerPrefix${now.microsecondsSinceEpoch}',
      astrologerId: 'me',
      astrologerName: LocalizedText.same(request.seekerName),
      channel: request.channel,
      status: ConsultationStatus.active,
      ratePerMinute: request.ratePerMinute,
      question: request.question,
      createdAt: now,
      startedAt: now,
    );
    await _save(session);
    await _writeMessages(session.id, [
      ChatMessage(
        id: 'm-sys-0',
        consultationId: session.id,
        sender: ChatSender.system,
        text: 'joined',
        sentAt: now,
      ),
      if (request.question.isNotEmpty)
        ChatMessage(
          id: 'm-q-0',
          consultationId: session.id,
          sender: ChatSender.seeker,
          text: request.question,
          sentAt: now,
        ),
    ]);
    return session;
  }

  @override
  Future<List<Consultation>> astrologerSessions() async {
    await Future<void>.delayed(_latency);
    return _readAll().values
        .where((c) => c.id.startsWith(astrologerPrefix))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<ChatMessage> sendAsAstrologer({
    required String consultationId,
    required String text,
  }) async {
    await Future<void>.delayed(_latency);
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      throw const ValidationException('Type a message first');
    }
    final session = _require(consultationId);
    if (session.status != ConsultationStatus.active) {
      throw const ValidationException('This session is not active');
    }

    final message = ChatMessage(
      id: 'm-${DateTime.now().microsecondsSinceEpoch}',
      consultationId: consultationId,
      sender: ChatSender.astrologer,
      text: trimmed,
      status: MessageStatus.delivered,
      sentAt: DateTime.now(),
    );
    final existing = _readMessages(consultationId);
    await _writeMessages(consultationId, [...existing, message]);
    return message;
  }

  @override
  Future<SessionSummary> saveNotes(SessionNotesDraft draft) async {
    await Future<void>.delayed(_latency);
    final session = _require(draft.consultationId);
    if (session.status != ConsultationStatus.completed) {
      throw const ValidationException(
        'Finish the session before writing it up',
      );
    }
    if (!draft.isValid) {
      throw const ValidationException(
        'Write a few lines, or add at least one remedy',
      );
    }

    final summary = SessionSummary(
      consultationId: draft.consultationId,
      notes: draft.notes.trim(),
      remedies: draft.remedies,
      hasTranscript: session.channel == ConsultChannel.chat,
    );
    await _writeNotes(summary);
    return summary;
  }

  Map<String, SessionSummary> _readNotes() {
    final raw = _store.getString(_notesKey);
    if (raw == null || raw.isEmpty) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return {
      for (final entry in decoded.entries)
        entry.key: SessionSummary(
          consultationId: entry.key,
          notes: (entry.value as Map<String, dynamic>)['notes'] as String,
          hasTranscript: entry.value['hasTranscript'] as bool? ?? false,
          remedies: [
            for (final r in (entry.value['remedies'] as List<dynamic>? ?? []))
              Remedy(
                kind: RemedyKind.values.firstWhere(
                  (k) => k.name == (r as Map<String, dynamic>)['kind'],
                  orElse: () => RemedyKind.practice,
                ),
                title: LocalizedText.same(
                  (r as Map<String, dynamic>)['title'] as String,
                ),
                description: LocalizedText.same(r['description'] as String),
                productId: r['productId'] as String?,
              ),
          ],
        ),
    };
  }

  Future<void> _writeNotes(SessionSummary summary) async {
    final all = _readNotes()..[summary.consultationId] = summary;
    await _store.setString(
      _notesKey,
      jsonEncode({
        for (final e in all.entries)
          e.key: {
            'notes': e.value.notes,
            'hasTranscript': e.value.hasTranscript,
            'remedies': [
              for (final r in e.value.remedies)
                {
                  'kind': r.kind.name,
                  'title': r.title.en,
                  'description': r.description.en,
                  'productId': r.productId,
                },
            ],
          },
      }),
    );
  }

  // --- Scripted astrologer ---------------------------------------------

  /// Appends any scripted replies whose scheduled moment has passed.
  ///
  /// Driven by elapsed time rather than by a counter so that polling twice,
  /// or reopening the screen, never duplicates or skips a line.
  Future<void> _appendScripted(Consultation session, DateTime now) async {
    if (session.startedAt == null) return;
    final elapsed = now.difference(session.startedAt!);
    final existing = _readMessages(session.id);
    final alreadyScripted = existing
        .where((m) => m.id.startsWith('m-script-'))
        .length;

    final due = ConsultationScript.lines
        .where((line) => elapsed >= line.after)
        .length;
    if (due <= alreadyScripted) return;

    final additions = <ChatMessage>[];
    for (var i = alreadyScripted; i < due; i++) {
      final line = ConsultationScript.lines[i];
      additions.add(
        ChatMessage(
          id: 'm-script-$i',
          consultationId: session.id,
          sender: ChatSender.astrologer,
          text: line.text,
          sentAt: session.startedAt!.add(line.after),
        ),
      );
    }
    await _writeMessages(session.id, [...existing, ...additions]);
  }

  // --- Persistence ------------------------------------------------------

  Consultation _require(String id) {
    final session = _readAll()[id];
    if (session == null) {
      throw NotFoundException('No consultation with id "$id"');
    }
    return session;
  }

  Map<String, Consultation> _readAll() {
    final raw = _store.getString(_sessionsKey);
    if (raw == null || raw.isEmpty) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return {
      for (final e in decoded.entries)
        e.key: _fromJson(e.value as Map<String, dynamic>),
    };
  }

  Consultation _fromJson(Map<String, dynamic> e) => Consultation(
    id: e['id'] as String,
    astrologerId: e['astrologerId'] as String,
    astrologerName: LocalizedText(
      ne: e['nameNe'] as String? ?? '',
      en: e['nameEn'] as String? ?? '',
      hi: e['nameHi'] as String?,
    ),
    astrologerAvatar: e['avatar'] as String?,
    channel: ConsultChannel.fromName(e['channel'] as String?),
    status: ConsultationStatus.fromName(e['status'] as String?),
    ratePerMinute: (e['rate'] as num).toDouble(),
    question: e['question'] as String? ?? '',
    queuePosition: e['queuePosition'] as int? ?? 0,
    billedSeconds: e['billedSeconds'] as int? ?? 0,
    amountCharged: (e['amountCharged'] as num?)?.toDouble() ?? 0,
    createdAt: DateTime.parse(e['createdAt'] as String),
    startedAt: e['startedAt'] == null
        ? null
        : DateTime.parse(e['startedAt'] as String),
    endedAt: e['endedAt'] == null
        ? null
        : DateTime.parse(e['endedAt'] as String),
  );

  Future<void> _save(Consultation session) async {
    final all = _readAll()..[session.id] = session;
    await _store.setString(
      _sessionsKey,
      jsonEncode({
        for (final e in all.entries)
          e.key: {
            'id': e.value.id,
            'astrologerId': e.value.astrologerId,
            'nameNe': e.value.astrologerName.ne,
            'nameEn': e.value.astrologerName.en,
            'nameHi': e.value.astrologerName.hi,
            'avatar': e.value.astrologerAvatar,
            'channel': e.value.channel.name,
            'status': e.value.status.name,
            'rate': e.value.ratePerMinute,
            'question': e.value.question,
            'queuePosition': e.value.queuePosition,
            'billedSeconds': e.value.billedSeconds,
            'amountCharged': e.value.amountCharged,
            'createdAt': e.value.createdAt.toIso8601String(),
            'startedAt': e.value.startedAt?.toIso8601String(),
            'endedAt': e.value.endedAt?.toIso8601String(),
          },
      }),
    );
  }

  List<ChatMessage> _readMessages(String consultationId) {
    final raw = _store.getString('$_messagesKey.$consultationId');
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        ChatMessage(
          id: e['id'] as String,
          consultationId: consultationId,
          sender: ChatSender.values.firstWhere(
            (s) => s.name == e['sender'],
            orElse: () => ChatSender.system,
          ),
          kind: MessageKind.values.firstWhere(
            (k) => k.name == e['kind'],
            orElse: () => MessageKind.text,
          ),
          text: e['text'] as String? ?? '',
          status: MessageStatus.values.firstWhere(
            (s) => s.name == e['status'],
            orElse: () => MessageStatus.sent,
          ),
          attachment: e['attachment'] as String?,
          sentAt: DateTime.parse(e['sentAt'] as String),
        ),
    ]..sort((a, b) => a.sentAt.compareTo(b.sentAt));
  }

  Future<void> _writeMessages(
    String consultationId,
    List<ChatMessage> messages,
  ) => _store.setString(
    '$_messagesKey.$consultationId',
    jsonEncode([
      for (final m in messages)
        {
          'id': m.id,
          'sender': m.sender.name,
          'kind': m.kind.name,
          'text': m.text,
          'status': m.status.name,
          'attachment': m.attachment,
          'sentAt': m.sentAt.toIso8601String(),
        },
    ]),
  );
}
