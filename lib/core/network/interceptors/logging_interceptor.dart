import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Request logging for development.
///
/// Prints the complete API URL (including host and base URL), headers, query parameters,
/// request payload, execution duration, and response body in the console/DevTools.
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor({required this.logBodies});

  final bool logBodies;

  static const Set<String> _redacted = {'authorization', 'cookie', 'x-api-key'};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startedAt'] = DateTime.now().millisecondsSinceEpoch;
    final fullUrl = options.uri.toString();

    final logBuffer = StringBuffer();
    logBuffer.writeln(
      '\n======================================================',
    );
    logBuffer.writeln('🚀 [FRONTEND API REQUEST] ${options.method} $fullUrl');

    if (logBodies) {
      final headers = options.headers.map(
        (key, value) => MapEntry(
          key,
          _redacted.contains(key.toLowerCase()) ? '[REDACTED]' : value,
        ),
      );
      logBuffer.writeln('Headers: ${_prettyJson(headers)}');
      if (options.queryParameters.isNotEmpty) {
        logBuffer.writeln(
          'Query Params: ${_prettyJson(options.queryParameters)}',
        );
      }
      if (options.data != null) {
        logBuffer.writeln('Payload: ${_prettyJson(options.data)}');
      }
    }
    logBuffer.writeln('======================================================');

    final message = logBuffer.toString();
    developer.log(message, name: 'api');
    if (kDebugMode) {
      // Print to standard console so it shows in terminal/IDE debug console
      print(message);
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final fullUrl = response.requestOptions.uri.toString();
    final elapsed = _elapsed(response.requestOptions);

    final logBuffer = StringBuffer();
    logBuffer.writeln(
      '\n======================================================',
    );
    logBuffer.writeln(
      '✅ [FRONTEND API RESPONSE] ${response.statusCode} ${response.requestOptions.method} $fullUrl (${elapsed}ms)',
    );
    if (logBodies && response.data != null) {
      logBuffer.writeln('Response Body: ${_prettyJson(response.data)}');
    }
    logBuffer.writeln('======================================================');

    final message = logBuffer.toString();
    developer.log(message, name: 'api');
    if (kDebugMode) {
      print(message);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final fullUrl = err.requestOptions.uri.toString();
    final traceId = err.response?.headers.value('x-trace-id');
    final statusCode = err.response?.statusCode ?? err.type.name;

    final logBuffer = StringBuffer();
    logBuffer.writeln(
      '\n======================================================',
    );
    logBuffer.writeln(
      '❌ [FRONTEND API ERROR] $statusCode ${err.requestOptions.method} $fullUrl (trace=$traceId)',
    );
    if (logBodies && err.response?.data != null) {
      logBuffer.writeln('Error Body: ${_prettyJson(err.response?.data)}');
    }
    logBuffer.writeln('======================================================');

    final message = logBuffer.toString();
    developer.log(message, name: 'api', error: err);
    if (kDebugMode) {
      print(message);
    }

    handler.next(err);
  }

  int _elapsed(RequestOptions options) {
    final startedAt = options.extra['startedAt'] as int?;
    if (startedAt == null) return 0;
    return DateTime.now().millisecondsSinceEpoch - startedAt;
  }

  String _prettyJson(dynamic json) {
    try {
      if (json is String) {
        final decoded = jsonDecode(json);
        return const JsonEncoder.withIndent('  ').convert(decoded);
      }
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (_) {
      return json.toString();
    }
  }
}
