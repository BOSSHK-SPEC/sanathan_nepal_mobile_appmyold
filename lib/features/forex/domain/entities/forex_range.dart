/// Trend chart time window (Figma pills "1 W / 1 M / 1 Y").
enum ForexRange {
  week(7),
  month(30),
  year(365);

  const ForexRange(this.days);
  final int days;
}
