import '../models/panchanga_model.dart';
import '../models/suva_sait_model.dart';

/// I/O boundary for panchanga data (mock or remote).
abstract interface class PanchangaDataSource {
  Future<PanchangaModel> fetchPanchanga(DateTime date);
  Future<List<SuvaSaitModel>> fetchSuvaSaits();
}
