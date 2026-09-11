import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/application.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/specialty.dart';

/// The rules the wizard's Next button enforces, stated once.
///
/// The hint bar reads these to tell the applicant what is missing, so a rule
/// the entity applies but the hint cannot describe is a step that refuses to
/// advance without saying why — which is exactly how a filled-in Experience
/// step ended up looking broken.
void main() {
  const complete = AstrologerApplication(
    fullName: 'Ram Joshi',
    phone: '+9779812345678',
    experienceYears: 4,
    bio: 'Vedic astrologer practising in Kathmandu for four years.',
    specialties: [Specialty.vedic],
    languageCodes: ['ne'],
    ratePerMinute: {ConsultChannel.chat: 20},
    // The final step is accepting the terms, which is a timestamp rather than
    // a field the applicant types.
    termsAcceptedAt: null,
    documents: [
      KycDocument(
        kind: KycDocumentKind.identityFront,
        status: DocumentStatus.uploaded,
      ),
      KycDocument(
        kind: KycDocumentKind.identityBack,
        status: DocumentStatus.uploaded,
      ),
      KycDocument(
        kind: KycDocumentKind.selfie,
        status: DocumentStatus.uploaded,
      ),
    ],
  );

  test('a bio one character short blocks the step', () {
    final short = 'a' * (AstrologerApplication.minBioLength - 1);
    expect(complete.copyWith(bio: short).credentialsComplete, isFalse);
    expect(
      complete
          .copyWith(bio: 'a' * AstrologerApplication.minBioLength)
          .credentialsComplete,
      isTrue,
    );
  });

  test('the years field alone does not complete the step', () {
    // What the reported case looked like: years filled, bio too short. The
    // hint used to name both fields, including the one that was correct.
    final typical = complete.copyWith(experienceYears: 4, bio: 'dfdfdfdfd');
    expect(typical.credentialsComplete, isFalse);
    expect(typical.experienceYears > 0, isTrue);
    expect(
      AstrologerApplication.minBioLength - typical.bio.trim().length,
      31,
      reason: 'the hint must be able to say how many characters are missing',
    );
  });

  test('an optional certificate never blocks the step', () {
    expect(complete.missingForStep(KycStep.credentials), isEmpty);
    expect(complete.credentialsComplete, isTrue);
  });

  test('every step passes once the terms are accepted', () {
    final accepted = complete.copyWith(termsAcceptedAt: DateTime(2026, 9, 1));

    for (final step in KycStep.values) {
      expect(
        accepted.isStepComplete(step),
        isTrue,
        reason: '${step.name} should be complete',
      );
    }
    expect(accepted.canSubmit, isTrue);

    // Without them, only the last step blocks — nothing else silently fails.
    expect(complete.isStepComplete(KycStep.introduction), isFalse);
    expect(complete.completedSteps, KycStep.values.length - 1);
  });
}
