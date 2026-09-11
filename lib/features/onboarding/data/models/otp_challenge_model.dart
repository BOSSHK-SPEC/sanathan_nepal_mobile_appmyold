import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/otp_challenge.dart';

part 'otp_challenge_model.freezed.dart';
part 'otp_challenge_model.g.dart';

/// JSON-serialisable [OtpChallenge] (returned by the OTP request endpoint).
@freezed
abstract class OtpChallengeModel with _$OtpChallengeModel {
  const OtpChallengeModel._();

  const factory OtpChallengeModel({
    required String phoneNumber,
    @Default(false) bool isRegistered,
    String? displayName,
    @Default(6) int codeLength,
  }) = _OtpChallengeModel;

  factory OtpChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$OtpChallengeModelFromJson(json);

  factory OtpChallengeModel.fromEntity(OtpChallenge e) => OtpChallengeModel(
    phoneNumber: e.phoneNumber,
    isRegistered: e.isRegistered,
    displayName: e.displayName,
    codeLength: e.codeLength,
  );

  OtpChallenge toEntity() => OtpChallenge(
    phoneNumber: phoneNumber,
    isRegistered: isRegistered,
    displayName: displayName,
    codeLength: codeLength,
  );
}
