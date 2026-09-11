import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/apply_coupon.dart';
import '../../domain/usecases/clear_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_cart_item.dart';
import '../../../../core/state/app_cubit.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

/// Shopping cart page state.
class CartCubit extends AppCubit<CartState> {
  CartCubit({
    required GetCart getCart,
    required AddToCart addToCart,
    required UpdateCartItem updateCartItem,
    required RemoveFromCart removeFromCart,
    required ApplyCoupon applyCoupon,
    required ClearCart clearCart,
  }) : _getCart = getCart,
       _addToCart = addToCart,
       _updateCartItem = updateCartItem,
       _removeFromCart = removeFromCart,
       _applyCoupon = applyCoupon,
       _clearCart = clearCart,
       super(const CartState());

  final GetCart _getCart;
  final AddToCart _addToCart;
  final UpdateCartItem _updateCartItem;
  final RemoveFromCart _removeFromCart;
  final ApplyCoupon _applyCoupon;
  final ClearCart _clearCart;

  Future<void> load() async {
    emit(state.copyWith(cart: state.cart.toLoading()));
    _apply(await _getCart());
  }

  Future<void> add(Product product, {int quantity = 1}) async => _apply(
    await _addToCart(AddToCartParams(product: product, quantity: quantity)),
  );

  Future<void> increment(String productId) async {
    final item = _find(productId);
    if (item == null) return;
    _apply(
      await _updateCartItem(
        UpdateCartItemParams(productId: productId, quantity: item.quantity + 1),
      ),
    );
  }

  Future<void> decrement(String productId) async {
    final item = _find(productId);
    if (item == null) return;
    _apply(
      await _updateCartItem(
        UpdateCartItemParams(productId: productId, quantity: item.quantity - 1),
      ),
    );
  }

  Future<void> remove(String productId) async =>
      _apply(await _removeFromCart(productId));

  void couponChanged(String value) =>
      emit(state.copyWith(couponInput: value, couponInvalid: false));

  Future<void> applyCoupon() async {
    final code = state.couponInput.trim();
    if (code.isEmpty) return;
    final result = await _applyCoupon(code);
    result.fold(
      (f) => emit(state.copyWith(cart: state.cart.toFailed(f))),
      (cart) => emit(
        state.copyWith(
          cart: LoadState.loaded(cart),
          couponInvalid: cart.couponCode == null,
        ),
      ),
    );
  }

  Future<void> clear() async => _apply(await _clearCart());

  CartItem? _find(String productId) => state.cart.dataOrNull?.items
      .where((i) => i.product.id == productId)
      .firstOrNull;

  void _apply(Result<Cart> result) => emit(
    state.copyWith(cart: result.fold(state.cart.toFailed, LoadState.loaded)),
  );
}
