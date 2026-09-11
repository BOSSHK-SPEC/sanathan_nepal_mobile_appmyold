import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_parts.freezed.dart';

/// Plain year/month/day triple – meaning (traditional or Gregorian) depends
/// on the use case.
@freezed
abstract class DateParts with _$DateParts {
  const factory DateParts({
    required int year,
    required int month,
    required int day,
  }) = _DateParts;
}
