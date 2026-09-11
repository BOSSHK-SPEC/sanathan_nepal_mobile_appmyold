import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/astrologer_repository.dart';

/// Follows / unfollows and returns the resulting state.
class ToggleFollowAstrologer implements UseCase<bool, String> {
  const ToggleFollowAstrologer(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<bool>> call(String params) => _repo.toggleFollow(params);
}
