part of 'cart_cubit.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default(LoadState.idle()) LoadState<Cart> cart,
    @Default('') String couponInput,
    @Default(false) bool couponInvalid,
  }) = _CartState;
}
