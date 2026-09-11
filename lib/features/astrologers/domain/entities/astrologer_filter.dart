import 'package:freezed_annotation/freezed_annotation.dart';

import 'consult_channel.dart';
import 'specialty.dart';

part 'astrologer_filter.freezed.dart';

/// Ordering applied to a filtered astrologer list.
enum AstrologerSort {
  recommended,
  ratingHigh,
  experienceHigh,
  priceLow,
  priceHigh,
  popularity;

  static AstrologerSort fromName(String? name) => AstrologerSort.values
      .firstWhere((s) => s.name == name, orElse: () => recommended);
}

/// Everything the discovery screen can narrow by.
///
/// One immutable value carried by the cubit; the filter sheet reports a whole
/// new instance rather than mutating, so "apply" and "reset" are trivial.
@freezed
abstract class AstrologerFilter with _$AstrologerFilter {
  const AstrologerFilter._();

  const factory AstrologerFilter({
    @Default('') String query,
    @Default({}) Set<Specialty> specialties,
    @Default({}) Set<String> languageCodes,
    @Default({}) Set<ConsultChannel> channels,

    /// Per-minute price ceiling; null means no ceiling.
    double? maxRate,
    @Default(0) double minRating,
    @Default(0) int minExperience,
    @Default(false) bool onlineOnly,

    /// Restricts to astrologers the seeker follows. Set by the Following
    /// screen rather than the filter sheet, so it is deliberately absent
    /// from [activeCount] and survives [cleared].
    @Default(false) bool followingOnly,
    @Default(AstrologerSort.recommended) AstrologerSort sort,
  }) = _AstrologerFilter;

  /// Number of *narrowing* filters in effect — drives the badge on the
  /// filter button. Sort and free-text query are not counted: they are shown
  /// elsewhere in the UI and would make the badge misleading.
  int get activeCount =>
      (specialties.isEmpty ? 0 : 1) +
      (languageCodes.isEmpty ? 0 : 1) +
      (channels.isEmpty ? 0 : 1) +
      (maxRate == null ? 0 : 1) +
      (minRating == 0 ? 0 : 1) +
      (minExperience == 0 ? 0 : 1) +
      (onlineOnly ? 1 : 0);

  bool get hasFilters => activeCount > 0;

  /// Clears the narrowing filters but keeps the query and sort, which the
  /// user set outside the sheet.
  AstrologerFilter cleared() =>
      AstrologerFilter(query: query, sort: sort, followingOnly: followingOnly);
}
