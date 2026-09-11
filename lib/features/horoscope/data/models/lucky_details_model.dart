import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/lucky_details.dart';

part 'lucky_details_model.freezed.dart';
part 'lucky_details_model.g.dart';

/// Wire shape of [LuckyDetails].
@freezed
abstract class LuckyDetailsModel with _$LuckyDetailsModel {
  const LuckyDetailsModel._();

  const factory LuckyDetailsModel({
    @Default([]) List<int> numbers,
    @Default('') String colorNe,
    @Default('') String colorEn,
    @Default('') String colorHi,
    @Default(0) int colorValue,
    @Default([]) List<String> daysNe,
    @Default([]) List<String> daysEn,
    @Default([]) List<String> daysHi,
    @Default('') String rulingPlanetNe,
    @Default('') String rulingPlanetEn,
    @Default('') String rulingPlanetHi,
    @Default('') String symbolNe,
    @Default('') String symbolEn,
    @Default('') String symbolHi,
    @Default('') String elementNe,
    @Default('') String elementEn,
    @Default('') String elementHi,
    @Default('') String luckyStoneNe,
    @Default('') String luckyStoneEn,
    @Default('') String luckyStoneHi,
    @Default('') String unluckyStoneNe,
    @Default('') String unluckyStoneEn,
    @Default('') String unluckyStoneHi,
    @Default('') String luckyAlphabet,
    @Default([]) List<int> eventfulYears,
  }) = _LuckyDetailsModel;

  factory LuckyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$LuckyDetailsModelFromJson(json);

  factory LuckyDetailsModel.fromEntity(LuckyDetails e) => LuckyDetailsModel(
    numbers: e.numbers,
    colorNe: e.colorNe,
    colorEn: e.colorEn,
    colorHi: e.colorHi,
    colorValue: e.colorValue,
    daysNe: e.daysNe,
    daysEn: e.daysEn,
    daysHi: e.daysHi,
    rulingPlanetNe: e.rulingPlanetNe,
    rulingPlanetEn: e.rulingPlanetEn,
    rulingPlanetHi: e.rulingPlanetHi,
    symbolNe: e.symbolNe,
    symbolEn: e.symbolEn,
    symbolHi: e.symbolHi,
    elementNe: e.elementNe,
    elementEn: e.elementEn,
    elementHi: e.elementHi,
    luckyStoneNe: e.luckyStoneNe,
    luckyStoneEn: e.luckyStoneEn,
    luckyStoneHi: e.luckyStoneHi,
    unluckyStoneNe: e.unluckyStoneNe,
    unluckyStoneEn: e.unluckyStoneEn,
    unluckyStoneHi: e.unluckyStoneHi,
    luckyAlphabet: e.luckyAlphabet,
    eventfulYears: e.eventfulYears,
  );

  LuckyDetails toEntity() => LuckyDetails(
    numbers: numbers,
    colorNe: colorNe,
    colorEn: colorEn,
    colorHi: colorHi,
    colorValue: colorValue,
    daysNe: daysNe,
    daysEn: daysEn,
    daysHi: daysHi,
    rulingPlanetNe: rulingPlanetNe,
    rulingPlanetEn: rulingPlanetEn,
    rulingPlanetHi: rulingPlanetHi,
    symbolNe: symbolNe,
    symbolEn: symbolEn,
    symbolHi: symbolHi,
    elementNe: elementNe,
    elementEn: elementEn,
    elementHi: elementHi,
    luckyStoneNe: luckyStoneNe,
    luckyStoneEn: luckyStoneEn,
    luckyStoneHi: luckyStoneHi,
    unluckyStoneNe: unluckyStoneNe,
    unluckyStoneEn: unluckyStoneEn,
    unluckyStoneHi: unluckyStoneHi,
    luckyAlphabet: luckyAlphabet,
    eventfulYears: eventfulYears,
  );
}
