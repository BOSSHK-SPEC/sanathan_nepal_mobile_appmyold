import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/legal_document.dart';

part 'legal_document_model.freezed.dart';
part 'legal_document_model.g.dart';

/// JSON shape of [LegalText].
@freezed
abstract class LegalTextModel with _$LegalTextModel {
  const LegalTextModel._();

  const factory LegalTextModel({
    @Default('') String ne,
    @Default('') String en,
    String? hi,
  }) = _LegalTextModel;

  factory LegalTextModel.fromJson(Map<String, dynamic> json) =>
      _$LegalTextModelFromJson(json);

  factory LegalTextModel.fromEntity(LegalText e) =>
      LegalTextModel(ne: e.ne, en: e.en, hi: e.hi);

  LegalText toEntity() => LegalText(ne: ne, en: en, hi: hi);
}

/// JSON shape of [LegalSection].
@freezed
abstract class LegalSectionModel with _$LegalSectionModel {
  const LegalSectionModel._();

  const factory LegalSectionModel({
    required LegalTextModel heading,
    required LegalTextModel body,
    @Default(1) int level,
  }) = _LegalSectionModel;

  factory LegalSectionModel.fromJson(Map<String, dynamic> json) =>
      _$LegalSectionModelFromJson(json);

  factory LegalSectionModel.fromEntity(LegalSection e) => LegalSectionModel(
    heading: LegalTextModel.fromEntity(e.heading),
    body: LegalTextModel.fromEntity(e.body),
    level: e.level,
  );

  LegalSection toEntity() => LegalSection(
    heading: heading.toEntity(),
    body: body.toEntity(),
    level: level,
  );
}

/// JSON-serialisable [LegalDocument].
@freezed
abstract class LegalDocumentModel with _$LegalDocumentModel {
  const LegalDocumentModel._();

  const factory LegalDocumentModel({
    @Default(LegalDocumentType.privacyPolicy) LegalDocumentType type,
    required LegalTextModel title,
    required LegalTextModel intro,
    required DateTime lastUpdated,
    @Default(<LegalSectionModel>[]) List<LegalSectionModel> sections,
  }) = _LegalDocumentModel;

  factory LegalDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$LegalDocumentModelFromJson(json);

  factory LegalDocumentModel.fromEntity(LegalDocument e) => LegalDocumentModel(
    type: e.type,
    title: LegalTextModel.fromEntity(e.title),
    intro: LegalTextModel.fromEntity(e.intro),
    lastUpdated: e.lastUpdated,
    sections: e.sections.map(LegalSectionModel.fromEntity).toList(),
  );

  LegalDocument toEntity() => LegalDocument(
    type: type,
    title: title.toEntity(),
    intro: intro.toEntity(),
    lastUpdated: lastUpdated,
    sections: sections.map((s) => s.toEntity()).toList(),
  );
}
