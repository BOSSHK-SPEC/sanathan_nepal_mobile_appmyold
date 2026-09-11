import '../../../../core/utils/result.dart';
import '../entities/boost_request.dart';

/// "Boost Post to sell quickly" submissions.
abstract interface class BoostRepository {
  Future<Result<List<BoostPlan>>> getPlans();
  Future<Result<BoostReceipt>> submit(BoostRequest request);
}
