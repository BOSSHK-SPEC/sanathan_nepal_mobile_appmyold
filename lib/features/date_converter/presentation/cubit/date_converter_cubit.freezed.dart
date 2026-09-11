// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_converter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DateConverterState {

 ConversionDirection get direction;/// Current picker values (traditional-calendar parts when [direction] is
/// `traditionalToGregorian`, else Gregorian).
 DateParts get input; LoadState<ConvertedDate> get result;
/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateConverterStateCopyWith<DateConverterState> get copyWith => _$DateConverterStateCopyWithImpl<DateConverterState>(this as DateConverterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateConverterState&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.input, input) || other.input == input)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,direction,input,result);

@override
String toString() {
  return 'DateConverterState(direction: $direction, input: $input, result: $result)';
}


}

/// @nodoc
abstract mixin class $DateConverterStateCopyWith<$Res>  {
  factory $DateConverterStateCopyWith(DateConverterState value, $Res Function(DateConverterState) _then) = _$DateConverterStateCopyWithImpl;
@useResult
$Res call({
 ConversionDirection direction, DateParts input, LoadState<ConvertedDate> result
});


$DatePartsCopyWith<$Res> get input;$LoadStateCopyWith<ConvertedDate, $Res> get result;

}
/// @nodoc
class _$DateConverterStateCopyWithImpl<$Res>
    implements $DateConverterStateCopyWith<$Res> {
  _$DateConverterStateCopyWithImpl(this._self, this._then);

  final DateConverterState _self;
  final $Res Function(DateConverterState) _then;

/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? direction = null,Object? input = null,Object? result = null,}) {
  return _then(_self.copyWith(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ConversionDirection,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as DateParts,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as LoadState<ConvertedDate>,
  ));
}
/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatePartsCopyWith<$Res> get input {
  
  return $DatePartsCopyWith<$Res>(_self.input, (value) {
    return _then(_self.copyWith(input: value));
  });
}/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConvertedDate, $Res> get result {
  
  return $LoadStateCopyWith<ConvertedDate, $Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}



/// @nodoc


class _DateConverterState extends DateConverterState {
  const _DateConverterState({this.direction = ConversionDirection.traditionalToGregorian, required this.input, this.result = const LoadState.idle()}): super._();
  

@override@JsonKey() final  ConversionDirection direction;
/// Current picker values (traditional-calendar parts when [direction] is
/// `traditionalToGregorian`, else Gregorian).
@override final  DateParts input;
@override@JsonKey() final  LoadState<ConvertedDate> result;

/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateConverterStateCopyWith<_DateConverterState> get copyWith => __$DateConverterStateCopyWithImpl<_DateConverterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateConverterState&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.input, input) || other.input == input)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,direction,input,result);

@override
String toString() {
  return 'DateConverterState(direction: $direction, input: $input, result: $result)';
}


}

/// @nodoc
abstract mixin class _$DateConverterStateCopyWith<$Res> implements $DateConverterStateCopyWith<$Res> {
  factory _$DateConverterStateCopyWith(_DateConverterState value, $Res Function(_DateConverterState) _then) = __$DateConverterStateCopyWithImpl;
@override @useResult
$Res call({
 ConversionDirection direction, DateParts input, LoadState<ConvertedDate> result
});


@override $DatePartsCopyWith<$Res> get input;@override $LoadStateCopyWith<ConvertedDate, $Res> get result;

}
/// @nodoc
class __$DateConverterStateCopyWithImpl<$Res>
    implements _$DateConverterStateCopyWith<$Res> {
  __$DateConverterStateCopyWithImpl(this._self, this._then);

  final _DateConverterState _self;
  final $Res Function(_DateConverterState) _then;

/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? direction = null,Object? input = null,Object? result = null,}) {
  return _then(_DateConverterState(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ConversionDirection,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as DateParts,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as LoadState<ConvertedDate>,
  ));
}

/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatePartsCopyWith<$Res> get input {
  
  return $DatePartsCopyWith<$Res>(_self.input, (value) {
    return _then(_self.copyWith(input: value));
  });
}/// Create a copy of DateConverterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConvertedDate, $Res> get result {
  
  return $LoadStateCopyWith<ConvertedDate, $Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
