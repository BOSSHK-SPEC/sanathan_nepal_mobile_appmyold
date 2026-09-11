import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/panchanga_element.dart';

part 'panchanga_element_model.freezed.dart';
part 'panchanga_element_model.g.dart';

/// Wire shape of [PanchangaElement].
@freezed
abstract class PanchangaElementModel with _$PanchangaElementModel {
  const PanchangaElementModel._();

  const factory PanchangaElementModel({
    @Default('') String nameNe,
    @Default('') String nameEn,
    required DateTime endsAt,
    @Default('') String nextNe,
    @Default('') String nextEn,
    @Default('') String ghatiPala,
    @Default(0) double bhukta,
    @Default(0) double bhogya,
    @Default(0) double spashta,
  }) = _PanchangaElementModel;

  factory PanchangaElementModel.fromJson(Map<String, dynamic> json) =>
      _$PanchangaElementModelFromJson(json);

  factory PanchangaElementModel.fromEntity(PanchangaElement e) =>
      PanchangaElementModel(
        nameNe: e.nameNe,
        nameEn: e.nameEn,
        endsAt: e.endsAt,
        nextNe: e.nextNe,
        nextEn: e.nextEn,
        ghatiPala: e.ghatiPala,
        bhukta: e.bhukta,
        bhogya: e.bhogya,
        spashta: e.spashta,
      );

  PanchangaElement toEntity() => PanchangaElement(
    nameNe: nameNe,
    nameEn: nameEn,
    endsAt: endsAt,
    nextNe: nextNe,
    nextEn: nextEn,
    ghatiPala: ghatiPala,
    bhukta: bhukta,
    bhogya: bhogya,
    spashta: spashta,
  );
}
