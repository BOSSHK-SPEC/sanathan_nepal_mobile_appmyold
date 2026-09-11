import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/currency.dart';
import '../models/forex_day_model.dart';
import '../models/forex_rate_model.dart';
import 'forex_remote_data_source.dart';

/// INR forex source for the India region: the free, key-less Frankfurter API
/// (ECB reference rates, business days only).
///
/// * Latest: `GET https://api.frankfurter.app/latest?from=USD&to=INR,EUR,…`
///   → `{amount, base, date, rates:{INR: 83.1, EUR: 0.92, …}}`
/// * History: `GET https://api.frankfurter.app/2026-07-18..2026-08-18?from=USD&to=…`
///   → `{…, start_date, end_date, rates:{"2026-07-18":{INR:…, EUR:…}, …}}`
///
/// Every quote is requested with `USD` as base (best precision) and turned
/// into "INR per [Currency.unit] units of X" via `INR/USD ÷ X/USD`.
///
/// The ECB publishes mid-market reference rates only, so buy / sell are
/// derived with a symmetric ±0.25 % spread (`buy = mid × 0.9975`,
/// `sell = mid × 1.0025`) to match the NRB-style [ForexRateModel] shape.
class FrankfurterForexRemoteDataSource
    with RangeForexHistory
    implements ForexRemoteDataSource {
  const FrankfurterForexRemoteDataSource(
    this._client, {
    this.catalogue = Currency.ecb,
    this.local = Currency.inr,
  });

  final ApiClient _client;

  /// Currencies to quote (must be supported by Frankfurter / the ECB).
  final List<Currency> catalogue;

  /// Quote currency (INR).
  final Currency local;

  static const String baseUrl = 'https://api.frankfurter.app';
  static const String _base = 'USD';
  static const double buySpread = 0.9975;
  static const double sellSpread = 1.0025;

  @override
  Future<List<ForexDayModel>> fetchRates({
    required DateTime from,
    required DateTime to,
  }) async {
    final symbols = <String>{
      local.iso3,
      for (final c in catalogue)
        if (c.iso3 != _base) c.iso3,
    };
    final sameDay = _fmt(from) == _fmt(to);
    final path = sameDay
        ? '$baseUrl/latest'
        : '$baseUrl/${_fmt(from)}..${_fmt(to)}';
    Map<String, dynamic> data;
    try {
      final response = await _client.get<Map<String, dynamic>>(
        path,
        query: <String, dynamic>{'from': _base, 'to': symbols.join(',')},
      );
      final body = response.data;
      if (body == null || response.statusCode != 200) {
        throw ServerException('Frankfurter error', response.statusCode);
      }
      data = body;
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
    final days = parse(data, catalogue: catalogue, local: local);
    if (days.isEmpty) throw const NotFoundException('No rates published');
    return days;
  }

  /// Parses either the `latest` or the range payload into days (oldest
  /// first). Exposed for tests.
  static List<ForexDayModel> parse(
    Map<String, dynamic> json, {
    List<Currency> catalogue = Currency.ecb,
    Currency local = Currency.inr,
  }) {
    final rates = json['rates'];
    if (rates is! Map) return const [];
    final days = <ForexDayModel>[];
    final firstValue = rates.values.firstOrNull;
    if (firstValue is Map) {
      // Range payload: date → {ISO: rate}.
      for (final entry in rates.entries) {
        final date = DateTime.tryParse(entry.key.toString());
        final quotes = entry.value;
        if (date == null || quotes is! Map) continue;
        days.add(_day(date, quotes, catalogue, local));
      }
    } else {
      // Latest payload: {ISO: rate} with a top-level date.
      final date = DateTime.tryParse(json['date']?.toString() ?? '');
      if (date != null) days.add(_day(date, rates, catalogue, local));
    }
    days.sort((a, b) => a.date.compareTo(b.date));
    return days;
  }

  static ForexDayModel _day(
    DateTime date,
    Map<dynamic, dynamic> perUsd,
    List<Currency> catalogue,
    Currency local,
  ) {
    final localPerUsd = _num(perUsd[local.iso3]);
    final rates = <ForexRateModel>[];
    if (localPerUsd != null && localPerUsd > 0) {
      for (final c in catalogue) {
        final double? mid;
        if (c.iso3 == _base) {
          mid = localPerUsd;
        } else {
          final cPerUsd = _num(perUsd[c.iso3]);
          mid = cPerUsd == null || cPerUsd <= 0 ? null : localPerUsd / cPerUsd;
        }
        if (mid == null) continue;
        final perUnit = mid * c.unit;
        rates.add(
          ForexRateModel(
            currency: ForexCurrencyModel.fromEntity(c),
            buy: _round(perUnit * buySpread),
            sell: _round(perUnit * sellSpread),
          ),
        );
      }
    }
    return ForexDayModel(date: date, publishedOn: date, rates: rates);
  }

  static double? _num(Object? v) => switch (v) {
    final num n => n.toDouble(),
    final String s => double.tryParse(s),
    _ => null,
  };

  static double _round(double v) => double.parse(v.toStringAsFixed(4));

  static String _fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
