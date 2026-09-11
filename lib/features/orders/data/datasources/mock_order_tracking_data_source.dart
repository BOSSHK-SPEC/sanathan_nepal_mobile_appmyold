import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/order_tracking.dart';
import 'order_tracking_data_source.dart';

/// In-memory order tracking.
///
/// Enforces the rules the screens must not re-implement: fulfilment can only
/// move forward one stage at a time, shipping requires courier details, and
/// a return can only be raised on a delivered order still inside the window.
class MockOrderTrackingDataSource implements OrderTrackingDataSource {
  MockOrderTrackingDataSource(this._store, this._regions);

  final KeyValueStore _store;
  final RegionResolver _regions;

  static const _ordersKey = 'orders.tracked';
  static const _seededKey = 'orders.seeded';
  static const Duration _latency = Duration(milliseconds: 180);

  double get _scale => _regions.region == Region.nepal ? 1.0 : 0.6;

  @override
  Future<List<TrackedOrder>> myOrders() async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    return _read().where((o) => !o.id.startsWith('so-')).toList()
      ..sort((a, b) => b.placedAt.compareTo(a.placedAt));
  }

  @override
  Future<List<TrackedOrder>> sellerOrders() async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    return _read().where((o) => o.id.startsWith('so-')).toList()
      ..sort((a, b) => b.placedAt.compareTo(a.placedAt));
  }

  @override
  Future<TrackedOrder> order(String orderId) async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    return _require(orderId);
  }

  @override
  Future<TrackedOrder> requestReturn(ReturnDraft draft) async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    final order = _require(draft.orderId);

    if (order.hasReturn) {
      throw const ValidationException(
        'A return has already been raised for this order',
      );
    }
    if (!order.canRequestReturn()) {
      throw const ValidationException(
        'Returns are only available for seven days after delivery',
      );
    }
    if (draft.reason == ReturnReason.other && draft.details.trim().isEmpty) {
      throw const ValidationException('Tell us what went wrong');
    }

    final updated = order.copyWith(
      stage: OrderStage.returnRequested,
      returnReason: draft.reason.name,
      events: [
        ...order.events,
        OrderEvent(
          stage: OrderStage.returnRequested,
          at: DateTime.now(),
          note: draft.details,
        ),
      ],
    );
    await _write([updated, ..._read().where((o) => o.id != order.id)]);
    return updated;
  }

  @override
  Future<TrackedOrder> advance({
    required String orderId,
    required OrderStage stage,
    String? courierName,
    String? trackingNumber,
  }) async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    final order = _require(orderId);

    final currentIndex = order.fulfilmentIndex;
    final targetIndex = OrderStage.fulfilment.indexOf(stage);
    if (targetIndex < 0) {
      throw const ValidationException('That is not a fulfilment stage');
    }
    if (targetIndex != currentIndex + 1) {
      throw const ValidationException(
        'Orders move one step at a time and cannot go backwards',
      );
    }
    if (stage == OrderStage.shipped &&
        (courierName == null || courierName.trim().isEmpty)) {
      throw const ValidationException(
        'Add the courier and tracking number before marking it shipped',
      );
    }

    final updated = order.copyWith(
      stage: stage,
      courierName: courierName ?? order.courierName,
      trackingNumber: trackingNumber ?? order.trackingNumber,
      events: [
        ...order.events,
        OrderEvent(stage: stage, at: DateTime.now()),
      ],
    );
    await _write([updated, ..._read().where((o) => o.id != order.id)]);
    return updated;
  }

  TrackedOrder _require(String id) {
    final matches = _read().where((o) => o.id == id);
    if (matches.isEmpty) {
      throw NotFoundException('No order with id "$id"');
    }
    return matches.first;
  }

  /// Seeds one order at each interesting point: mid-flight, just delivered
  /// (so a return is possible), long delivered (so it is not), and one on
  /// the seller side awaiting action.
  Future<void> _seedOnce() async {
    if (_store.getBool(_seededKey) ?? false) return;
    final now = DateTime.now();

    List<OrderEvent> upTo(OrderStage stage, DateTime from) {
      final events = <OrderEvent>[];
      for (final s in OrderStage.fulfilment) {
        events.add(
          OrderEvent(
            stage: s,
            at: from.add(Duration(hours: events.length * 9)),
          ),
        );
        if (s == stage) break;
      }
      return events;
    }

    final seeded = <TrackedOrder>[
      TrackedOrder(
        id: 'o-1',
        reference: 'SN-24081',
        stage: OrderStage.shipped,
        placedAt: now.subtract(const Duration(days: 2)),
        deliveryAddress: 'Baluwatar, Kathmandu',
        counterpartyName: 'Sanatan Ratna Bhandar',
        courierName: 'Nepal Can Move',
        trackingNumber: 'NCM4471209',
        expectedBy: now.add(const Duration(days: 2)),
        shipping: 120 * _scale,
        items: [
          OrderItem(
            productId: 'neelam',
            name: 'Blue sapphire (Neelam)',
            quantity: 1,
            unitPrice: 18500 * _scale,
          ),
        ],
        events: upTo(OrderStage.shipped, now.subtract(const Duration(days: 2))),
      ),
      TrackedOrder(
        id: 'o-2',
        reference: 'SN-23940',
        stage: OrderStage.delivered,
        placedAt: now.subtract(const Duration(days: 5)),
        deliveryAddress: 'Baluwatar, Kathmandu',
        counterpartyName: 'Himalayan Rudraksha',
        shipping: 80 * _scale,
        items: [
          OrderItem(
            productId: 'panchmukhi',
            name: 'Panchmukhi Rudraksha',
            quantity: 2,
            unitPrice: 1250 * _scale,
          ),
        ],
        // Delivered two days ago: still inside the return window.
        events: upTo(
          OrderStage.delivered,
          now.subtract(const Duration(days: 5)),
        ),
      ),
      TrackedOrder(
        id: 'o-3',
        reference: 'SN-21188',
        stage: OrderStage.delivered,
        placedAt: now.subtract(const Duration(days: 40)),
        deliveryAddress: 'Baluwatar, Kathmandu',
        counterpartyName: 'Vedic Puja Samagri',
        shipping: 60 * _scale,
        items: [
          OrderItem(
            productId: 'moti',
            name: 'Pearl (Moti)',
            quantity: 1,
            unitPrice: 6400 * _scale,
          ),
        ],
        events: upTo(
          OrderStage.delivered,
          now.subtract(const Duration(days: 40)),
        ),
      ),
      TrackedOrder(
        id: 'so-1',
        reference: 'SN-24120',
        stage: OrderStage.placed,
        placedAt: now.subtract(const Duration(hours: 5)),
        deliveryAddress: 'Lakeside, Pokhara',
        counterpartyName: 'Sabina K.',
        shipping: 100 * _scale,
        items: [
          OrderItem(
            productId: 'panna',
            name: 'Emerald (Panna)',
            quantity: 1,
            unitPrice: 12800 * _scale,
          ),
        ],
        events: [
          OrderEvent(
            stage: OrderStage.placed,
            at: now.subtract(const Duration(hours: 5)),
          ),
        ],
      ),
    ];

    await _write(seeded);
    await _store.setBool(_seededKey, true);
  }

  List<TrackedOrder> _read() {
    final raw = _store.getString(_ordersKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        TrackedOrder(
          id: (e as Map<String, dynamic>)['id'] as String,
          reference: e['reference'] as String,
          stage: OrderStage.fromName(e['stage'] as String?),
          placedAt: DateTime.parse(e['placedAt'] as String),
          deliveryAddress: e['deliveryAddress'] as String? ?? '',
          counterpartyName: e['counterpartyName'] as String? ?? '',
          courierName: e['courierName'] as String?,
          trackingNumber: e['trackingNumber'] as String?,
          returnReason: e['returnReason'] as String?,
          shipping: (e['shipping'] as num?)?.toDouble() ?? 0,
          discount: (e['discount'] as num?)?.toDouble() ?? 0,
          expectedBy: e['expectedBy'] == null
              ? null
              : DateTime.parse(e['expectedBy'] as String),
          items: [
            for (final i in (e['items'] as List<dynamic>))
              OrderItem(
                productId: (i as Map<String, dynamic>)['productId'] as String,
                name: i['name'] as String,
                quantity: i['quantity'] as int,
                unitPrice: (i['unitPrice'] as num).toDouble(),
                imageAsset: i['imageAsset'] as String?,
              ),
          ],
          events: [
            for (final ev in (e['events'] as List<dynamic>? ?? []))
              OrderEvent(
                stage: OrderStage.fromName(
                  (ev as Map<String, dynamic>)['stage'] as String?,
                ),
                at: DateTime.parse(ev['at'] as String),
                note: ev['note'] as String? ?? '',
              ),
          ],
        ),
    ];
  }

  Future<void> _write(List<TrackedOrder> orders) => _store.setString(
    _ordersKey,
    jsonEncode([
      for (final o in orders)
        {
          'id': o.id,
          'reference': o.reference,
          'stage': o.stage.name,
          'placedAt': o.placedAt.toIso8601String(),
          'deliveryAddress': o.deliveryAddress,
          'counterpartyName': o.counterpartyName,
          'courierName': o.courierName,
          'trackingNumber': o.trackingNumber,
          'returnReason': o.returnReason,
          'shipping': o.shipping,
          'discount': o.discount,
          'expectedBy': o.expectedBy?.toIso8601String(),
          'items': [
            for (final i in o.items)
              {
                'productId': i.productId,
                'name': i.name,
                'quantity': i.quantity,
                'unitPrice': i.unitPrice,
                'imageAsset': i.imageAsset,
              },
          ],
          'events': [
            for (final e in o.events)
              {
                'stage': e.stage.name,
                'at': e.at.toIso8601String(),
                'note': e.note,
              },
          ],
        },
    ]),
  );
}
