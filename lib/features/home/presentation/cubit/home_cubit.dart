import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/metal_rates.dart';
import '../../domain/usecases/get_metal_rates.dart';
import '../../../../core/state/app_cubit.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

/// Header-level state for the Home page (clock + gold/silver rates).
/// Section widgets own their own cubits.
class HomeCubit extends AppCubit<HomeState> {
  HomeCubit({
    required GetMetalRates getMetalRates,
    DateTime Function()? clock,
    Duration tick = const Duration(seconds: 30),
  }) : _getMetalRates = getMetalRates,
       _clock = clock ?? DateTime.now,
       _tick = tick,
       super(HomeState(now: (clock ?? DateTime.now)()));

  final GetMetalRates _getMetalRates;
  final DateTime Function() _clock;
  final Duration _tick;
  Timer? _timer;

  Future<void> load() async {
    _timer ??= Timer.periodic(
      _tick,
      (_) => emit(state.copyWith(now: _clock())),
    );
    emit(state.copyWith(metalRates: state.metalRates.toLoading()));
    final result = await _getMetalRates();
    emit(
      state.copyWith(
        metalRates: result.fold(state.metalRates.toFailed, LoadState.loaded),
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
