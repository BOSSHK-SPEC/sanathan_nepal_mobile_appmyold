import 'package:freezed_annotation/freezed_annotation.dart';

part 'boost_request.freezed.dart';

/// A purchasable boost duration ("12 Hours (Rs.1,000)").
@freezed
abstract class BoostPlan with _$BoostPlan {
  const factory BoostPlan({
    required int hours,
    required double pricePerProduct,
  }) = _BoostPlan;
}

/// Form payload for the "Boost your listing" flow.
@freezed
abstract class BoostRequest with _$BoostRequest {
  const BoostRequest._();

  const factory BoostRequest({
    required List<String> productIds,
    required BoostPlan plan,
    required String firstName,
    required String lastName,
    required String phone,
    required String productLink,
    String? receiptPath,
  }) = _BoostRequest;

  double get total => plan.pricePerProduct * productIds.length;
}

/// Acknowledgement returned once a boost request is submitted.
@freezed
abstract class BoostReceipt with _$BoostReceipt {
  const factory BoostReceipt({
    required String referenceId,
    required double total,
    required DateTime submittedAt,
  }) = _BoostReceipt;
}
