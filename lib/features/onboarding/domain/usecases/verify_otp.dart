import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

part 'verify_otp.freezed.dart';

/// Parameters for [VerifyOtp].
@freezed
abstract class VerifyOtpParams with _$VerifyOtpParams {
  const factory VerifyOtpParams({
    required String phoneNumber,
    required String code,
  }) = _VerifyOtpParams;
}

/// Verifies the OTP entered by the user and returns the resulting session.
class VerifyOtp implements UseCase<AuthSession, VerifyOtpParams> {
  const VerifyOtp(this._repo);
  final AuthRepository _repo;

  @override
  Future<Result<AuthSession>> call(VerifyOtpParams params) {
    if (params.code.length < 4 || int.tryParse(params.code) == null) {
      return Future.value(
        const Result.failure(ValidationFailure('Invalid OTP')),
      );
    }
    return _repo.verifyOtp(phoneNumber: params.phoneNumber, code: params.code);
  }
}
