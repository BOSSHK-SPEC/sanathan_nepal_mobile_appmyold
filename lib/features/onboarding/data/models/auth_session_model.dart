import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_session.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

/// JSON-serialisable [AuthSession].
@freezed
abstract class AuthSessionModel with _$AuthSessionModel {
  const AuthSessionModel._();

  const factory AuthSessionModel({
    required String userId,
    @JsonKey(unknownEnumValue: AuthProvider.phone)
    @Default(AuthProvider.phone)
    AuthProvider provider,
    @Default(false) bool isNewUser,
    String? displayName,
    String? phoneNumber,
    String? email,
  }) = _AuthSessionModel;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);

  factory AuthSessionModel.fromEntity(AuthSession e) => AuthSessionModel(
    userId: e.userId,
    provider: e.provider,
    isNewUser: e.isNewUser,
    displayName: e.displayName,
    phoneNumber: e.phoneNumber,
    email: e.email,
  );

  AuthSession toEntity() => AuthSession(
    userId: userId,
    provider: provider,
    isNewUser: isNewUser,
    displayName: displayName,
    phoneNumber: phoneNumber,
    email: email,
  );
}
