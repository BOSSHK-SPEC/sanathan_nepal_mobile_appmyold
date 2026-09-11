// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketplaceState {

 MarketplaceTab get tab; FeedTab get feedTab; String get selectedCategoryId; LoadState<List<Category>> get categories; LoadState<List<Product>> get boosted; LoadState<List<Product>> get myProducts; LoadState<List<Product>> get recent; LoadState<List<Product>> get recommended;/// Last "delete my product" outcome (loaded = id of the removed listing).
 LoadState<String> get deletion;
/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceStateCopyWith<MarketplaceState> get copyWith => _$MarketplaceStateCopyWithImpl<MarketplaceState>(this as MarketplaceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceState&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.feedTab, feedTab) || other.feedTab == feedTab)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.categories, categories) || other.categories == categories)&&(identical(other.boosted, boosted) || other.boosted == boosted)&&(identical(other.myProducts, myProducts) || other.myProducts == myProducts)&&(identical(other.recent, recent) || other.recent == recent)&&(identical(other.recommended, recommended) || other.recommended == recommended)&&(identical(other.deletion, deletion) || other.deletion == deletion));
}


@override
int get hashCode => Object.hash(runtimeType,tab,feedTab,selectedCategoryId,categories,boosted,myProducts,recent,recommended,deletion);

@override
String toString() {
  return 'MarketplaceState(tab: $tab, feedTab: $feedTab, selectedCategoryId: $selectedCategoryId, categories: $categories, boosted: $boosted, myProducts: $myProducts, recent: $recent, recommended: $recommended, deletion: $deletion)';
}


}

/// @nodoc
abstract mixin class $MarketplaceStateCopyWith<$Res>  {
  factory $MarketplaceStateCopyWith(MarketplaceState value, $Res Function(MarketplaceState) _then) = _$MarketplaceStateCopyWithImpl;
@useResult
$Res call({
 MarketplaceTab tab, FeedTab feedTab, String selectedCategoryId, LoadState<List<Category>> categories, LoadState<List<Product>> boosted, LoadState<List<Product>> myProducts, LoadState<List<Product>> recent, LoadState<List<Product>> recommended, LoadState<String> deletion
});


$LoadStateCopyWith<List<Category>, $Res> get categories;$LoadStateCopyWith<List<Product>, $Res> get boosted;$LoadStateCopyWith<List<Product>, $Res> get myProducts;$LoadStateCopyWith<List<Product>, $Res> get recent;$LoadStateCopyWith<List<Product>, $Res> get recommended;$LoadStateCopyWith<String, $Res> get deletion;

}
/// @nodoc
class _$MarketplaceStateCopyWithImpl<$Res>
    implements $MarketplaceStateCopyWith<$Res> {
  _$MarketplaceStateCopyWithImpl(this._self, this._then);

  final MarketplaceState _self;
  final $Res Function(MarketplaceState) _then;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tab = null,Object? feedTab = null,Object? selectedCategoryId = null,Object? categories = null,Object? boosted = null,Object? myProducts = null,Object? recent = null,Object? recommended = null,Object? deletion = null,}) {
  return _then(_self.copyWith(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as MarketplaceTab,feedTab: null == feedTab ? _self.feedTab : feedTab // ignore: cast_nullable_to_non_nullable
as FeedTab,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as LoadState<List<Category>>,boosted: null == boosted ? _self.boosted : boosted // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,myProducts: null == myProducts ? _self.myProducts : myProducts // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,recommended: null == recommended ? _self.recommended : recommended // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<String>,
  ));
}
/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Category>, $Res> get categories {
  
  return $LoadStateCopyWith<List<Category>, $Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get boosted {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.boosted, (value) {
    return _then(_self.copyWith(boosted: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get myProducts {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.myProducts, (value) {
    return _then(_self.copyWith(myProducts: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get recent {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.recent, (value) {
    return _then(_self.copyWith(recent: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get recommended {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.recommended, (value) {
    return _then(_self.copyWith(recommended: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<String, $Res> get deletion {
  
  return $LoadStateCopyWith<String, $Res>(_self.deletion, (value) {
    return _then(_self.copyWith(deletion: value));
  });
}
}



/// @nodoc


class _MarketplaceState extends MarketplaceState {
  const _MarketplaceState({this.tab = MarketplaceTab.boosted, this.feedTab = FeedTab.recent, this.selectedCategoryId = MarketplaceState.allCategoryId, this.categories = const LoadState.idle(), this.boosted = const LoadState.idle(), this.myProducts = const LoadState.idle(), this.recent = const LoadState.idle(), this.recommended = const LoadState.idle(), this.deletion = const LoadState.idle()}): super._();
  

@override@JsonKey() final  MarketplaceTab tab;
@override@JsonKey() final  FeedTab feedTab;
@override@JsonKey() final  String selectedCategoryId;
@override@JsonKey() final  LoadState<List<Category>> categories;
@override@JsonKey() final  LoadState<List<Product>> boosted;
@override@JsonKey() final  LoadState<List<Product>> myProducts;
@override@JsonKey() final  LoadState<List<Product>> recent;
@override@JsonKey() final  LoadState<List<Product>> recommended;
/// Last "delete my product" outcome (loaded = id of the removed listing).
@override@JsonKey() final  LoadState<String> deletion;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceStateCopyWith<_MarketplaceState> get copyWith => __$MarketplaceStateCopyWithImpl<_MarketplaceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceState&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.feedTab, feedTab) || other.feedTab == feedTab)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.categories, categories) || other.categories == categories)&&(identical(other.boosted, boosted) || other.boosted == boosted)&&(identical(other.myProducts, myProducts) || other.myProducts == myProducts)&&(identical(other.recent, recent) || other.recent == recent)&&(identical(other.recommended, recommended) || other.recommended == recommended)&&(identical(other.deletion, deletion) || other.deletion == deletion));
}


@override
int get hashCode => Object.hash(runtimeType,tab,feedTab,selectedCategoryId,categories,boosted,myProducts,recent,recommended,deletion);

@override
String toString() {
  return 'MarketplaceState(tab: $tab, feedTab: $feedTab, selectedCategoryId: $selectedCategoryId, categories: $categories, boosted: $boosted, myProducts: $myProducts, recent: $recent, recommended: $recommended, deletion: $deletion)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceStateCopyWith<$Res> implements $MarketplaceStateCopyWith<$Res> {
  factory _$MarketplaceStateCopyWith(_MarketplaceState value, $Res Function(_MarketplaceState) _then) = __$MarketplaceStateCopyWithImpl;
@override @useResult
$Res call({
 MarketplaceTab tab, FeedTab feedTab, String selectedCategoryId, LoadState<List<Category>> categories, LoadState<List<Product>> boosted, LoadState<List<Product>> myProducts, LoadState<List<Product>> recent, LoadState<List<Product>> recommended, LoadState<String> deletion
});


@override $LoadStateCopyWith<List<Category>, $Res> get categories;@override $LoadStateCopyWith<List<Product>, $Res> get boosted;@override $LoadStateCopyWith<List<Product>, $Res> get myProducts;@override $LoadStateCopyWith<List<Product>, $Res> get recent;@override $LoadStateCopyWith<List<Product>, $Res> get recommended;@override $LoadStateCopyWith<String, $Res> get deletion;

}
/// @nodoc
class __$MarketplaceStateCopyWithImpl<$Res>
    implements _$MarketplaceStateCopyWith<$Res> {
  __$MarketplaceStateCopyWithImpl(this._self, this._then);

  final _MarketplaceState _self;
  final $Res Function(_MarketplaceState) _then;

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? feedTab = null,Object? selectedCategoryId = null,Object? categories = null,Object? boosted = null,Object? myProducts = null,Object? recent = null,Object? recommended = null,Object? deletion = null,}) {
  return _then(_MarketplaceState(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as MarketplaceTab,feedTab: null == feedTab ? _self.feedTab : feedTab // ignore: cast_nullable_to_non_nullable
as FeedTab,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as LoadState<List<Category>>,boosted: null == boosted ? _self.boosted : boosted // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,myProducts: null == myProducts ? _self.myProducts : myProducts // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,recommended: null == recommended ? _self.recommended : recommended // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<String>,
  ));
}

/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Category>, $Res> get categories {
  
  return $LoadStateCopyWith<List<Category>, $Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get boosted {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.boosted, (value) {
    return _then(_self.copyWith(boosted: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get myProducts {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.myProducts, (value) {
    return _then(_self.copyWith(myProducts: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get recent {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.recent, (value) {
    return _then(_self.copyWith(recent: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get recommended {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.recommended, (value) {
    return _then(_self.copyWith(recommended: value));
  });
}/// Create a copy of MarketplaceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<String, $Res> get deletion {
  
  return $LoadStateCopyWith<String, $Res>(_self.deletion, (value) {
    return _then(_self.copyWith(deletion: value));
  });
}
}

// dart format on
