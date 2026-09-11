import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/horoscope_prediction.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../../domain/usecases/get_all_predictions.dart';
import '../../../../core/state/app_cubit.dart';

part 'horoscope_cubit.freezed.dart';
part 'horoscope_state.dart';

/// Drives the horoscope listing page and the compact home section.
///
/// Media playback is mocked: [togglePlayback] starts a one-second ticker
/// that advances [HoroscopeState.position] until the clip ends.
class HoroscopeCubit extends AppCubit<HoroscopeState> {
  HoroscopeCubit({
    required GetAllPredictions getAllPredictions,
    this.tick = const Duration(seconds: 1),
  }) : _getAll = getAllPredictions,
       super(const HoroscopeState());

  final GetAllPredictions _getAll;

  /// Interval of the mocked playback ticker (overridable in tests).
  final Duration tick;
  Timer? _ticker;

  /// Loads predictions for the current period.
  Future<void> load() => _load(state.period);

  /// Switches दैनिक / साप्ताहिक / मासिक / वार्षिक and reloads.
  Future<void> selectPeriod(HoroscopePeriod period) {
    if (period == state.period && state.predictions.isLoaded) {
      return Future.value();
    }
    _stopTicker();
    emit(state.copyWith(period: period, playingSign: null, isPlaying: false));
    return _load(period);
  }

  /// Highlights a sign (home section / dropdown).
  void selectSign(ZodiacSign sign) => emit(state.copyWith(selectedSign: sign));

  /// Toggles the ♥ of [sign].
  void toggleLike(ZodiacSign sign) {
    final liked = {...state.likedSigns};
    if (!liked.remove(sign)) liked.add(sign);
    emit(state.copyWith(likedSigns: liked));
  }

  /// Opens / closes the "More Details" area of [sign].
  void toggleDetails(ZodiacSign sign) {
    final open = {...state.expandedSigns};
    if (!open.remove(sign)) open.add(sign);
    emit(state.copyWith(expandedSigns: open));
  }

  /// Play / pause the (mocked) clip of [sign] – the prediction clip, or the
  /// "lucky details" video when [lucky]. Selecting a different clip restarts
  /// playback from the beginning.
  void togglePlayback(ZodiacSign sign, {bool lucky = false}) {
    final sameClip = state.isClipLoaded(sign, lucky: lucky);
    if (sameClip && state.isPlaying) {
      _stopTicker();
      emit(state.copyWith(isPlaying: false));
      return;
    }
    final position = sameClip ? state.position : Duration.zero;
    emit(
      state.copyWith(
        playingSign: sign,
        playingLuckyClip: lucky,
        position: position,
        isPlaying: true,
      ),
    );
    _startTicker();
  }

  /// Moves the playhead of the current clip to [fraction] (0‥1).
  void seek(double fraction) {
    final clip = state.playingSign;
    if (clip == null) return;
    final total = _clipDuration(clip, lucky: state.playingLuckyClip);
    final clamped = fraction.clamp(0.0, 1.0);
    emit(
      state.copyWith(
        position: Duration(seconds: (total.inSeconds * clamped).round()),
      ),
    );
  }

  Duration _clipDuration(ZodiacSign sign, {required bool lucky}) {
    final p = state.predictionFor(sign);
    if (p == null) return Duration.zero;
    return lucky
        ? (p.profile?.luckyMedia.duration ?? Duration.zero)
        : p.media.duration;
  }

  Future<void> _load(HoroscopePeriod period) async {
    emit(state.copyWith(predictions: state.predictions.toLoading()));
    final result = await _getAll(period);
    if (isClosed) return;
    emit(
      state.copyWith(
        predictions: result.fold(state.predictions.toFailed, LoadState.loaded),
      ),
    );
  }

  void _startTicker() {
    _stopTicker();
    _ticker = Timer.periodic(tick, (_) {
      final clip = state.playingSign;
      if (clip == null || !state.isPlaying) return _stopTicker();
      final total = _clipDuration(clip, lucky: state.playingLuckyClip);
      final next = state.position + tick;
      if (next >= total) {
        _stopTicker();
        emit(state.copyWith(position: total, isPlaying: false));
      } else {
        emit(state.copyWith(position: next));
      }
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  @override
  Future<void> close() {
    _stopTicker();
    return super.close();
  }
}
