import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/orders/data/datasources/mock_order_tracking_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/orders/domain/entities/order_tracking.dart';

void main() {
  late InMemoryKeyValueStore store;

  MockOrderTrackingDataSource sourceFor([Region region = Region.nepal]) =>
      MockOrderTrackingDataSource(store, FixedRegionResolver(region));

  setUp(() => store = InMemoryKeyValueStore());

  group('Listing', () {
    test('buyer and seller orders are disjoint', () async {
      final source = sourceFor();
      final mine = await source.myOrders();
      final theirs = await source.sellerOrders();
      expect(mine, isNotEmpty);
      expect(theirs, isNotEmpty);
      expect(
        mine
            .map((o) => o.id)
            .toSet()
            .intersection(theirs.map((o) => o.id).toSet()),
        isEmpty,
      );
    });

    test('newest first', () async {
      final orders = await sourceFor().myOrders();
      for (var i = 1; i < orders.length; i++) {
        expect(orders[i - 1].placedAt.isBefore(orders[i].placedAt), isFalse);
      }
    });

    test('India amounts are scaled', () async {
      // Separate stores: the seed is written once and then persisted, so a
      // second source sharing the store would read the first one's numbers.
      final np = (await MockOrderTrackingDataSource(
        InMemoryKeyValueStore(),
        const FixedRegionResolver(Region.nepal),
      ).myOrders()).first;
      final ind = (await MockOrderTrackingDataSource(
        InMemoryKeyValueStore(),
        const FixedRegionResolver(Region.india),
      ).myOrders()).first;
      expect(ind.total, lessThan(np.total));
    });
  });

  group('Totals', () {
    test('total is subtotal plus shipping minus discount', () async {
      for (final order in await sourceFor().myOrders()) {
        expect(
          order.total,
          closeTo(order.subtotal - order.discount + order.shipping, 0.01),
        );
        expect(
          order.subtotal,
          closeTo(
            order.items.fold<double>(0, (sum, i) => sum + i.lineTotal),
            0.01,
          ),
        );
      }
    });
  });

  group('Fulfilment', () {
    test('moves exactly one stage forward', () async {
      final source = sourceFor();
      final order = (await source.sellerOrders()).first;
      expect(order.stage, OrderStage.placed);

      final advanced = await source.advance(
        orderId: order.id,
        stage: OrderStage.confirmed,
      );
      expect(advanced.stage, OrderStage.confirmed);
      expect(advanced.events.last.stage, OrderStage.confirmed);
    });

    test('refuses to skip a stage', () async {
      final source = sourceFor();
      final order = (await source.sellerOrders()).first;
      expect(
        () => source.advance(orderId: order.id, stage: OrderStage.delivered),
        throwsA(isA<ValidationException>()),
      );
    });

    test('refuses to go backwards', () async {
      final source = sourceFor();
      final order = (await source.sellerOrders()).first;
      await source.advance(orderId: order.id, stage: OrderStage.confirmed);
      expect(
        () => source.advance(orderId: order.id, stage: OrderStage.placed),
        throwsA(isA<ValidationException>()),
      );
    });

    test('shipping requires courier details', () async {
      final source = sourceFor();
      final order = (await source.sellerOrders()).first;
      await source.advance(orderId: order.id, stage: OrderStage.confirmed);
      await source.advance(orderId: order.id, stage: OrderStage.packed);

      expect(
        () => source.advance(orderId: order.id, stage: OrderStage.shipped),
        throwsA(isA<ValidationException>()),
      );

      final shipped = await source.advance(
        orderId: order.id,
        stage: OrderStage.shipped,
        courierName: 'Nepal Can Move',
        trackingNumber: 'NCM1',
      );
      expect(shipped.courierName, 'Nepal Can Move');
    });

    test('a return stage is not a fulfilment stage', () async {
      final source = sourceFor();
      final order = (await source.sellerOrders()).first;
      expect(
        () => source.advance(
          orderId: order.id,
          stage: OrderStage.returnRequested,
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('Returns', () {
    Future<TrackedOrder> recentlyDelivered(
      MockOrderTrackingDataSource source,
    ) async =>
        (await source.myOrders()).firstWhere((o) => o.canRequestReturn());

    test(
      'the window is open just after delivery and closed long after',
      () async {
        final orders = await sourceFor().myOrders();
        final recent = orders.firstWhere((o) => o.id == 'o-2');
        final old = orders.firstWhere((o) => o.id == 'o-3');
        expect(recent.canRequestReturn(), isTrue);
        expect(old.canRequestReturn(), isFalse);
      },
    );

    test('an undelivered order cannot be returned', () async {
      final shipped = (await sourceFor().myOrders()).firstWhere(
        (o) => o.id == 'o-1',
      );
      expect(shipped.canRequestReturn(), isFalse);
    });

    test('a valid return moves the order onto the return branch', () async {
      final source = sourceFor();
      final order = await recentlyDelivered(source);
      final updated = await source.requestReturn(
        ReturnDraft(
          orderId: order.id,
          reason: ReturnReason.damaged,
          productIds: [order.items.first.productId],
        ),
      );
      expect(updated.stage, OrderStage.returnRequested);
      expect(updated.hasReturn, isTrue);
      // The forward path is no longer meaningful.
      expect(updated.fulfilmentIndex, -1);
    });

    test('a second return on the same order is refused', () async {
      final source = sourceFor();
      final order = await recentlyDelivered(source);
      await source.requestReturn(
        ReturnDraft(orderId: order.id, reason: ReturnReason.damaged),
      );
      expect(
        () => source.requestReturn(
          ReturnDraft(orderId: order.id, reason: ReturnReason.wrongItem),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('"other" requires details', () async {
      final source = sourceFor();
      final order = await recentlyDelivered(source);
      expect(
        () => source.requestReturn(
          ReturnDraft(orderId: order.id, reason: ReturnReason.other),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a return outside the window is refused', () async {
      final source = sourceFor();
      expect(
        () => source.requestReturn(
          const ReturnDraft(orderId: 'o-3', reason: ReturnReason.damaged),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('seller-fault reasons are distinguished from change-of-mind', () {
      expect(ReturnReason.damaged.isSellerFault, isTrue);
      expect(ReturnReason.wrongItem.isSellerFault, isTrue);
      expect(ReturnReason.noLongerNeeded.isSellerFault, isFalse);
    });
  });

  test('an unknown order is a not-found error', () async {
    expect(() => sourceFor().order('nope'), throwsA(isA<NotFoundException>()));
  });
}
