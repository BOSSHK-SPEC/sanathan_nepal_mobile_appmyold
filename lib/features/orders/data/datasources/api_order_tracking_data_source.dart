import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../domain/entities/order_tracking.dart';
import 'order_tracking_data_source.dart';

/// Order tracking, served by the backend.
///
/// The timeline is built from the server's append-only `order_events`, so a
/// status can always be explained by who set it and when — the client never
/// synthesises a stage it did not receive.
class ApiOrderTrackingDataSource implements OrderTrackingDataSource {
  const ApiOrderTrackingDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<TrackedOrder>> myOrders() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.orders);
    return asJsonList(response).map(_toOrder).toList(growable: false);
  });

  @override
  Future<TrackedOrder> order(String orderId) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.order(orderId));
    return _toOrder(asJsonMap(response));
  });

  @override
  Future<List<TrackedOrder>> sellerOrders() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.sellingOrders);
    return asJsonList(response).map(_toOrder).toList(growable: false);
  });

  @override
  Future<TrackedOrder> requestReturn(ReturnDraft draft) => guardApi(() async {
    await _client.post<dynamic>(
      ApiEndpoints.orderReturn(draft.orderId),
      data: {
        'reason': draft.details.isEmpty
            ? draft.reason.name
            : '${draft.reason.name}: ${draft.details}',
        'imageKeys': draft.photoRefs,
      },
    );
    // The return endpoint answers with the request, not the order; re-reading
    // gives the caller the order with its new stage and event already applied.
    return order(draft.orderId);
  });

  @override
  Future<TrackedOrder> advance({
    required String orderId,
    required OrderStage stage,
    String? courierName,
    String? trackingNumber,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.orderAdvance(orderId),
      data: {
        'status': _statusFor(stage),
        'courierName': ?courierName,
        'trackingNumber': ?trackingNumber,
      },
    );
    return _toOrder(asJsonMap(response));
  });

  /// The app's stages and the server's statuses are close but not identical —
  /// `packed` is the app's word for the server's `processing`.
  static String _statusFor(OrderStage stage) => switch (stage) {
    OrderStage.placed ||
    OrderStage.confirmed ||
    OrderStage.packed => 'processing',
    OrderStage.shipped => 'shipped',
    OrderStage.outForDelivery => 'outForDelivery',
    OrderStage.delivered => 'delivered',
    OrderStage.cancelled => 'cancelled',
    // The app distinguishes the two return steps; the server tracks the
    // request and the completed return, and pickup is not a status it holds.
    OrderStage.returnRequested || OrderStage.returnPickedUp => 'returned',
    OrderStage.refunded => 'refunded',
  };

  static OrderStage _stageFor(String? status) => switch (status) {
    'confirmed' => OrderStage.confirmed,
    'processing' => OrderStage.packed,
    'shipped' => OrderStage.shipped,
    'outForDelivery' => OrderStage.outForDelivery,
    'delivered' => OrderStage.delivered,
    'cancelled' => OrderStage.cancelled,
    'returnRequested' => OrderStage.returnRequested,
    'returned' => OrderStage.returnPickedUp,
    'refunded' => OrderStage.refunded,
    _ => OrderStage.placed,
  };

  TrackedOrder _toOrder(Map<String, dynamic> json) {
    final shipping = json['shipping'];
    final items = json['items'];
    final events = json['events'];

    // Courier details live on the most recent event that carried them, which
    // is where the seller entered them.
    String? courier;
    String? tracking;
    if (events is List) {
      for (final event in events.whereType<Map>()) {
        courier = (event['courierName'] as String?) ?? courier;
        tracking = (event['trackingNumber'] as String?) ?? tracking;
      }
    }

    return TrackedOrder(
      id: json['id'] as String? ?? '',
      reference: json['reference'] as String? ?? '',
      stage: _stageFor(json['status'] as String?),
      items: items is List
          ? items
                .whereType<Map>()
                .map(
                  (item) => OrderItem(
                    productId: item['productId'] as String? ?? '',
                    name: _localized(item['title'])['en'] ?? '',
                    quantity: (item['quantity'] as num?)?.toInt() ?? 1,
                    unitPrice: ApiMoney.toMajor(item['unitPriceMinor']),
                    imageAsset: item['imageKey'] as String?,
                  ),
                )
                .toList(growable: false)
          : const [],
      placedAt: ApiTime.instantOr(json['placedAt'], DateTime.now()),
      deliveryAddress: _address(shipping),
      events: events is List
          ? events
                .whereType<Map>()
                .map(
                  (event) => OrderEvent(
                    stage: _stageFor(event['status'] as String?),
                    at: ApiTime.instantOr(event['createdAt'], DateTime.now()),
                    note: event['note'] as String? ?? '',
                  ),
                )
                .toList(growable: false)
          : const [],
      shipping: ApiMoney.toMajor(json['shippingMinor']),
      discount: ApiMoney.toMajor(json['discountMinor']),
      counterpartyName: _name(shipping),
      courierName: courier,
      trackingNumber: tracking,
    );
  }

  static String _address(Object? shipping) {
    if (shipping is! Map) return '';
    return [
      shipping['street'],
      shipping['apartment'],
      shipping['city'],
      shipping['province'],
      shipping['country'],
    ].whereType<String>().where((part) => part.isNotEmpty).join(', ');
  }

  static String _name(Object? shipping) {
    if (shipping is! Map) return '';
    return [
      shipping['firstName'],
      shipping['lastName'],
    ].whereType<String>().where((part) => part.isNotEmpty).join(' ');
  }

  static Map<String, String> _localized(Object? raw) {
    if (raw is String) return {'en': raw};
    if (raw is! Map) return const {};
    return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
  }
}
