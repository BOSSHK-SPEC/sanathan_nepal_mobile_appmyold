import 'package:freezed_annotation/freezed_annotation.dart';

part 'dosha.freezed.dart';

/// The afflictions people most often ask about.
enum DoshaKind { manglik, kaalSarp, sadeSati, pitra, nadiDosha }

/// How strongly an affliction applies. A boolean would be wrong: Manglik in
/// particular is routinely partial and routinely cancelled.
enum DoshaSeverity { none, mild, moderate, high }

@freezed
abstract class DoshaReading with _$DoshaReading {
  const DoshaReading._();

  const factory DoshaReading({
    required DoshaKind kind,
    required DoshaSeverity severity,

    /// Which houses or placements triggered it, for the explanation.
    @Default(<String>[]) List<String> factors,

    /// Classical cancellations that reduce or nullify the affliction.
    @Default(<String>[]) List<String> cancellations,
  }) = _DoshaReading;

  bool get isPresent => severity != DoshaSeverity.none;

  bool get isCancelled => isPresent && cancellations.isNotEmpty;
}
