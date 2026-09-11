import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_challenge.freezed.dart';

/// Issued after a phone number is submitted; describes the pending OTP step.
///
/// [isRegistered] drives which OTP popup is shown ("Existing User" with the
/// known [displayName] vs. "New User").
@freezed
abstract class OtpChallenge with _$OtpChallenge {
  const factory OtpChallenge({
    required String phoneNumber,
    required bool isRegistered,
    String? displayName,
    @Default(6) int codeLength,
  }) = _OtpChallenge;
}
