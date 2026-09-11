import '../utils/result.dart';

/// Base contract for a use case with parameters.
abstract interface class UseCase<T, P> {
  Future<Result<T>> call(P params);
}

/// Base contract for a use case that needs no parameters.
abstract interface class NoParamsUseCase<T> {
  Future<Result<T>> call();
}

/// Base contract for a use case that exposes a stream.
abstract interface class StreamUseCase<T, P> {
  Stream<T> call(P params);
}

/// Marker for use cases with no arguments (kept for symmetry / readability).
final class NoParams {
  const NoParams();

  @override
  bool operator ==(Object other) => other is NoParams;

  @override
  int get hashCode => 0;
}
