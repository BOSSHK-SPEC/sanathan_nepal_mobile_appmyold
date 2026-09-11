import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../../domain/entities/astrologer_review.dart';
import 'astrologer_data_source.dart';
import 'astrologer_review_seed.dart';
import 'astrologer_seed_india.dart';
import 'astrologer_seed_nepal.dart';

/// Deterministic in-memory catalogue.
///
/// Filtering and sorting run here rather than in the cubit on purpose: this
/// is exactly the work a real backend will do, so swapping in an HTTP data
/// source later changes no other layer.
///
/// Follows, submitted reviews and recent searches persist through
/// [KeyValueStore] so they survive a restart the way a real account would.
class MockAstrologerDataSource implements AstrologerDataSource {
  MockAstrologerDataSource(this._store, this._regions);

  final KeyValueStore _store;
  final RegionResolver _regions;

  static const _followsKey = 'astrologers.follows';
  static const _reviewsKey = 'astrologers.reviews';
  static const _searchesKey = 'astrologers.searches';
  static const _maxRecentSearches = 8;

  static const Duration _latency = Duration(milliseconds: 220);

  List<Astrologer> get _catalogue => switch (_regions.region) {
    Region.nepal => nepalAstrologers,
    Region.india => indiaAstrologers,
  };

  Set<String> get _follows =>
      (_store.getStringList(_followsKey) ?? const <String>[]).toSet();

  List<Astrologer> get _withFollowState {
    final follows = _follows;
    return [
      for (final a in _catalogue)
        follows.contains(a.id) ? a.copyWith(isFollowing: true) : a,
    ];
  }

  @override
  Future<List<Astrologer>> getAstrologers(AstrologerFilter filter) async {
    await Future<void>.delayed(_latency);
    final matched = _withFollowState.where((a) => _matches(a, filter)).toList();
    _sort(matched, filter.sort);
    return matched;
  }

  bool _matches(Astrologer a, AstrologerFilter f) {
    if (f.followingOnly && !a.isFollowing) return false;
    if (f.onlineOnly && !a.isOnline) return false;
    if (a.rating < f.minRating) return false;
    if (a.experienceYears < f.minExperience) return false;
    if (f.maxRate != null && a.lowestRate > f.maxRate!) return false;
    if (f.specialties.isNotEmpty &&
        !a.specialties.any(f.specialties.contains)) {
      return false;
    }
    if (f.languageCodes.isNotEmpty &&
        !a.languageCodes.any(f.languageCodes.contains)) {
      return false;
    }
    if (f.channels.isNotEmpty && !a.channels.any(f.channels.contains)) {
      return false;
    }
    if (f.query.trim().isNotEmpty && !_matchesQuery(a, f.query)) return false;
    return true;
  }

  /// Matches across every language so a Nepali speaker can still find an
  /// astrologer by typing the English name and vice versa.
  bool _matchesQuery(Astrologer a, String query) {
    final q = query.trim().toLowerCase();
    final haystack = [
      a.name.ne,
      a.name.en,
      a.name.hi ?? '',
      a.headline.ne,
      a.headline.en,
      a.headline.hi ?? '',
      ...a.specialties.map((s) => s.name),
      a.location?.en ?? '',
      a.location?.ne ?? '',
    ].join(' ').toLowerCase();
    return haystack.contains(q);
  }

  void _sort(List<Astrologer> list, AstrologerSort sort) {
    switch (sort) {
      case AstrologerSort.recommended:
        // Online first, then rating, then volume — the ordering a marketplace
        // actually wants, since an offline five-star profile cannot convert.
        list.sort((a, b) {
          final presence = _presenceRank(a).compareTo(_presenceRank(b));
          if (presence != 0) return presence;
          final rating = b.rating.compareTo(a.rating);
          if (rating != 0) return rating;
          return b.consultationCount.compareTo(a.consultationCount);
        });
      case AstrologerSort.ratingHigh:
        list.sort((a, b) {
          final r = b.rating.compareTo(a.rating);
          return r != 0 ? r : b.reviewCount.compareTo(a.reviewCount);
        });
      case AstrologerSort.experienceHigh:
        list.sort((a, b) => b.experienceYears.compareTo(a.experienceYears));
      case AstrologerSort.priceLow:
        list.sort((a, b) => a.lowestRate.compareTo(b.lowestRate));
      case AstrologerSort.priceHigh:
        list.sort((a, b) => b.lowestRate.compareTo(a.lowestRate));
      case AstrologerSort.popularity:
        list.sort((a, b) => b.followers.compareTo(a.followers));
    }
  }

  /// 0 = free now, 1 = online with a queue, 2 = offline.
  int _presenceRank(Astrologer a) {
    if (!a.isOnline) return 2;
    return a.queueLength == 0 ? 0 : 1;
  }

  @override
  Future<Astrologer> getAstrologer(String id) async {
    await Future<void>.delayed(_latency);
    final match = _withFollowState.where((a) => a.id == id).toList();
    if (match.isEmpty) {
      throw NotFoundException('No astrologer with id "$id"');
    }
    return match.first;
  }

  @override
  Future<List<String>> getLanguages() async {
    await Future<void>.delayed(_latency);
    return {for (final a in _catalogue) ...a.languageCodes}.toList()..sort();
  }

  @override
  Future<List<AstrologerReview>> getReviews(String astrologerId) async {
    await Future<void>.delayed(_latency);
    final seeded = astrologerReviewSeed
        .where((r) => r.astrologerId == astrologerId)
        .toList();
    final submitted = _readSubmitted()
        .where((r) => r.astrologerId == astrologerId)
        .toList();
    return [...submitted, ...seeded]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<AstrologerReview> submitReview(ReviewDraft draft) async {
    await Future<void>.delayed(_latency);
    if (draft.rating < 1 || draft.rating > 5) {
      throw const ValidationException('Rating must be between 1 and 5');
    }
    final review = AstrologerReview(
      id: 'r-${DateTime.now().microsecondsSinceEpoch}',
      astrologerId: draft.astrologerId,
      authorName: 'You',
      rating: draft.rating,
      comment: draft.comment,
      tags: draft.tags,
      consultationId: draft.consultationId,
      createdAt: DateTime.now(),
    );
    final all = _readSubmitted()..insert(0, review);
    await _writeSubmitted(all);
    return review;
  }

  @override
  Future<String?> reviewableConsultationId(String astrologerId) async {
    // Demo mode has no consultation history to check against, so reviewing is
    // always offered — the point of the mock is to exercise the screen.
    return 'mock-consultation-$astrologerId';
  }

  @override
  Future<bool> toggleFollow(String astrologerId) async {
    await Future<void>.delayed(_latency);
    final follows = _follows;
    final following = !follows.remove(astrologerId);
    if (following) follows.add(astrologerId);
    await _store.setStringList(_followsKey, follows.toList());
    return following;
  }

  @override
  Future<void> report(ReportDraft draft) async {
    await Future<void>.delayed(_latency);
    if (draft.reason == ReportReason.other && draft.details.trim().isEmpty) {
      throw const ValidationException(
        'Tell us what happened so we can look into it',
      );
    }
    // Nothing to persist client-side: a report is a server-side record.
  }

  @override
  Future<List<String>> recentSearches() async =>
      _store.getStringList(_searchesKey) ?? const [];

  @override
  Future<void> saveSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final existing = [...?_store.getStringList(_searchesKey)]
      ..removeWhere((q) => q.toLowerCase() == trimmed.toLowerCase())
      ..insert(0, trimmed);
    await _store.setStringList(
      _searchesKey,
      existing.take(_maxRecentSearches).toList(),
    );
  }

  @override
  Future<void> clearSearches() => _store.remove(_searchesKey);

  List<AstrologerReview> _readSubmitted() {
    final raw = _store.getString(_reviewsKey);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return [
      for (final e in decoded)
        AstrologerReview(
          id: e['id'] as String,
          astrologerId: e['astrologerId'] as String,
          authorName: e['authorName'] as String,
          rating: e['rating'] as int,
          comment: e['comment'] as String,
          tags: (e['tags'] as List<dynamic>).cast<String>(),
          consultationId: e['consultationId'] as String?,
          createdAt: DateTime.parse(e['createdAt'] as String),
        ),
    ];
  }

  Future<void> _writeSubmitted(List<AstrologerReview> reviews) =>
      _store.setString(
        _reviewsKey,
        jsonEncode([
          for (final r in reviews)
            {
              'id': r.id,
              'astrologerId': r.astrologerId,
              'authorName': r.authorName,
              'rating': r.rating,
              'comment': r.comment,
              'tags': r.tags,
              'consultationId': r.consultationId,
              'createdAt': r.createdAt.toIso8601String(),
            },
        ]),
      );
}
