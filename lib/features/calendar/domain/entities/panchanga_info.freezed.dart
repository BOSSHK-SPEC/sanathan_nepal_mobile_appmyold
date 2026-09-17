// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panchanga_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PanchangaInfo {

 LunarDay get lunarDay; String get nakshatraNe; String get nakshatraEn; String get karanNe; String get karanEn; String get yogNe; String get yogEn; String get chandraRashiNe; String get chandraRashiEn;/// Wall-clock times at the region's default city.
 DateTime get sunrise; DateTime get sunset;/// True for the on-device estimate; false once the server's calculation
/// has replaced it.
 bool get isApproximate;
/// Create a copy of PanchangaInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanchangaInfoCopyWith<PanchangaInfo> get copyWith => _$PanchangaInfoCopyWithImpl<PanchangaInfo>(this as PanchangaInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PanchangaInfo&&(identical(other.lunarDay, lunarDay) || other.lunarDay == lunarDay)&&(identical(other.nakshatraNe, nakshatraNe) || other.nakshatraNe == nakshatraNe)&&(identical(other.nakshatraEn, nakshatraEn) || other.nakshatraEn == nakshatraEn)&&(identical(other.karanNe, karanNe) || other.karanNe == karanNe)&&(identical(other.karanEn, karanEn) || other.karanEn == karanEn)&&(identical(other.yogNe, yogNe) || other.yogNe == yogNe)&&(identical(other.yogEn, yogEn) || other.yogEn == yogEn)&&(identical(other.chandraRashiNe, chandraRashiNe) || other.chandraRashiNe == chandraRashiNe)&&(identical(other.chandraRashiEn, chandraRashiEn) || other.chandraRashiEn == chandraRashiEn)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.isApproximate, isApproximate) || other.isApproximate == isApproximate));
}


@override
int get hashCode => Object.hash(runtimeType,lunarDay,nakshatraNe,nakshatraEn,karanNe,karanEn,yogNe,yogEn,chandraRashiNe,chandraRashiEn,sunrise,sunset,isApproximate);

@override
String toString() {
  return 'PanchangaInfo(lunarDay: $lunarDay, nakshatraNe: $nakshatraNe, nakshatraEn: $nakshatraEn, karanNe: $karanNe, karanEn: $karanEn, yogNe: $yogNe, yogEn: $yogEn, chandraRashiNe: $chandraRashiNe, chandraRashiEn: $chandraRashiEn, sunrise: $sunrise, sunset: $sunset, isApproximate: $isApproximate)';
}


}

/// @nodoc
abstract mixin class $PanchangaInfoCopyWith<$Res>  {
  factory $PanchangaInfoCopyWith(PanchangaInfo value, $Res Function(PanchangaInfo) _then) = _$PanchangaInfoCopyWithImpl;
@useResult
$Res call({
 LunarDay lunarDay, String nakshatraNe, String nakshatraEn, String karanNe, String karanEn, String yogNe, String yogEn, String chandraRashiNe, String chandraRashiEn, DateTime sunrise, DateTime sunset, bool isApproximate
});


$LunarDayCopyWith<$Res> get lunarDay;

}
/// @nodoc
class _$PanchangaInfoCopyWithImpl<$Res>
    implements $PanchangaInfoCopyWith<$Res> {
  _$PanchangaInfoCopyWithImpl(this._self, this._then);

  final PanchangaInfo _self;
  final $Res Function(PanchangaInfo) _then;

/// Create a copy of PanchangaInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lunarDay = null,Object? nakshatraNe = null,Object? nakshatraEn = null,Object? karanNe = null,Object? karanEn = null,Object? yogNe = null,Object? yogEn = null,Object? chandraRashiNe = null,Object? chandraRashiEn = null,Object? sunrise = null,Object? sunset = null,Object? isApproximate = null,}) {
  return _then(_self.copyWith(
lunarDay: null == lunarDay ? _self.lunarDay : lunarDay // ignore: cast_nullable_to_non_nullable
as LunarDay,nakshatraNe: null == nakshatraNe ? _self.nakshatraNe : nakshatraNe // ignore: cast_nullable_to_non_nullable
as String,nakshatraEn: null == nakshatraEn ? _self.nakshatraEn : nakshatraEn // ignore: cast_nullable_to_non_nullable
as String,karanNe: null == karanNe ? _self.karanNe : karanNe // ignore: cast_nullable_to_non_nullable
as String,karanEn: null == karanEn ? _self.karanEn : karanEn // ignore: cast_nullable_to_non_nullable
as String,yogNe: null == yogNe ? _self.yogNe : yogNe // ignore: cast_nullable_to_non_nullable
as String,yogEn: null == yogEn ? _self.yogEn : yogEn // ignore: cast_nullable_to_non_nullable
as String,chandraRashiNe: null == chandraRashiNe ? _self.chandraRashiNe : chandraRashiNe // ignore: cast_nullable_to_non_nullable
as String,chandraRashiEn: null == chandraRashiEn ? _self.chandraRashiEn : chandraRashiEn // ignore: cast_nullable_to_non_nullable
as String,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,isApproximate: null == isApproximate ? _self.isApproximate : isApproximate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PanchangaInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LunarDayCopyWith<$Res> get lunarDay {
  
  return $LunarDayCopyWith<$Res>(_self.lunarDay, (value) {
    return _then(_self.copyWith(lunarDay: value));
  });
}
}



/// @nodoc


class _PanchangaInfo extends PanchangaInfo {
  const _PanchangaInfo({required this.lunarDay, required this.nakshatraNe, required this.nakshatraEn, required this.karanNe, required this.karanEn, required this.yogNe, required this.yogEn, required this.chandraRashiNe, required this.chandraRashiEn, required this.sunrise, required this.sunset, this.isApproximate = true}): super._();
  

@override final  LunarDay lunarDay;
@override final  String nakshatraNe;
@override final  String nakshatraEn;
@override final  String karanNe;
@override final  String karanEn;
@override final  String yogNe;
@override final  String yogEn;
@override final  String chandraRashiNe;
@override final  String chandraRashiEn;
/// Wall-clock times at the region's default city.
@override final  DateTime sunrise;
@override final  DateTime sunset;
/// True for the on-device estimate; false once the server's calculation
/// has replaced it.
@override@JsonKey() final  bool isApproximate;

/// Create a copy of PanchangaInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanchangaInfoCopyWith<_PanchangaInfo> get copyWith => __$PanchangaInfoCopyWithImpl<_PanchangaInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PanchangaInfo&&(identical(other.lunarDay, lunarDay) || other.lunarDay == lunarDay)&&(identical(other.nakshatraNe, nakshatraNe) || other.nakshatraNe == nakshatraNe)&&(identical(other.nakshatraEn, nakshatraEn) || other.nakshatraEn == nakshatraEn)&&(identical(other.karanNe, karanNe) || other.karanNe == karanNe)&&(identical(other.karanEn, karanEn) || other.karanEn == karanEn)&&(identical(other.yogNe, yogNe) || other.yogNe == yogNe)&&(identical(other.yogEn, yogEn) || other.yogEn == yogEn)&&(identical(other.chandraRashiNe, chandraRashiNe) || other.chandraRashiNe == chandraRashiNe)&&(identical(other.chandraRashiEn, chandraRashiEn) || other.chandraRashiEn == chandraRashiEn)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.isApproximate, isApproximate) || other.isApproximate == isApproximate));
}


@override
int get hashCode => Object.hash(runtimeType,lunarDay,nakshatraNe,nakshatraEn,karanNe,karanEn,yogNe,yogEn,chandraRashiNe,chandraRashiEn,sunrise,sunset,isApproximate);

@override
String toString() {
  return 'PanchangaInfo(lunarDay: $lunarDay, nakshatraNe: $nakshatraNe, nakshatraEn: $nakshatraEn, karanNe: $karanNe, karanEn: $karanEn, yogNe: $yogNe, yogEn: $yogEn, chandraRashiNe: $chandraRashiNe, chandraRashiEn: $chandraRashiEn, sunrise: $sunrise, sunset: $sunset, isApproximate: $isApproximate)';
}


}

/// @nodoc
abstract mixin class _$PanchangaInfoCopyWith<$Res> implements $PanchangaInfoCopyWith<$Res> {
  factory _$PanchangaInfoCopyWith(_PanchangaInfo value, $Res Function(_PanchangaInfo) _then) = __$PanchangaInfoCopyWithImpl;
@override @useResult
$Res call({
 LunarDay lunarDay, String nakshatraNe, String nakshatraEn, String karanNe, String karanEn, String yogNe, String yogEn, String chandraRashiNe, String chandraRashiEn, DateTime sunrise, DateTime sunset, bool isApproximate
});


@override $LunarDayCopyWith<$Res> get lunarDay;

}
/// @nodoc
class __$PanchangaInfoCopyWithImpl<$Res>
    implements _$PanchangaInfoCopyWith<$Res> {
  __$PanchangaInfoCopyWithImpl(this._self, this._then);

  final _PanchangaInfo _self;
  final $Res Function(_PanchangaInfo) _then;

/// Create a copy of PanchangaInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lunarDay = null,Object? nakshatraNe = null,Object? nakshatraEn = null,Object? karanNe = null,Object? karanEn = null,Object? yogNe = null,Object? yogEn = null,Object? chandraRashiNe = null,Object? chandraRashiEn = null,Object? sunrise = null,Object? sunset = null,Object? isApproximate = null,}) {
  return _then(_PanchangaInfo(
lunarDay: null == lunarDay ? _self.lunarDay : lunarDay // ignore: cast_nullable_to_non_nullable
as LunarDay,nakshatraNe: null == nakshatraNe ? _self.nakshatraNe : nakshatraNe // ignore: cast_nullable_to_non_nullable
as String,nakshatraEn: null == nakshatraEn ? _self.nakshatraEn : nakshatraEn // ignore: cast_nullable_to_non_nullable
as String,karanNe: null == karanNe ? _self.karanNe : karanNe // ignore: cast_nullable_to_non_nullable
as String,karanEn: null == karanEn ? _self.karanEn : karanEn // ignore: cast_nullable_to_non_nullable
as String,yogNe: null == yogNe ? _self.yogNe : yogNe // ignore: cast_nullable_to_non_nullable
as String,yogEn: null == yogEn ? _self.yogEn : yogEn // ignore: cast_nullable_to_non_nullable
as String,chandraRashiNe: null == chandraRashiNe ? _self.chandraRashiNe : chandraRashiNe // ignore: cast_nullable_to_non_nullable
as String,chandraRashiEn: null == chandraRashiEn ? _self.chandraRashiEn : chandraRashiEn // ignore: cast_nullable_to_non_nullable
as String,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,isApproximate: null == isApproximate ? _self.isApproximate : isApproximate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PanchangaInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LunarDayCopyWith<$Res> get lunarDay {
  
  return $LunarDayCopyWith<$Res>(_self.lunarDay, (value) {
    return _then(_self.copyWith(lunarDay: value));
  });
}
}

// dart format on
