// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sitting_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SittingOption {

 String get id; SittingChannel get channel; LocalizedText get name;/// Whole-sitting price in the astrologer's currency (NPR / INR), i.e.
/// [ratePerMinute] × [durationMinutes] — formatted in presentation via
/// `RegionFormat.money`. The server re-computes this at booking time, so
/// it is a quote, never the authority.
 int get price;/// What the astrologer charges per minute, in the same currency.
///
/// Carried beside [price] so the UI can show where the total came from.
/// A bare "₹30,000" beside a profile advertising "from ₹1,000/min" reads
/// as a bug even when it is arithmetic — the two numbers are the same
/// fact, and the screen has to say so.
 double get ratePerMinute; LocalizedText get description; int get durationMinutes;
/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SittingOptionCopyWith<SittingOption> get copyWith => _$SittingOptionCopyWithImpl<SittingOption>(this as SittingOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SittingOption&&(identical(other.id, id) || other.id == id)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,id,channel,name,price,ratePerMinute,description,durationMinutes);

@override
String toString() {
  return 'SittingOption(id: $id, channel: $channel, name: $name, price: $price, ratePerMinute: $ratePerMinute, description: $description, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $SittingOptionCopyWith<$Res>  {
  factory $SittingOptionCopyWith(SittingOption value, $Res Function(SittingOption) _then) = _$SittingOptionCopyWithImpl;
@useResult
$Res call({
 String id, SittingChannel channel, LocalizedText name, int price, double ratePerMinute, LocalizedText description, int durationMinutes
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get description;

}
/// @nodoc
class _$SittingOptionCopyWithImpl<$Res>
    implements $SittingOptionCopyWith<$Res> {
  _$SittingOptionCopyWithImpl(this._self, this._then);

  final SittingOption _self;
  final $Res Function(SittingOption) _then;

/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? channel = null,Object? name = null,Object? price = null,Object? ratePerMinute = null,Object? description = null,Object? durationMinutes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as SittingChannel,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get description {
  
  return $LocalizedTextCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}



/// @nodoc


class _SittingOption implements SittingOption {
  const _SittingOption({required this.id, required this.channel, required this.name, required this.price, this.ratePerMinute = 0, required this.description, this.durationMinutes = 30});
  

@override final  String id;
@override final  SittingChannel channel;
@override final  LocalizedText name;
/// Whole-sitting price in the astrologer's currency (NPR / INR), i.e.
/// [ratePerMinute] × [durationMinutes] — formatted in presentation via
/// `RegionFormat.money`. The server re-computes this at booking time, so
/// it is a quote, never the authority.
@override final  int price;
/// What the astrologer charges per minute, in the same currency.
///
/// Carried beside [price] so the UI can show where the total came from.
/// A bare "₹30,000" beside a profile advertising "from ₹1,000/min" reads
/// as a bug even when it is arithmetic — the two numbers are the same
/// fact, and the screen has to say so.
@override@JsonKey() final  double ratePerMinute;
@override final  LocalizedText description;
@override@JsonKey() final  int durationMinutes;

/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SittingOptionCopyWith<_SittingOption> get copyWith => __$SittingOptionCopyWithImpl<_SittingOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SittingOption&&(identical(other.id, id) || other.id == id)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,id,channel,name,price,ratePerMinute,description,durationMinutes);

@override
String toString() {
  return 'SittingOption(id: $id, channel: $channel, name: $name, price: $price, ratePerMinute: $ratePerMinute, description: $description, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$SittingOptionCopyWith<$Res> implements $SittingOptionCopyWith<$Res> {
  factory _$SittingOptionCopyWith(_SittingOption value, $Res Function(_SittingOption) _then) = __$SittingOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, SittingChannel channel, LocalizedText name, int price, double ratePerMinute, LocalizedText description, int durationMinutes
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get description;

}
/// @nodoc
class __$SittingOptionCopyWithImpl<$Res>
    implements _$SittingOptionCopyWith<$Res> {
  __$SittingOptionCopyWithImpl(this._self, this._then);

  final _SittingOption _self;
  final $Res Function(_SittingOption) _then;

/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? channel = null,Object? name = null,Object? price = null,Object? ratePerMinute = null,Object? description = null,Object? durationMinutes = null,}) {
  return _then(_SittingOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as SittingChannel,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SittingOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get description {
  
  return $LocalizedTextCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}

// dart format on
