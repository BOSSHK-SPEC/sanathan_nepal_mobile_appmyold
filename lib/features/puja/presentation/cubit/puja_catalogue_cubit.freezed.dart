// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puja_catalogue_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PujaCatalogueState {

 LoadState<List<PujaService>> get services; PujaPurpose? get purpose;
/// Create a copy of PujaCatalogueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PujaCatalogueStateCopyWith<PujaCatalogueState> get copyWith => _$PujaCatalogueStateCopyWithImpl<PujaCatalogueState>(this as PujaCatalogueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PujaCatalogueState&&(identical(other.services, services) || other.services == services)&&(identical(other.purpose, purpose) || other.purpose == purpose));
}


@override
int get hashCode => Object.hash(runtimeType,services,purpose);

@override
String toString() {
  return 'PujaCatalogueState(services: $services, purpose: $purpose)';
}


}

/// @nodoc
abstract mixin class $PujaCatalogueStateCopyWith<$Res>  {
  factory $PujaCatalogueStateCopyWith(PujaCatalogueState value, $Res Function(PujaCatalogueState) _then) = _$PujaCatalogueStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<PujaService>> services, PujaPurpose? purpose
});


$LoadStateCopyWith<List<PujaService>, $Res> get services;

}
/// @nodoc
class _$PujaCatalogueStateCopyWithImpl<$Res>
    implements $PujaCatalogueStateCopyWith<$Res> {
  _$PujaCatalogueStateCopyWithImpl(this._self, this._then);

  final PujaCatalogueState _self;
  final $Res Function(PujaCatalogueState) _then;

/// Create a copy of PujaCatalogueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? services = null,Object? purpose = freezed,}) {
  return _then(_self.copyWith(
services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as LoadState<List<PujaService>>,purpose: freezed == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as PujaPurpose?,
  ));
}
/// Create a copy of PujaCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PujaService>, $Res> get services {
  
  return $LoadStateCopyWith<List<PujaService>, $Res>(_self.services, (value) {
    return _then(_self.copyWith(services: value));
  });
}
}



/// @nodoc


class _PujaCatalogueState extends PujaCatalogueState {
  const _PujaCatalogueState({this.services = const LoadState.idle(), this.purpose}): super._();
  

@override@JsonKey() final  LoadState<List<PujaService>> services;
@override final  PujaPurpose? purpose;

/// Create a copy of PujaCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PujaCatalogueStateCopyWith<_PujaCatalogueState> get copyWith => __$PujaCatalogueStateCopyWithImpl<_PujaCatalogueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PujaCatalogueState&&(identical(other.services, services) || other.services == services)&&(identical(other.purpose, purpose) || other.purpose == purpose));
}


@override
int get hashCode => Object.hash(runtimeType,services,purpose);

@override
String toString() {
  return 'PujaCatalogueState(services: $services, purpose: $purpose)';
}


}

/// @nodoc
abstract mixin class _$PujaCatalogueStateCopyWith<$Res> implements $PujaCatalogueStateCopyWith<$Res> {
  factory _$PujaCatalogueStateCopyWith(_PujaCatalogueState value, $Res Function(_PujaCatalogueState) _then) = __$PujaCatalogueStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<PujaService>> services, PujaPurpose? purpose
});


@override $LoadStateCopyWith<List<PujaService>, $Res> get services;

}
/// @nodoc
class __$PujaCatalogueStateCopyWithImpl<$Res>
    implements _$PujaCatalogueStateCopyWith<$Res> {
  __$PujaCatalogueStateCopyWithImpl(this._self, this._then);

  final _PujaCatalogueState _self;
  final $Res Function(_PujaCatalogueState) _then;

/// Create a copy of PujaCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? services = null,Object? purpose = freezed,}) {
  return _then(_PujaCatalogueState(
services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as LoadState<List<PujaService>>,purpose: freezed == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as PujaPurpose?,
  ));
}

/// Create a copy of PujaCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PujaService>, $Res> get services {
  
  return $LoadStateCopyWith<List<PujaService>, $Res>(_self.services, (value) {
    return _then(_self.copyWith(services: value));
  });
}
}

// dart format on
