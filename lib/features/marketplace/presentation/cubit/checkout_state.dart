part of 'checkout_cubit.dart';

@freezed
abstract class CheckoutState with _$CheckoutState {
  const CheckoutState._();

  const factory CheckoutState({
    @Default(LoadState.idle()) LoadState<Cart> cart,
    @Default(PaymentMethod.esewa) PaymentMethod paymentMethod,
    @Default(false) bool shipToDifferentAddress,
    @Default(false) bool addressConfirmed,

    /// Placed order (loading while submitting).
    @Default(LoadState.idle()) LoadState<Order> order,
  }) = _CheckoutState;

  bool get isSubmitting => order.isLoading;

  bool get canPlaceOrder =>
      addressConfirmed && !(cart.dataOrNull?.isEmpty ?? true) && !isSubmitting;
}
