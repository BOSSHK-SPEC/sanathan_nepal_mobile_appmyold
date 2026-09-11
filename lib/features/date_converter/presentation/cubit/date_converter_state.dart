part of 'date_converter_cubit.dart';

/// Input + result state of the converter form.
@freezed
abstract class DateConverterState with _$DateConverterState {
  const DateConverterState._();

  const factory DateConverterState({
    @Default(ConversionDirection.traditionalToGregorian)
    ConversionDirection direction,

    /// Current picker values (traditional-calendar parts when [direction] is
    /// `traditionalToGregorian`, else Gregorian).
    required DateParts input,
    @Default(LoadState.idle()) LoadState<ConvertedDate> result,
  }) = _DateConverterState;

  bool get isTraditionalInput =>
      direction == ConversionDirection.traditionalToGregorian;
}
