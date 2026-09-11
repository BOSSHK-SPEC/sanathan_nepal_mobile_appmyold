import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region_all.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/clear_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/place_order.dart';
import '../../../../core/state/app_cubit.dart';

part 'checkout_cubit.freezed.dart';
part 'checkout_state.dart';

/// Checkout page: address form, payment method, order summary, place order.
///
/// The offered payment methods come from `RegionConfig.paymentRails`
/// (read from [RegionResolver] on every [load]); the first rail is the
/// default selection.
class CheckoutCubit extends AppCubit<CheckoutState> {
  CheckoutCubit({
    required GetCart getCart,
    required PlaceOrder placeOrder,
    required ClearCart clearCart,
    required RegionResolver resolver,
  }) : _getCart = getCart,
       _placeOrder = placeOrder,
       _clearCart = clearCart,
       _resolver = resolver,
       super(
         CheckoutState(
           paymentMethod: PaymentMethod.forRegion(resolver.config).first,
         ),
       );

  final GetCart _getCart;
  final PlaceOrder _placeOrder;
  final ClearCart _clearCart;
  final RegionResolver _resolver;

  Future<void> load() async {
    final methods = PaymentMethod.forRegion(_resolver.config);
    emit(
      state.copyWith(
        cart: state.cart.toLoading(),
        paymentMethod: methods.contains(state.paymentMethod)
            ? state.paymentMethod
            : methods.first,
      ),
    );
    final result = await _getCart();
    emit(
      state.copyWith(cart: result.fold(state.cart.toFailed, LoadState.loaded)),
    );
  }

  void setPaymentMethod(PaymentMethod method) =>
      emit(state.copyWith(paymentMethod: method));

  void toggleShipToDifferent(bool value) =>
      emit(state.copyWith(shipToDifferentAddress: value));

  void toggleAddressConfirmed(bool value) =>
      emit(state.copyWith(addressConfirmed: value));

  Future<void> placeOrder({
    required ShippingAddress address,
    String notes = '',
  }) async {
    final cart = state.cart.dataOrNull;
    if (cart == null || !state.canPlaceOrder) return;
    emit(state.copyWith(order: state.order.toLoading()));
    final result = await _placeOrder(
      OrderRequest(
        cart: cart,
        address: address,
        paymentMethod: state.paymentMethod,
        notes: notes,
        shipToDifferentAddress: state.shipToDifferentAddress,
      ),
    );
    await result.fold(
      (f) async => emit(state.copyWith(order: state.order.toFailed(f))),
      (order) async {
        await _clearCart();
        emit(
          state.copyWith(
            order: LoadState.loaded(order),
            cart: const LoadState.loaded(Cart.empty),
          ),
        );
      },
    );
  }
}
