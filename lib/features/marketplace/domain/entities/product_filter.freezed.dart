// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductFilter {

 String? get categoryId; String? get query; ProductSort get sort; bool get boostedOnly; bool get mineOnly;/// Restricts to one shop's listings — what its profile's Products and
/// Services tabs show.
 String? get businessId;/// Restricts to listings the buyer has saved. Set by the Saved
/// screen rather than the sort/category row, so it is not something
/// browsing can switch on by accident.
 bool get favouritesOnly; int? get limit;
/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFilterCopyWith<ProductFilter> get copyWith => _$ProductFilterCopyWithImpl<ProductFilter>(this as ProductFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFilter&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.query, query) || other.query == query)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.boostedOnly, boostedOnly) || other.boostedOnly == boostedOnly)&&(identical(other.mineOnly, mineOnly) || other.mineOnly == mineOnly)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.favouritesOnly, favouritesOnly) || other.favouritesOnly == favouritesOnly)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,query,sort,boostedOnly,mineOnly,businessId,favouritesOnly,limit);

@override
String toString() {
  return 'ProductFilter(categoryId: $categoryId, query: $query, sort: $sort, boostedOnly: $boostedOnly, mineOnly: $mineOnly, businessId: $businessId, favouritesOnly: $favouritesOnly, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ProductFilterCopyWith<$Res>  {
  factory $ProductFilterCopyWith(ProductFilter value, $Res Function(ProductFilter) _then) = _$ProductFilterCopyWithImpl;
@useResult
$Res call({
 String? categoryId, String? query, ProductSort sort, bool boostedOnly, bool mineOnly, String? businessId, bool favouritesOnly, int? limit
});




}
/// @nodoc
class _$ProductFilterCopyWithImpl<$Res>
    implements $ProductFilterCopyWith<$Res> {
  _$ProductFilterCopyWithImpl(this._self, this._then);

  final ProductFilter _self;
  final $Res Function(ProductFilter) _then;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = freezed,Object? query = freezed,Object? sort = null,Object? boostedOnly = null,Object? mineOnly = null,Object? businessId = freezed,Object? favouritesOnly = null,Object? limit = freezed,}) {
  return _then(_self.copyWith(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProductSort,boostedOnly: null == boostedOnly ? _self.boostedOnly : boostedOnly // ignore: cast_nullable_to_non_nullable
as bool,mineOnly: null == mineOnly ? _self.mineOnly : mineOnly // ignore: cast_nullable_to_non_nullable
as bool,businessId: freezed == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String?,favouritesOnly: null == favouritesOnly ? _self.favouritesOnly : favouritesOnly // ignore: cast_nullable_to_non_nullable
as bool,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}



/// @nodoc


class _ProductFilter implements ProductFilter {
  const _ProductFilter({this.categoryId, this.query, this.sort = ProductSort.latest, this.boostedOnly = false, this.mineOnly = false, this.businessId, this.favouritesOnly = false, this.limit});
  

@override final  String? categoryId;
@override final  String? query;
@override@JsonKey() final  ProductSort sort;
@override@JsonKey() final  bool boostedOnly;
@override@JsonKey() final  bool mineOnly;
/// Restricts to one shop's listings — what its profile's Products and
/// Services tabs show.
@override final  String? businessId;
/// Restricts to listings the buyer has saved. Set by the Saved
/// screen rather than the sort/category row, so it is not something
/// browsing can switch on by accident.
@override@JsonKey() final  bool favouritesOnly;
@override final  int? limit;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductFilterCopyWith<_ProductFilter> get copyWith => __$ProductFilterCopyWithImpl<_ProductFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductFilter&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.query, query) || other.query == query)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.boostedOnly, boostedOnly) || other.boostedOnly == boostedOnly)&&(identical(other.mineOnly, mineOnly) || other.mineOnly == mineOnly)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.favouritesOnly, favouritesOnly) || other.favouritesOnly == favouritesOnly)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,query,sort,boostedOnly,mineOnly,businessId,favouritesOnly,limit);

@override
String toString() {
  return 'ProductFilter(categoryId: $categoryId, query: $query, sort: $sort, boostedOnly: $boostedOnly, mineOnly: $mineOnly, businessId: $businessId, favouritesOnly: $favouritesOnly, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ProductFilterCopyWith<$Res> implements $ProductFilterCopyWith<$Res> {
  factory _$ProductFilterCopyWith(_ProductFilter value, $Res Function(_ProductFilter) _then) = __$ProductFilterCopyWithImpl;
@override @useResult
$Res call({
 String? categoryId, String? query, ProductSort sort, bool boostedOnly, bool mineOnly, String? businessId, bool favouritesOnly, int? limit
});




}
/// @nodoc
class __$ProductFilterCopyWithImpl<$Res>
    implements _$ProductFilterCopyWith<$Res> {
  __$ProductFilterCopyWithImpl(this._self, this._then);

  final _ProductFilter _self;
  final $Res Function(_ProductFilter) _then;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = freezed,Object? query = freezed,Object? sort = null,Object? boostedOnly = null,Object? mineOnly = null,Object? businessId = freezed,Object? favouritesOnly = null,Object? limit = freezed,}) {
  return _then(_ProductFilter(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProductSort,boostedOnly: null == boostedOnly ? _self.boostedOnly : boostedOnly // ignore: cast_nullable_to_non_nullable
as bool,mineOnly: null == mineOnly ? _self.mineOnly : mineOnly // ignore: cast_nullable_to_non_nullable
as bool,businessId: freezed == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String?,favouritesOnly: null == favouritesOnly ? _self.favouritesOnly : favouritesOnly // ignore: cast_nullable_to_non_nullable
as bool,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
