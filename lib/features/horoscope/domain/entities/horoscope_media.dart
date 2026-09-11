import 'package:freezed_annotation/freezed_annotation.dart';

part 'horoscope_media.freezed.dart';

/// Audio/video "राशिफल" clip attached to a prediction
/// (Figma: "Aries Rashifal - Baishak,2079" player card).
@freezed
abstract class HoroscopeMedia with _$HoroscopeMedia {
  const HoroscopeMedia._();

  const factory HoroscopeMedia({
    required String titleNe,
    required String titleEn,
    required Duration duration,

    /// Hindi title – empty when not provided (falls back to [titleEn]).
    @Default('') String titleHi,

    /// Remote media URL – null while the backend is mocked.
    String? url,
  }) = _HoroscopeMedia;

  String title({required bool nepali}) => nepali ? titleNe : titleEn;

  /// Title for a language code (`ne`, `hi` → English when empty, else `en`).
  String titleFor(String languageCode) => switch (languageCode) {
    'ne' => titleNe,
    'hi' => titleHi.isNotEmpty ? titleHi : titleEn,
    _ => titleEn,
  };
}
