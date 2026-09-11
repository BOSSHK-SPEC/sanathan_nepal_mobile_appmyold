import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/message_thread.dart';
import '../../domain/usecases/messaging_usecases.dart';

part 'business_contact_cubit.freezed.dart';
part 'business_contact_state.dart';

/// The "Send Message" form on a business profile.
///
/// Separate from [MessageThreadCubit] because it is a different interaction:
/// one enquiry with contact details attached, answered with a result the user
/// can act on, rather than an open conversation.
class BusinessContactCubit extends AppCubit<BusinessContactState> {
  BusinessContactCubit({
    required MessageBusiness messageBusiness,
    required String businessId,
  }) : _messageBusiness = messageBusiness,
       _businessId = businessId,
       super(const BusinessContactState());

  final MessageBusiness _messageBusiness;
  final String _businessId;

  Future<MessageThread?> send({
    required String body,
    String name = '',
    String email = '',
    String subject = '',
  }) async {
    final text = body.trim();
    if (text.isEmpty || state.sending.isLoading) return null;

    emit(state.copyWith(sending: state.sending.toLoading()));
    final result = await _messageBusiness(
      MessageBusinessParams(
        businessId: _businessId,
        body: text,
        subject: subject.trim(),
        contactName: name.trim(),
        contactEmail: email.trim(),
      ),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(sending: state.sending.toFailed(failure)));
        return null;
      },
      (thread) {
        emit(state.copyWith(sending: LoadState.loaded(thread)));
        return thread;
      },
    );
  }

  /// Clears a failure so the banner disappears as soon as the user edits the
  /// form, rather than sitting under a message they have already fixed.
  void dismissError() {
    if (!state.sending.isFailed) return;
    emit(state.copyWith(sending: const LoadState<MessageThread>.idle()));
  }
}
