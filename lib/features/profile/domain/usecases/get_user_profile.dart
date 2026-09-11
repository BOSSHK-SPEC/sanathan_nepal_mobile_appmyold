import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Loads the signed-in user's profile.
class GetUserProfile implements NoParamsUseCase<UserProfile> {
  const GetUserProfile(this._repo);
  final ProfileRepository _repo;

  @override
  Future<Result<UserProfile>> call() => _repo.getProfile();
}
