import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';
import '../../../../core/utils/localized_text_model.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/consult_channel.dart';
import '../../domain/entities/specialty.dart';

part 'astrologer_model.freezed.dart';
part 'astrologer_model.g.dart';

/// Wire shape of [Astrologer].
///
/// Enum-keyed maps have no JSON representation, so [ratePerMinute] and
/// [ratingBreakdown] travel as string-keyed maps and are converted here.
@freezed
abstract class AstrologerModel with _$AstrologerModel {
  const AstrologerModel._();

  const factory AstrologerModel({
    required String id,
    required LocalizedTextModel name,
    required LocalizedTextModel headline,
    required LocalizedTextModel about,
    @Default([]) List<String> specialties,
    @Default([]) List<String> languageCodes,
    @Default(0) int experienceYears,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default({}) Map<String, double> ratePerMinute,
    @Default(0) int consultationCount,
    @Default(0) int followers,
    @Default(0) int recommendedPercent,
    @Default(false) bool isOnline,
    @Default(false) bool isVerified,
    @Default(0) int queueLength,
    @Default(false) bool isFollowing,
    String? avatarAsset,
    LocalizedTextModel? location,
    @Default({}) Map<String, int> ratingBreakdown,
  }) = _AstrologerModel;

  factory AstrologerModel.fromJson(Map<String, dynamic> json) =>
      _$AstrologerModelFromJson(json);

  factory AstrologerModel.fromEntity(Astrologer e) => AstrologerModel(
    id: e.id,
    name: LocalizedTextModel.fromEntity(e.name),
    headline: LocalizedTextModel.fromEntity(e.headline),
    about: LocalizedTextModel.fromEntity(e.about),
    specialties: e.specialties.map((s) => s.name).toList(),
    languageCodes: e.languageCodes,
    experienceYears: e.experienceYears,
    rating: e.rating,
    reviewCount: e.reviewCount,
    ratePerMinute: e.ratePerMinute.map((k, v) => MapEntry(k.name, v)),
    consultationCount: e.consultationCount,
    followers: e.followers,
    recommendedPercent: e.recommendedPercent,
    isOnline: e.isOnline,
    isVerified: e.isVerified,
    queueLength: e.queueLength,
    isFollowing: e.isFollowing,
    avatarAsset: e.avatarAsset,
    location: e.location == null
        ? null
        : LocalizedTextModel.fromEntity(e.location!),
    ratingBreakdown: e.ratingBreakdown.map((k, v) => MapEntry('$k', v)),
  );

  Astrologer toEntity() => Astrologer(
    id: id,
    name: name.toEntity(),
    headline: headline.toEntity(),
    about: about.toEntity(),
    specialties: specialties.map(Specialty.fromName).toList(),
    languageCodes: languageCodes,
    experienceYears: experienceYears,
    rating: rating,
    reviewCount: reviewCount,
    ratePerMinute: {
      for (final e in ratePerMinute.entries)
        ConsultChannel.fromName(e.key): e.value,
    },
    consultationCount: consultationCount,
    followers: followers,
    recommendedPercent: recommendedPercent,
    isOnline: isOnline,
    isVerified: isVerified,
    queueLength: queueLength,
    isFollowing: isFollowing,
    avatarAsset: avatarAsset,
    location: location?.toEntity(),
    ratingBreakdown: {
      for (final e in ratingBreakdown.entries) ?int.tryParse(e.key): e.value,
    },
  );
}

/// Convenience for seeds and tests.
extension LocalizedTextSeedX on LocalizedText {
  LocalizedTextModel get asModel => LocalizedTextModel.fromEntity(this);
}
