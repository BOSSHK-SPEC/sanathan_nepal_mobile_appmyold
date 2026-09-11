/// Time span a horoscope prediction covers (दैनिक / साप्ताहिक / मासिक / वार्षिक).
enum HoroscopePeriod {
  daily(nameNe: 'दैनिक', nameEn: 'Daily', nameHi: 'दैनिक'),
  weekly(nameNe: 'साप्ताहिक', nameEn: 'Weekly', nameHi: 'साप्ताहिक'),
  monthly(nameNe: 'मासिक', nameEn: 'Monthly', nameHi: 'मासिक'),
  yearly(nameNe: 'वार्षिक', nameEn: 'Yearly', nameHi: 'वार्षिक');

  const HoroscopePeriod({
    required this.nameNe,
    required this.nameEn,
    required this.nameHi,
  });

  final String nameNe;
  final String nameEn;
  final String nameHi;

  String label({required bool nepali}) => nepali ? nameNe : nameEn;

  /// Label for a language code (`ne`, `hi`, otherwise English).
  String labelFor(String languageCode) => switch (languageCode) {
    'ne' => nameNe,
    'hi' => nameHi,
    _ => nameEn,
  };
}
