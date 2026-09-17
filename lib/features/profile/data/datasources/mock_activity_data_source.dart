import '../../../../core/error/exceptions.dart';
import '../../domain/entities/appointment_summary.dart';
import '../../domain/entities/order_summary.dart';

/// Source of appointments and orders for the ACTIVITIES tab.
abstract interface class ActivityDataSource {
  Future<List<AppointmentSummary>> getAppointments();
  Future<List<OrderSummary>> getOrders();
  Future<OrderSummary> applyOrderAction(OrderSummary order, OrderAction action);
  Future<OrderSummary> rateOrder(String id, int rating);
}

/// Deterministic in-memory activity data mirroring the Figma cards.
class MockActivityDataSource implements ActivityDataSource {
  MockActivityDataSource() {
    final now = DateTime.now();
    _orders = [
      OrderSummary(
        id: 'ord-1',
        productName: 'Iphone 14 Pro Max 245GB..',
        price: 10000,
        counterpartyName: 'Uttam Upadhayay',
        counterpartyId: 'biz-1',
        role: OrderRole.buyer,
        status: OrderStatus.placed,
        updatedAt: now.subtract(const Duration(days: 5)),
      ),
      OrderSummary(
        id: 'ord-2',
        productName: 'Iphone 14 Pro Max 245GB..',
        price: 10000,
        counterpartyName: 'Uttam Upadhayay',
        counterpartyId: 'biz-1',
        role: OrderRole.buyer,
        status: OrderStatus.processing,
        updatedAt: now.subtract(const Duration(days: 4)),
      ),
      OrderSummary(
        id: 'ord-3',
        productName: 'Iphone 14 Pro Max 245GB..',
        price: 10000,
        counterpartyName: 'Uttam Upadhayay',
        counterpartyId: 'biz-1',
        role: OrderRole.buyer,
        status: OrderStatus.completed,
        updatedAt: now.subtract(const Duration(days: 3)),
        rating: 4,
      ),
      OrderSummary(
        id: 'ord-4',
        productName: 'Iphone 14 Pro Max 245GB, 5G',
        price: 8000,
        sellingPrice: 10000,
        counterpartyName: 'Ram Bahadur',
        counterpartyId: 'u-2002',
        role: OrderRole.seller,
        // Paid and waiting on the seller — the state where Accept appears.
        status: OrderStatus.confirmed,
        updatedAt: now.subtract(const Duration(hours: 11)),
      ),
      OrderSummary(
        id: 'ord-5',
        productName: 'Iphone 14 Pro Max 245GB, 5G',
        price: 8000,
        sellingPrice: 10000,
        counterpartyName: 'Ram Bahadur',
        counterpartyId: 'u-2002',
        role: OrderRole.seller,
        status: OrderStatus.processing,
        updatedAt: now.subtract(const Duration(hours: 1)),
      ),
      OrderSummary(
        id: 'ord-6',
        productName: 'Iphone 14 Pro Max 245GB, 5G',
        price: 8000,
        sellingPrice: 10000,
        counterpartyName: 'Ram Bahadur',
        counterpartyId: 'u-2002',
        role: OrderRole.seller,
        // A finished sale. `sold` was a state the API never produced, so a
        // card could show it but no action could ever reach it.
        status: OrderStatus.completed,
        updatedAt: now.subtract(const Duration(minutes: 15)),
      ),
    ];
  }

  late List<OrderSummary> _orders;

  static final List<AppointmentSummary> _appointments = [
    AppointmentSummary(
      id: 'apt-1',
      titleEn: 'CHEENA READING APPOINTMENT',
      titleNe: 'चिना टिप्पन हेर्ने',
      doctorName: 'Dr. Uttam Upadhyaya',
      serviceEn: 'Cheena Reading',
      serviceNe: 'चिना टिप्पन',
      dateTime: DateTime(2023, 3, 30, 20, 30),
    ),
  ];

  @override
  Future<List<AppointmentSummary>> getAppointments() async =>
      List.unmodifiable(_appointments);

  @override
  Future<List<OrderSummary>> getOrders() async => List.unmodifiable(_orders);

  /// Applies the same transition rules the server enforces.
  ///
  /// A mock that accepts any move would let the demo do things the live API
  /// refuses, which is how a screen ships working against mocks and failing
  /// against the backend.
  @override
  Future<OrderSummary> applyOrderAction(
    OrderSummary order,
    OrderAction action,
  ) async {
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index < 0) throw const NotFoundException('Order not found');

    final current = _orders[index];
    if (!current.availableActions.contains(action)) {
      throw const ValidationException('That is no longer possible');
    }

    final updated = current.copyWith(
      status: switch (action) {
        OrderAction.accept => OrderStatus.processing,
        OrderAction.ship => OrderStatus.shipped,
        OrderAction.deliver => OrderStatus.completed,
        OrderAction.cancel => OrderStatus.cancelled,
      },
      updatedAt: DateTime.now(),
    );
    _orders = [..._orders]..[index] = updated;
    return updated;
  }

  @override
  Future<OrderSummary> rateOrder(String id, int rating) async {
    final index = _orders.indexWhere((o) => o.id == id);
    if (index < 0) throw const NotFoundException('Order not found');
    final updated = _orders[index].copyWith(rating: rating.clamp(1, 5));
    _orders = [..._orders]..[index] = updated;
    return updated;
  }
}
