import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_notice.freezed.dart';

/// Why a notice was issued. Kept separate from severity: a policy update is
/// informational at any severity, a suspension never is.
enum ComplianceKind {
  policyUpdate,
  qualityWarning,
  lateResponse,
  refundIssued,
  penalty,
  documentExpiring,
  suspension,
}

/// How loudly the notice should read.
enum ComplianceSeverity { info, warning, critical }

enum ComplianceStatus { open, acknowledged, appealed, resolved, expired }

/// A notice from the platform to an astrologer.
///
/// This is the record of an enforcement decision, so it is append-only from
/// the astrologer's side: they can acknowledge it or appeal it, never edit or
/// delete it. That is also why the appeal carries its own timestamps —
/// "when did they respond" is the fact a dispute turns on.
@freezed
abstract class ComplianceNotice with _$ComplianceNotice {
  const ComplianceNotice._();

  const factory ComplianceNotice({
    required String id,
    required ComplianceKind kind,
    required ComplianceSeverity severity,
    required String title,
    required String body,
    required DateTime issuedAt,
    @Default(ComplianceStatus.open) ComplianceStatus status,

    /// What the astrologer has to do, if anything.
    String? requiredAction,

    /// When the required action must be done by. Past this, the notice
    /// escalates on the platform side.
    DateTime? dueBy,

    /// Amount withheld or charged, in the region's currency.
    double? penaltyAmount,

    /// The consultation or order the notice is about, when it has one.
    String? referenceId,
    DateTime? acknowledgedAt,

    /// Appeals close after a window; a notice past it can still be read but
    /// not contested.
    @Default(true) bool appealable,
    String? appealReason,
    DateTime? appealedAt,
    String? resolutionNote,
  }) = _ComplianceNotice;

  bool get isOpen => status == ComplianceStatus.open;

  bool get needsAction => isOpen && requiredAction != null;

  bool get canAppeal =>
      appealable &&
      (status == ComplianceStatus.open ||
          status == ComplianceStatus.acknowledged);

  bool get isOverdue =>
      dueBy != null && isOpen && DateTime.now().isAfter(dueBy!);

  bool get hasPenalty => (penaltyAmount ?? 0) > 0;
}
