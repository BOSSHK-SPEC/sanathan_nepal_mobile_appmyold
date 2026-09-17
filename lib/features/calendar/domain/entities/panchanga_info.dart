import 'package:freezed_annotation/freezed_annotation.dart';

import 'lunar_day.dart';

part 'panchanga_info.freezed.dart';

/// Approximate daily Panchanga values used by the date popup and the date
/// converter (a real Panchanga API can replace the approximator later).
@freezed
abstract class PanchangaInfo with _$PanchangaInfo {
  const PanchangaInfo._();

  const factory PanchangaInfo({
    required LunarDay lunarDay,
    required String nakshatraNe,
    required String nakshatraEn,
    required String karanNe,
    required String karanEn,
    required String yogNe,
    required String yogEn,
    required String chandraRashiNe,
    required String chandraRashiEn,

    /// Wall-clock times at the region's default city.
    required DateTime sunrise,
    required DateTime sunset,

    /// True for the on-device estimate; false once the server's calculation
    /// has replaced it.
    @Default(true) bool isApproximate,
  }) = _PanchangaInfo;

  String nakshatra({required bool nepali}) =>
      nepali ? nakshatraNe : nakshatraEn;
  String karan({required bool nepali}) => nepali ? karanNe : karanEn;
  String yog({required bool nepali}) => nepali ? yogNe : yogEn;
  String chandraRashi({required bool nepali}) =>
      nepali ? chandraRashiNe : chandraRashiEn;
}
