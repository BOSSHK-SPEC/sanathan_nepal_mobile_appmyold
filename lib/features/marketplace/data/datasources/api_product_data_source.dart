import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_draft.dart';
import '../../domain/entities/product_filter.dart';
import '../models/product_model.dart';
import '../models/seller_model.dart';
import 'mock_product_data_source.dart';

/// Marketplace listings served by the backend.
///
/// Filtering, sorting and boost ordering all happen server-side. Doing any of
/// it here would mean paging through the whole catalogue to sort it, which is
/// exactly what a mobile connection cannot afford.
class ApiProductDataSource implements ProductDataSource {
  const ApiProductDataSource(this._client);

  final ApiClient _client;

  /// One page is what a list screen shows before the user scrolls; the cursor
  /// the server returns is what fetches the next one.
  static const int _pageSize = 40;

  @override
  Future<List<ProductModel>> fetchProducts(ProductFilter filter) => guardApi(
    () async {
      final response = await _client.get<dynamic>(
        ApiEndpoints.products,
        query: {
          'limit': filter.limit ?? _pageSize,
          if (filter.categoryId != null && filter.categoryId != Category.all.id)
            'categoryId': filter.categoryId,
          if (filter.query != null && filter.query!.isNotEmpty)
            'search': filter.query,
          if (filter.businessId != null) 'businessId': filter.businessId,
          'sort': _sortName(filter),
        },
      );

      var items = asPageItems(response).map(_toModel).toList(growable: false);

      // Two filters the list endpoint does not express. `favouritesOnly` has
      // its own endpoint the repository can call instead, and `boostedOnly` is
      // a display toggle over a page the server already ordered by boost.
      // `mineOnly` is deliberately not among them any more — see
      // [ProductDataSource.myProducts].
      if (filter.boostedOnly) {
        items = items.where((p) => p.isBoosted).toList(growable: false);
      }
      if (filter.favouritesOnly) {
        items = items.where((p) => p.isFavourite).toList(growable: false);
      }
      return items;
    },
  );

  @override
  Future<ProductModel> fetchById(String id) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.product(id));
    return _toModel(asJsonMap(response));
  });

  @override
  Future<ProductModel> toggleFavourite(String id) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.productFavourite(id),
    );
    return _toModel(asJsonMap(response));
  });

  @override
  Future<List<ProductModel>> myProducts() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.myProducts);
    return asJsonList(response).map(_toModel).toList(growable: false);
  });

  @override
  Future<ProductModel> create(ProductDraft draft) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.products,
      data: _draftBody(draft),
    );
    return _toModel(asJsonMap(response));
  });

  @override
  Future<ProductModel> update(String id, ProductDraft draft) =>
      guardApi(() async {
        final response = await _client.patch<dynamic>(
          ApiEndpoints.product(id),
          data: _draftBody(draft),
        );
        return _toModel(asJsonMap(response));
      });

  @override
  Future<void> delete(String id) =>
      guardApi(() => _client.delete<dynamic>(ApiEndpoints.product(id)));

  @override
  Future<List<Category>> fetchCategories() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.categories);
    return asJsonList(response)
        .map(
          (json) => Category(
            id: json['id'] as String? ?? '',
            nameEn: _localized(json['name'])['en'] ?? '',
            nameNe: _localized(json['name'])['ne'] ?? '',
            nameHi: _localized(json['name'])['hi'],
            iconName: json['iconName'] as String?,
          ),
        )
        .toList(growable: false);
  });

  Map<String, dynamic> _draftBody(ProductDraft draft) => {
    // `titleLocal` is whichever local language the seller typed in; the server
    // stores it under `ne` for Nepal and `hi` for India, keyed by the region
    // header the client already sends.
    'title': {
      'en': draft.title,
      'ne': _orEnglish(draft.titleLocal, draft.title),
    },
    'description': {
      'en': draft.description,
      'ne': _orEnglish(draft.descriptionLocal, draft.description),
    },
    'location': {
      'en': draft.location,
      'ne': _orEnglish(draft.locationLocal, draft.location),
    },
    'priceMinor': ApiMoney.toMinorString(draft.price),
    'categoryId': draft.categoryId,
    'condition': draft.condition.name,
    'isService': draft.isService,
    'negotiable': draft.negotiable,
    if (draft.websiteLink != null && draft.websiteLink!.isNotEmpty)
      'websiteLink': draft.websiteLink,
    'imageKeys': draft.images,
    // `.toUtc()` is load-bearing twice over: `toIso8601String()` on a local
    // DateTime emits no zone suffix, which the server's RFC-3339 check
    // rejects — and a wall-clock time sent as if it were absolute would
    // expire the listing hours early or late depending on the device.
    'expiresAt': DateTime.now()
        .add(Duration(days: draft.expiryDays))
        .toUtc()
        .toIso8601String(),
  };

  /// A blank local translation falls back to English rather than being sent as
  /// an empty string, which would render as a blank title in Nepali.
  static String _orEnglish(String local, String english) =>
      local.trim().isEmpty ? english : local;

  static String _sortName(ProductFilter filter) => switch (filter.sort) {
    ProductSort.priceLowToHigh => 'priceAsc',
    ProductSort.priceHighToLow => 'priceDesc',
    ProductSort.latest => 'recent',
  };

  ProductModel _toModel(Map<String, dynamic> json) {
    final title = _localized(json['title']);
    final description = _localized(json['description']);
    final location = _localized(json['location']);
    final seller = json['seller'];

    return ProductModel(
      id: json['id'] as String? ?? '',
      title: title['en'] ?? '',
      titleNe: title['ne'] ?? title['en'] ?? '',
      description: description['en'] ?? '',
      descriptionNe: description['ne'] ?? description['en'] ?? '',
      price: ApiMoney.toMajor(json['priceMinor']),
      categoryId: json['categoryId'] as String? ?? '',
      images: _strings(json['imageKeys']),
      videos: _strings(json['videoKeys']),
      seller: _toSeller(seller),
      location: location['en'] ?? '',
      locationNe: location['ne'] ?? location['en'] ?? '',
      postedAt: ApiTime.instantOr(json['publishedAt'], DateTime.now()),
      currency: json['currency'] as String? ?? 'NPR',
      condition: json['condition'] == 'brandNew'
          ? ProductCondition.brandNew
          : ProductCondition.used,
      views: (json['viewCount'] as num?)?.toInt() ?? 0,
      likes: (json['likeCount'] as num?)?.toInt() ?? 0,
      rating: (json['ratingAvg'] as num?)?.toDouble() ?? 0,
      isBoosted: json['isBoosted'] as bool? ?? false,
      isFavourite: json['isFavourite'] as bool? ?? false,
      isMine: json['isMine'] as bool? ?? false,
      businessId: json['businessId'] as String?,
      negotiable: json['negotiable'] as bool? ?? false,
      isService: json['isService'] as bool? ?? false,
      websiteLink: json['websiteLink'] as String?,
      expiresAt: ApiTime.instant(json['expiresAt']),
      specs: _stringMap(json['specs']),
      options: _optionMap(json['options']),
    );
  }

  SellerModel _toSeller(Object? raw) {
    if (raw is! Map) return const SellerModel(id: '', name: 'Seller');
    return SellerModel(
      id: raw['id'] as String? ?? '',
      // A business name is what a buyer recognises; the personal name is the
      // fallback for an individual seller.
      name:
          (raw['businessName'] as String?) ??
          raw['name'] as String? ??
          'Seller',
      avatar: raw['avatarUrl'] as String?,
      verified: raw['verified'] as bool? ?? false,
    );
  }

  static Map<String, String> _localized(Object? raw) {
    if (raw is String) return {'en': raw};
    if (raw is! Map) return const {};
    return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
  }

  static List<String> _strings(Object? raw) {
    if (raw is! List) return const [];
    return raw.whereType<String>().toList(growable: false);
  }

  static Map<String, String> _stringMap(Object? raw) {
    if (raw is! Map) return const {};
    return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
  }

  static Map<String, List<String>> _optionMap(Object? raw) {
    if (raw is! Map) return const {};
    return raw.map(
      (key, value) => MapEntry(
        key.toString(),
        value is List ? value.map((v) => v.toString()).toList() : <String>[],
      ),
    );
  }
}
