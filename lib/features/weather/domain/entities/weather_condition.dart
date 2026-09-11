/// Normalised weather condition derived from a WMO weather-interpretation
/// code (as returned by Open-Meteo `weather_code`).
///
/// Each value knows its icon asset (day / night variant) and a trilingual
/// (English / Nepali / Hindi) label so presentation never has to switch on
/// raw codes.
enum WeatherCondition {
  clear,
  mainlyClear,
  partlyCloudy,
  overcast,
  fog,
  drizzle,
  rain,
  heavyRain,
  showers,
  snow,
  thunderstorm;

  /// Maps a WMO code (0–99) to a [WeatherCondition].
  static WeatherCondition fromWmo(int code) => switch (code) {
    0 => clear,
    1 => mainlyClear,
    2 => partlyCloudy,
    3 => overcast,
    45 || 48 => fog,
    51 || 53 || 55 || 56 || 57 => drizzle,
    61 || 63 || 66 => rain,
    65 || 67 => heavyRain,
    71 || 73 || 75 || 77 || 85 || 86 => snow,
    80 || 81 || 82 => showers,
    95 || 96 || 99 => thunderstorm,
    _ => partlyCloudy,
  };

  static const String _dir = 'assets/icons/weather';

  /// Icon asset for this condition. Night variants exist for clear-ish skies.
  String iconAsset({bool isDay = true}) => switch (this) {
    clear => isDay ? '$_dir/sun.svg' : '$_dir/moon.svg',
    mainlyClear => isDay ? '$_dir/sun.svg' : '$_dir/moon.svg',
    partlyCloudy =>
      isDay ? '$_dir/partly_cloudy.svg' : '$_dir/partly_cloudy_night.svg',
    overcast => '$_dir/cloudy.svg',
    fog => '$_dir/fog.svg',
    drizzle => '$_dir/drizzle.svg',
    rain => '$_dir/rain.svg',
    heavyRain => '$_dir/heavy_rain.svg',
    showers => '$_dir/showers.svg',
    snow => '$_dir/snow.svg',
    thunderstorm => '$_dir/thunder.svg',
  };

  String get labelEn => switch (this) {
    clear => 'Clear',
    mainlyClear => 'Mainly Clear',
    partlyCloudy => 'Partly Cloudy',
    overcast => 'Overcast',
    fog => 'Foggy',
    drizzle => 'Drizzle',
    rain => 'Rain',
    heavyRain => 'Heavy Rain',
    showers => 'Rain Showers',
    snow => 'Snow',
    thunderstorm => 'Thunderstorm',
  };

  String get labelNe => switch (this) {
    clear => 'सफा आकाश',
    mainlyClear => 'प्रायः सफा',
    partlyCloudy => 'आंशिक बादल',
    overcast => 'बादल लागेको',
    fog => 'कुहिरो',
    drizzle => 'सिमसिम पानी',
    rain => 'वर्षा',
    heavyRain => 'भारी वर्षा',
    showers => 'झरी',
    snow => 'हिमपात',
    thunderstorm => 'चट्याङसहित वर्षा',
  };

  String get labelHi => switch (this) {
    clear => 'साफ़ आसमान',
    mainlyClear => 'अधिकतर साफ़',
    partlyCloudy => 'आंशिक बादल',
    overcast => 'घने बादल',
    fog => 'कोहरा',
    drizzle => 'बूंदाबांदी',
    rain => 'बारिश',
    heavyRain => 'भारी बारिश',
    showers => 'बौछारें',
    snow => 'हिमपात',
    thunderstorm => 'आंधी-तूफ़ान',
  };

  /// Label for [languageCode] (`en` / `ne` / `hi`).
  String label({required String languageCode}) => switch (languageCode) {
    'ne' => labelNe,
    'hi' => labelHi,
    _ => labelEn,
  };
}
