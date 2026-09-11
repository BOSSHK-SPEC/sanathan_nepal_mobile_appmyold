import 'package:freezed_annotation/freezed_annotation.dart';

part 'panchanga_element.freezed.dart';

/// One of the five limbs of the panchanga (तिथि / नक्षत्र / करण / योग) with
/// the detail values shown under "थप जानकारी".
@freezed
abstract class PanchangaElement with _$PanchangaElement {
  const PanchangaElement._();

  const factory PanchangaElement({
    required String nameNe,
    required String nameEn,

    /// Local time at which this element ends and [nextNe] begins.
    required DateTime endsAt,
    required String nextNe,
    required String nextEn,

    /// End time as `घडी:पला:विपला:प्रतिविपला`, ASCII digits, e.g. `56:26:42:23`.
    required String ghatiPala,

    /// Elapsed part at sunrise (घडी).
    required double bhukta,

    /// Remaining part at sunrise (घडी).
    required double bhogya,

    /// Apparent value at sunrise (घडी).
    required double spashta,
  }) = _PanchangaElement;

  String name({required bool nepali}) => nepali ? nameNe : nameEn;
  String next({required bool nepali}) => nepali ? nextNe : nextEn;
}
