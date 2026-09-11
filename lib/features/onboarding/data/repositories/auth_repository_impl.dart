import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/otp_challenge.dart';
import '../../domain/entities/user_profile_draft.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_profile_draft_model.dart';

/// Orchestrates remote authentication and local session persistence.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  bool get isLoggedIn => _local.isLoggedIn;

  @override
  Future<Result<AuthSession>> signInWithGoogle() => guard(() async {
    final session = await _remote.signInWithGoogle();
    await _local.writeSession(session);
    return session.toEntity();
  });

  @override
  Future<Result<AuthSession>> signInWithApple() => guard(() async {
    final session = await _remote.signInWithApple();
    await _local.writeSession(session);
    return session.toEntity();
  });

  @override
  Future<Result<OtpChallenge>> signInWithPhone(String phoneNumber) =>
      guard(() async => (await _remote.requestOtp(phoneNumber)).toEntity());

  @override
  Future<Result<AuthSession>> verifyOtp({
    required String phoneNumber,
    required String code,
  }) => guard(() async {
    final session = await _remote.verifyOtp(
      phoneNumber: phoneNumber,
      code: code,
    );
    await _local.writeSession(session);
    return session.toEntity();
  });

  @override
  Future<Result<void>> submitProfile(UserProfileDraft draft) => guard(() async {
    final model = UserProfileDraftModel.fromEntity(draft);
    await _remote.submitProfile(model);
    await _local.writeProfile(model);
  });
}
