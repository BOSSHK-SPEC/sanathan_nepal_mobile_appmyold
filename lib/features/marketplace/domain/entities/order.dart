import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import 'cart.dart';

part 'order.freezed.dart';

/// Payment options offered at checkout. Which ones are shown comes from
/// `RegionConfig.paymentRails` (Nepal: eSewa / Khalti / bank transfer / COD;
/// India: UPI / card / net banking / COD) – see [PaymentMethod.fromRail].
enum PaymentMethod {
  esewa,
  khalti,
  bankTransfer,
  cashOnDelivery,
  upi,
  card,
  netBanking;

  /// Domain payment method for a region [PaymentRail].
  static PaymentMethod fromRail(PaymentRail rail) => switch (rail) {
    PaymentRail.esewa => esewa,
    PaymentRail.khalti => khalti,
    PaymentRail.bankTransfer => bankTransfer,
    PaymentRail.cashOnDelivery => cashOnDelivery,
    PaymentRail.upi => upi,
    PaymentRail.card => card,
    PaymentRail.netBanking => netBanking,
  };

  /// Methods offered by [config], in the region's display order.
  static List<PaymentMethod> forRegion(RegionConfig config) => [
    for (final r in config.paymentRails) fromRail(r),
  ];

  PaymentRail get rail => switch (this) {
    esewa => PaymentRail.esewa,
    khalti => PaymentRail.khalti,
    bankTransfer => PaymentRail.bankTransfer,
    cashOnDelivery => PaymentRail.cashOnDelivery,
    upi => PaymentRail.upi,
    card => PaymentRail.card,
    netBanking => PaymentRail.netBanking,
  };
}

/// Delivery address collected on the checkout page.
@freezed
abstract class ShippingAddress with _$ShippingAddress {
  const ShippingAddress._();

  const factory ShippingAddress({
    required String firstName,
    required String lastName,
    required String country,
    required String street,
    required String city,
    required String province,
    required String email,
    @Default('') String apartment,
    @Default('') String postcode,
    @Default('') String phone,
  }) = _ShippingAddress;

  String get fullName => '$firstName $lastName'.trim();
}

/// Everything needed to place an order.
@freezed
abstract class OrderRequest with _$OrderRequest {
  const factory OrderRequest({
    required Cart cart,
    required ShippingAddress address,
    required PaymentMethod paymentMethod,
    @Default('') String notes,
    @Default(false) bool shipToDifferentAddress,
  }) = _OrderRequest;
}

/// A confirmed order returned by [OrderRepository.placeOrder].
@freezed
abstract class Order with _$Order {
  const factory Order({
    required String id,
    required List<CartItem> items,
    required double subtotal,
    required double discount,
    required double shippingCost,
    required double total,
    required PaymentMethod paymentMethod,
    required ShippingAddress address,
    required DateTime placedAt,
    @Default('paid') String status,
  }) = _Order;
}
