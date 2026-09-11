import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_tracking.freezed.dart';

/// Where an order is in its lifecycle.
///
/// [returnRequested] onwards are a separate branch rather than more forward
/// steps: a return is not progress toward delivery, and rendering it on the
/// same timeline misleads.
enum OrderStage {
  placed,
  confirmed,
  packed,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
  returnRequested,
  returnPickedUp,
  refunded;

  /// The forward path, in order. Used to draw the tracking timeline.
  static const List<OrderStage> fulfilment = [
    OrderStage.placed,
    OrderStage.confirmed,
    OrderStage.packed,
    OrderStage.shipped,
    OrderStage.outForDelivery,
    OrderStage.delivered,
  ];

  bool get isReturnFlow =>
      this == returnRequested || this == returnPickedUp || this == refunded;

  bool get isTerminal =>
      this == delivered || this == cancelled || this == refunded;

  static OrderStage fromName(String? name) =>
      OrderStage.values.firstWhere((s) => s.name == name, orElse: () => placed);
}

/// One recorded movement, so the timeline shows what happened and when.
@freezed
abstract class OrderEvent with _$OrderEvent {
  const factory OrderEvent({
    required OrderStage stage,
    required DateTime at,
    @Default('') String note,
  }) = _OrderEvent;
}

@freezed
abstract class OrderItem with _$OrderItem {
  const OrderItem._();

  const factory OrderItem({
    required String productId,
    required String name,
    required int quantity,
    required double unitPrice,
    String? imageAsset,
  }) = _OrderItem;

  double get lineTotal => unitPrice * quantity;
}

/// A tracked order.
@freezed
abstract class TrackedOrder with _$TrackedOrder {
  const TrackedOrder._();

  const factory TrackedOrder({
    required String id,
    required String reference,
    required OrderStage stage,
    required List<OrderItem> items,
    required DateTime placedAt,
    required String deliveryAddress,
    @Default(<OrderEvent>[]) List<OrderEvent> events,
    @Default(0) double shipping,
    @Default(0) double discount,

    /// Counterparty: the seller for a buyer, the buyer for a seller.
    @Default('') String counterpartyName,
    String? courierName,
    String? trackingNumber,
    DateTime? expectedBy,

    /// Set once a return has been raised.
    String? returnReason,
  }) = _TrackedOrder;

  double get subtotal => items.fold<double>(0, (sum, i) => sum + i.lineTotal);

  double get total => subtotal + shipping - discount;

  int get itemCount => items.fold<int>(0, (sum, i) => sum + i.quantity);

  /// Index reached along the fulfilment path; -1 for the return branch and
  /// for a cancellation, which never travelled it.
  int get fulfilmentIndex => OrderStage.fulfilment.indexOf(stage);

  bool get isDelivered => stage == OrderStage.delivered;

  /// Returns are only offered for a short window after delivery, which is
  /// why the window is part of the model rather than a UI constant.
  static const Duration returnWindow = Duration(days: 7);

  bool canRequestReturn({DateTime? now}) {
    if (!isDelivered) return false;
    final deliveredAt = events
        .where((e) => e.stage == OrderStage.delivered)
        .map((e) => e.at)
        .firstOrNull;
    if (deliveredAt == null) return false;
    return (now ?? DateTime.now()).difference(deliveredAt) <= returnWindow;
  }

  bool get hasReturn => stage.isReturnFlow;
}

/// Why a buyer is sending something back.
enum ReturnReason {
  damaged,
  wrongItem,
  notAsDescribed,
  qualityIssue,
  noLongerNeeded,
  other;

  /// "Changed my mind" returns are usually the buyer's cost, so the reason
  /// materially changes the outcome and is worth distinguishing.
  bool get isSellerFault =>
      this == damaged || this == wrongItem || this == notAsDescribed;

  static ReturnReason fromName(String? name) => ReturnReason.values.firstWhere(
    (r) => r.name == name,
    orElse: () => other,
  );
}

@freezed
abstract class ReturnDraft with _$ReturnDraft {
  const factory ReturnDraft({
    required String orderId,
    required ReturnReason reason,
    @Default(<String>[]) List<String> productIds,
    @Default('') String details,
    @Default(<String>[]) List<String> photoRefs,
  }) = _ReturnDraft;
}
