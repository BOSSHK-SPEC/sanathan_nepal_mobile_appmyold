import '../../../../core/utils/result.dart';
import '../entities/converted_date.dart';
import '../entities/date_parts.dart';

/// Conversion contract between the active region's traditional calendar
/// (Bikram Sambat / Saka) and the Gregorian calendar – kept behind an
/// interface so the use cases / cubit stay testable and the layering is
/// uniform.
abstract interface class DateConversionRepository {
  Future<Result<ConvertedDate>> traditionalToGregorian(DateParts traditional);
  Future<Result<ConvertedDate>> gregorianToTraditional(DateParts gregorian);
}
