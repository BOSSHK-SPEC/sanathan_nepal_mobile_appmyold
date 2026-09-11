import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/legal_document.dart';
import '../repositories/legal_repository.dart';

/// Loads a [LegalDocument] of the given [LegalDocumentType].
class GetLegalDocument implements UseCase<LegalDocument, LegalDocumentType> {
  const GetLegalDocument(this._repo);
  final LegalRepository _repo;

  @override
  Future<Result<LegalDocument>> call(LegalDocumentType params) =>
      _repo.getDocument(params);
}
