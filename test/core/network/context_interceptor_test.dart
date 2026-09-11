import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/interceptors/context_interceptor.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';

/// The exact set the server's `regionSchema` accepts. Anything else is not
/// rejected — `RegionOf` falls back to Nepal — so a wrong header is invisible
/// until someone in India is quoted in rupees they do not use.
const _serverAcceptsRegions = {'NP', 'IN'};

RequestOptions _send(
  ContextInterceptor interceptor, {
  Map<String, dynamic>? headers,
}) {
  final options = RequestOptions(path: '/anything', headers: headers ?? {});
  interceptor.onRequest(options, RequestInterceptorHandler());
  return options;
}

void main() {
  ContextInterceptor interceptorFor(Region region) => ContextInterceptor(
    regions: FixedRegionResolver(region),
    languageCode: () => 'ne',
  );

  test('every region sends a code the server actually accepts', () {
    for (final region in Region.values) {
      final options = _send(interceptorFor(region));
      expect(
        _serverAcceptsRegions,
        contains(options.headers['X-Region']),
        reason: '${region.name} sends "${options.headers['X-Region']}"',
      );
    }
  });

  test('the header is the region code, not the enum name', () {
    expect(_send(interceptorFor(Region.nepal)).headers['X-Region'], 'NP');
    expect(_send(interceptorFor(Region.india)).headers['X-Region'], 'IN');
  });

  test('language is read per request, not captured once', () {
    var language = 'ne';
    final interceptor = ContextInterceptor(
      regions: const FixedRegionResolver(Region.nepal),
      languageCode: () => language,
    );

    expect(_send(interceptor).headers['Accept-Language'], 'ne');
    language = 'hi';
    expect(_send(interceptor).headers['Accept-Language'], 'hi');
  });

  test('each request carries its own trace id', () {
    final interceptor = interceptorFor(Region.nepal);
    final first = _send(interceptor).headers['X-Trace-Id'] as String;
    final second = _send(interceptor).headers['X-Trace-Id'] as String;

    expect(first, isNotEmpty);
    expect(first, isNot(second));
  });

  test('an explicit header set by a caller wins', () {
    // Retries and replays re-send the original request; regenerating the trace
    // id would break the link between the two attempts in the logs.
    final options = _send(
      interceptorFor(Region.nepal),
      headers: {'X-Trace-Id': 'kept', 'X-Region': 'IN'},
    );

    expect(options.headers['X-Trace-Id'], 'kept');
    expect(options.headers['X-Region'], 'IN');
  });
}
