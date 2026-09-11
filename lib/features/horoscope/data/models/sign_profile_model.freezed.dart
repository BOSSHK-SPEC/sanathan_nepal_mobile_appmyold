// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignProfileModel {

 String get aboutNe; String get aboutEn; String get aboutHi; List<SignProfileTabModel> get tabs; HoroscopeMediaModel get luckyMedia;
/// Create a copy of SignProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignProfileModelCopyWith<SignProfileModel> get copyWith => _$SignProfileModelCopyWithImpl<SignProfileModel>(this as SignProfileModel, _$identity);

  /// Serializes this SignProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignProfileModel&&(identical(other.aboutNe, aboutNe) || other.aboutNe == aboutNe)&&(identical(other.aboutEn, aboutEn) || other.aboutEn == aboutEn)&&(identical(other.aboutHi, aboutHi) || other.aboutHi == aboutHi)&&const DeepCollectionEquality().equals(other.tabs, tabs)&&(identical(other.luckyMedia, luckyMedia) || other.luckyMedia == luckyMedia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aboutNe,aboutEn,aboutHi,const DeepCollectionEquality().hash(tabs),luckyMedia);

@override
String toString() {
  return 'SignProfileModel(aboutNe: $aboutNe, aboutEn: $aboutEn, aboutHi: $aboutHi, tabs: $tabs, luckyMedia: $luckyMedia)';
}


}

/// @nodoc
abstract mixin class $SignProfileModelCopyWith<$Res>  {
  factory $SignProfileModelCopyWith(SignProfileModel value, $Res Function(SignProfileModel) _then) = _$SignProfileModelCopyWithImpl;
@useResult
$Res call({
 String aboutNe, String aboutEn, String aboutHi, List<SignProfileTabModel> tabs, HoroscopeMediaModel luckyMedia
});


$HoroscopeMediaModelCopyWith<$Res> get luckyMedia;

}
/// @nodoc
class _$SignProfileModelCopyWithImpl<$Res>
    implements $SignProfileModelCopyWith<$Res> {
  _$SignProfileModelCopyWithImpl(this._self, this._then);

  final SignProfileModel _self;
  final $Res Function(SignProfileModel) _then;

/// Create a copy of SignProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? aboutNe = null,Object? aboutEn = null,Object? aboutHi = null,Object? tabs = null,Object? luckyMedia = null,}) {
  return _then(_self.copyWith(
aboutNe: null == aboutNe ? _self.aboutNe : aboutNe // ignore: cast_nullable_to_non_nullable
as String,aboutEn: null == aboutEn ? _self.aboutEn : aboutEn // ignore: cast_nullable_to_non_nullable
as String,aboutHi: null == aboutHi ? _self.aboutHi : aboutHi // ignore: cast_nullable_to_non_nullable
as String,tabs: null == tabs ? _self.tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<SignProfileTabModel>,luckyMedia: null == luckyMedia ? _self.luckyMedia : luckyMedia // ignore: cast_nullable_to_non_nullable
as HoroscopeMediaModel,
  ));
}
/// Create a copy of SignProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HoroscopeMediaModelCopyWith<$Res> get luckyMedia {
  
  return $HoroscopeMediaModelCopyWith<$Res>(_self.luckyMedia, (value) {
    return _then(_self.copyWith(luckyMedia: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _SignProfileModel extends SignProfileModel {
  const _SignProfileModel({this.aboutNe = '', this.aboutEn = '', this.aboutHi = '', final  List<SignProfileTabModel> tabs = const [], this.luckyMedia = const HoroscopeMediaModel()}): _tabs = tabs,super._();
  factory _SignProfileModel.fromJson(Map<String, dynamic> json) => _$SignProfileModelFromJson(json);

@override@JsonKey() final  String aboutNe;
@override@JsonKey() final  String aboutEn;
@override@JsonKey() final  String aboutHi;
 final  List<SignProfileTabModel> _tabs;
@override@JsonKey() List<SignProfileTabModel> get tabs {
  if (_tabs is EqualUnmodifiableListView) return _tabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tabs);
}

@override@JsonKey() final  HoroscopeMediaModel luckyMedia;

/// Create a copy of SignProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignProfileModelCopyWith<_SignProfileModel> get copyWith => __$SignProfileModelCopyWithImpl<_SignProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignProfileModel&&(identical(other.aboutNe, aboutNe) || other.aboutNe == aboutNe)&&(identical(other.aboutEn, aboutEn) || other.aboutEn == aboutEn)&&(identical(other.aboutHi, aboutHi) || other.aboutHi == aboutHi)&&const DeepCollectionEquality().equals(other._tabs, _tabs)&&(identical(other.luckyMedia, luckyMedia) || other.luckyMedia == luckyMedia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,aboutNe,aboutEn,aboutHi,const DeepCollectionEquality().hash(_tabs),luckyMedia);

@override
String toString() {
  return 'SignProfileModel(aboutNe: $aboutNe, aboutEn: $aboutEn, aboutHi: $aboutHi, tabs: $tabs, luckyMedia: $luckyMedia)';
}


}

/// @nodoc
abstract mixin class _$SignProfileModelCopyWith<$Res> implements $SignProfileModelCopyWith<$Res> {
  factory _$SignProfileModelCopyWith(_SignProfileModel value, $Res Function(_SignProfileModel) _then) = __$SignProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String aboutNe, String aboutEn, String aboutHi, List<SignProfileTabModel> tabs, HoroscopeMediaModel luckyMedia
});


@override $HoroscopeMediaModelCopyWith<$Res> get luckyMedia;

}
/// @nodoc
class __$SignProfileModelCopyWithImpl<$Res>
    implements _$SignProfileModelCopyWith<$Res> {
  __$SignProfileModelCopyWithImpl(this._self, this._then);

  final _SignProfileModel _self;
  final $Res Function(_SignProfileModel) _then;

/// Create a copy of SignProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? aboutNe = null,Object? aboutEn = null,Object? aboutHi = null,Object? tabs = null,Object? luckyMedia = null,}) {
  return _then(_SignProfileModel(
aboutNe: null == aboutNe ? _self.aboutNe : aboutNe // ignore: cast_nullable_to_non_nullable
as String,aboutEn: null == aboutEn ? _self.aboutEn : aboutEn // ignore: cast_nullable_to_non_nullable
as String,aboutHi: null == aboutHi ? _self.aboutHi : aboutHi // ignore: cast_nullable_to_non_nullable
as String,tabs: null == tabs ? _self._tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<SignProfileTabModel>,luckyMedia: null == luckyMedia ? _self.luckyMedia : luckyMedia // ignore: cast_nullable_to_non_nullable
as HoroscopeMediaModel,
  ));
}

/// Create a copy of SignProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HoroscopeMediaModelCopyWith<$Res> get luckyMedia {
  
  return $HoroscopeMediaModelCopyWith<$Res>(_self.luckyMedia, (value) {
    return _then(_self.copyWith(luckyMedia: value));
  });
}
}


/// @nodoc
mixin _$SignProfileTabModel {

 String get titleNe; String get titleEn; String get titleHi; String get introNe; String get introEn; String get introHi; List<SignProfilePointModel> get points;
/// Create a copy of SignProfileTabModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignProfileTabModelCopyWith<SignProfileTabModel> get copyWith => _$SignProfileTabModelCopyWithImpl<SignProfileTabModel>(this as SignProfileTabModel, _$identity);

  /// Serializes this SignProfileTabModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignProfileTabModel&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.introNe, introNe) || other.introNe == introNe)&&(identical(other.introEn, introEn) || other.introEn == introEn)&&(identical(other.introHi, introHi) || other.introHi == introHi)&&const DeepCollectionEquality().equals(other.points, points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleNe,titleEn,titleHi,introNe,introEn,introHi,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'SignProfileTabModel(titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, introNe: $introNe, introEn: $introEn, introHi: $introHi, points: $points)';
}


}

/// @nodoc
abstract mixin class $SignProfileTabModelCopyWith<$Res>  {
  factory $SignProfileTabModelCopyWith(SignProfileTabModel value, $Res Function(SignProfileTabModel) _then) = _$SignProfileTabModelCopyWithImpl;
@useResult
$Res call({
 String titleNe, String titleEn, String titleHi, String introNe, String introEn, String introHi, List<SignProfilePointModel> points
});




}
/// @nodoc
class _$SignProfileTabModelCopyWithImpl<$Res>
    implements $SignProfileTabModelCopyWith<$Res> {
  _$SignProfileTabModelCopyWithImpl(this._self, this._then);

  final SignProfileTabModel _self;
  final $Res Function(SignProfileTabModel) _then;

/// Create a copy of SignProfileTabModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? introNe = null,Object? introEn = null,Object? introHi = null,Object? points = null,}) {
  return _then(_self.copyWith(
titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,introNe: null == introNe ? _self.introNe : introNe // ignore: cast_nullable_to_non_nullable
as String,introEn: null == introEn ? _self.introEn : introEn // ignore: cast_nullable_to_non_nullable
as String,introHi: null == introHi ? _self.introHi : introHi // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<SignProfilePointModel>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _SignProfileTabModel extends SignProfileTabModel {
  const _SignProfileTabModel({this.titleNe = '', this.titleEn = '', this.titleHi = '', this.introNe = '', this.introEn = '', this.introHi = '', final  List<SignProfilePointModel> points = const []}): _points = points,super._();
  factory _SignProfileTabModel.fromJson(Map<String, dynamic> json) => _$SignProfileTabModelFromJson(json);

@override@JsonKey() final  String titleNe;
@override@JsonKey() final  String titleEn;
@override@JsonKey() final  String titleHi;
@override@JsonKey() final  String introNe;
@override@JsonKey() final  String introEn;
@override@JsonKey() final  String introHi;
 final  List<SignProfilePointModel> _points;
@override@JsonKey() List<SignProfilePointModel> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of SignProfileTabModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignProfileTabModelCopyWith<_SignProfileTabModel> get copyWith => __$SignProfileTabModelCopyWithImpl<_SignProfileTabModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignProfileTabModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignProfileTabModel&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.introNe, introNe) || other.introNe == introNe)&&(identical(other.introEn, introEn) || other.introEn == introEn)&&(identical(other.introHi, introHi) || other.introHi == introHi)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleNe,titleEn,titleHi,introNe,introEn,introHi,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'SignProfileTabModel(titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, introNe: $introNe, introEn: $introEn, introHi: $introHi, points: $points)';
}


}

/// @nodoc
abstract mixin class _$SignProfileTabModelCopyWith<$Res> implements $SignProfileTabModelCopyWith<$Res> {
  factory _$SignProfileTabModelCopyWith(_SignProfileTabModel value, $Res Function(_SignProfileTabModel) _then) = __$SignProfileTabModelCopyWithImpl;
@override @useResult
$Res call({
 String titleNe, String titleEn, String titleHi, String introNe, String introEn, String introHi, List<SignProfilePointModel> points
});




}
/// @nodoc
class __$SignProfileTabModelCopyWithImpl<$Res>
    implements _$SignProfileTabModelCopyWith<$Res> {
  __$SignProfileTabModelCopyWithImpl(this._self, this._then);

  final _SignProfileTabModel _self;
  final $Res Function(_SignProfileTabModel) _then;

/// Create a copy of SignProfileTabModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? introNe = null,Object? introEn = null,Object? introHi = null,Object? points = null,}) {
  return _then(_SignProfileTabModel(
titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,introNe: null == introNe ? _self.introNe : introNe // ignore: cast_nullable_to_non_nullable
as String,introEn: null == introEn ? _self.introEn : introEn // ignore: cast_nullable_to_non_nullable
as String,introHi: null == introHi ? _self.introHi : introHi // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<SignProfilePointModel>,
  ));
}


}


/// @nodoc
mixin _$SignProfilePointModel {

 String get labelNe; String get labelEn; String get labelHi; String get textNe; String get textEn; String get textHi;
/// Create a copy of SignProfilePointModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignProfilePointModelCopyWith<SignProfilePointModel> get copyWith => _$SignProfilePointModelCopyWithImpl<SignProfilePointModel>(this as SignProfilePointModel, _$identity);

  /// Serializes this SignProfilePointModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignProfilePointModel&&(identical(other.labelNe, labelNe) || other.labelNe == labelNe)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.labelHi, labelHi) || other.labelHi == labelHi)&&(identical(other.textNe, textNe) || other.textNe == textNe)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textHi, textHi) || other.textHi == textHi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labelNe,labelEn,labelHi,textNe,textEn,textHi);

@override
String toString() {
  return 'SignProfilePointModel(labelNe: $labelNe, labelEn: $labelEn, labelHi: $labelHi, textNe: $textNe, textEn: $textEn, textHi: $textHi)';
}


}

/// @nodoc
abstract mixin class $SignProfilePointModelCopyWith<$Res>  {
  factory $SignProfilePointModelCopyWith(SignProfilePointModel value, $Res Function(SignProfilePointModel) _then) = _$SignProfilePointModelCopyWithImpl;
@useResult
$Res call({
 String labelNe, String labelEn, String labelHi, String textNe, String textEn, String textHi
});




}
/// @nodoc
class _$SignProfilePointModelCopyWithImpl<$Res>
    implements $SignProfilePointModelCopyWith<$Res> {
  _$SignProfilePointModelCopyWithImpl(this._self, this._then);

  final SignProfilePointModel _self;
  final $Res Function(SignProfilePointModel) _then;

/// Create a copy of SignProfilePointModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? labelNe = null,Object? labelEn = null,Object? labelHi = null,Object? textNe = null,Object? textEn = null,Object? textHi = null,}) {
  return _then(_self.copyWith(
labelNe: null == labelNe ? _self.labelNe : labelNe // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,labelHi: null == labelHi ? _self.labelHi : labelHi // ignore: cast_nullable_to_non_nullable
as String,textNe: null == textNe ? _self.textNe : textNe // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textHi: null == textHi ? _self.textHi : textHi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _SignProfilePointModel extends SignProfilePointModel {
  const _SignProfilePointModel({this.labelNe = '', this.labelEn = '', this.labelHi = '', this.textNe = '', this.textEn = '', this.textHi = ''}): super._();
  factory _SignProfilePointModel.fromJson(Map<String, dynamic> json) => _$SignProfilePointModelFromJson(json);

@override@JsonKey() final  String labelNe;
@override@JsonKey() final  String labelEn;
@override@JsonKey() final  String labelHi;
@override@JsonKey() final  String textNe;
@override@JsonKey() final  String textEn;
@override@JsonKey() final  String textHi;

/// Create a copy of SignProfilePointModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignProfilePointModelCopyWith<_SignProfilePointModel> get copyWith => __$SignProfilePointModelCopyWithImpl<_SignProfilePointModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignProfilePointModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignProfilePointModel&&(identical(other.labelNe, labelNe) || other.labelNe == labelNe)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.labelHi, labelHi) || other.labelHi == labelHi)&&(identical(other.textNe, textNe) || other.textNe == textNe)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textHi, textHi) || other.textHi == textHi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labelNe,labelEn,labelHi,textNe,textEn,textHi);

@override
String toString() {
  return 'SignProfilePointModel(labelNe: $labelNe, labelEn: $labelEn, labelHi: $labelHi, textNe: $textNe, textEn: $textEn, textHi: $textHi)';
}


}

/// @nodoc
abstract mixin class _$SignProfilePointModelCopyWith<$Res> implements $SignProfilePointModelCopyWith<$Res> {
  factory _$SignProfilePointModelCopyWith(_SignProfilePointModel value, $Res Function(_SignProfilePointModel) _then) = __$SignProfilePointModelCopyWithImpl;
@override @useResult
$Res call({
 String labelNe, String labelEn, String labelHi, String textNe, String textEn, String textHi
});




}
/// @nodoc
class __$SignProfilePointModelCopyWithImpl<$Res>
    implements _$SignProfilePointModelCopyWith<$Res> {
  __$SignProfilePointModelCopyWithImpl(this._self, this._then);

  final _SignProfilePointModel _self;
  final $Res Function(_SignProfilePointModel) _then;

/// Create a copy of SignProfilePointModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? labelNe = null,Object? labelEn = null,Object? labelHi = null,Object? textNe = null,Object? textEn = null,Object? textHi = null,}) {
  return _then(_SignProfilePointModel(
labelNe: null == labelNe ? _self.labelNe : labelNe // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,labelHi: null == labelHi ? _self.labelHi : labelHi // ignore: cast_nullable_to_non_nullable
as String,textNe: null == textNe ? _self.textNe : textNe // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textHi: null == textHi ? _self.textHi : textHi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
