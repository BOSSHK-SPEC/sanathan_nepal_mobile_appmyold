import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/failures.dart';

part 'load_state.freezed.dart';

/// Async slice of a cubit state: `idle → loading → loaded | failed`.
///
/// Use one [LoadState] per independent piece of data in a freezed cubit
/// state instead of a shared `status` enum + nullable fields:
///
/// ```dart
/// @freezed
/// abstract class WeatherState with _$WeatherState {
///   const factory WeatherState({
///     @Default(LoadState.idle()) LoadState<WeatherBundle> weather,
///     @Default(0) int selectedHour,
///   }) = _WeatherState;
/// }
/// ```
///
/// Read with Dart pattern matching:
/// ```dart
/// switch (state.weather) {
///   case Loading(): ...
///   case Loaded(:final data): ...
///   case Failed(:final failure): ...
///   case Idle(): ...
/// }
/// ```
@freezed
sealed class LoadState<T> with _$LoadState<T> {
  const LoadState._();

  /// Nothing requested yet.
  const factory LoadState.idle() = Idle<T>;

  /// In flight; [previous] keeps stale data visible while refreshing.
  const factory LoadState.loading({T? previous}) = Loading<T>;

  /// Success.
  const factory LoadState.loaded(T data) = Loaded<T>;

  /// Failure; [previous] keeps stale data visible.
  const factory LoadState.failed(Failure failure, {T? previous}) = Failed<T>;

  bool get isIdle => this is Idle<T>;
  bool get isLoading => this is Loading<T>;
  bool get isLoaded => this is Loaded<T>;
  bool get isFailed => this is Failed<T>;

  /// Data if loaded, otherwise the stale value carried by loading/failed.
  T? get dataOrNull => switch (this) {
    Loaded<T>(:final data) => data,
    Loading<T>(:final previous) => previous,
    Failed<T>(:final previous) => previous,
    Idle<T>() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Failed<T>(:final failure) => failure,
    _ => null,
  };

  String? get errorMessage => failureOrNull?.message;

  /// Transition to loading while keeping current data as [previous].
  LoadState<T> toLoading() => LoadState.loading(previous: dataOrNull);

  /// Transition to failed while keeping current data as [previous].
  LoadState<T> toFailed(Failure failure) =>
      LoadState.failed(failure, previous: dataOrNull);

  LoadState<R> map<R>(R Function(T data) transform) => switch (this) {
    Loaded<T>(:final data) => LoadState.loaded(transform(data)),
    Loading<T>(:final previous) => LoadState.loading(
      previous: previous == null ? null : transform(previous),
    ),
    Failed<T>(:final failure, :final previous) => LoadState.failed(
      failure,
      previous: previous == null ? null : transform(previous),
    ),
    Idle<T>() => LoadState<R>.idle(),
  };
}
