import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_profile_draft.dart';

part 'user_profile_draft_model.freezed.dart';
part 'user_profile_draft_model.g.dart';

/// JSON-serialisable [UserProfileDraft].
@freezed
abstract class UserProfileDraftModel with _$UserProfileDraftModel {
  const UserProfileDraftModel._();

  const factory UserProfileDraftModel({
    @Default('') String fullName,
    @Default('') String email,
    DateTime? dateOfBirth,
    @JsonKey(unknownEnumValue: DateSystem.bs)
    @Default(DateSystem.bs)
    DateSystem dateSystem,
    int? birthTimeMinutes,
    @Default('') String birthPlace,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    Gender? gender,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    ZodiacSign? zodiacSign,
  }) = _UserProfileDraftModel;

  factory UserProfileDraftModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDraftModelFromJson(json);

  factory UserProfileDraftModel.fromEntity(UserProfileDraft e) =>
      UserProfileDraftModel(
        fullName: e.fullName,
        email: e.email,
        dateOfBirth: e.dateOfBirth,
        dateSystem: e.dateSystem,
        birthTimeMinutes: e.birthTimeMinutes,
        birthPlace: e.birthPlace,
        gender: e.gender,
        zodiacSign: e.zodiacSign,
      );

  UserProfileDraft toEntity() => UserProfileDraft(
    fullName: fullName,
    email: email,
    dateOfBirth: dateOfBirth,
    dateSystem: dateSystem,
    birthTimeMinutes: birthTimeMinutes,
    birthPlace: birthPlace,
    gender: gender,
    zodiacSign: zodiacSign,
  );
}
