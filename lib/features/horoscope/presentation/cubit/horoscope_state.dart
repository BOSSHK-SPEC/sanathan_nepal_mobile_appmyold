part of 'horoscope_cubit.dart';

/// UI state of the horoscope feature (listing page + home section).
@freezed
abstract class HoroscopeState with _$HoroscopeState {
  const HoroscopeState._();

  const factory HoroscopeState({
    /// Predictions of all twelve signs for [period] (zodiac order).
    @Default(LoadState.idle()) LoadState<List<HoroscopePrediction>> predictions,
    @Default(HoroscopePeriod.daily) HoroscopePeriod period,
    @Default(ZodiacSign.aries) ZodiacSign selectedSign,

    /// Signs the user has "liked" (♥ under the sign icon) – session only
    /// until a backend exists.
    @Default(<ZodiacSign>{}) Set<ZodiacSign> likedSigns,

    /// Signs whose "थप विवरण / More Details" area is open.
    @Default(<ZodiacSign>{}) Set<ZodiacSign> expandedSigns,
  }) = _HoroscopeState;

  bool isLiked(ZodiacSign sign) => likedSigns.contains(sign);

  /// The clip of [sign], or null when the reading has none published.
  ///
  /// A reading without a clip renders no player at all — there is nothing to
  /// open, and a card over a dead button is worse than no card.
  String? clipUrlOf(ZodiacSign sign, {bool lucky = false}) {
    final p = predictionFor(sign);
    if (p == null) return null;
    final url = lucky ? p.profile?.luckyMedia.url : p.media.url;
    return (url == null || url.isEmpty) ? null : url;
  }
  bool isExpanded(ZodiacSign sign) => expandedSigns.contains(sign);

  bool get isLoading => predictions.isLoading;

  /// Prediction of [selectedSign] (null while loading / on error).
  HoroscopePrediction? get selected => predictionFor(selectedSign);

  HoroscopePrediction? predictionFor(ZodiacSign sign) {
    for (final p in predictions.dataOrNull ?? const <HoroscopePrediction>[]) {
      if (p.sign == sign) return p;
    }
    return null;
  }
}
