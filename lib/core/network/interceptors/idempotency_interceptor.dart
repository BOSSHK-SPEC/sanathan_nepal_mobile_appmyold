import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

/// Supplies an `Idempotency-Key` for mutations that require one.
///
/// The server rejects a checkout, top-up, booking or payout without a key.
/// The key must be **stable across retries of the same logical attempt** — a
/// fresh key per HTTP retry would defeat the whole mechanism and create a
/// second order. So it is generated once, in `onRequest`, and stored on the
/// request options; Dio reuses those options when retrying, which keeps the
/// key with the attempt rather than the transmission.
///
/// A caller who needs to retry a *new* attempt simply issues a new request.
class IdempotencyInterceptor extends Interceptor {
  static const Uuid _uuid = Uuid();

  /// Paths whose mutations the server marks `@Idempotent()`.
  static const List<String> _requiresKey = [
    '/orders/checkout',
    '/wallet/topup',
    '/wallet/refunds',
    '/appointments',
    '/puja/bookings',
    '/reports/purchase',
    '/consultations',
    '/console/payouts',
    '/marketplace/boosts',
  ];

  static bool _needsKey(RequestOptions options) {
    if (options.method.toUpperCase() != 'POST') return false;
    final path = options.path;
    return _requiresKey.any((candidate) {
      if (!path.contains(candidate)) return false;
      // `/appointments` must match the create endpoint, not `/appointments/x/cancel`.
      final tail = path.substring(path.indexOf(candidate) + candidate.length);
      return tail.isEmpty || tail == '/';
    });
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_needsKey(options) && !options.headers.containsKey('Idempotency-Key')) {
      options.headers['Idempotency-Key'] = _uuid.v4();
    }
    handler.next(options);
  }
}
