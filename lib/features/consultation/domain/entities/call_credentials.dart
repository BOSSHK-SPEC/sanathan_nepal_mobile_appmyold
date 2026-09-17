import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_credentials.freezed.dart';

/// Permission to join one live call, issued by the server for one person.
///
/// Short-lived and single-room by design: it is the only thing standing
/// between a call and anyone who learns the room's name, so it is fetched per
/// join and never cached to disk.
@freezed
abstract class CallCredentials with _$CallCredentials {
  const CallCredentials._();

  const factory CallCredentials({
    /// The media server the device connects to, e.g. `wss://calls.example.com`.
    required String url,
    required String token,
    required String room,

    /// Who the other side sees us as — the signed-in user's id.
    required String identity,
    DateTime? expiresAt,
  }) = _CallCredentials;

  bool get isUsable => url.isNotEmpty && token.isNotEmpty;
}
