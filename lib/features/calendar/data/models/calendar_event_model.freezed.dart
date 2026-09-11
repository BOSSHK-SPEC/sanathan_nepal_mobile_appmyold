// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarEventModel {

 String get id;@JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime get date; String get titleNe; String get titleEn; String get titleHi; String get descriptionNe; String get descriptionEn; String get descriptionHi; String get tithiNe; String get tithiEn; bool get isHoliday; String? get imageUrl;
/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventModelCopyWith<CalendarEventModel> get copyWith => _$CalendarEventModelCopyWithImpl<CalendarEventModel>(this as CalendarEventModel, _$identity);

  /// Serializes this CalendarEventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.descriptionNe, descriptionNe) || other.descriptionNe == descriptionNe)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionHi, descriptionHi) || other.descriptionHi == descriptionHi)&&(identical(other.tithiNe, tithiNe) || other.tithiNe == tithiNe)&&(identical(other.tithiEn, tithiEn) || other.tithiEn == tithiEn)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,titleNe,titleEn,titleHi,descriptionNe,descriptionEn,descriptionHi,tithiNe,tithiEn,isHoliday,imageUrl);

@override
String toString() {
  return 'CalendarEventModel(id: $id, date: $date, titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, descriptionNe: $descriptionNe, descriptionEn: $descriptionEn, descriptionHi: $descriptionHi, tithiNe: $tithiNe, tithiEn: $tithiEn, isHoliday: $isHoliday, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $CalendarEventModelCopyWith<$Res>  {
  factory $CalendarEventModelCopyWith(CalendarEventModel value, $Res Function(CalendarEventModel) _then) = _$CalendarEventModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime date, String titleNe, String titleEn, String titleHi, String descriptionNe, String descriptionEn, String descriptionHi, String tithiNe, String tithiEn, bool isHoliday, String? imageUrl
});




}
/// @nodoc
class _$CalendarEventModelCopyWithImpl<$Res>
    implements $CalendarEventModelCopyWith<$Res> {
  _$CalendarEventModelCopyWithImpl(this._self, this._then);

  final CalendarEventModel _self;
  final $Res Function(CalendarEventModel) _then;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? descriptionNe = null,Object? descriptionEn = null,Object? descriptionHi = null,Object? tithiNe = null,Object? tithiEn = null,Object? isHoliday = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,descriptionNe: null == descriptionNe ? _self.descriptionNe : descriptionNe // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionHi: null == descriptionHi ? _self.descriptionHi : descriptionHi // ignore: cast_nullable_to_non_nullable
as String,tithiNe: null == tithiNe ? _self.tithiNe : tithiNe // ignore: cast_nullable_to_non_nullable
as String,tithiEn: null == tithiEn ? _self.tithiEn : tithiEn // ignore: cast_nullable_to_non_nullable
as String,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _CalendarEventModel extends CalendarEventModel {
  const _CalendarEventModel({required this.id, @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) required this.date, this.titleNe = '', this.titleEn = '', this.titleHi = '', this.descriptionNe = '', this.descriptionEn = '', this.descriptionHi = '', this.tithiNe = '', this.tithiEn = '', this.isHoliday = false, this.imageUrl}): super._();
  factory _CalendarEventModel.fromJson(Map<String, dynamic> json) => _$CalendarEventModelFromJson(json);

@override final  String id;
@override@JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) final  DateTime date;
@override@JsonKey() final  String titleNe;
@override@JsonKey() final  String titleEn;
@override@JsonKey() final  String titleHi;
@override@JsonKey() final  String descriptionNe;
@override@JsonKey() final  String descriptionEn;
@override@JsonKey() final  String descriptionHi;
@override@JsonKey() final  String tithiNe;
@override@JsonKey() final  String tithiEn;
@override@JsonKey() final  bool isHoliday;
@override final  String? imageUrl;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEventModelCopyWith<_CalendarEventModel> get copyWith => __$CalendarEventModelCopyWithImpl<_CalendarEventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarEventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.descriptionNe, descriptionNe) || other.descriptionNe == descriptionNe)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionHi, descriptionHi) || other.descriptionHi == descriptionHi)&&(identical(other.tithiNe, tithiNe) || other.tithiNe == tithiNe)&&(identical(other.tithiEn, tithiEn) || other.tithiEn == tithiEn)&&(identical(other.isHoliday, isHoliday) || other.isHoliday == isHoliday)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,titleNe,titleEn,titleHi,descriptionNe,descriptionEn,descriptionHi,tithiNe,tithiEn,isHoliday,imageUrl);

@override
String toString() {
  return 'CalendarEventModel(id: $id, date: $date, titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, descriptionNe: $descriptionNe, descriptionEn: $descriptionEn, descriptionHi: $descriptionHi, tithiNe: $tithiNe, tithiEn: $tithiEn, isHoliday: $isHoliday, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$CalendarEventModelCopyWith<$Res> implements $CalendarEventModelCopyWith<$Res> {
  factory _$CalendarEventModelCopyWith(_CalendarEventModel value, $Res Function(_CalendarEventModel) _then) = __$CalendarEventModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime date, String titleNe, String titleEn, String titleHi, String descriptionNe, String descriptionEn, String descriptionHi, String tithiNe, String tithiEn, bool isHoliday, String? imageUrl
});




}
/// @nodoc
class __$CalendarEventModelCopyWithImpl<$Res>
    implements _$CalendarEventModelCopyWith<$Res> {
  __$CalendarEventModelCopyWithImpl(this._self, this._then);

  final _CalendarEventModel _self;
  final $Res Function(_CalendarEventModel) _then;

/// Create a copy of CalendarEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? descriptionNe = null,Object? descriptionEn = null,Object? descriptionHi = null,Object? tithiNe = null,Object? tithiEn = null,Object? isHoliday = null,Object? imageUrl = freezed,}) {
  return _then(_CalendarEventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,descriptionNe: null == descriptionNe ? _self.descriptionNe : descriptionNe // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionHi: null == descriptionHi ? _self.descriptionHi : descriptionHi // ignore: cast_nullable_to_non_nullable
as String,tithiNe: null == tithiNe ? _self.tithiNe : tithiNe // ignore: cast_nullable_to_non_nullable
as String,tithiEn: null == tithiEn ? _self.tithiEn : tithiEn // ignore: cast_nullable_to_non_nullable
as String,isHoliday: null == isHoliday ? _self.isHoliday : isHoliday // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
