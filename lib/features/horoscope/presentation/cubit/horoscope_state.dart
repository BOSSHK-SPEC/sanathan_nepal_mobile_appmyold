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

    /// Sign whose media clip is currently loaded in the mocked player.
    ZodiacSign? playingSign,

    /// True when the loaded clip is the sign's "lucky details" video (second
    /// player of the expanded card) rather than the prediction clip.
    @Default(false) bool playingLuckyClip,

    /// Playback head of the mocked player.
    @Default(Duration.zero) Duration position,
    @Default(false) bool isPlaying,

    /// Signs the user has "liked" (♥ under the sign icon) – session only
    /// until a backend exists.
    @Default(<ZodiacSign>{}) Set<ZodiacSign> likedSigns,

    /// Signs whose "थप विवरण / More Details" area is open.
    @Default(<ZodiacSign>{}) Set<ZodiacSign> expandedSigns,
  }) = _HoroscopeState;

  bool isLiked(ZodiacSign sign) => likedSigns.contains(sign);

  /// Whether the clip identified by [sign] + [lucky] is the loaded one.
  bool isClipLoaded(ZodiacSign sign, {bool lucky = false}) =>
      playingSign == sign && playingLuckyClip == lucky;

  /// Playhead of the clip [sign] + [lucky] (zero when not loaded).
  Duration positionOf(ZodiacSign sign, {bool lucky = false}) =>
      isClipLoaded(sign, lucky: lucky) ? position : Duration.zero;

  /// True while the clip [sign] + [lucky] is playing.
  bool isPlayingClip(ZodiacSign sign, {bool lucky = false}) =>
      isPlaying && isClipLoaded(sign, lucky: lucky);
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
