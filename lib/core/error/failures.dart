import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Domain-level failure returned by repositories / use-cases.
///
/// Sealed freezed union so presentation can exhaustively map failures to UI
/// messages with `switch`.
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.server([@Default('Server error') String message]) =
      ServerFailure;
  const factory Failure.network([
    @Default('No internet connection') String message,
  ]) = NetworkFailure;
  const factory Failure.cache([@Default('Cache error') String message]) =
      CacheFailure;
  const factory Failure.validation(String message) = ValidationFailure;
  const factory Failure.notFound([@Default('Not found') String message]) =
      NotFoundFailure;
  const factory Failure.permission([
    @Default('Permission denied') String message,
  ]) = PermissionFailure;
  const factory Failure.unknown([
    @Default('Something went wrong') String message,
  ]) = UnknownFailure;
}
