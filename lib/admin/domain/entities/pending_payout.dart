import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_payout.freezed.dart';

/// An astrologer or merchant asking to be paid out.
@freezed
abstract class PendingPayout with _$PendingPayout {
  const factory PendingPayout({
    required String id,
    required String userId,

    /// Major units — see [FinancialSummary] on why the conversion happens once,
    /// at the data source.
    @Default(0) double amount,
    required DateTime createdAt,
  }) = _PendingPayout;
}

/// The outcome of a decision on a payout or a refund.
///
/// The server answers with only the new state, which is all the console needs:
/// the list is refetched afterwards rather than patched locally, so two
/// reviewers working at once cannot leave one of them looking at a stale row.
@freezed
abstract class DecisionOutcome with _$DecisionOutcome {
  const factory DecisionOutcome({
    required String id,
    required String status,
  }) = _DecisionOutcome;
}
