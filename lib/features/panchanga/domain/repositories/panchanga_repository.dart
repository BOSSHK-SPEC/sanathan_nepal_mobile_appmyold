import '../../../../core/utils/result.dart';
import '../entities/panchanga.dart';
import '../entities/suva_sait.dart';

/// Read-side contract for panchanga and auspicious-timing data.
abstract interface class PanchangaRepository {
  Future<Result<Panchanga>> getPanchanga(DateTime date);
  Future<Result<List<SuvaSait>>> getSuvaSaits();
}
