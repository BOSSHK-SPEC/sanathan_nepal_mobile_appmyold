import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/domain/entities/specialty.dart';

part 'application.freezed.dart';

/// Where an astrologer's application stands.
///
/// [moreInfoNeeded] is separate from [rejected] because they need different
/// screens: one is a fixable request, the other is an outcome.
enum ApplicationStatus {
  notStarted,
  draft,
  submitted,
  underReview,
  moreInfoNeeded,
  approved,
  rejected;

  bool get isTerminal => this == approved || this == rejected;

  bool get isEditable =>
      this == notStarted || this == draft || this == moreInfoNeeded;

  /// Whether the applicant may still attach or discard documents.
  ///
  /// Wider than [isEditable] by exactly one status, deliberately: the server
  /// reopens a rejected application on the next edit, which makes a rejection
  /// the one outcome an applicant can still act on. Kept as its own getter
  /// rather than widening [isEditable], which also decides whether Submit is
  /// offered.
  ///
  /// Mirrors the server's guard — anything queued for review is off limits,
  /// because the reviewer is deciding on those exact files.
  bool get allowsDocumentChanges => isEditable || this == rejected;
}

/// The five wizard steps, in order.
enum KycStep { identity, credentials, expertise, pricing, introduction }

/// A document the applicant uploads.
///
/// Each kind names the [step] that collects it. That binding is what stops a
/// required document from being invisible: step completeness is derived from
/// it, so a requirement with no field on its step would block that step
/// rather than surfacing only at submit — which is a dead end.
enum KycDocumentKind {
  identityFront(KycStep.identity, required: true),
  identityBack(KycStep.identity, required: true),
  selfie(KycStep.identity, required: true),

  /// Optional: many practising astrologers trained in a lineage rather than
  /// an institution, so demanding a certificate would exclude them.
  certificate(KycStep.credentials, required: false),

  /// Optional: identity and a selfie are what verification actually needs.
  /// Kept because reviewers ask for it in edge cases.
  addressProof(KycStep.identity, required: false);

  const KycDocumentKind(this.step, {required bool required})
    : isRequired = required;

  /// Which wizard step collects this document.
  final KycStep step;

  final bool isRequired;

  /// Documents this step is responsible for.
  static List<KycDocumentKind> forStep(KycStep step) =>
      KycDocumentKind.values.where((k) => k.step == step).toList();
}

/// Per-document review state, so a rejection can name the one file at fault
/// instead of failing the whole application.
enum DocumentStatus { missing, uploaded, verified, rejected }

@freezed
abstract class KycDocument with _$KycDocument {
  const KycDocument._();

  const factory KycDocument({
    required KycDocumentKind kind,
    @Default(DocumentStatus.missing) DocumentStatus status,

    /// Local path or URL of the uploaded file.
    String? fileRef,

    /// Reviewer's reason when [status] is rejected.
    String? rejectionReason,
  }) = _KycDocument;

  bool get isSatisfied =>
      status == DocumentStatus.uploaded || status == DocumentStatus.verified;

  bool get blocksSubmission => kind.isRequired && !isSatisfied;
}

/// An astrologer's application to join the platform.
@freezed
abstract class AstrologerApplication with _$AstrologerApplication {
  const AstrologerApplication._();

  const factory AstrologerApplication({
    @Default(ApplicationStatus.notStarted) ApplicationStatus status,
    @Default('') String fullName,
    @Default('') String phone,
    @Default('') String email,
    @Default(0) int experienceYears,
    @Default('') String bio,
    @Default(<Specialty>[]) List<Specialty> specialties,
    @Default(<String>[]) List<String> languageCodes,

    /// Per-minute rate by channel; an omitted channel is not offered.
    @Default(<ConsultChannel, double>{})
    Map<ConsultChannel, double> ratePerMinute,
    @Default(<KycDocument>[]) List<KycDocument> documents,
    String? introVideoRef,

    /// Timestamped acceptance of the commission and conduct terms.
    DateTime? termsAcceptedAt,
    @Default('') String termsVersion,
    DateTime? submittedAt,
    DateTime? reviewedAt,

    /// Set when the reviewer rejects or asks for more.
    String? reviewerNote,
  }) = _AstrologerApplication;

  KycDocument documentFor(KycDocumentKind kind) => documents.firstWhere(
    (d) => d.kind == kind,
    orElse: () => KycDocument(kind: kind),
  );

  List<KycDocument> get missingRequired => [
    for (final kind in KycDocumentKind.values)
      if (documentFor(kind).blocksSubmission) documentFor(kind),
  ];

  /// Required documents this step owns that are still missing.
  List<KycDocumentKind> missingForStep(KycStep step) => [
    for (final kind in KycDocumentKind.forStep(step))
      if (documentFor(kind).blocksSubmission) kind,
  ];

  bool get identityComplete =>
      fullName.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      missingForStep(KycStep.identity).isEmpty;

  /// Shortest bio a reviewer can judge — and the shortest one a seeker gets
  /// anything from. Named because the wizard has to tell the applicant how
  /// far off they are, not just refuse to advance.
  static const int minBioLength = 40;

  bool get credentialsComplete =>
      experienceYears > 0 &&
      bio.trim().length >= minBioLength &&
      missingForStep(KycStep.credentials).isEmpty;

  bool get expertiseComplete =>
      specialties.isNotEmpty && languageCodes.isNotEmpty;

  bool get pricingComplete =>
      ratePerMinute.isNotEmpty && ratePerMinute.values.every((r) => r > 0);

  bool get introductionComplete => termsAcceptedAt != null;

  bool isStepComplete(KycStep step) => switch (step) {
    KycStep.identity => identityComplete,
    KycStep.credentials => credentialsComplete,
    KycStep.expertise => expertiseComplete,
    KycStep.pricing => pricingComplete,
    KycStep.introduction => introductionComplete,
  };

  /// Every step complete is now sufficient: each required document belongs
  /// to a step, so there is no requirement the wizard cannot show.
  bool get canSubmit =>
      status.isEditable && KycStep.values.every(isStepComplete);

  /// How far through the wizard, for the progress header.
  int get completedSteps => KycStep.values.where(isStepComplete).length;
}
