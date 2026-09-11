import '../../domain/entities/order.dart';

/// Order API contract.
abstract interface class OrderDataSource {
  Future<Order> placeOrder(OrderRequest request);
}

/// Mock that "confirms" every order with a deterministic id.
class MockOrderDataSource implements OrderDataSource {
  MockOrderDataSource({DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final DateTime Function() _clock;
  int _sequence = 12345678;

  @override
  Future<Order> placeOrder(OrderRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final cart = request.cart;
    final id = 'U${_sequence++}';
    return Order(
      id: id,
      items: cart.items,
      subtotal: cart.subtotal,
      discount: cart.discount,
      shippingCost: cart.shippingCost,
      total: cart.total,
      paymentMethod: request.paymentMethod,
      address: request.address,
      placedAt: _clock(),
      status: request.paymentMethod == PaymentMethod.cashOnDelivery
          ? 'pending'
          : 'paid',
    );
  }
}
