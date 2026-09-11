import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';

part 'consultation.freezed.dart';

/// Lifecycle of a live consultation.
///
/// [queued] and [ringing] are distinct because they mean different things to
/// the seeker: waiting in line, versus the astrologer being asked right now.
enum ConsultationStatus {
  queued,
  ringing,
  active,
  completed,
  cancelled,
  declined,
  missed;

  bool get isLive => this == active || this == ringing;

  bool get isOver =>
      this == completed ||
      this == cancelled ||
      this == declined ||
      this == missed;

  static ConsultationStatus fromName(String? name) => ConsultationStatus.values
      .firstWhere((s) => s.name == name, orElse: () => queued);
}

/// A live consultation session.
@freezed
abstract class Consultation with _$Consultation {
  const Consultation._();

  const factory Consultation({
    required String id,
    required String astrologerId,
    required LocalizedText astrologerName,
    required ConsultChannel channel,
    required ConsultationStatus status,
    required double ratePerMinute,
    required DateTime createdAt,
    String? astrologerAvatar,

    /// What the seeker wants to ask, captured at intake.
    @Default('') String question,

    /// Set when the astrologer accepts and billing starts.
    DateTime? startedAt,
    DateTime? endedAt,

    /// Billed seconds, fixed at the end so the receipt cannot drift.
    @Default(0) int billedSeconds,
    @Default(0) double amountCharged,

    /// People ahead at the moment the session was created.
    ///
    /// Stored as-is for the whole life of the session; screens receive a
    /// copy carrying the *remaining* count, so nothing derived from the
    /// original position is lost as the queue drains.
    @Default(0) int queuePosition,
  }) = _Consultation;

  /// Seconds elapsed since billing started, for the live meter.
  int elapsedSeconds({DateTime? now}) {
    if (startedAt == null) return 0;
    final end = endedAt ?? now ?? DateTime.now();
    return end.difference(startedAt!).inSeconds.clamp(0, 1 << 30);
  }

  /// Billing is per started minute, which is what the rate advertises — a
  /// per-second proration would under-report against the quoted price.
  int billedMinutes({DateTime? now}) {
    final seconds = billedSeconds > 0
        ? billedSeconds
        : elapsedSeconds(now: now);
    return seconds == 0 ? 0 : (seconds / 60).ceil();
  }

  double costSoFar({DateTime? now}) => billedMinutes(now: now) * ratePerMinute;
}
