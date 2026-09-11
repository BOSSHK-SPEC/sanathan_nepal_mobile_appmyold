import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/forex_rate.dart';
import 'forex_rate_model.dart';

part 'forex_day_model.freezed.dart';
part 'forex_day_model.g.dart';

/// One element of the NRB `payload` array: a publication date with all
/// currency quotes for that day (`{date, published_on, rates:[…]}`).
@freezed
abstract class ForexDayModel with _$ForexDayModel {
  const ForexDayModel._();

  const factory ForexDayModel({
    @JsonKey(name: 'date', fromJson: _dateFromJson, toJson: _dateToJson)
    required DateTime date,
    @JsonKey(
      name: 'published_on',
      fromJson: _nullableDateFromJson,
      toJson: _nullableDateToJson,
    )
    DateTime? publishedOn,
    @JsonKey(name: 'rates') @Default([]) List<ForexRateModel> rates,
  }) = _ForexDayModel;

  factory ForexDayModel.fromJson(Map<String, dynamic> json) =>
      _$ForexDayModelFromJson(json);

  /// Groups same-day [rates] into a day model.
  factory ForexDayModel.fromEntities(DateTime date, List<ForexRate> rates) =>
      ForexDayModel(
        date: date,
        publishedOn: date,
        rates: [for (final r in rates) ForexRateModel.fromEntity(r)],
      );

  /// All quotes of the day stamped with [date].
  List<ForexRate> toEntities() => [for (final r in rates) r.toEntity(date)];

  /// Parses `{data:{payload:[…]}}` into a list of days (oldest first).
  static List<ForexDayModel> listFromResponse(Map<String, dynamic> json) {
    final data = json['data'];
    final payload = data is Map ? data['payload'] : null;
    if (payload is! List) return const [];
    final days =
        payload
            .whereType<Map<String, dynamic>>()
            .map(ForexDayModel.fromJson)
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));
    return days;
  }
}

DateTime _dateFromJson(Object? v) =>
    DateTime.tryParse(v?.toString() ?? '') ?? DateTime.now();

String _dateToJson(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

DateTime? _nullableDateFromJson(Object? v) =>
    v == null ? null : DateTime.tryParse(v.toString());

String? _nullableDateToJson(DateTime? d) => d?.toIso8601String();
