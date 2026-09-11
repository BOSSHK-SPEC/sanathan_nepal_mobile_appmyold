// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sitting_option_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SittingOptionModel {

 String get id; SittingChannel get channel; LocalizedTextModel get name; int get price; double get ratePerMinute; LocalizedTextModel get description; int get durationMinutes;
/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SittingOptionModelCopyWith<SittingOptionModel> get copyWith => _$SittingOptionModelCopyWithImpl<SittingOptionModel>(this as SittingOptionModel, _$identity);

  /// Serializes this SittingOptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SittingOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channel,name,price,ratePerMinute,description,durationMinutes);

@override
String toString() {
  return 'SittingOptionModel(id: $id, channel: $channel, name: $name, price: $price, ratePerMinute: $ratePerMinute, description: $description, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $SittingOptionModelCopyWith<$Res>  {
  factory $SittingOptionModelCopyWith(SittingOptionModel value, $Res Function(SittingOptionModel) _then) = _$SittingOptionModelCopyWithImpl;
@useResult
$Res call({
 String id, SittingChannel channel, LocalizedTextModel name, int price, double ratePerMinute, LocalizedTextModel description, int durationMinutes
});


$LocalizedTextModelCopyWith<$Res> get name;$LocalizedTextModelCopyWith<$Res> get description;

}
/// @nodoc
class _$SittingOptionModelCopyWithImpl<$Res>
    implements $SittingOptionModelCopyWith<$Res> {
  _$SittingOptionModelCopyWithImpl(this._self, this._then);

  final SittingOptionModel _self;
  final $Res Function(SittingOptionModel) _then;

/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? channel = null,Object? name = null,Object? price = null,Object? ratePerMinute = null,Object? description = null,Object? durationMinutes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as SittingChannel,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get name {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get description {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _SittingOptionModel extends SittingOptionModel {
  const _SittingOptionModel({required this.id, this.channel = SittingChannel.chat, required this.name, required this.price, this.ratePerMinute = 0, required this.description, this.durationMinutes = 30}): super._();
  factory _SittingOptionModel.fromJson(Map<String, dynamic> json) => _$SittingOptionModelFromJson(json);

@override final  String id;
@override@JsonKey() final  SittingChannel channel;
@override final  LocalizedTextModel name;
@override final  int price;
@override@JsonKey() final  double ratePerMinute;
@override final  LocalizedTextModel description;
@override@JsonKey() final  int durationMinutes;

/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SittingOptionModelCopyWith<_SittingOptionModel> get copyWith => __$SittingOptionModelCopyWithImpl<_SittingOptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SittingOptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SittingOptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,channel,name,price,ratePerMinute,description,durationMinutes);

@override
String toString() {
  return 'SittingOptionModel(id: $id, channel: $channel, name: $name, price: $price, ratePerMinute: $ratePerMinute, description: $description, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$SittingOptionModelCopyWith<$Res> implements $SittingOptionModelCopyWith<$Res> {
  factory _$SittingOptionModelCopyWith(_SittingOptionModel value, $Res Function(_SittingOptionModel) _then) = __$SittingOptionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, SittingChannel channel, LocalizedTextModel name, int price, double ratePerMinute, LocalizedTextModel description, int durationMinutes
});


@override $LocalizedTextModelCopyWith<$Res> get name;@override $LocalizedTextModelCopyWith<$Res> get description;

}
/// @nodoc
class __$SittingOptionModelCopyWithImpl<$Res>
    implements _$SittingOptionModelCopyWith<$Res> {
  __$SittingOptionModelCopyWithImpl(this._self, this._then);

  final _SittingOptionModel _self;
  final $Res Function(_SittingOptionModel) _then;

/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? channel = null,Object? name = null,Object? price = null,Object? ratePerMinute = null,Object? description = null,Object? durationMinutes = null,}) {
  return _then(_SittingOptionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as SittingChannel,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get name {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SittingOptionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get description {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}

// dart format on
