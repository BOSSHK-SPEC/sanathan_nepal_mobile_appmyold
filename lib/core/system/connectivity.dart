import 'dart:async';

/// Whether the device can reach the network.
///
/// An interface rather than a package call so the offline banner can be
/// built and tested now, and `connectivity_plus` dropped in later without
/// touching any screen.
abstract interface class ConnectivityStatus {
  /// Current state, checked on demand.
  Future<bool> isOnline();

  /// Emits on every change. Implementations must emit the current value
  /// immediately on subscription so a listener never starts blank.
  Stream<bool> get onChanged;
}

/// Assumes connectivity. Replace with a real implementation when the
/// platform plugin lands.
class AlwaysOnlineConnectivity implements ConnectivityStatus {
  const AlwaysOnlineConnectivity();

  @override
  Future<bool> isOnline() async => true;

  @override
  Stream<bool> get onChanged => Stream<bool>.value(true);
}

/// Controllable implementation for tests and previews.
class FakeConnectivity implements ConnectivityStatus {
  FakeConnectivity({bool online = true}) : _online = online {
    _controller.add(_online);
  }

  bool _online;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  set online(bool value) {
    _online = value;
    _controller.add(value);
  }

  @override
  Future<bool> isOnline() async => _online;

  @override
  Stream<bool> get onChanged async* {
    yield _online;
    yield* _controller.stream;
  }

  Future<void> dispose() => _controller.close();
}
