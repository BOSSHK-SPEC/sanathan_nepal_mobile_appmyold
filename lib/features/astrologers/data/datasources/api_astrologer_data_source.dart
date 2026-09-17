import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../../domain/entities/astrologer_review.dart';
import '../../domain/entities/consult_channel.dart';
import '../../domain/entities/specialty.dart';
import 'astrologer_data_source.dart';

/// Astrologer discovery, served by the backend.
///
/// Only verified astrologers are ever returned — the server enforces that, so
/// a pending application cannot appear in a list because a client forgot to
/// filter.
class ApiAstrologerDataSource implements AstrologerDataSource {
  const ApiAstrologerDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<Astrologer>> getAstrologers(
    AstrologerFilter filter,
  ) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.astrologers,
      query: {
        'limit': 40,
        if (filter.query.isNotEmpty) 'search': filter.query,
        // The server takes one specialty and one language; with several
        // selected it narrows on the first and the rest are applied below.
        if (filter.specialties.isNotEmpty)
          'specialty': filter.specialties.first.name,
        if (filter.languageCodes.isNotEmpty)
          'language': filter.languageCodes.first,
        if (filter.channels.length == 1) 'channel': filter.channels.single.name,
        if (filter.onlineOnly) 'onlineOnly': true,
        'maxRate': ?filter.maxRate == null
            ? null
            : ApiMoney.toMinorString(filter.maxRate!),
        if (filter.minRating > 0) 'minRating': filter.minRating,
        'sort': _sortName(filter.sort),
      },
    );

    var items = asPageItems(response).map(_toAstrologer).toList();

    // Multi-select narrowing the endpoint cannot express. Applied to the
    // page the server already ranked rather than re-querying per value.
    if (filter.specialties.length > 1) {
      items = items
          .where((a) => a.specialties.any(filter.specialties.contains))
          .toList();
    }
    if (filter.languageCodes.length > 1) {
      items = items
          .where((a) => a.languageCodes.any(filter.languageCodes.contains))
          .toList();
    }
    if (filter.channels.length > 1) {
      items = items
          .where((a) => a.channels.any(filter.channels.contains))
          .toList();
    }
    if (filter.minExperience > 0) {
      items = items
          .where((a) => a.experienceYears >= filter.minExperience)
          .toList();
    }
    if (filter.followingOnly) {
      items = items.where((a) => a.isFollowing).toList();
    }
    return items;
  });

  @override
  Future<Astrologer> getAstrologer(String id) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.astrologer(id));
    return _toAstrologer(asJsonMap(response));
  });

  @override
  Future<List<String>> getLanguages() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.astrologerLanguages,
    );
    final body = response.data;
    return body is List ? body.whereType<String>().toList() : const [];
  });

  @override
  Future<List<AstrologerReview>> getReviews(String astrologerId) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.astrologerReviewsFor(astrologerId),
        );
        return asJsonList(response).map(_toReview).toList(growable: false);
      });

  /// Submitting requires the consultation being reviewed.
  ///
  /// The server rejects a review with no completed session behind it, which is
  /// what keeps ratings honest — so a draft without one is refused here rather
  /// than making a round trip to be told the same thing.
  @override
  Future<AstrologerReview> submitReview(ReviewDraft draft) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.astrologerReviews,
          data: {
            'astrologerId': draft.astrologerId,
            'consultationId': draft.consultationId,
            'rating': draft.rating,
            'body': _bodyWithTags(draft),
          },
        );
        return _toReview(asJsonMap(response));
      });

  /// Tags are a client-side convenience; the server stores one body, so they
  /// are appended rather than silently dropped.
  static String _bodyWithTags(ReviewDraft draft) {
    if (draft.tags.isEmpty) return draft.comment;
    final tags = draft.tags.join(', ');
    return draft.comment.isEmpty ? tags : '${draft.comment}\n\n$tags';
  }

  @override
  Future<String?> reviewableConsultationId(String astrologerId) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(ApiEndpoints.consultations);

        // Newest first, so a repeat client reviews the session they just had
        // rather than one from months ago.
        final completed =
            asJsonList(response)
                .where(
                  (json) =>
                      json['astrologerId'] == astrologerId &&
                      json['status'] == 'completed',
                )
                .toList()
              ..sort(
                (a, b) =>
                    (b['endedAt'] ?? b['startedAt'] ?? '').toString().compareTo(
                      (a['endedAt'] ?? a['startedAt'] ?? '').toString(),
                    ),
              );

        if (completed.isEmpty) return null;
        return completed.first['id'] as String?;
      });

  @override
  Future<bool> toggleFollow(String astrologerId) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.astrologerFollow(astrologerId),
    );
    return asJsonMap(response)['following'] as bool? ?? false;
  });

  @override
  Future<void> report(ReportDraft draft) => guardApi(() async {
    await _client.post<dynamic>(
      ApiEndpoints.astrologerReports,
      data: {
        'targetType': 'astrologer',
        'targetId': draft.astrologerId,
        'reason': _reasonName(draft.reason),
        'detail': draft.details,
      },
    );
  });

  /// The app's reasons are more specific than the server's five buckets.
  static String _reasonName(ReportReason reason) => switch (reason) {
    ReportReason.misleading => 'fraud',
    ReportReason.rude => 'abusive',
    ReportReason.spam => 'spam',
    ReportReason.pricing => 'other',
    _ => 'other',
  };

  @override
  Future<List<String>> recentSearches() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.astrologerSearches,
    );
    final body = response.data;
    return body is List ? body.whereType<String>().toList() : const [];
  });

  @override
  Future<void> saveSearch(String query) => guardApi(() async {
    await _client.post<dynamic>(
      ApiEndpoints.astrologerSearches,
      data: {'query': query},
    );
  });

  @override
  Future<void> clearSearches() => guardApi(() async {
    await _client.delete<dynamic>(ApiEndpoints.astrologerSearches);
  });

  static String _sortName(AstrologerSort sort) => switch (sort) {
    AstrologerSort.ratingHigh => 'rating',
    AstrologerSort.experienceHigh => 'experience',
    AstrologerSort.priceLow => 'priceAsc',
    AstrologerSort.priceHigh => 'priceDesc',
    AstrologerSort.recommended || AstrologerSort.popularity => 'recommended',
  };

  Astrologer _toAstrologer(Map<String, dynamic> json) {
    final rates = json['ratePerMinute'];
    final ratePerMinute = <ConsultChannel, double>{};
    if (rates is Map) {
      for (final entry in rates.entries) {
        ratePerMinute[ConsultChannel.fromName(entry.key.toString())] =
            ApiMoney.toMajor(entry.value);
      }
    }

    final breakdown = json['ratingBreakdown'];

    return Astrologer(
      id: json['id'] as String? ?? '',
      name: _text(json['name']),
      headline: _text(json['headline']),
      about: _text(json['about']),
      location: json['location'] == null ? null : _text(json['location']),
      specialties: _strings(
        json['specialties'],
      ).map(Specialty.fromName).toList(growable: false),
      languageCodes: _strings(json['languageCodes']),
      experienceYears: (json['experienceYears'] as num?)?.toInt() ?? 0,
      rating: (json['ratingAvg'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      ratePerMinute: ratePerMinute,
      consultationCount: (json['consultationCount'] as num?)?.toInt() ?? 0,
      followers: (json['followerCount'] as num?)?.toInt() ?? 0,
      recommendedPercent: (json['recommendedPercent'] as num?)?.toInt() ?? 0,
      isOnline: json['isOnline'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      queueLength: (json['queueLength'] as num?)?.toInt() ?? 0,
      isFollowing: json['isFollowing'] as bool? ?? false,
      avatarAsset: json['avatarKey'] as String?,
      ratingBreakdown: breakdown is Map
          ? {
              for (var star = 1; star <= 5; star++)
                star: (breakdown['$star'] as num?)?.toInt() ?? 0,
            }
          : const {},
    );
  }

  AstrologerReview _toReview(Map<String, dynamic> json) => AstrologerReview(
    id: json['id'] as String? ?? '',
    astrologerId: json['astrologerId'] as String? ?? '',
    authorName: json['authorName'] as String? ?? 'User',
    authorAvatar: json['authorAvatar'] as String?,
    rating: (json['rating'] as num?)?.toInt() ?? 0,
    comment: json['body'] as String? ?? '',
    createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
    reply: json['reply'] as String?,
    repliedAt: ApiTime.instant(json['repliedAt']),
  );

  static LocalizedText _text(Object? raw) {
    if (raw is String) return LocalizedText(en: raw, ne: raw);
    if (raw is! Map) return const LocalizedText(en: '', ne: '');
    final en = raw['en'] as String? ?? '';
    return LocalizedText(
      en: en,
      // English is the only guaranteed translation, so it is the fallback
      // rather than an empty string a screen would render as a blank name.
      ne: raw['ne'] as String? ?? en,
      hi: raw['hi'] as String? ?? '',
    );
  }

  static List<String> _strings(Object? raw) =>
      raw is List ? raw.whereType<String>().toList(growable: false) : const [];
}
