import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_text.dart';

part 'localized_text_model.freezed.dart';
part 'localized_text_model.g.dart';

/// JSON shape of [LocalizedText] (`{"ne": …, "en": …, "hi": …}`; `hi` is
/// omitted when no dedicated Hindi translation exists).
@freezed
abstract class LocalizedTextModel with _$LocalizedTextModel {
  const LocalizedTextModel._();

  const factory LocalizedTextModel({
    @Default('') String ne,
    @Default('') String en,
    String? hi,
  }) = _LocalizedTextModel;

  factory LocalizedTextModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizedTextModelFromJson(json);

  factory LocalizedTextModel.fromEntity(LocalizedText e) =>
      LocalizedTextModel(ne: e.ne, en: e.en, hi: e.hi);

  LocalizedText toEntity() => LocalizedText(ne: ne, en: en, hi: hi);
}
