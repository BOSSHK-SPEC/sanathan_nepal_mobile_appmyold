part of 'business_contact_cubit.dart';

@freezed
abstract class BusinessContactState with _$BusinessContactState {
  const BusinessContactState._();

  const factory BusinessContactState({
    @Default(LoadState<MessageThread>.idle()) LoadState<MessageThread> sending,
  }) = _BusinessContactState;

  bool get isSending => sending.isLoading;

  MessageThread? get sentThread => sending.dataOrNull;

  String? get errorMessage => sending.errorMessage;
}
