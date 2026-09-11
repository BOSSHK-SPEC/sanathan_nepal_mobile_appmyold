// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forex_rate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ForexCurrencyModel {

@JsonKey(name: 'iso3') String get iso3;@JsonKey(name: 'name') String? get name;@JsonKey(name: 'unit', fromJson: _unitFromJson) int get unit;
/// Create a copy of ForexCurrencyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForexCurrencyModelCopyWith<ForexCurrencyModel> get copyWith => _$ForexCurrencyModelCopyWithImpl<ForexCurrencyModel>(this as ForexCurrencyModel, _$identity);

  /// Serializes this ForexCurrencyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForexCurrencyModel&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.name, name) || other.name == name)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,iso3,name,unit);

@override
String toString() {
  return 'ForexCurrencyModel(iso3: $iso3, name: $name, unit: $unit)';
}


}

/// @nodoc
abstract mixin class $ForexCurrencyModelCopyWith<$Res>  {
  factory $ForexCurrencyModelCopyWith(ForexCurrencyModel value, $Res Function(ForexCurrencyModel) _then) = _$ForexCurrencyModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'iso3') String iso3,@JsonKey(name: 'name') String? name,@JsonKey(name: 'unit', fromJson: _unitFromJson) int unit
});




}
/// @nodoc
class _$ForexCurrencyModelCopyWithImpl<$Res>
    implements $ForexCurrencyModelCopyWith<$Res> {
  _$ForexCurrencyModelCopyWithImpl(this._self, this._then);

  final ForexCurrencyModel _self;
  final $Res Function(ForexCurrencyModel) _then;

/// Create a copy of ForexCurrencyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iso3 = null,Object? name = freezed,Object? unit = null,}) {
  return _then(_self.copyWith(
iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _ForexCurrencyModel extends ForexCurrencyModel {
  const _ForexCurrencyModel({@JsonKey(name: 'iso3') required this.iso3, @JsonKey(name: 'name') this.name, @JsonKey(name: 'unit', fromJson: _unitFromJson) this.unit = 1}): super._();
  factory _ForexCurrencyModel.fromJson(Map<String, dynamic> json) => _$ForexCurrencyModelFromJson(json);

@override@JsonKey(name: 'iso3') final  String iso3;
@override@JsonKey(name: 'name') final  String? name;
@override@JsonKey(name: 'unit', fromJson: _unitFromJson) final  int unit;

/// Create a copy of ForexCurrencyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForexCurrencyModelCopyWith<_ForexCurrencyModel> get copyWith => __$ForexCurrencyModelCopyWithImpl<_ForexCurrencyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForexCurrencyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForexCurrencyModel&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.name, name) || other.name == name)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,iso3,name,unit);

@override
String toString() {
  return 'ForexCurrencyModel(iso3: $iso3, name: $name, unit: $unit)';
}


}

/// @nodoc
abstract mixin class _$ForexCurrencyModelCopyWith<$Res> implements $ForexCurrencyModelCopyWith<$Res> {
  factory _$ForexCurrencyModelCopyWith(_ForexCurrencyModel value, $Res Function(_ForexCurrencyModel) _then) = __$ForexCurrencyModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'iso3') String iso3,@JsonKey(name: 'name') String? name,@JsonKey(name: 'unit', fromJson: _unitFromJson) int unit
});




}
/// @nodoc
class __$ForexCurrencyModelCopyWithImpl<$Res>
    implements _$ForexCurrencyModelCopyWith<$Res> {
  __$ForexCurrencyModelCopyWithImpl(this._self, this._then);

  final _ForexCurrencyModel _self;
  final $Res Function(_ForexCurrencyModel) _then;

/// Create a copy of ForexCurrencyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iso3 = null,Object? name = freezed,Object? unit = null,}) {
  return _then(_ForexCurrencyModel(
iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ForexRateModel {

@JsonKey(name: 'currency') ForexCurrencyModel get currency;@JsonKey(name: 'buy', fromJson: _doubleFromJson) double get buy;@JsonKey(name: 'sell', fromJson: _doubleFromJson) double get sell;
/// Create a copy of ForexRateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForexRateModelCopyWith<ForexRateModel> get copyWith => _$ForexRateModelCopyWithImpl<ForexRateModel>(this as ForexRateModel, _$identity);

  /// Serializes this ForexRateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForexRateModel&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.buy, buy) || other.buy == buy)&&(identical(other.sell, sell) || other.sell == sell));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,buy,sell);

@override
String toString() {
  return 'ForexRateModel(currency: $currency, buy: $buy, sell: $sell)';
}


}

/// @nodoc
abstract mixin class $ForexRateModelCopyWith<$Res>  {
  factory $ForexRateModelCopyWith(ForexRateModel value, $Res Function(ForexRateModel) _then) = _$ForexRateModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'currency') ForexCurrencyModel currency,@JsonKey(name: 'buy', fromJson: _doubleFromJson) double buy,@JsonKey(name: 'sell', fromJson: _doubleFromJson) double sell
});


$ForexCurrencyModelCopyWith<$Res> get currency;

}
/// @nodoc
class _$ForexRateModelCopyWithImpl<$Res>
    implements $ForexRateModelCopyWith<$Res> {
  _$ForexRateModelCopyWithImpl(this._self, this._then);

  final ForexRateModel _self;
  final $Res Function(ForexRateModel) _then;

/// Create a copy of ForexRateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? buy = null,Object? sell = null,}) {
  return _then(_self.copyWith(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as ForexCurrencyModel,buy: null == buy ? _self.buy : buy // ignore: cast_nullable_to_non_nullable
as double,sell: null == sell ? _self.sell : sell // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of ForexRateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForexCurrencyModelCopyWith<$Res> get currency {
  
  return $ForexCurrencyModelCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _ForexRateModel extends ForexRateModel {
  const _ForexRateModel({@JsonKey(name: 'currency') required this.currency, @JsonKey(name: 'buy', fromJson: _doubleFromJson) required this.buy, @JsonKey(name: 'sell', fromJson: _doubleFromJson) required this.sell}): super._();
  factory _ForexRateModel.fromJson(Map<String, dynamic> json) => _$ForexRateModelFromJson(json);

@override@JsonKey(name: 'currency') final  ForexCurrencyModel currency;
@override@JsonKey(name: 'buy', fromJson: _doubleFromJson) final  double buy;
@override@JsonKey(name: 'sell', fromJson: _doubleFromJson) final  double sell;

/// Create a copy of ForexRateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForexRateModelCopyWith<_ForexRateModel> get copyWith => __$ForexRateModelCopyWithImpl<_ForexRateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForexRateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForexRateModel&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.buy, buy) || other.buy == buy)&&(identical(other.sell, sell) || other.sell == sell));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,buy,sell);

@override
String toString() {
  return 'ForexRateModel(currency: $currency, buy: $buy, sell: $sell)';
}


}

/// @nodoc
abstract mixin class _$ForexRateModelCopyWith<$Res> implements $ForexRateModelCopyWith<$Res> {
  factory _$ForexRateModelCopyWith(_ForexRateModel value, $Res Function(_ForexRateModel) _then) = __$ForexRateModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'currency') ForexCurrencyModel currency,@JsonKey(name: 'buy', fromJson: _doubleFromJson) double buy,@JsonKey(name: 'sell', fromJson: _doubleFromJson) double sell
});


@override $ForexCurrencyModelCopyWith<$Res> get currency;

}
/// @nodoc
class __$ForexRateModelCopyWithImpl<$Res>
    implements _$ForexRateModelCopyWith<$Res> {
  __$ForexRateModelCopyWithImpl(this._self, this._then);

  final _ForexRateModel _self;
  final $Res Function(_ForexRateModel) _then;

/// Create a copy of ForexRateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? buy = null,Object? sell = null,}) {
  return _then(_ForexRateModel(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as ForexCurrencyModel,buy: null == buy ? _self.buy : buy // ignore: cast_nullable_to_non_nullable
as double,sell: null == sell ? _self.sell : sell // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ForexRateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ForexCurrencyModelCopyWith<$Res> get currency {
  
  return $ForexCurrencyModelCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}

// dart format on
