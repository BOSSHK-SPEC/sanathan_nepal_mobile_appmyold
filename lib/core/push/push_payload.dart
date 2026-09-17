/// What a push notification carries besides its title and body.
///
/// The transport hands over a `Map<String, dynamic>` written by the server —
/// but a notification is the one piece of app input that arrives from outside
/// the app's own request/response cycle, so nothing in it is trusted: the deep
/// link is validated to be an in-app route before anything navigates to it.
class PushPayload {
  const PushPayload({required this.kind, this.route, this.data = const {}});

  /// Matches the server's notification kind (`message`, `consultation`, …).
  final String kind;

  /// In-app route to open on tap, already validated. Null when there is none.
  final String? route;

  /// Everything else the server sent, as strings.
  final Map<String, String> data;

  /// Reads a payload from an FCM data map.
  factory PushPayload.fromData(Map<Object?, Object?> raw) {
    final data = <String, String>{
      for (final entry in raw.entries)
        if (entry.key != null && entry.value != null)
          entry.key.toString(): entry.value.toString(),
    };
    return PushPayload(
      kind: data['kind'] ?? 'general',
      route: safeRoute(data['route']),
      data: data,
    );
  }

  /// The thread this notification belongs to, when it is about a chat.
  String? get threadId => data['threadId'];

  /// An in-app path, or null.
  ///
  /// Only a single-slash absolute path is accepted. `https://…` would open a
  /// browser, `//evil.example` is protocol-relative and does the same, and a
  /// relative path would resolve against whatever screen happens to be open —
  /// a push is a message from the network, and none of those may be reachable
  /// from one.
  static String? safeRoute(String? value) {
    final route = value?.trim() ?? '';
    if (route.isEmpty || route.length > 300) return null;
    if (!route.startsWith('/') || route.startsWith('//')) return null;
    if (route.contains('..')) return null;
    return route;
  }

  @override
  String toString() => 'PushPayload(kind: $kind, route: $route)';
}
