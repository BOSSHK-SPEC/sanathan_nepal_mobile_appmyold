import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/suva_sait.dart';

part 'suva_sait_model.freezed.dart';
part 'suva_sait_model.g.dart';

/// Serialisable [SuvaSait].
@freezed
abstract class SuvaSaitModel with _$SuvaSaitModel {
  const SuvaSaitModel._();

  const factory SuvaSaitModel({
    required String id,
    @Default('') String titleNe,
    @Default('') String titleEn,
    @Default([]) List<DateTime> dates,
    @Default('') String noteNe,
    @Default('') String noteEn,
  }) = _SuvaSaitModel;

  factory SuvaSaitModel.fromJson(Map<String, dynamic> json) =>
      _$SuvaSaitModelFromJson(json);

  factory SuvaSaitModel.fromEntity(SuvaSait e) => SuvaSaitModel(
    id: e.id,
    titleNe: e.titleNe,
    titleEn: e.titleEn,
    dates: e.dates,
    noteNe: e.noteNe,
    noteEn: e.noteEn,
  );

  SuvaSait toEntity() => SuvaSait(
    id: id,
    titleNe: titleNe,
    titleEn: titleEn,
    dates: dates,
    noteNe: noteNe,
    noteEn: noteEn,
  );
}
