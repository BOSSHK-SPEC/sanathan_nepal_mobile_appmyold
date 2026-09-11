// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_listings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessListingsState {

 LoadState<List<Product>> get listings; LoadState<String> get deletion;
/// Create a copy of BusinessListingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessListingsStateCopyWith<BusinessListingsState> get copyWith => _$BusinessListingsStateCopyWithImpl<BusinessListingsState>(this as BusinessListingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessListingsState&&(identical(other.listings, listings) || other.listings == listings)&&(identical(other.deletion, deletion) || other.deletion == deletion));
}


@override
int get hashCode => Object.hash(runtimeType,listings,deletion);

@override
String toString() {
  return 'BusinessListingsState(listings: $listings, deletion: $deletion)';
}


}

/// @nodoc
abstract mixin class $BusinessListingsStateCopyWith<$Res>  {
  factory $BusinessListingsStateCopyWith(BusinessListingsState value, $Res Function(BusinessListingsState) _then) = _$BusinessListingsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<Product>> listings, LoadState<String> deletion
});


$LoadStateCopyWith<List<Product>, $Res> get listings;$LoadStateCopyWith<String, $Res> get deletion;

}
/// @nodoc
class _$BusinessListingsStateCopyWithImpl<$Res>
    implements $BusinessListingsStateCopyWith<$Res> {
  _$BusinessListingsStateCopyWithImpl(this._self, this._then);

  final BusinessListingsState _self;
  final $Res Function(BusinessListingsState) _then;

/// Create a copy of BusinessListingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listings = null,Object? deletion = null,}) {
  return _then(_self.copyWith(
listings: null == listings ? _self.listings : listings // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<String>,
  ));
}
/// Create a copy of BusinessListingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get listings {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.listings, (value) {
    return _then(_self.copyWith(listings: value));
  });
}/// Create a copy of BusinessListingsState
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


class _BusinessListingsState extends BusinessListingsState {
  const _BusinessListingsState({this.listings = const LoadState<List<Product>>.idle(), this.deletion = const LoadState<String>.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<Product>> listings;
@override@JsonKey() final  LoadState<String> deletion;

/// Create a copy of BusinessListingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessListingsStateCopyWith<_BusinessListingsState> get copyWith => __$BusinessListingsStateCopyWithImpl<_BusinessListingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessListingsState&&(identical(other.listings, listings) || other.listings == listings)&&(identical(other.deletion, deletion) || other.deletion == deletion));
}


@override
int get hashCode => Object.hash(runtimeType,listings,deletion);

@override
String toString() {
  return 'BusinessListingsState(listings: $listings, deletion: $deletion)';
}


}

/// @nodoc
abstract mixin class _$BusinessListingsStateCopyWith<$Res> implements $BusinessListingsStateCopyWith<$Res> {
  factory _$BusinessListingsStateCopyWith(_BusinessListingsState value, $Res Function(_BusinessListingsState) _then) = __$BusinessListingsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<Product>> listings, LoadState<String> deletion
});


@override $LoadStateCopyWith<List<Product>, $Res> get listings;@override $LoadStateCopyWith<String, $Res> get deletion;

}
/// @nodoc
class __$BusinessListingsStateCopyWithImpl<$Res>
    implements _$BusinessListingsStateCopyWith<$Res> {
  __$BusinessListingsStateCopyWithImpl(this._self, this._then);

  final _BusinessListingsState _self;
  final $Res Function(_BusinessListingsState) _then;

/// Create a copy of BusinessListingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listings = null,Object? deletion = null,}) {
  return _then(_BusinessListingsState(
listings: null == listings ? _self.listings : listings // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,deletion: null == deletion ? _self.deletion : deletion // ignore: cast_nullable_to_non_nullable
as LoadState<String>,
  ));
}

/// Create a copy of BusinessListingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get listings {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.listings, (value) {
    return _then(_self.copyWith(listings: value));
  });
}/// Create a copy of BusinessListingsState
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
