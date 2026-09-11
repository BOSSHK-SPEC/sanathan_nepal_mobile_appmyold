// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_businesses_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminBusinessesState {

 LoadState<List<BusinessProfile>> get businesses;/// Active status filter; `null` = all listings.
 BusinessStatus? get filter;
/// Create a copy of AdminBusinessesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminBusinessesStateCopyWith<AdminBusinessesState> get copyWith => _$AdminBusinessesStateCopyWithImpl<AdminBusinessesState>(this as AdminBusinessesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminBusinessesState&&(identical(other.businesses, businesses) || other.businesses == businesses)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,businesses,filter);

@override
String toString() {
  return 'AdminBusinessesState(businesses: $businesses, filter: $filter)';
}


}

/// @nodoc
abstract mixin class $AdminBusinessesStateCopyWith<$Res>  {
  factory $AdminBusinessesStateCopyWith(AdminBusinessesState value, $Res Function(AdminBusinessesState) _then) = _$AdminBusinessesStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<BusinessProfile>> businesses, BusinessStatus? filter
});


$LoadStateCopyWith<List<BusinessProfile>, $Res> get businesses;

}
/// @nodoc
class _$AdminBusinessesStateCopyWithImpl<$Res>
    implements $AdminBusinessesStateCopyWith<$Res> {
  _$AdminBusinessesStateCopyWithImpl(this._self, this._then);

  final AdminBusinessesState _self;
  final $Res Function(AdminBusinessesState) _then;

/// Create a copy of AdminBusinessesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businesses = null,Object? filter = freezed,}) {
  return _then(_self.copyWith(
businesses: null == businesses ? _self.businesses : businesses // ignore: cast_nullable_to_non_nullable
as LoadState<List<BusinessProfile>>,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as BusinessStatus?,
  ));
}
/// Create a copy of AdminBusinessesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BusinessProfile>, $Res> get businesses {
  
  return $LoadStateCopyWith<List<BusinessProfile>, $Res>(_self.businesses, (value) {
    return _then(_self.copyWith(businesses: value));
  });
}
}



/// @nodoc


class _AdminBusinessesState extends AdminBusinessesState {
  const _AdminBusinessesState({this.businesses = const LoadState.idle(), this.filter = BusinessStatus.pending}): super._();
  

@override@JsonKey() final  LoadState<List<BusinessProfile>> businesses;
/// Active status filter; `null` = all listings.
@override@JsonKey() final  BusinessStatus? filter;

/// Create a copy of AdminBusinessesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminBusinessesStateCopyWith<_AdminBusinessesState> get copyWith => __$AdminBusinessesStateCopyWithImpl<_AdminBusinessesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminBusinessesState&&(identical(other.businesses, businesses) || other.businesses == businesses)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,businesses,filter);

@override
String toString() {
  return 'AdminBusinessesState(businesses: $businesses, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$AdminBusinessesStateCopyWith<$Res> implements $AdminBusinessesStateCopyWith<$Res> {
  factory _$AdminBusinessesStateCopyWith(_AdminBusinessesState value, $Res Function(_AdminBusinessesState) _then) = __$AdminBusinessesStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<BusinessProfile>> businesses, BusinessStatus? filter
});


@override $LoadStateCopyWith<List<BusinessProfile>, $Res> get businesses;

}
/// @nodoc
class __$AdminBusinessesStateCopyWithImpl<$Res>
    implements _$AdminBusinessesStateCopyWith<$Res> {
  __$AdminBusinessesStateCopyWithImpl(this._self, this._then);

  final _AdminBusinessesState _self;
  final $Res Function(_AdminBusinessesState) _then;

/// Create a copy of AdminBusinessesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? businesses = null,Object? filter = freezed,}) {
  return _then(_AdminBusinessesState(
businesses: null == businesses ? _self.businesses : businesses // ignore: cast_nullable_to_non_nullable
as LoadState<List<BusinessProfile>>,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as BusinessStatus?,
  ));
}

/// Create a copy of AdminBusinessesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BusinessProfile>, $Res> get businesses {
  
  return $LoadStateCopyWith<List<BusinessProfile>, $Res>(_self.businesses, (value) {
    return _then(_self.copyWith(businesses: value));
  });
}
}

// dart format on
