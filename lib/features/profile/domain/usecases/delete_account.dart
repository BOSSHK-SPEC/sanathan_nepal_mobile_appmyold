import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/profile_repository.dart';

/// Deletes the user's account (Figma "DELETE POPUP").
class DeleteAccount implements NoParamsUseCase<void> {
  const DeleteAccount(this._repo);
  final ProfileRepository _repo;

  @override
  Future<Result<void>> call() => _repo.deleteAccount();
}
