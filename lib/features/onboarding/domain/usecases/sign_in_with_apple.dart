import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Signs the user in with their Apple ID.
class SignInWithApple implements NoParamsUseCase<AuthSession> {
  const SignInWithApple(this._repo);
  final AuthRepository _repo;

  @override
  Future<Result<AuthSession>> call() => _repo.signInWithApple();
}
