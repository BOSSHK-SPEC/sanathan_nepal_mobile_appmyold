// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metal_rates_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MetalRatesModel {

 double get gold; double get silver; String get currency; String get unit; DateTime get date;
/// Create a copy of MetalRatesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetalRatesModelCopyWith<MetalRatesModel> get copyWith => _$MetalRatesModelCopyWithImpl<MetalRatesModel>(this as MetalRatesModel, _$identity);

  /// Serializes this MetalRatesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetalRatesModel&&(identical(other.gold, gold) || other.gold == gold)&&(identical(other.silver, silver) || other.silver == silver)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gold,silver,currency,unit,date);

@override
String toString() {
  return 'MetalRatesModel(gold: $gold, silver: $silver, currency: $currency, unit: $unit, date: $date)';
}


}

/// @nodoc
abstract mixin class $MetalRatesModelCopyWith<$Res>  {
  factory $MetalRatesModelCopyWith(MetalRatesModel value, $Res Function(MetalRatesModel) _then) = _$MetalRatesModelCopyWithImpl;
@useResult
$Res call({
 double gold, double silver, String currency, String unit, DateTime date
});




}
/// @nodoc
class _$MetalRatesModelCopyWithImpl<$Res>
    implements $MetalRatesModelCopyWith<$Res> {
  _$MetalRatesModelCopyWithImpl(this._self, this._then);

  final MetalRatesModel _self;
  final $Res Function(MetalRatesModel) _then;

/// Create a copy of MetalRatesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gold = null,Object? silver = null,Object? currency = null,Object? unit = null,Object? date = null,}) {
  return _then(_self.copyWith(
gold: null == gold ? _self.gold : gold // ignore: cast_nullable_to_non_nullable
as double,silver: null == silver ? _self.silver : silver // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _MetalRatesModel extends MetalRatesModel {
  const _MetalRatesModel({required this.gold, required this.silver, this.currency = 'NPR', this.unit = 'tola', required this.date}): super._();
  factory _MetalRatesModel.fromJson(Map<String, dynamic> json) => _$MetalRatesModelFromJson(json);

@override final  double gold;
@override final  double silver;
@override@JsonKey() final  String currency;
@override@JsonKey() final  String unit;
@override final  DateTime date;

/// Create a copy of MetalRatesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetalRatesModelCopyWith<_MetalRatesModel> get copyWith => __$MetalRatesModelCopyWithImpl<_MetalRatesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MetalRatesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetalRatesModel&&(identical(other.gold, gold) || other.gold == gold)&&(identical(other.silver, silver) || other.silver == silver)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gold,silver,currency,unit,date);

@override
String toString() {
  return 'MetalRatesModel(gold: $gold, silver: $silver, currency: $currency, unit: $unit, date: $date)';
}


}

/// @nodoc
abstract mixin class _$MetalRatesModelCopyWith<$Res> implements $MetalRatesModelCopyWith<$Res> {
  factory _$MetalRatesModelCopyWith(_MetalRatesModel value, $Res Function(_MetalRatesModel) _then) = __$MetalRatesModelCopyWithImpl;
@override @useResult
$Res call({
 double gold, double silver, String currency, String unit, DateTime date
});




}
/// @nodoc
class __$MetalRatesModelCopyWithImpl<$Res>
    implements _$MetalRatesModelCopyWith<$Res> {
  __$MetalRatesModelCopyWithImpl(this._self, this._then);

  final _MetalRatesModel _self;
  final $Res Function(_MetalRatesModel) _then;

/// Create a copy of MetalRatesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gold = null,Object? silver = null,Object? currency = null,Object? unit = null,Object? date = null,}) {
  return _then(_MetalRatesModel(
gold: null == gold ? _self.gold : gold // ignore: cast_nullable_to_non_nullable
as double,silver: null == silver ? _self.silver : silver // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
