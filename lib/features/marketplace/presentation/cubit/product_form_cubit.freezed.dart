// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductFormState {

/// Listing being edited; `null` while creating a new one.
 String? get productId; ProductDraft get draft;/// The existing product loaded for edit mode.
 LoadState<Product> get initial; LoadState<List<Category>> get categories;/// Result of Save / Update.
 LoadState<Product> get submission;/// Result of Delete (`true` when the listing was removed).
 LoadState<bool> get deletion; Map<ProductFormField, ProductFormError> get errors;/// True after the first submit attempt – errors are shown live from then.
 bool get submitted;/// Category names renamed through the "Product Category edit" popup
/// (display-only overrides, keyed by category id).
 Map<String, String> get categoryNames;
/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormStateCopyWith<ProductFormState> get copyWith => _$ProductFormStateCopyWithImpl<ProductFormState>(this as ProductFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormState&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.categories, categories) || other.categories == categories)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.deletion, deletion) || other.deletion == deletion)&&const DeepCollectionEquality().equals(other.errors, errors)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&const DeepCollectionEquality().equals(other.categoryNames, categoryNames));
}


@override
int get hashCode => Object.hash(runtimeType,productId,draft,initial,categories,submission,deletion,const DeepCollectionEquality().hash(errors),submitted,const DeepCollectionEquality().hash(categoryNames));

@override
String toString() {
  return 'ProductFormState(productId: $productId, draft: $draft, initial: $initial, categories: $categories, submission: $submission, deletion: $deletion, errors: $errors, submitted: $submitted, categoryNames: $categoryNames)';
}


}

/// @nodoc
abstract mixin class $ProductFormStateCopyWith<$Res>  {
  factory $ProductFormStateCopyWith(ProductFormState value, $Res Function(ProductFormState) _then) = _$ProductFormStateCopyWithImpl;
@useResult
$Res call({
 String? productId, ProductDraft draft, LoadState<Product> initial, LoadState<List<Category>> categories, LoadState<Product> submission, LoadState<bool> deletion, Map<ProductFormField, ProductFormError> errors, bool submitted, Map<String, String> categoryNames
});


$ProductDraftCopyWith<$Res> get draft;$LoadStateCopyWith<Product, $Res> get initial;$LoadStateCopyWith<List<Category>, $Res> get categories;$LoadStateCopyWith<Product, $Res> get submission;$LoadStateCopyWith<bool, $Res> get deletion;

}
/// @nodoc
class _$ProductFormStateCopyWithImpl<$Res>
    implements $ProductFormStateCopyWith<$Res> {
  _$ProductFormStateCopyWithImpl(this._self, this._then);

  final ProductFormState _self;
  final $Res Function(ProductFormState) _then;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = freezed,Object? draft = null,Object? initial = null,Object? categories = null,Object? submission = null,Object? deletion = null,Object? errors = null,Object? submitted = null,Object? categoryNames = null,}) {
  return _then(_self.copyWith(
productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ProductDraft,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as LoadState<Product>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as LoadState<List<Category>>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<Product>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<bool>,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Map<ProductFormField, ProductFormError>,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,categoryNames: null == categoryNames ? _self.categoryNames : categoryNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}
/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDraftCopyWith<$Res> get draft {
  
  return $ProductDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Product, $Res> get initial {
  
  return $LoadStateCopyWith<Product, $Res>(_self.initial, (value) {
    return _then(_self.copyWith(initial: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Category>, $Res> get categories {
  
  return $LoadStateCopyWith<List<Category>, $Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Product, $Res> get submission {
  
  return $LoadStateCopyWith<Product, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<bool, $Res> get deletion {
  
  return $LoadStateCopyWith<bool, $Res>(_self.deletion, (value) {
    return _then(_self.copyWith(deletion: value));
  });
}
}



/// @nodoc


class _ProductFormState extends ProductFormState {
  const _ProductFormState({this.productId, this.draft = const ProductDraft(), this.initial = const LoadState.idle(), this.categories = const LoadState.idle(), this.submission = const LoadState.idle(), this.deletion = const LoadState.idle(), final  Map<ProductFormField, ProductFormError> errors = const {}, this.submitted = false, final  Map<String, String> categoryNames = const {}}): _errors = errors,_categoryNames = categoryNames,super._();
  

/// Listing being edited; `null` while creating a new one.
@override final  String? productId;
@override@JsonKey() final  ProductDraft draft;
/// The existing product loaded for edit mode.
@override@JsonKey() final  LoadState<Product> initial;
@override@JsonKey() final  LoadState<List<Category>> categories;
/// Result of Save / Update.
@override@JsonKey() final  LoadState<Product> submission;
/// Result of Delete (`true` when the listing was removed).
@override@JsonKey() final  LoadState<bool> deletion;
 final  Map<ProductFormField, ProductFormError> _errors;
@override@JsonKey() Map<ProductFormField, ProductFormError> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}

/// True after the first submit attempt – errors are shown live from then.
@override@JsonKey() final  bool submitted;
/// Category names renamed through the "Product Category edit" popup
/// (display-only overrides, keyed by category id).
 final  Map<String, String> _categoryNames;
/// Category names renamed through the "Product Category edit" popup
/// (display-only overrides, keyed by category id).
@override@JsonKey() Map<String, String> get categoryNames {
  if (_categoryNames is EqualUnmodifiableMapView) return _categoryNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryNames);
}


/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductFormStateCopyWith<_ProductFormState> get copyWith => __$ProductFormStateCopyWithImpl<_ProductFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductFormState&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.categories, categories) || other.categories == categories)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.deletion, deletion) || other.deletion == deletion)&&const DeepCollectionEquality().equals(other._errors, _errors)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&const DeepCollectionEquality().equals(other._categoryNames, _categoryNames));
}


@override
int get hashCode => Object.hash(runtimeType,productId,draft,initial,categories,submission,deletion,const DeepCollectionEquality().hash(_errors),submitted,const DeepCollectionEquality().hash(_categoryNames));

@override
String toString() {
  return 'ProductFormState(productId: $productId, draft: $draft, initial: $initial, categories: $categories, submission: $submission, deletion: $deletion, errors: $errors, submitted: $submitted, categoryNames: $categoryNames)';
}


}

/// @nodoc
abstract mixin class _$ProductFormStateCopyWith<$Res> implements $ProductFormStateCopyWith<$Res> {
  factory _$ProductFormStateCopyWith(_ProductFormState value, $Res Function(_ProductFormState) _then) = __$ProductFormStateCopyWithImpl;
@override @useResult
$Res call({
 String? productId, ProductDraft draft, LoadState<Product> initial, LoadState<List<Category>> categories, LoadState<Product> submission, LoadState<bool> deletion, Map<ProductFormField, ProductFormError> errors, bool submitted, Map<String, String> categoryNames
});


@override $ProductDraftCopyWith<$Res> get draft;@override $LoadStateCopyWith<Product, $Res> get initial;@override $LoadStateCopyWith<List<Category>, $Res> get categories;@override $LoadStateCopyWith<Product, $Res> get submission;@override $LoadStateCopyWith<bool, $Res> get deletion;

}
/// @nodoc
class __$ProductFormStateCopyWithImpl<$Res>
    implements _$ProductFormStateCopyWith<$Res> {
  __$ProductFormStateCopyWithImpl(this._self, this._then);

  final _ProductFormState _self;
  final $Res Function(_ProductFormState) _then;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = freezed,Object? draft = null,Object? initial = null,Object? categories = null,Object? submission = null,Object? deletion = null,Object? errors = null,Object? submitted = null,Object? categoryNames = null,}) {
  return _then(_ProductFormState(
productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ProductDraft,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as LoadState<Product>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as LoadState<List<Category>>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<Product>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<bool>,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<ProductFormField, ProductFormError>,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,categoryNames: null == categoryNames ? _self._categoryNames : categoryNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDraftCopyWith<$Res> get draft {
  
  return $ProductDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Product, $Res> get initial {
  
  return $LoadStateCopyWith<Product, $Res>(_self.initial, (value) {
    return _then(_self.copyWith(initial: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Category>, $Res> get categories {
  
  return $LoadStateCopyWith<List<Category>, $Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Product, $Res> get submission {
  
  return $LoadStateCopyWith<Product, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<bool, $Res> get deletion {
  
  return $LoadStateCopyWith<bool, $Res>(_self.deletion, (value) {
    return _then(_self.copyWith(deletion: value));
  });
}
}

// dart format on
