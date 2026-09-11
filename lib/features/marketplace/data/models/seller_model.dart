import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/seller.dart';

part 'seller_model.freezed.dart';
part 'seller_model.g.dart';

/// Wire/persistence shape of [Seller].
@freezed
abstract class SellerModel with _$SellerModel {
  const SellerModel._();

  const factory SellerModel({
    required String id,
    required String name,
    String? avatar,
    @Default(false) bool verified,
    String? phone,
    String? handle,
  }) = _SellerModel;

  factory SellerModel.fromJson(Map<String, dynamic> json) =>
      _$SellerModelFromJson(json);

  factory SellerModel.fromEntity(Seller s) => SellerModel(
    id: s.id,
    name: s.name,
    avatar: s.avatar,
    verified: s.verified,
    phone: s.phone,
    handle: s.handle,
  );

  Seller toEntity() => Seller(
    id: id,
    name: name,
    avatar: avatar,
    verified: verified,
    phone: phone,
    handle: handle,
  );
}
