import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/sitting_option.dart';
import '../../../../core/utils/localized_text_model.dart';

part 'sitting_option_model.freezed.dart';
part 'sitting_option_model.g.dart';

/// JSON-serialisable [SittingOption].
@freezed
abstract class SittingOptionModel with _$SittingOptionModel {
  const SittingOptionModel._();

  const factory SittingOptionModel({
    required String id,
    @Default(SittingChannel.chat) SittingChannel channel,
    required LocalizedTextModel name,
    required int price,
    @Default(0) double ratePerMinute,
    required LocalizedTextModel description,
    @Default(30) int durationMinutes,
  }) = _SittingOptionModel;

  factory SittingOptionModel.fromJson(Map<String, dynamic> json) =>
      _$SittingOptionModelFromJson(json);

  factory SittingOptionModel.fromEntity(SittingOption e) =>
      SittingOptionModel(
        id: e.id,
        channel: e.channel,
        name: LocalizedTextModel.fromEntity(e.name),
        price: e.price,
        ratePerMinute: e.ratePerMinute,
        description: LocalizedTextModel.fromEntity(e.description),
        durationMinutes: e.durationMinutes,
      );

  SittingOption toEntity() => SittingOption(
    id: id,
    channel: channel,
    name: name.toEntity(),
    price: price,
    ratePerMinute: ratePerMinute,
    description: description.toEntity(),
    durationMinutes: durationMinutes,
  );
}
