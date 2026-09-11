import '../entities/onboarding_step.dart';
import '../entities/user_profile_draft.dart';

/// Remembers how far onboarding got, and a half-filled details form, across
/// app restarts. Cleared once onboarding completes.
abstract interface class OnboardingProgressRepository {
  /// The last step reached, or null if onboarding never started.
  OnboardingStep? get step;

  Future<void> saveStep(OnboardingStep step);

  /// What the person had typed on the details form, if they left mid-way.
  UserProfileDraft? get detailsDraft;

  Future<void> saveDetailsDraft(UserProfileDraft draft);

  Future<void> clearDetailsDraft();

  /// Forgets everything — called when onboarding finishes.
  Future<void> clear();
}
