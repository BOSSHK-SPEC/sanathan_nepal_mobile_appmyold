import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/sign_profile.dart';
import 'horoscope_media_model.dart';

part 'sign_profile_model.freezed.dart';
part 'sign_profile_model.g.dart';

/// Serialisable [SignProfile].
@freezed
abstract class SignProfileModel with _$SignProfileModel {
  const SignProfileModel._();

  const factory SignProfileModel({
    @Default('') String aboutNe,
    @Default('') String aboutEn,
    @Default('') String aboutHi,
    @Default([]) List<SignProfileTabModel> tabs,
    @Default(HoroscopeMediaModel()) HoroscopeMediaModel luckyMedia,
  }) = _SignProfileModel;

  factory SignProfileModel.fromJson(Map<String, dynamic> json) =>
      _$SignProfileModelFromJson(json);

  factory SignProfileModel.fromEntity(SignProfile e) => SignProfileModel(
    aboutNe: e.aboutNe,
    aboutEn: e.aboutEn,
    aboutHi: e.aboutHi,
    tabs: [for (final t in e.tabs) SignProfileTabModel.fromEntity(t)],
    luckyMedia: HoroscopeMediaModel.fromEntity(e.luckyMedia),
  );

  SignProfile toEntity() => SignProfile(
    aboutNe: aboutNe,
    aboutEn: aboutEn,
    aboutHi: aboutHi,
    tabs: [for (final t in tabs) t.toEntity()],
    luckyMedia: luckyMedia.toEntity(),
  );
}

/// Serialisable [SignProfileTab].
@freezed
abstract class SignProfileTabModel with _$SignProfileTabModel {
  const SignProfileTabModel._();

  const factory SignProfileTabModel({
    @Default('') String titleNe,
    @Default('') String titleEn,
    @Default('') String titleHi,
    @Default('') String introNe,
    @Default('') String introEn,
    @Default('') String introHi,
    @Default([]) List<SignProfilePointModel> points,
  }) = _SignProfileTabModel;

  factory SignProfileTabModel.fromJson(Map<String, dynamic> json) =>
      _$SignProfileTabModelFromJson(json);

  factory SignProfileTabModel.fromEntity(SignProfileTab e) =>
      SignProfileTabModel(
        titleNe: e.titleNe,
        titleEn: e.titleEn,
        titleHi: e.titleHi,
        introNe: e.introNe,
        introEn: e.introEn,
        introHi: e.introHi,
        points: [for (final p in e.points) SignProfilePointModel.fromEntity(p)],
      );

  SignProfileTab toEntity() => SignProfileTab(
    titleNe: titleNe,
    titleEn: titleEn,
    titleHi: titleHi,
    introNe: introNe,
    introEn: introEn,
    introHi: introHi,
    points: [for (final p in points) p.toEntity()],
  );
}

/// Serialisable [SignProfilePoint].
@freezed
abstract class SignProfilePointModel with _$SignProfilePointModel {
  const SignProfilePointModel._();

  const factory SignProfilePointModel({
    @Default('') String labelNe,
    @Default('') String labelEn,
    @Default('') String labelHi,
    @Default('') String textNe,
    @Default('') String textEn,
    @Default('') String textHi,
  }) = _SignProfilePointModel;

  factory SignProfilePointModel.fromJson(Map<String, dynamic> json) =>
      _$SignProfilePointModelFromJson(json);

  factory SignProfilePointModel.fromEntity(SignProfilePoint e) =>
      SignProfilePointModel(
        labelNe: e.labelNe,
        labelEn: e.labelEn,
        labelHi: e.labelHi,
        textNe: e.textNe,
        textEn: e.textEn,
        textHi: e.textHi,
      );

  SignProfilePoint toEntity() => SignProfilePoint(
    labelNe: labelNe,
    labelEn: labelEn,
    labelHi: labelHi,
    textNe: textNe,
    textEn: textEn,
    textHi: textHi,
  );
}
