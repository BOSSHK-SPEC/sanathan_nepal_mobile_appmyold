import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Validates and persists profile edits.
class UpdateUserProfile implements UseCase<UserProfile, UserProfile> {
  const UpdateUserProfile(this._repo);
  final ProfileRepository _repo;

  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  @override
  Future<Result<UserProfile>> call(UserProfile params) {
    if (params.name.trim().isEmpty) {
      return Future.value(
        const Result.failure(ValidationFailure('Name is required')),
      );
    }
    // Email is optional — phone-first accounts have none — but one that was
    // entered must be a real address.
    final email = params.email.trim();
    if (email.isNotEmpty && !_email.hasMatch(email)) {
      return Future.value(
        const Result.failure(ValidationFailure('Enter a valid email')),
      );
    }
    return _repo.updateProfile(params);
  }
}
