import '../../../../core/utils/result.dart';
import '../entities/legal_document.dart';

/// Read access to legal documents.
abstract interface class LegalRepository {
  Future<Result<LegalDocument>> getDocument(LegalDocumentType type);
}
