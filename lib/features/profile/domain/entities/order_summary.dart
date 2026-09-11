import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_summary.freezed.dart';

/// Life-cycle of a marketplace order as shown in "My Orders".
enum OrderStatus { placed, processing, completed, sold, cancelled }

/// Whether the current user is the buyer or the seller of the order.
enum OrderRole { buyer, seller }

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
}
