import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../region/region_resolver.dart';

/// Adds the per-request headers the server expects on every call.
///
/// * `X-Region` — which region's pricing, calendar and payment rails apply.
///   Before sign-in this is the only signal; afterwards the account's region
///   wins server-side, so sending it is harmless and correct in both states.
/// * `X-Trace-Id` — a client-generated id echoed back on the response and
///   stamped on every server log line for that request. Generating it here
///   means a crash report and a server log can be joined on one value.
/// * `Accept-Language` — used for localized upstream content.
class ContextInterceptor extends Interceptor {
  ContextInterceptor({
    required RegionResolver regions,
    required String Function() languageCode,
  }) : _regions = regions,
       _languageCode = languageCode;

  final RegionResolver _regions;
  final String Function() _languageCode;
  static const Uuid _uuid = Uuid();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // `code`, never the enum's Dart name: the server accepts NP/IN and
    // silently falls back to NP for anything else, so a wrong value here is
    // not an error — it is an Indian user quietly served Nepali content.
    options.headers.putIfAbsent('X-Region', () => _regions.region.code);
    options.headers.putIfAbsent('X-Trace-Id', () => _uuid.v4());
    options.headers.putIfAbsent('Accept-Language', _languageCode);
    handler.next(options);
  }
}
