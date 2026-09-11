import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/order_tracking.dart';
import '../../domain/usecases/order_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'order_tracking_cubit.freezed.dart';
part 'order_tracking_state.dart';

/// One order's tracking timeline, and the return request raised from it.
class OrderTrackingCubit extends AppCubit<OrderTrackingState> {
  OrderTrackingCubit({
    required String orderId,
    required GetTrackedOrder getOrder,
    required RequestReturn requestReturn,
  }) : _orderId = orderId,
       _getOrder = getOrder,
       _requestReturn = requestReturn,
       super(const OrderTrackingState());

  final String _orderId;
  final GetTrackedOrder _getOrder;
  final RequestReturn _requestReturn;

  Future<void> load() async {
    emit(state.copyWith(order: state.order.toLoading()));
    final result = await _getOrder(_orderId);
    emit(
      state.copyWith(
        order: result.fold(state.order.toFailed, LoadState.loaded),
      ),
    );
  }

  void selectReason(ReturnReason reason) =>
      emit(state.copyWith(reason: reason, returning: const LoadState.idle()));

  void setDetails(String details) => emit(state.copyWith(details: details));

  void toggleItem(String productId) {
    final next = {...state.selectedItems};
    if (!next.remove(productId)) next.add(productId);
    emit(state.copyWith(selectedItems: next));
  }

  Future<bool> submitReturn() async {
    if (!state.canSubmitReturn) return false;
    emit(state.copyWith(returning: state.returning.toLoading()));
    final result = await _requestReturn(
      ReturnDraft(
        orderId: _orderId,
        reason: state.reason!,
        productIds: state.selectedItems.toList(),
        details: state.details.trim(),
      ),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(returning: state.returning.toFailed(failure)));
        return false;
      },
      (order) {
        emit(
          state.copyWith(
            returning: LoadState.loaded(order),
            order: LoadState.loaded(order),
          ),
        );
        return true;
      },
    );
  }
}
