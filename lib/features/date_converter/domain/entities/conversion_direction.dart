/// Which way the converter works (traditional = the region's calendar:
/// Bikram Sambat in Nepal, Saka in India).
enum ConversionDirection {
  /// वि.सं./शक → ई.सं.
  traditionalToGregorian,

  /// ई.सं. → वि.सं./शक
  gregorianToTraditional,
}
