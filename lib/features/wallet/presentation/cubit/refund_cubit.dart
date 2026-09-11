import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/refund_request.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'refund_cubit.freezed.dart';
part 'refund_state.dart';

/// Refund request form for one transaction.
class RefundCubit extends AppCubit<RefundState> {
  RefundCubit({
    required String transactionId,
    required RequestRefund requestRefund,
  }) : _requestRefund = requestRefund,
       super(RefundState(transactionId: transactionId));

  final RequestRefund _requestRefund;

  void selectReason(RefundReason reason) =>
      emit(state.copyWith(reason: reason, submission: const LoadState.idle()));

  void setDetails(String details) => emit(state.copyWith(details: details));

  Future<RefundRequest?> submit() async {
    if (!state.canSubmit) return null;
    emit(state.copyWith(submission: state.submission.toLoading()));
    final result = await _requestRefund(
      RefundDraft(
        transactionId: state.transactionId,
        reason: state.reason!,
        details: state.details.trim(),
      ),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(submission: state.submission.toFailed(failure)));
        return null;
      },
      (request) {
        emit(state.copyWith(submission: LoadState.loaded(request)));
        return request;
      },
    );
  }
}
