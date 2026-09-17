import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/appointment_summary.dart';
import '../../domain/entities/business_profile.dart';
import '../../domain/entities/favourite_product.dart';
import '../../domain/entities/order_summary.dart';
import '../../domain/entities/user_profile.dart';
import '../models/business_profile_model.dart';
import '../models/user_profile_model.dart';
import 'mock_activity_data_source.dart';
import 'mock_business_data_source.dart';
import 'mock_favourites_data_source.dart';
import 'profile_wire_format.dart';

/// Shared JSON helpers for the profile family.
Map<String, String> _localized(Object? raw) {
  if (raw is String) return {'en': raw};
  if (raw is! Map) return const {};
  return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
}

/// The signed-in user's profile, served by the backend.
///
/// Unlike the other sources here this one is *not* a `ProfileLocalDataSource`
/// replacement — the local one stays as the offline cache. This fetches the
/// authoritative copy, which matters because roles live on it and a stale role
/// decides which screens the app offers.
class ApiProfileDataSource {
  const ApiProfileDataSource(this._client);

  final ApiClient _client;

  Future<UserProfileModel> read() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.profile);
    return _toProfile(asJsonMap(response));
  });

  Future<UserProfileModel> update(UserProfileModel profile) =>
      guardApi(() async {
        final response = await _client.patch<dynamic>(
          ApiEndpoints.profile,
          data: {
            'name': profile.name,
            if (profile.email.isNotEmpty) 'email': profile.email,
            if (profile.phone.isNotEmpty) 'phone': profile.phone,
            'gender': ?profile.gender?.name,
            'dobAd': ?ProfileWireFormat.dateToWire(profile.dobAd),
            'birthTime': ?ProfileWireFormat.timeToWire(profile.birthTime),
            'birthPlace': ?profile.birthPlace,
            'address': ?profile.address,
            'bio': ?profile.bio,
            // Sent even when empty, like the sign below: blank clears it.
            'religion': profile.religion?.trim() ?? '',
            'avatarUrl': ?profile.avatarUrl,
            // Sent even when null: null clears the sign, and leaving it out
            // would make "remove my sign" silently do nothing.
            'zodiacSign': profile.zodiacSign?.name,
          },
        );
        return _toProfile(asJsonMap(response));
      });

  Future<void> deleteAccount() =>
      guardApi(() => _client.delete<dynamic>(ApiEndpoints.profile));

  Future<void> logout() =>
      guardApi(() => _client.post<dynamic>(ApiEndpoints.profileLogout));

  UserProfileModel _toProfile(Map<String, dynamic> json) => UserProfileModel(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    email: json['email'] as String? ?? '',
    phone: json['phone'] as String? ?? '',
    avatarUrl: json['avatarUrl'] as String?,
    gender: _gender(json['gender'] as String?),
    dobAd: ProfileWireFormat.dateFromWire(json['dobAd'] as String?),
    birthTime: ProfileWireFormat.timeFromWire(json['birthTime'] as String?),
    birthPlace: json['birthPlace'] as String?,
    address: json['address'] as String?,
    bio: json['bio'] as String?,
    religion: json['religion'] as String?,
    zodiacSign: _zodiac(json['zodiacSign'] as String?),
    verified: json['verified'] as bool? ?? false,
    roles: _roles(json['roles']),
  );

  /// Same twelve names as the server's enum; anything unrecognised reads as
  /// "not set" rather than failing the whole profile.
  static ProfileZodiac? _zodiac(String? name) =>
      ProfileZodiac.values.where((z) => z.name == name).firstOrNull;

  static Gender? _gender(String? name) => switch (name) {
    'female' => Gender.female,
    'male' => Gender.male,
    'other' => Gender.other,
    _ => null,
  };

  /// The server's role set is richer than the app's four; the extras collapse
  /// onto `admin`, which is what the app uses to unlock staff screens.
  static Set<UserRole> _roles(Object? raw) {
    if (raw is! List) return const {UserRole.user};
    final roles = <UserRole>{UserRole.user};
    for (final role in raw.whereType<String>()) {
      switch (role) {
        case 'astrologer':
          roles.add(UserRole.astrologer);
        case 'merchant':
          roles.add(UserRole.seller);
        case 'moderator' || 'finance' || 'support' || 'superAdmin':
          roles.add(UserRole.admin);
      }
    }
    return roles;
  }
}

/// Orders and appointments shown on the activity tab.
class ApiActivityDataSource implements ActivityDataSource {
  const ApiActivityDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<AppointmentSummary>> getAppointments() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.appointments);
    return asJsonList(response)
        .map(
          (json) => AppointmentSummary(
            id: json['id'] as String? ?? '',
            titleEn: _localized(json['serviceName'])['en'] ?? '',
            titleNe: _localized(json['serviceName'])['ne'] ?? '',
            doctorName: _localized(json['astrologerName'])['en'] ?? '',
            serviceEn: _localized(json['serviceName'])['en'] ?? '',
            serviceNe: _localized(json['serviceName'])['ne'] ?? '',
            dateTime: ApiTime.instantOr(json['startsAt'], DateTime.now()),
          ),
        )
        .toList(growable: false);
  });

  @override
  Future<List<OrderSummary>> getOrders() => guardApi(() async {
    // Orders the user bought and orders they sold are two endpoints; the
    // activity tab shows both, tagged by role.
    final bought = await _client.get<dynamic>(ApiEndpoints.orders);
    final summaries = asJsonList(
      bought,
    ).map((json) => _toSummary(json, OrderRole.buyer)).toList();

    try {
      final sold = await _client.get<dynamic>(ApiEndpoints.sellingOrders);
      summaries.addAll(
        asJsonList(sold).map((json) => _toSummary(json, OrderRole.seller)),
      );
    } on Exception {
      // A buyer with no merchant role is refused the selling list. That is
      // expected, not an error — their activity tab simply has no sales.
    }

    summaries.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return summaries;
  });

  /// Applies a seller or buyer action to an order.
  ///
  /// Two endpoints, not one: a seller advances an order through the fulfilment
  /// states, while a buyer may only cancel. This used to call `cancel` for
  /// every action, so a seller pressing Accept hit the *buyer's* endpoint,
  /// which looks the order up by `buyerId` — no match, 404, and a button that
  /// appeared to do nothing.
  @override
  Future<OrderSummary> applyOrderAction(
    OrderSummary order,
    OrderAction action,
  ) => guardApi(() async {
    final isSellerAction = order.role == OrderRole.seller;
    final response = isSellerAction
        ? await _client.post<dynamic>(
            ApiEndpoints.orderAdvance(order.id),
            data: {'status': _advanceStatus(action)},
          )
        : await _client.post<dynamic>(
            ApiEndpoints.orderCancel(order.id),
            data: {'reason': 'Cancelled by the buyer'},
          );

    // Re-tagged with the role it came from: the response says nothing about
    // which side asked, and stamping every update as a purchase moved sales
    // into the buyer's list the moment they were touched.
    return _toSummary(asJsonMap(response), order.role);
  });

  /// The server status each seller action moves the order to.
  ///
  /// These are exactly the moves `SELLER_TRANSITIONS` permits; anything else
  /// comes back as `ORDER_TRANSITION_INVALID`.
  static String _advanceStatus(OrderAction action) => switch (action) {
    OrderAction.accept => 'processing',
    OrderAction.ship => 'shipped',
    OrderAction.deliver => 'delivered',
    OrderAction.cancel => 'cancelled',
  };

  @override
  Future<OrderSummary> rateOrder(String id, int rating) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.orderRate(id),
      data: {'rating': rating},
    );
    return _toSummary(asJsonMap(response), OrderRole.buyer);
  });

  OrderSummary _toSummary(Map<String, dynamic> json, OrderRole role) {
    final items = json['items'];
    final first = items is List && items.isNotEmpty && items.first is Map
        ? Map<String, dynamic>.from(items.first as Map)
        : const <String, dynamic>{};

    return OrderSummary(
      id: json['id'] as String? ?? '',
      productName: _localized(first['title'])['en'] ?? '',
      price: ApiMoney.toMajor(json['totalMinor']),
      counterpartyName: _counterparty(json),
      counterpartyId: first['sellerId'] as String? ?? '',
      role: role,
      status: _status(json['status'] as String?),
      updatedAt: ApiTime.instantOr(json['updatedAt'], DateTime.now()),
      rating: (json['rating'] as num?)?.toInt(),
      imageUrl: first['imageKey'] as String?,
    );
  }

  static String _counterparty(Map<String, dynamic> json) {
    final shipping = json['shipping'];
    if (shipping is! Map) return '';
    return [
      shipping['firstName'],
      shipping['lastName'],
    ].whereType<String>().where((part) => part.isNotEmpty).join(' ');
  }

  /// The server's ten states, mapped one-for-one onto what the card shows.
  ///
  /// `confirmed`, `shipped` and `outForDelivery` used to collapse into
  /// `placed`/`processing`, which is why a sales card could not tell an order
  /// awaiting acceptance from one awaiting a courier — and drew the wrong
  /// button for both.
  static OrderStatus _status(String? status) => switch (status) {
    'confirmed' => OrderStatus.confirmed,
    'processing' => OrderStatus.processing,
    'shipped' => OrderStatus.shipped,
    'outForDelivery' => OrderStatus.outForDelivery,
    'delivered' => OrderStatus.completed,
    'cancelled' ||
    'returnRequested' ||
    'returned' ||
    'refunded' => OrderStatus.cancelled,
    // `pendingPayment`, and anything a newer server adds: placed, with no
    // action offered, which is the safe default for a state we do not know.
    _ => OrderStatus.placed,
  };
}

/// Saved products.
class ApiFavouritesDataSource implements FavouritesDataSource {
  const ApiFavouritesDataSource(this._client, this._regions);

  final ApiClient _client;
  final RegionResolver _regions;

  @override
  Future<List<FavouriteProduct>> getFavourites() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.profileFavourites);
    final config = _regions.config;

    return asJsonList(response)
        .map(
          (json) => FavouriteProduct(
            id: json['id'] as String? ?? '',
            name: _localized(json['title'])['en'] ?? '',
            description: '',
            // Formatted here rather than server-side: the currency symbol and
            // digit script follow the user's language, which the server does
            // not know per request.
            priceLabel: RegionFormat.money(
              ApiMoney.toMajor(json['priceMinor']),
              config: config,
              languageCode: config.defaultLanguageCode,
            ),
            condition: '',
            sellerName: '',
            location: '',
            views: 0,
            sold: 0,
            rating: 0,
            postedAt: DateTime.now(),
            imageUrl: json['imageKey'] as String?,
          ),
        )
        .toList(growable: false);
  });
}

/// Business profiles and the seller onboarding flow.
class ApiBusinessDataSource implements BusinessDataSource {
  const ApiBusinessDataSource(this._client);

  final ApiClient _client;

  @override
  Future<BusinessProfileModel> getBusiness(String id) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.business(id));
    return _toBusiness(asJsonMap(response));
  });

  @override
  Future<BusinessProfileModel> myBusiness() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.businessMine);
    // The endpoint answers `null` when the user has not registered one, which
    // is a normal state rather than an error — but the caller asked for *the*
    // business, so it is a not-found to them.
    if (response.data == null) {
      throw const NotFoundException('You have not registered a business yet');
    }
    return _toBusiness(asJsonMap(response));
  });

  @override
  Future<List<BusinessProfileModel>> listBusinesses({
    BusinessStatus? status,
  }) => guardApi(() async {
    // The moderation queue, not `/business/mine`. This used to call the latter,
    // so "Business approvals" listed exactly one row — the reviewer's own
    // business — and every listing actually waiting for a decision was
    // invisible. The endpoint is guarded by `approveBusiness` server-side.
    final response = await _client.get<dynamic>(
      ApiEndpoints.adminBusinesses,
      query: {'status': ?status?.name},
    );
    return asJsonList(response).map(_toBusiness).toList(growable: false);
  });

  @override
  Future<BusinessProfileModel> setImage(
    BusinessImageSlot slot,
    String? url,
  ) => guardApi(() async {
    // Only the one picture, so a new banner never overwrites the rest of the
    // listing with whatever this device last loaded.
    final response = await _client.patch<dynamic>(
      ApiEndpoints.businessMineBranding,
      data: {slot == BusinessImageSlot.logo ? 'logoKey' : 'coverKey': url},
    );
    return _toBusiness(asJsonMap(response));
  });

  @override
  Future<BusinessProfileModel> upsert(BusinessProfileModel model) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.businessMine,
          data: {
            'name': model.name,
            'description': model.description,
            'category': model.category,
            'tagline': model.tagline,
            'phone': model.phone,
            'whatsapp': model.whatsapp,
            'email': model.email,
            'website': model.website,
            'address': model.address,
            // The form has one address field; the server keeps a separate
            // city for its listings, so the address doubles as it until the
            // form asks for both.
            'city': model.address,
            'mapLink': model.mapLink,
            'workingHours': model.workingHours,
            'taxId': model.taxId,
            // Sent even when null: null removes the picture, and leaving it
            // out would make "remove" silently keep it.
            'logoKey': model.logoUrl,
            'coverKey': model.coverUrl,
            'documentIds': model.documents,
            // Sent whole. The owner edits the list as a list — adding one
            // item and losing another would be worse than a slow save.
            'items': [
              for (final item in model.items)
                {
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'priceLabel': item.priceLabel,
                  'category': item.category,
                  'isService': item.isService,
                  'imageUrl': item.imageUrl,
                  'purchaseLink': item.purchaseLink,
                  'tiktokLink': item.tiktokLink,
                  'youtubeLink': item.youtubeLink,
                  'negotiable': item.negotiable,
                },
            ],
          },
        );
        return _toBusiness(asJsonMap(response));
      });

  @override
  Future<BusinessProfileModel> setStatus(
    String id,
    BusinessStatus status, {
    String note = '',
  }) => guardApi(() async {
    // `pending` is where a listing starts, not somewhere a reviewer can put it
    // back: the endpoint only accepts a decision. Caught here so the reviewer
    // gets a sentence instead of a 400 with a Zod path in it.
    if (status == BusinessStatus.pending) {
      throw const ValidationException(
        'A business can be approved or rejected, not moved back to pending',
        'status',
      );
    }

    final response = await _client.post<dynamic>(
      ApiEndpoints.adminBusinessDecision(id),
      // The server names this field `status` and takes the decision itself —
      // not an `approve` boolean, which is what the astrologer and payout
      // endpoints use. The two shapes are easy to confuse.
      data: {'status': status.name, 'note': note},
    );
    return _toBusiness(asJsonMap(response));
  });

  @override
  Future<BusinessProfileModel> addReview(
    String businessId,
    int rating,
    String text,
  ) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.businessReview(businessId),
      data: {'rating': rating, 'text': text},
    );
    return _toBusiness(asJsonMap(response));
  });

  BusinessProfileModel _toBusiness(Map<String, dynamic> json) =>
      BusinessProfileModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        category: json['category'] as String? ?? '',
        description: json['description'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        website: json['website'] as String? ?? '',
        address: json['address'] as String? ?? '',
        tagline: json['tagline'] as String? ?? '',
        whatsapp: json['whatsapp'] as String? ?? '',
        mapLink: json['mapLink'] as String? ?? '',
        workingHours: json['workingHours'] as String? ?? '',
        taxId: json['taxId'] as String? ?? '',
        logoUrl: json['logoKey'] as String?,
        coverUrl: json['coverKey'] as String?,
        documents:
            (json['documentIds'] as List?)?.whereType<String>().toList() ??
            const [],
        items: _items(json['items']),
        reviews: _reviews(json['reviews']),
        verified: json['status'] == 'approved',
        status: _status(json['status'] as String?),
        moderationNote: json['statusNote'] as String? ?? '',
      );

  static List<BusinessReviewModel> _reviews(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map(Map<String, dynamic>.from)
        .map(
          (review) => BusinessReviewModel(
            id: review['id'] as String? ?? '',
            author: review['author'] as String? ?? 'Customer',
            rating: (review['rating'] as num?)?.toInt() ?? 5,
            date: ApiTime.instantOr(review['date'], DateTime.now()),
            text: review['text'] as String? ?? '',
            helpfulCount: (review['helpfulCount'] as num?)?.toInt() ?? 0,
          ),
        )
        .toList(growable: false);
  }

  static List<BusinessItemModel> _items(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map(Map<String, dynamic>.from)
        .map(
          (item) => BusinessItemModel(
            id: item['id'] as String? ?? '',
            title: item['title'] as String? ?? '',
            description: item['description'] as String? ?? '',
            priceLabel: item['priceLabel'] as String? ?? '',
            category: item['category'] as String? ?? '',
            isService: item['isService'] as bool? ?? false,
            imageUrl: item['imageUrl'] as String?,
            purchaseLink: item['purchaseLink'] as String? ?? '',
            tiktokLink: item['tiktokLink'] as String? ?? '',
            youtubeLink: item['youtubeLink'] as String? ?? '',
            negotiable: item['negotiable'] as bool? ?? false,
          ),
        )
        .toList(growable: false);
  }

  /// The app has no `suspended` state; a suspended business is treated as
  /// rejected, which is what it means for the seller — they cannot trade.
  static BusinessStatus _status(String? status) => switch (status) {
    'approved' => BusinessStatus.approved,
    'rejected' || 'suspended' => BusinessStatus.rejected,
    _ => BusinessStatus.pending,
  };
}
