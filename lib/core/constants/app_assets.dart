/// Centralised asset paths. Feature-specific assets live in
/// `assets/images/<feature>/` and `assets/icons/<feature>/`.
abstract final class AppAssets {
  static const String _img = 'assets/images';
  static const String _ico = 'assets/icons';

  static String image(String name) => '$_img/$name';
  static String icon(String name) => '$_ico/$name';

  // Shared
  static const String logo = '$_img/logo.png';
  static const String flagNepal = '$_img/nepal_icon.png';
  static const String flagUsa = '$_img/usa-icon.png';
  static const String flagUk = '$_img/england_icon.png';
}
