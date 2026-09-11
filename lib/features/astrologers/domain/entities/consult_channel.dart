/// How a consultation is delivered.
///
/// Rates, availability and the astrologer's accept/reject flow are all
/// per-channel: someone may take chat all day but only schedule video.
enum ConsultChannel {
  chat,
  voice,
  video;

  static ConsultChannel fromName(String? name) => ConsultChannel.values
      .firstWhere((c) => c.name == name, orElse: () => ConsultChannel.chat);
}
