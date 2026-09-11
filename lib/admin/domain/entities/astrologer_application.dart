import 'package:freezed_annotation/freezed_annotation.dart';

part 'astrologer_application.freezed.dart';

/// Where an application sits in review. Mirrors the server's `ApplicationStatus`.
enum ApplicationStatus {
  draft,
  submitted,
  underReview,
  approved,
  rejected;

  /// Unknown values decay to [submitted] rather than throwing: a server that
  /// adds a state must not crash a console that has not shipped yet.
  static ApplicationStatus fromName(String? name) => values.firstWhere(
    (status) => status.name == name,
    orElse: () => ApplicationStatus.submitted,
  );

  bool get isDecided =>
      this == ApplicationStatus.approved || this == ApplicationStatus.rejected;
}

/// An astrologer asking to be verified, as a reviewer sees them.
@freezed
abstract class AstrologerApplication with _$AstrologerApplication {
  const factory AstrologerApplication({
    required String id,
    required String userId,
    required String fullName,
    required ApplicationStatus status,
    @Default(0) int experienceYears,
    DateTime? submittedAt,

    /// KYC documents, keyed by kind (`citizenship`, `certificate`, …). The
    /// values are media object ids, resolved to a URL only when opened — a
    /// reviewer's screen should not fetch every applicant's papers at once.
    @Default(<String, String>{}) Map<String, String> documents,
  }) = _AstrologerApplication;
}
