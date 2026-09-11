import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region_all.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/product_review.dart';
import '../../domain/repositories/product_review_repository.dart';

/// I/O contract for product reviews.
abstract interface class ProductReviewDataSource {
  Future<List<ProductReview>> reviews(
    String productId, {
    ReviewSort sort,
    int? minRating,
    bool withPhotosOnly,
  });
  Future<ProductRatingSummary> summary(String productId);
  Future<ProductReview> submit(ProductReviewDraft draft);
  Future<ProductReview> toggleHelpful(String reviewId);
  Future<ProductReview> reply(String reviewId, String message);
  Future<List<PendingReview>> pendingReviews();
}

/// In-memory reviews.
///
/// The rules that matter live here rather than in the screens: one review
/// per person per product, one seller reply per review, no rating outside
/// 1–5, and "verified" derived from the order rather than settable.
class MockProductReviewDataSource implements ProductReviewDataSource {
  MockProductReviewDataSource(this._store, this._regions);

  final KeyValueStore _store;
  final RegionResolver _regions;

  static const _reviewsKey = 'marketplace.reviews';
  static const _helpfulKey = 'marketplace.reviewsHelpful';
  static const Duration _latency = Duration(milliseconds: 160);

  /// The signed-in buyer, as the seed writes them.
  static const String currentAuthor = 'You';

  @override
  Future<List<ProductReview>> reviews(
    String productId, {
    ReviewSort sort = ReviewSort.recent,
    int? minRating,
    bool withPhotosOnly = false,
  }) async {
    await Future<void>.delayed(_latency);
    var list = _all().where((r) => r.productId == productId).toList();
    if (minRating != null) {
      list = list.where((r) => r.rating >= minRating).toList();
    }
    if (withPhotosOnly) list = list.where((r) => r.hasPhotos).toList();
    _sort(list, sort);
    return list;
  }

  @override
  Future<ProductRatingSummary> summary(String productId) async {
    await Future<void>.delayed(_latency);
    return ProductRatingSummary.from(
      _all().where((r) => r.productId == productId).toList(),
    );
  }

  @override
  Future<ProductReview> submit(ProductReviewDraft draft) async {
    await Future<void>.delayed(_latency);
    if (!draft.isValid) {
      throw const ValidationException('Pick a rating from one to five stars.');
    }
    final stored = _stored();
    if (stored.any(
      (r) => r.productId == draft.productId && r.authorName == currentAuthor,
    )) {
      // One voice per buyer per product. Editing an existing review is a
      // different action and would need its own endpoint.
      throw const ValidationException(
        'You have already reviewed this product.',
      );
    }

    final review = ProductReview(
      id: 'rev-${DateTime.now().millisecondsSinceEpoch}',
      productId: draft.productId,
      authorName: currentAuthor,
      rating: draft.rating,
      comment: draft.comment.trim(),
      photos: draft.photos,
      orderId: draft.orderId,
      createdAt: DateTime.now(),
    );
    await _write([review, ...stored]);
    return review;
  }

  @override
  Future<ProductReview> toggleHelpful(String reviewId) async {
    await Future<void>.delayed(_latency);
    final marked = _marked();
    final wasMarked = marked.contains(reviewId);
    wasMarked ? marked.remove(reviewId) : marked.add(reviewId);
    await _store.setStringList(_helpfulKey, marked.toList());

    final review = _all().firstWhere(
      (r) => r.id == reviewId,
      orElse: () => throw NotFoundException('No review "$reviewId"'),
    );
    return review;
  }

  @override
  Future<ProductReview> reply(String reviewId, String message) async {
    await Future<void>.delayed(_latency);
    if (message.trim().isEmpty) {
      throw const ValidationException('Write a reply first.');
    }

    final stored = _stored();
    final index = stored.indexWhere((r) => r.id == reviewId);
    final seeded = _seed().where((r) => r.id == reviewId).toList();
    if (index < 0 && seeded.isEmpty) {
      throw NotFoundException('No review "$reviewId"');
    }

    final current = index >= 0 ? stored[index] : seeded.first;
    if (current.hasReply) {
      // A seller answers once in public; a conversation belongs in support.
      throw const ValidationException(
        'You have already replied to this review.',
      );
    }
    final replied = current.copyWith(
      sellerReply: message.trim(),
      repliedAt: DateTime.now(),
    );
    if (index >= 0) {
      stored[index] = replied;
    } else {
      stored.add(replied);
    }
    await _write(stored);
    return replied;
  }

  @override
  Future<List<PendingReview>> pendingReviews() async {
    await Future<void>.delayed(_latency);
    final reviewed = _all()
        .where((r) => r.authorName == currentAuthor)
        .map((r) => r.productId)
        .toSet();
    return _deliveredSeed()
        .where((p) => !reviewed.contains(p.productId))
        .toList();
  }

  void _sort(List<ProductReview> list, ReviewSort sort) {
    switch (sort) {
      case ReviewSort.recent:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case ReviewSort.helpful:
        // Ties broken by recency so a wall of zero-vote reviews still reads
        // newest-first rather than in storage order.
        list.sort((a, b) {
          final helpful = b.helpfulCount.compareTo(a.helpfulCount);
          return helpful != 0 ? helpful : b.createdAt.compareTo(a.createdAt);
        });
      case ReviewSort.highest:
        list.sort((a, b) => b.rating.compareTo(a.rating));
      case ReviewSort.lowest:
        list.sort((a, b) => a.rating.compareTo(b.rating));
    }
  }

  /// Seeded reviews plus the buyer's own, with the helpful marks applied.
  List<ProductReview> _all() {
    final stored = _stored();
    final storedIds = stored.map((r) => r.id).toSet();
    final marked = _marked();
    return [
      for (final r in [
        ...stored,
        ..._seed().where((r) => !storedIds.contains(r.id)),
      ])
        marked.contains(r.id)
            ? r.copyWith(markedHelpful: true, helpfulCount: r.helpfulCount + 1)
            : r,
    ];
  }

  Set<String> _marked() =>
      (_store.getStringList(_helpfulKey) ?? const <String>[]).toSet();

  List<ProductReview> _stored() {
    final raw = _store.getString(_reviewsKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        _fromJson(e as Map<String, dynamic>),
    ];
  }

  Future<void> _write(List<ProductReview> reviews) => _store.setString(
    _reviewsKey,
    jsonEncode([for (final r in reviews) _toJson(r)]),
  );

  ProductReview _fromJson(Map<String, dynamic> e) => ProductReview(
    id: e['id'] as String,
    productId: e['productId'] as String,
    authorName: e['authorName'] as String,
    rating: e['rating'] as int,
    comment: e['comment'] as String? ?? '',
    createdAt: DateTime.parse(e['createdAt'] as String),
    authorAvatar: e['authorAvatar'] as String?,
    orderId: e['orderId'] as String?,
    photos: [
      for (final p in (e['photos'] as List<dynamic>? ?? [])) p as String,
    ],
    sellerReply: e['sellerReply'] as String?,
    repliedAt: e['repliedAt'] == null
        ? null
        : DateTime.parse(e['repliedAt'] as String),
    helpfulCount: e['helpfulCount'] as int? ?? 0,
  );

  Map<String, dynamic> _toJson(ProductReview r) => {
    'id': r.id,
    'productId': r.productId,
    'authorName': r.authorName,
    'rating': r.rating,
    'comment': r.comment,
    'createdAt': r.createdAt.toIso8601String(),
    'authorAvatar': r.authorAvatar,
    'orderId': r.orderId,
    'photos': r.photos,
    'sellerReply': r.sellerReply,
    'repliedAt': r.repliedAt?.toIso8601String(),
    'helpfulCount': r.helpfulCount,
  };

  // --- Seed ---------------------------------------------------------------

  /// Reviews the catalogue ships with, so a listing is not blank on first
  /// open. Product ids match the region seed.
  List<ProductReview> _seed() {
    final now = DateTime.now();
    final nepal = _regions.region == Region.nepal;
    final firstProduct = nepal ? 'np-p1' : 'in-p1';
    final secondProduct = nepal ? 'np-p2' : 'in-p2';
    return [
      ProductReview(
        id: 'rev-seed-1',
        productId: firstProduct,
        authorName: nepal ? 'Sabina K.' : 'Meera S.',
        rating: 5,
        comment:
            'Exactly as described and the packaging was careful. The priest '
            'at our local temple confirmed it is the right size.',
        orderId: 'ord-seed-1',
        helpfulCount: 12,
        createdAt: now.subtract(const Duration(days: 6)),
      ),
      ProductReview(
        id: 'rev-seed-2',
        productId: firstProduct,
        authorName: nepal ? 'Rajan T.' : 'Arun P.',
        rating: 4,
        comment: 'Good quality, but delivery took a week longer than promised.',
        orderId: 'ord-seed-2',
        sellerReply:
            'Thank you for the patience — the delay was at the courier and we '
            'have changed partners since.',
        repliedAt: now.subtract(const Duration(days: 11)),
        helpfulCount: 4,
        createdAt: now.subtract(const Duration(days: 13)),
      ),
      ProductReview(
        id: 'rev-seed-3',
        productId: firstProduct,
        authorName: nepal ? 'Anu G.' : 'Kavita R.',
        rating: 3,
        comment: 'Smaller than I expected from the photos.',
        photos: const ['local://reviews/rev-seed-3.jpg'],
        createdAt: now.subtract(const Duration(days: 24)),
      ),
      ProductReview(
        id: 'rev-seed-4',
        productId: secondProduct,
        authorName: nepal ? 'Bikash S.' : 'Nikhil D.',
        rating: 5,
        comment: 'Bought it for Dashain and the whole family was pleased.',
        orderId: 'ord-seed-3',
        helpfulCount: 7,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }

  /// Delivered orders the buyer could review. Stands in for the order
  /// history until reviews are read off the real orders API.
  List<PendingReview> _deliveredSeed() {
    final now = DateTime.now();
    final nepal = _regions.region == Region.nepal;
    return [
      PendingReview(
        orderId: 'ord-1042',
        productId: nepal ? 'np-p3' : 'in-p3',
        productName: nepal ? 'Brass puja thali set' : 'Brass puja thali set',
        deliveredAt: now.subtract(const Duration(days: 2)),
      ),
      PendingReview(
        orderId: 'ord-1039',
        productId: nepal ? 'np-p4' : 'in-p4',
        productName: 'Rudraksha mala',
        deliveredAt: now.subtract(const Duration(days: 9)),
      ),
    ];
  }
}
