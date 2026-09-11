import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/boost_request.dart';
import '../../domain/repositories/boost_repository.dart';
import '../datasources/mock_boost_data_source.dart';

class BoostRepositoryImpl implements BoostRepository {
  BoostRepositoryImpl(this._source);
  final BoostDataSource _source;

  @override
  Future<Result<List<BoostPlan>>> getPlans() => guard(_source.fetchPlans);

  @override
  Future<Result<BoostReceipt>> submit(BoostRequest request) =>
      guard(() => _source.submit(request));
}
