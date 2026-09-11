import 'package:freezed_annotation/freezed_annotation.dart';

part 'astrologer_client.freezed.dart';

/// Someone the astrologer has consulted, from their side of the ledger.
@freezed
abstract class AstrologerClient with _$AstrologerClient {
  const AstrologerClient._();

  const factory AstrologerClient({
    required String id,
    required String name,
    required int sessionCount,
    required double lifetimeValue,
    required DateTime lastSessionAt,
    String? avatar,

    /// Birth details the seeker supplied, so a returning client does not
    /// have to repeat them.
    String? birthDetails,

    /// The astrologer's own running notes about this client.
    @Default('') String notes,
    double? averageRating,
  }) = _AstrologerClient;

  bool get isRepeat => sessionCount > 1;

  double get averageSessionValue =>
      sessionCount == 0 ? 0 : lifetimeValue / sessionCount;
}
