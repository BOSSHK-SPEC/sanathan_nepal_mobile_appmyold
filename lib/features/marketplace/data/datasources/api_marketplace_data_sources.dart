import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../domain/entities/boost_request.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product_review.dart';
import '../../domain/repositories/product_review_repository.dart';
import 'mock_boost_data_source.dart';
import 'mock_order_data_source.dart';
import 'product_review_data_source.dart';

/// Checkout, served by the backend.
///
/// The cart is *not* sent. The server reads it from the buyer's own cart rows
/// and re-prices every line from the live listing — a client-supplied cart is a
/// client-supplied price, which is the oldest way to buy something for a rupee.
class ApiOrderDataSource implements OrderDataSource {
  const ApiOrderDataSource(this._client);

  final ApiClient _client;

  @override
  Future<Order> placeOrder(OrderRequest request) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.checkout,
      data: {
        'paymentMethod': request.paymentMethod.name,
        'shipping': {
          'firstName': request.address.firstName,
          'lastName': request.address.lastName,
          'country': request.address.country,
          'street': request.address.street,
          'apartment': request.address.apartment,
          'city': request.address.city,
          'province': request.address.province,
          'postcode': request.address.postcode,
          'phone': request.address.phone,
          'email': request.address.email,
        },
        'note': request.notes,
      },
    );

    // The Idempotency-Key header is added by the interceptor, so a retry of
    // this attempt returns the first order rather than placing a second.
    final body = asJsonMap(response);
    final order = body['order'];
    final json = order is Map ? Map<String, dynamic>.from(order) : body;

    return Order(
      // The human-quotable reference is what support asks for, so it is the
      // id the UI shows; the ULID stays server-side.
      id: json['reference'] as String? ?? json['id'] as String? ?? '',
      items: request.cart.items,
      address: request.address,
      paymentMethod: request.paymentMethod,
      subtotal: ApiMoney.toMajor(json['subtotalMinor']),
      discount: ApiMoney.toMajor(json['discountMinor']),
      shippingCost: ApiMoney.toMajor(json['shippingMinor']),
      total: ApiMoney.toMajor(json['totalMinor']),
      placedAt: ApiTime.instantOr(json['placedAt'], DateTime.now()),
      status: json['status'] as String? ?? 'paid',
    );
  });
}

/// Product reviews, served by the backend.
class ApiProductReviewDataSource implements ProductReviewDataSource {
  const ApiProductReviewDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<ProductReview>> reviews(
    String productId, {
    ReviewSort sort = ReviewSort.recent,
    int? minRating,
    bool withPhotosOnly = false,
  }) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.reviewsFor(productId),
      query: {
        'sort': _sortName(sort),
        'minRating': ?minRating,
        if (withPhotosOnly) 'withPhotos': true,
      },
    );
    return asJsonList(response).map(_toReview).toList(growable: false);
  });

  @override
  Future<ProductRatingSummary> summary(String productId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.reviewSummary(productId),
    );
    final json = asJsonMap(response);
    final breakdown = json['breakdown'];

    return ProductRatingSummary(
      average: (json['average'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      distribution: breakdown is Map
          ? {
              for (var star = 1; star <= 5; star++)
                star: (breakdown['$star'] as num?)?.toInt() ?? 0,
            }
          : const {},
    );
  });

  @override
  Future<ProductReview> submit(ProductReviewDraft draft) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.productReviews,
      data: {
        'productId': draft.productId,
        'rating': draft.rating,
        'body': draft.comment,
        'imageKeys': draft.photos,
      },
    );
    return _toReview(asJsonMap(response));
  });

  @override
  Future<ProductReview> toggleHelpful(String reviewId) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.reviewHelpful(reviewId),
    );
    return _toReview(asJsonMap(response));
  });

  @override
  Future<ProductReview> reply(String reviewId, String message) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.reviewReply(reviewId),
          data: {'message': message},
        );
        return _toReview(asJsonMap(response));
      });

  @override
  Future<List<PendingReview>> pendingReviews() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.pendingReviews);
    return asJsonList(response)
        .map(
          (json) => PendingReview(
            orderId: json['orderId'] as String? ?? '',
            productId: json['productId'] as String? ?? '',
            productName: _localized(json['title'])['en'] ?? '',
            deliveredAt: ApiTime.instantOr(json['deliveredAt'], DateTime.now()),
            image: json['imageKey'] as String?,
          ),
        )
        .toList(growable: false);
  });

  static String _sortName(ReviewSort sort) => switch (sort) {
    // The server sorts high-to-low; "lowest" is the same ordering reversed by
    // the repository, so both map onto one server sort.
    ReviewSort.highest || ReviewSort.lowest => 'rating',
    ReviewSort.helpful => 'helpful',
    ReviewSort.recent => 'recent',
  };

  ProductReview _toReview(Map<String, dynamic> json) => ProductReview(
    id: json['id'] as String? ?? '',
    productId: json['productId'] as String? ?? '',
    authorName: json['authorName'] as String? ?? 'User',
    authorAvatar: json['authorAvatar'] as String?,
    rating: (json['rating'] as num?)?.toInt() ?? 0,
    comment: json['body'] as String? ?? '',
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    // Set only for a verified purchase, which is what the badge keys off.
    orderId: json['verifiedPurchase'] == true ? (json['id'] as String?) : null,
    photos: json['imageKeys'] is List
        ? (json['imageKeys'] as List).whereType<String>().toList()
        : const [],
    sellerReply: json['sellerReply'] as String?,
    helpfulCount: (json['helpfulCount'] as num?)?.toInt() ?? 0,
    markedHelpful: json['markedHelpful'] as bool? ?? false,
  );

  static Map<String, String> _localized(Object? raw) {
    if (raw is String) return {'en': raw};
    if (raw is! Map) return const {};
    return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
  }
}

/// Listing boosts, served by the backend.
class ApiBoostDataSource implements BoostDataSource {
  const ApiBoostDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<BoostPlan>> fetchPlans() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.boostPlans);
    return asJsonList(response)
        .map(
          (json) => BoostPlan(
            // The server sells whole days; the app's plan is expressed in hours.
            hours: ((json['days'] as num?)?.toInt() ?? 1) * 24,
            pricePerProduct: ApiMoney.toMajor(json['priceMinor']),
          ),
        )
        .toList(growable: false);
  });

  /// Boosts each selected listing.
  ///
  /// The server boosts one target per call, so a multi-select becomes several
  /// calls. They run sequentially rather than in parallel: each one debits the
  /// wallet, and firing them together would race on the same balance row for
  /// no benefit at this size.
  @override
  Future<BoostReceipt> submit(BoostRequest request) => guardApi(() async {
    final planId = await _planIdFor(request.plan);

    var total = 0.0;
    String? reference;

    for (final productId in request.productIds) {
      final response = await _client.post<dynamic>(
        ApiEndpoints.boosts,
        data: {'planId': planId, 'target': 'product', 'targetId': productId},
      );
      final json = asJsonMap(response);
      total += ApiMoney.toMajor(json['paidMinor']);
      reference ??= json['campaignId'] as String?;
    }

    return BoostReceipt(
      referenceId: reference ?? '',
      total: total,
      submittedAt: DateTime.now(),
    );
  });

  /// Resolves the plan the user picked back to a server plan id.
  ///
  /// The app's `BoostPlan` carries hours and price but no id, so the plan is
  /// matched on duration — the field the user actually chose.
  Future<String> _planIdFor(BoostPlan plan) async {
    final response = await _client.get<dynamic>(ApiEndpoints.boostPlans);
    final plans = asJsonList(response);

    final wantedDays = (plan.hours / 24).round();
    final match = plans.firstWhere(
      (json) => ((json['days'] as num?)?.toInt() ?? -1) == wantedDays,
      orElse: () => plans.isEmpty ? const <String, dynamic>{} : plans.first,
    );
    return match['id'] as String? ?? '';
  }
}
