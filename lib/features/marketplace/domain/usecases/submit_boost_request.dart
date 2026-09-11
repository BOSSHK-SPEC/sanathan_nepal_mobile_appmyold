import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/boost_request.dart';
import '../repositories/boost_repository.dart';

/// Submits the "Boost your listing" form.
class SubmitBoostRequest implements UseCase<BoostReceipt, BoostRequest> {
  const SubmitBoostRequest(this._repo);
  final BoostRepository _repo;

  @override
  Future<Result<BoostReceipt>> call(BoostRequest params) =>
      _repo.submit(params);
}
