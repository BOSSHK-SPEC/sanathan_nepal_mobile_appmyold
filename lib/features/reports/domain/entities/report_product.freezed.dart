// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportProduct {

 String get id; ReportKind get kind; LocalizedText get title; LocalizedText get summary; double get price;/// Pages in the generated PDF — the honest proxy for how much a buyer
/// gets, and the number they compare across products.
 int get pageCount;/// Section headings, so the buyer sees what is inside before paying.
 List<LocalizedText> get contents;/// Struck-through original price when discounted.
 double? get originalPrice;/// How long generation takes. Reports are not instant and saying so up
/// front prevents a support ticket per purchase.
 Duration get deliveryTime;/// Matching reports need the partner's birth details as well.
 bool get needsSecondProfile; bool get isPopular;
/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportProductCopyWith<ReportProduct> get copyWith => _$ReportProductCopyWithImpl<ReportProduct>(this as ReportProduct, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.price, price) || other.price == price)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&const DeepCollectionEquality().equals(other.contents, contents)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.needsSecondProfile, needsSecondProfile) || other.needsSecondProfile == needsSecondProfile)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,summary,price,pageCount,const DeepCollectionEquality().hash(contents),originalPrice,deliveryTime,needsSecondProfile,isPopular);

@override
String toString() {
  return 'ReportProduct(id: $id, kind: $kind, title: $title, summary: $summary, price: $price, pageCount: $pageCount, contents: $contents, originalPrice: $originalPrice, deliveryTime: $deliveryTime, needsSecondProfile: $needsSecondProfile, isPopular: $isPopular)';
}


}

/// @nodoc
abstract mixin class $ReportProductCopyWith<$Res>  {
  factory $ReportProductCopyWith(ReportProduct value, $Res Function(ReportProduct) _then) = _$ReportProductCopyWithImpl;
@useResult
$Res call({
 String id, ReportKind kind, LocalizedText title, LocalizedText summary, double price, int pageCount, List<LocalizedText> contents, double? originalPrice, Duration deliveryTime, bool needsSecondProfile, bool isPopular
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get summary;

}
/// @nodoc
class _$ReportProductCopyWithImpl<$Res>
    implements $ReportProductCopyWith<$Res> {
  _$ReportProductCopyWithImpl(this._self, this._then);

  final ReportProduct _self;
  final $Res Function(ReportProduct) _then;

/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? summary = null,Object? price = null,Object? pageCount = null,Object? contents = null,Object? originalPrice = freezed,Object? deliveryTime = null,Object? needsSecondProfile = null,Object? isPopular = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReportKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,pageCount: null == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int,contents: null == contents ? _self.contents : contents // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double?,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,needsSecondProfile: null == needsSecondProfile ? _self.needsSecondProfile : needsSecondProfile // ignore: cast_nullable_to_non_nullable
as bool,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}



/// @nodoc


class _ReportProduct extends ReportProduct {
  const _ReportProduct({required this.id, required this.kind, required this.title, required this.summary, required this.price, required this.pageCount, final  List<LocalizedText> contents = const <LocalizedText>[], this.originalPrice, this.deliveryTime = const Duration(minutes: 10), this.needsSecondProfile = false, this.isPopular = false}): _contents = contents,super._();
  

@override final  String id;
@override final  ReportKind kind;
@override final  LocalizedText title;
@override final  LocalizedText summary;
@override final  double price;
/// Pages in the generated PDF — the honest proxy for how much a buyer
/// gets, and the number they compare across products.
@override final  int pageCount;
/// Section headings, so the buyer sees what is inside before paying.
 final  List<LocalizedText> _contents;
/// Section headings, so the buyer sees what is inside before paying.
@override@JsonKey() List<LocalizedText> get contents {
  if (_contents is EqualUnmodifiableListView) return _contents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contents);
}

/// Struck-through original price when discounted.
@override final  double? originalPrice;
/// How long generation takes. Reports are not instant and saying so up
/// front prevents a support ticket per purchase.
@override@JsonKey() final  Duration deliveryTime;
/// Matching reports need the partner's birth details as well.
@override@JsonKey() final  bool needsSecondProfile;
@override@JsonKey() final  bool isPopular;

/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportProductCopyWith<_ReportProduct> get copyWith => __$ReportProductCopyWithImpl<_ReportProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.price, price) || other.price == price)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&const DeepCollectionEquality().equals(other._contents, _contents)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.needsSecondProfile, needsSecondProfile) || other.needsSecondProfile == needsSecondProfile)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,summary,price,pageCount,const DeepCollectionEquality().hash(_contents),originalPrice,deliveryTime,needsSecondProfile,isPopular);

@override
String toString() {
  return 'ReportProduct(id: $id, kind: $kind, title: $title, summary: $summary, price: $price, pageCount: $pageCount, contents: $contents, originalPrice: $originalPrice, deliveryTime: $deliveryTime, needsSecondProfile: $needsSecondProfile, isPopular: $isPopular)';
}


}

/// @nodoc
abstract mixin class _$ReportProductCopyWith<$Res> implements $ReportProductCopyWith<$Res> {
  factory _$ReportProductCopyWith(_ReportProduct value, $Res Function(_ReportProduct) _then) = __$ReportProductCopyWithImpl;
@override @useResult
$Res call({
 String id, ReportKind kind, LocalizedText title, LocalizedText summary, double price, int pageCount, List<LocalizedText> contents, double? originalPrice, Duration deliveryTime, bool needsSecondProfile, bool isPopular
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get summary;

}
/// @nodoc
class __$ReportProductCopyWithImpl<$Res>
    implements _$ReportProductCopyWith<$Res> {
  __$ReportProductCopyWithImpl(this._self, this._then);

  final _ReportProduct _self;
  final $Res Function(_ReportProduct) _then;

/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? summary = null,Object? price = null,Object? pageCount = null,Object? contents = null,Object? originalPrice = freezed,Object? deliveryTime = null,Object? needsSecondProfile = null,Object? isPopular = null,}) {
  return _then(_ReportProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReportKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,pageCount: null == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int,contents: null == contents ? _self._contents : contents // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double?,deliveryTime: null == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as Duration,needsSecondProfile: null == needsSecondProfile ? _self.needsSecondProfile : needsSecondProfile // ignore: cast_nullable_to_non_nullable
as bool,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of ReportProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
