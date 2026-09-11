import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/user_profile_draft.dart';
import '../repositories/auth_repository.dart';

/// Validates and stores the onboarding profile draft.
class SubmitProfile implements UseCase<void, UserProfileDraft> {
  const SubmitProfile(this._repo);
  final AuthRepository _repo;

  @override
  Future<Result<void>> call(UserProfileDraft params) {
    if (!params.isValid) {
      return Future.value(
        const Result.failure(ValidationFailure('Incomplete profile')),
      );
    }
    return _repo.submitProfile(params);
  }
}
