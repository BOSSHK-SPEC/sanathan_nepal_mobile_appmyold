import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/profile_repository.dart';

/// Signs the user out.
class Logout implements NoParamsUseCase<void> {
  const Logout(this._repo);
  final ProfileRepository _repo;

  @override
  Future<Result<void>> call() => _repo.logout();
}
