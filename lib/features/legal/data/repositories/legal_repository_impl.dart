import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/legal_document.dart';
import '../../domain/repositories/legal_repository.dart';
import '../datasources/legal_local_data_source.dart';

/// [LegalRepository] backed by a local/bundled data source.
class LegalRepositoryImpl implements LegalRepository {
  LegalRepositoryImpl(this._local);
  final LegalLocalDataSource _local;

  @override
  Future<Result<LegalDocument>> getDocument(LegalDocumentType type) =>
      guard(() async => (await _local.fetch(type)).toEntity());
}
