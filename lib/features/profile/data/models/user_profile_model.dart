import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

/// Persistence shape of [UserProfile] (JSON in the local key-value store).
@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const UserProfileModel._();

  const factory UserProfileModel({
    required String id,
    required String name,
    required String email,
    @Default('') String phone,
    String? avatarUrl,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    Gender? gender,
    String? dobBs,
    String? dobAd,
    String? birthTime,
    String? birthPlace,
    String? address,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    ProfileZodiac? zodiacSign,
    String? religion,
    String? bio,
    @Default(false) bool verified,
    @JsonKey(unknownEnumValue: UserRole.user)
    @Default({UserRole.user})
    Set<UserRole> roles,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  factory UserProfileModel.fromEntity(UserProfile e) => UserProfileModel(
    id: e.id,
    name: e.name,
    email: e.email,
    phone: e.phone,
    avatarUrl: e.avatarUrl,
    gender: e.gender,
    dobBs: e.dobBs,
    dobAd: e.dobAd,
    birthTime: e.birthTime,
    birthPlace: e.birthPlace,
    address: e.address,
    zodiacSign: e.zodiacSign,
    religion: e.religion,
    bio: e.bio,
    verified: e.verified,
    roles: e.roles,
  );

  UserProfile toEntity() => UserProfile(
    id: id,
    name: name,
    email: email,
    phone: phone,
    avatarUrl: avatarUrl,
    gender: gender,
    dobBs: dobBs,
    dobAd: dobAd,
    birthTime: birthTime,
    birthPlace: birthPlace,
    address: address,
    zodiacSign: zodiacSign,
    religion: religion,
    bio: bio,
    verified: verified,
    roles: roles,
  );
}
