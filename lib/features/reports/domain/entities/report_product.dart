import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';

part 'report_product.freezed.dart';

/// What a report covers. Drives the icon, the ordering and — for matching —
/// whether a second birth profile has to be collected before checkout.
enum ReportKind { life, career, marriage, yearAhead, matchMaking, remedies }

/// A report the seeker can buy.
@freezed
abstract class ReportProduct with _$ReportProduct {
  const ReportProduct._();

  const factory ReportProduct({
    required String id,
    required ReportKind kind,
    required LocalizedText title,
    required LocalizedText summary,
    required double price,

    /// Pages in the generated PDF — the honest proxy for how much a buyer
    /// gets, and the number they compare across products.
    required int pageCount,

    /// Section headings, so the buyer sees what is inside before paying.
    @Default(<LocalizedText>[]) List<LocalizedText> contents,

    /// Struck-through original price when discounted.
    double? originalPrice,

    /// How long generation takes. Reports are not instant and saying so up
    /// front prevents a support ticket per purchase.
    @Default(Duration(minutes: 10)) Duration deliveryTime,

    /// Matching reports need the partner's birth details as well.
    @Default(false) bool needsSecondProfile,
    @Default(false) bool isPopular,
  }) = _ReportProduct;

  bool get isDiscounted => originalPrice != null && originalPrice! > price;

  int get discountPercent => isDiscounted
      ? (((originalPrice! - price) / originalPrice!) * 100).round()
      : 0;
}
