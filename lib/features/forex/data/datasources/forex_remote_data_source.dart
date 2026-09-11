import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/forex_day_model.dart';

/// I/O contract for daily rate tables. Implemented by the NRB and ECB clients,
/// by the backend client and by [MockForexDataSource].
abstract interface class ForexRemoteDataSource {
  /// All published days between [from] and [to] (inclusive), oldest first.
  Future<List<ForexDayModel>> fetchRates({
    required DateTime from,
    required DateTime to,
  });

  /// Days carrying a quote for [iso3] only, oldest first.
  ///
  /// Separate from [fetchRates] because sources that can answer "one currency
  /// over N days" directly (our backend does) should not be made to download
  /// every currency for every day just so the caller can throw most of it away.
  Future<List<ForexDayModel>> fetchHistory({
    required String iso3,
    required DateTime from,
    required DateTime to,
  });
}

/// [ForexRemoteDataSource.fetchHistory] for sources that only speak in date
/// ranges: fetch the range and let the repository pick the currency out.
mixin RangeForexHistory {
  Future<List<ForexDayModel>> fetchRates({
    required DateTime from,
    required DateTime to,
  });

  Future<List<ForexDayModel>> fetchHistory({
    required String iso3,
    required DateTime from,
    required DateTime to,
  }) => fetchRates(from: from, to: to);
}

/// Nepal Rastra Bank forex API:
/// `GET /rates?page=1&per_page=100&from=YYYY-MM-DD&to=YYYY-MM-DD`.
class NrbForexRemoteDataSource
    with RangeForexHistory
    implements ForexRemoteDataSource {
  const NrbForexRemoteDataSource(this._client);
  final ApiClient _client;

  static const String _path = '/rates';
  static const int _perPage = 100;
  static const int _maxPages = 5;

  @override
  Future<List<ForexDayModel>> fetchRates({
    required DateTime from,
    required DateTime to,
  }) async {
    final days = <ForexDayModel>[];
    try {
      for (var page = 1; page <= _maxPages; page++) {
        final response = await _client.get<Map<String, dynamic>>(
          _path,
          query: <String, dynamic>{
            'page': page,
            'per_page': _perPage,
            'from': _fmt(from),
            'to': _fmt(to),
          },
        );
        final data = response.data;
        if (data == null || response.statusCode != 200) {
          throw ServerException('NRB error', response.statusCode);
        }
        final batch = ForexDayModel.listFromResponse(data);
        days.addAll(batch);
        if (batch.length < _perPage) break;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException(e.message ?? 'No internet connection');
      }
      throw ServerException(
        e.message ?? 'Server error',
        e.response?.statusCode,
      );
    }
    if (days.isEmpty) throw const NotFoundException('No rates published');
    days.sort((a, b) => a.date.compareTo(b.date));
    return days;
  }

  static String _fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
