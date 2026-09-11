part of 'system_cubit.dart';

@freezed
abstract class SystemState with _$SystemState {
  const SystemState._();

  const factory SystemState({
    @Default(AppStatus()) AppStatus status,
    @Default(true) bool online,

    /// Optional update prompts are dismissible for the session; required
    /// ones are not, which is why this only affects the former.
    @Default(false) bool updateDismissed,
  }) = _SystemState;

  bool get isBlocked => status.isBlocking;

  bool get shouldPromptUpdate =>
      status.availability == AppAvailability.updateAvailable &&
      !updateDismissed;
}
