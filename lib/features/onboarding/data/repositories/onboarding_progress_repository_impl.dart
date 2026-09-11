import '../../domain/entities/onboarding_step.dart';
import '../../domain/entities/user_profile_draft.dart';
import '../../domain/repositories/onboarding_progress_repository.dart';
import '../datasources/onboarding_progress_local_data_source.dart';
import '../models/user_profile_draft_model.dart';

class OnboardingProgressRepositoryImpl implements OnboardingProgressRepository {
  OnboardingProgressRepositoryImpl(this._local);

  final OnboardingProgressLocalDataSource _local;

  @override
  OnboardingStep? get step => OnboardingStep.tryParse(_local.readStep());

  @override
  Future<void> saveStep(OnboardingStep step) => _local.writeStep(step.name);

  @override
  UserProfileDraft? get detailsDraft => _local.readDraft()?.toEntity();

  @override
  Future<void> saveDetailsDraft(UserProfileDraft draft) =>
      _local.writeDraft(UserProfileDraftModel.fromEntity(draft));

  @override
  Future<void> clearDetailsDraft() => _local.clearDraft();

  @override
  Future<void> clear() => _local.clear();
}
