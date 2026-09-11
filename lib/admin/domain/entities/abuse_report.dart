import 'package:freezed_annotation/freezed_annotation.dart';

part 'abuse_report.freezed.dart';

/// Why something was reported. Mirrors the server's `ReportReason`.
enum ReportReason {
  abusive,
  fraud,
  impersonation,
  spam,
  other;

  static ReportReason fromName(String? name) => values.firstWhere(
    (reason) => reason.name == name,
    orElse: () => ReportReason.other,
  );

  String get label => switch (this) {
    ReportReason.abusive => 'Abusive',
    ReportReason.fraud => 'Fraud',
    ReportReason.impersonation => 'Impersonation',
    ReportReason.spam => 'Spam',
    ReportReason.other => 'Other',
  };
}

/// A user's report about another user, a listing or a review.
@freezed
abstract class AbuseReport with _$AbuseReport {
  const factory AbuseReport({
    required String id,
    required String reporterId,
    required String targetType,
    required String targetId,
    required ReportReason reason,
    @Default('') String detail,
    @Default(false) bool resolved,
    required DateTime createdAt,
  }) = _AbuseReport;
}
