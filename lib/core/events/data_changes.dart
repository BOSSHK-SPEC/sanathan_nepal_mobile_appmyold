import 'dart:async';

/// What changed. Named for the data, not for a feature, so any feature can
/// announce a change or listen for one without importing another.
enum DataTopic { orders, appointments }

/// App-wide "this data changed" signal.
///
/// The bottom-nav tabs stay alive, and each loads its data once. Without a
/// signal they keep showing what they loaded: an order placed from the
/// marketplace never appeared under Profile › Activities, because that tab had
/// loaded before the order existed and nothing told it to look again.
///
/// The screen that makes a change announces it with [notify]; every screen
/// showing that data listens with [on] and reloads. Registered once in GetIt.
class DataChanges {
  final StreamController<DataTopic> _controller =
      StreamController<DataTopic>.broadcast();

  /// Every announced change.
  Stream<DataTopic> get stream => _controller.stream;

  /// Changes to any of [topics].
  Stream<DataTopic> on(Set<DataTopic> topics) => stream.where(topics.contains);

  void notify(DataTopic topic) {
    if (!_controller.isClosed) _controller.add(topic);
  }

  Future<void> dispose() => _controller.close();
}
