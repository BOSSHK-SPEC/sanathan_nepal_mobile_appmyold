import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/entities/suva_sait.dart';
import '../../domain/repositories/panchanga_repository.dart';
import '../datasources/panchanga_data_source.dart';

/// Default [PanchangaRepository] backed by a single [PanchangaDataSource].
class PanchangaRepositoryImpl implements PanchangaRepository {
  const PanchangaRepositoryImpl(this._source);
  final PanchangaDataSource _source;

  @override
  Future<Result<Panchanga>> getPanchanga(DateTime date) =>
      guard(() async => (await _source.fetchPanchanga(date)).toEntity());

  @override
  Future<Result<List<SuvaSait>>> getSuvaSaits() => guard(() async {
    final models = await _source.fetchSuvaSaits();
    return [for (final m in models) m.toEntity()];
  });
}
