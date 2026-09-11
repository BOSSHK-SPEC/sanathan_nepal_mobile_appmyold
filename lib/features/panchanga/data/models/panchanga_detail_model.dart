import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/panchanga_detail.dart';

part 'panchanga_detail_model.freezed.dart';
part 'panchanga_detail_model.g.dart';

/// Wire shape of [PanchangaDetail].
@freezed
abstract class PanchangaDetailModel with _$PanchangaDetailModel {
  const PanchangaDetailModel._();

  const factory PanchangaDetailModel({
    @Default('') String labelNe,
    @Default('') String labelEn,
    @Default('') String value,
  }) = _PanchangaDetailModel;

  factory PanchangaDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PanchangaDetailModelFromJson(json);

  factory PanchangaDetailModel.fromEntity(PanchangaDetail e) =>
      PanchangaDetailModel(
        labelNe: e.labelNe,
        labelEn: e.labelEn,
        value: e.value,
      );

  PanchangaDetail toEntity() =>
      PanchangaDetail(labelNe: labelNe, labelEn: labelEn, value: value);
}
