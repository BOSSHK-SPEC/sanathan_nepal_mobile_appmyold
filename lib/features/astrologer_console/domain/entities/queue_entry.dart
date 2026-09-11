import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/consult_channel.dart';

part 'queue_entry.freezed.dart';

/// Someone waiting to consult.
@freezed
abstract class QueueEntry with _$QueueEntry {
  const QueueEntry._();

  const factory QueueEntry({
    required String id,
    required String seekerName,
    required ConsultChannel channel,
    required DateTime joinedAt,
    String? seekerAvatar,

    /// What they typed at intake — the astrologer's only preparation.
    @Default('') String question,
    @Default(false) bool isRepeatClient,

    /// Their balance in minutes at the current rate; a one-minute wallet
    /// predicts a session that ends before it starts.
    @Default(0) int affordableMinutes,
  }) = _QueueEntry;

  Duration waitedFor({DateTime? now}) =>
      (now ?? DateTime.now()).difference(joinedAt);

  /// Flagged in the queue so the astrologer can set expectations rather than
  /// be cut off mid-sentence.
  bool get isShortOnBalance => affordableMinutes > 0 && affordableMinutes < 3;
}

/// A request being offered to the astrologer right now.
@freezed
abstract class IncomingRequest with _$IncomingRequest {
  const IncomingRequest._();

  const factory IncomingRequest({
    required QueueEntry entry,
    required DateTime offeredAt,

    /// Seconds to respond before it rolls to the next astrologer.
    @Default(30) int timeoutSeconds,
  }) = _IncomingRequest;

  int secondsRemaining({DateTime? now}) {
    final elapsed = (now ?? DateTime.now()).difference(offeredAt).inSeconds;
    return (timeoutSeconds - elapsed).clamp(0, timeoutSeconds);
  }

  double progress({DateTime? now}) =>
      timeoutSeconds == 0 ? 0 : secondsRemaining(now: now) / timeoutSeconds;

  bool get isExpired => secondsRemaining() <= 0;
}
