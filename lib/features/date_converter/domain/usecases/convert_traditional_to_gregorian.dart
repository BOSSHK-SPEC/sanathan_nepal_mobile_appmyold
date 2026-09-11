import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/converted_date.dart';
import '../entities/date_parts.dart';
import '../repositories/date_conversion_repository.dart';

/// वि.सं./शक → ई.सं.
class ConvertTraditionalToGregorian
    implements UseCase<ConvertedDate, DateParts> {
  const ConvertTraditionalToGregorian(this._repo);
  final DateConversionRepository _repo;

  @override
  Future<Result<ConvertedDate>> call(DateParts params) =>
      _repo.traditionalToGregorian(params);
}
