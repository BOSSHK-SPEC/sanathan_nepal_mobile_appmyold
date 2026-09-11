import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/astrologer_repository.dart';

/// Languages actually present in the catalogue, so the filter sheet never
/// offers an option that can only return an empty list.
class GetConsultLanguages implements NoParamsUseCase<List<String>> {
  const GetConsultLanguages(this._repo);
  final AstrologerRepository _repo;

  @override
  Future<Result<List<String>>> call() => _repo.getLanguages();
}
