import 'package:freezed_annotation/freezed_annotation.dart';

part 'seller.freezed.dart';

/// Seller / poster of a marketplace listing.
@freezed
abstract class Seller with _$Seller {
  const factory Seller({
    required String id,
    required String name,
    String? avatar,
    @Default(false) bool verified,
    String? phone,
    String? handle,
  }) = _Seller;
}
