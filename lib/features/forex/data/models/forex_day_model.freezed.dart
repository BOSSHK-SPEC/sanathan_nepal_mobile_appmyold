// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forex_day_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ForexDayModel {

@JsonKey(name: 'date', fromJson: _dateFromJson, toJson: _dateToJson) DateTime get date;@JsonKey(name: 'published_on', fromJson: _nullableDateFromJson, toJson: _nullableDateToJson) DateTime? get publishedOn;@JsonKey(name: 'rates') List<ForexRateModel> get rates;
/// Create a copy of ForexDayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForexDayModelCopyWith<ForexDayModel> get copyWith => _$ForexDayModelCopyWithImpl<ForexDayModel>(this as ForexDayModel, _$identity);

  /// Serializes this ForexDayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForexDayModel&&(identical(other.date, date) || other.date == date)&&(identical(other.publishedOn, publishedOn) || other.publishedOn == publishedOn)&&const DeepCollectionEquality().equals(other.rates, rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,publishedOn,const DeepCollectionEquality().hash(rates));

@override
String toString() {
  return 'ForexDayModel(date: $date, publishedOn: $publishedOn, rates: $rates)';
}


}

/// @nodoc
abstract mixin class $ForexDayModelCopyWith<$Res>  {
  factory $ForexDayModelCopyWith(ForexDayModel value, $Res Function(ForexDayModel) _then) = _$ForexDayModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date', fromJson: _dateFromJson, toJson: _dateToJson) DateTime date,@JsonKey(name: 'published_on', fromJson: _nullableDateFromJson, toJson: _nullableDateToJson) DateTime? publishedOn,@JsonKey(name: 'rates') List<ForexRateModel> rates
});




}
/// @nodoc
class _$ForexDayModelCopyWithImpl<$Res>
    implements $ForexDayModelCopyWith<$Res> {
  _$ForexDayModelCopyWithImpl(this._self, this._then);

  final ForexDayModel _self;
  final $Res Function(ForexDayModel) _then;

/// Create a copy of ForexDayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? publishedOn = freezed,Object? rates = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,publishedOn: freezed == publishedOn ? _self.publishedOn : publishedOn // ignore: cast_nullable_to_non_nullable
as DateTime?,rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as List<ForexRateModel>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _ForexDayModel extends ForexDayModel {
  const _ForexDayModel({@JsonKey(name: 'date', fromJson: _dateFromJson, toJson: _dateToJson) required this.date, @JsonKey(name: 'published_on', fromJson: _nullableDateFromJson, toJson: _nullableDateToJson) this.publishedOn, @JsonKey(name: 'rates') final  List<ForexRateModel> rates = const []}): _rates = rates,super._();
  factory _ForexDayModel.fromJson(Map<String, dynamic> json) => _$ForexDayModelFromJson(json);

@override@JsonKey(name: 'date', fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime date;
@override@JsonKey(name: 'published_on', fromJson: _nullableDateFromJson, toJson: _nullableDateToJson) final  DateTime? publishedOn;
 final  List<ForexRateModel> _rates;
@override@JsonKey(name: 'rates') List<ForexRateModel> get rates {
  if (_rates is EqualUnmodifiableListView) return _rates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rates);
}


/// Create a copy of ForexDayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForexDayModelCopyWith<_ForexDayModel> get copyWith => __$ForexDayModelCopyWithImpl<_ForexDayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForexDayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForexDayModel&&(identical(other.date, date) || other.date == date)&&(identical(other.publishedOn, publishedOn) || other.publishedOn == publishedOn)&&const DeepCollectionEquality().equals(other._rates, _rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,publishedOn,const DeepCollectionEquality().hash(_rates));

@override
String toString() {
  return 'ForexDayModel(date: $date, publishedOn: $publishedOn, rates: $rates)';
}


}

/// @nodoc
abstract mixin class _$ForexDayModelCopyWith<$Res> implements $ForexDayModelCopyWith<$Res> {
  factory _$ForexDayModelCopyWith(_ForexDayModel value, $Res Function(_ForexDayModel) _then) = __$ForexDayModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date', fromJson: _dateFromJson, toJson: _dateToJson) DateTime date,@JsonKey(name: 'published_on', fromJson: _nullableDateFromJson, toJson: _nullableDateToJson) DateTime? publishedOn,@JsonKey(name: 'rates') List<ForexRateModel> rates
});




}
/// @nodoc
class __$ForexDayModelCopyWithImpl<$Res>
    implements _$ForexDayModelCopyWith<$Res> {
  __$ForexDayModelCopyWithImpl(this._self, this._then);

  final _ForexDayModel _self;
  final $Res Function(_ForexDayModel) _then;

/// Create a copy of ForexDayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? publishedOn = freezed,Object? rates = null,}) {
  return _then(_ForexDayModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,publishedOn: freezed == publishedOn ? _self.publishedOn : publishedOn // ignore: cast_nullable_to_non_nullable
as DateTime?,rates: null == rates ? _self._rates : rates // ignore: cast_nullable_to_non_nullable
as List<ForexRateModel>,
  ));
}


}

// dart format on
