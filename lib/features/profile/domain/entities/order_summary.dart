import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_summary.freezed.dart';

/// Life-cycle of a marketplace order as shown in "My Orders".
///
/// These mirror the server's states rather than summarising them. The old set
/// collapsed `confirmed`, `shipped` and `outForDelivery` together, so a sales
/// card could not tell "this needs accepting" from "this needs posting" — and
/// offered the seller a button for a move the server would refuse.
enum OrderStatus {
  /// Placed, payment not settled. Nothing for the seller to do yet.
  placed,

  /// Paid, waiting for the seller to accept it.
  confirmed,

  /// Accepted and being prepared.
  processing,

  /// Handed to a courier.
  shipped,
  outForDelivery,

  /// Delivered — the end of a happy order.
  completed,

  /// Cancelled, returned or refunded: all dead ends from this card's point of
  /// view, and it says "cancelled" for each.
  cancelled,
}

/// Whether the current user is the buyer or the seller of the order.
enum OrderRole { buyer, seller }

/// What a person can *do* to an order from the activity tab.
///
/// An intent, deliberately, rather than a target status: the buyer's cancel and
/// the seller's cancel are different endpoints, and the app used to send a
/// status and hope. Each action is exactly one legal transition, mirroring
/// `SELLER_TRANSITIONS` in the API, so a button that cannot succeed is never
/// drawn.
enum OrderAction {
  /// Seller takes the order on: `confirmed → processing`.
  accept,

  /// Seller hands it to a courier: `processing → shipped`.
  ship,

  /// Seller confirms it arrived: `outForDelivery → delivered`.
  deliver,

  /// Either side calls it off, while that is still possible.
  cancel,
}

/// Order card data (Figma "User: My Purchase" / "Seller: My Sales").
@freezed
abstract class OrderSummary with _$OrderSummary {
  const factory OrderSummary({
    required String id,
    required String productName,

    /// Order price in the region currency (NPR / INR).
    required double price,

    /// Seller name for purchases, buyer name for sales.
    required String counterpartyName,

    /// Business/user id of the counterparty (used by "Visit Seller Profile").
    required String counterpartyId,
    required OrderRole role,
    required OrderStatus status,
    required DateTime updatedAt,

    /// Seller's listed price (S.P) shown on sales cards.
    double? sellingPrice,

    /// Buyer rating (1–5) once the purchase is completed.
    int? rating,
    String? imageUrl,
  }) = _OrderSummary;

  const OrderSummary._();

  /// What this person may do to this order, right now.
  ///
  /// One list, read by the card to draw buttons and by the use case to refuse
  /// anything else, so the two can never disagree about what is on offer. The
  /// rules are the server's, restated:
  ///
  ///  * a seller accepts only what is `confirmed`, posts only what is
  ///    `processing`, and completes only what is `outForDelivery`;
  ///  * a buyer cancels until it ships — after that it is a return, which is a
  ///    different screen with different consequences;
  ///  * a seller may also cancel until it ships, which is how an out-of-stock
  ///    order gets closed.
  List<OrderAction> get availableActions => switch ((role, status)) {
    (OrderRole.seller, OrderStatus.confirmed) => const [
      OrderAction.accept,
      OrderAction.cancel,
    ],
    (OrderRole.seller, OrderStatus.processing) => const [
      OrderAction.ship,
      OrderAction.cancel,
    ],
    (OrderRole.seller, OrderStatus.outForDelivery) => const [
      OrderAction.deliver,
    ],
    (OrderRole.buyer, OrderStatus.placed) ||
    (OrderRole.buyer, OrderStatus.confirmed) ||
    (OrderRole.buyer, OrderStatus.processing) => const [OrderAction.cancel],
    _ => const [],
  };

  bool get isOver =>
      status == OrderStatus.completed || status == OrderStatus.cancelled;
}
