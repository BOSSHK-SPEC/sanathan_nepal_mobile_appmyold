// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PricingState {

 LoadState<ConsolePricing> get pricing; LoadState<ConsolePricing> get saving; ConsolePricing? get draft; String? get saveError;
/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricingStateCopyWith<PricingState> get copyWith => _$PricingStateCopyWithImpl<PricingState>(this as PricingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricingState&&(identical(other.pricing, pricing) || other.pricing == pricing)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,pricing,saving,draft,saveError);

@override
String toString() {
  return 'PricingState(pricing: $pricing, saving: $saving, draft: $draft, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class $PricingStateCopyWith<$Res>  {
  factory $PricingStateCopyWith(PricingState value, $Res Function(PricingState) _then) = _$PricingStateCopyWithImpl;
@useResult
$Res call({
 LoadState<ConsolePricing> pricing, LoadState<ConsolePricing> saving, ConsolePricing? draft, String? saveError
});


$LoadStateCopyWith<ConsolePricing, $Res> get pricing;$LoadStateCopyWith<ConsolePricing, $Res> get saving;$ConsolePricingCopyWith<$Res>? get draft;

}
/// @nodoc
class _$PricingStateCopyWithImpl<$Res>
    implements $PricingStateCopyWith<$Res> {
  _$PricingStateCopyWithImpl(this._self, this._then);

  final PricingState _self;
  final $Res Function(PricingState) _then;

/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pricing = null,Object? saving = null,Object? draft = freezed,Object? saveError = freezed,}) {
  return _then(_self.copyWith(
pricing: null == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as LoadState<ConsolePricing>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<ConsolePricing>,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ConsolePricing?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConsolePricing, $Res> get pricing {
  
  return $LoadStateCopyWith<ConsolePricing, $Res>(_self.pricing, (value) {
    return _then(_self.copyWith(pricing: value));
  });
}/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConsolePricing, $Res> get saving {
  
  return $LoadStateCopyWith<ConsolePricing, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsolePricingCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $ConsolePricingCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}



/// @nodoc


class _PricingState extends PricingState {
  const _PricingState({this.pricing = const LoadState.idle(), this.saving = const LoadState.idle(), this.draft, this.saveError}): super._();
  

@override@JsonKey() final  LoadState<ConsolePricing> pricing;
@override@JsonKey() final  LoadState<ConsolePricing> saving;
@override final  ConsolePricing? draft;
@override final  String? saveError;

/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricingStateCopyWith<_PricingState> get copyWith => __$PricingStateCopyWithImpl<_PricingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricingState&&(identical(other.pricing, pricing) || other.pricing == pricing)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,pricing,saving,draft,saveError);

@override
String toString() {
  return 'PricingState(pricing: $pricing, saving: $saving, draft: $draft, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class _$PricingStateCopyWith<$Res> implements $PricingStateCopyWith<$Res> {
  factory _$PricingStateCopyWith(_PricingState value, $Res Function(_PricingState) _then) = __$PricingStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<ConsolePricing> pricing, LoadState<ConsolePricing> saving, ConsolePricing? draft, String? saveError
});


@override $LoadStateCopyWith<ConsolePricing, $Res> get pricing;@override $LoadStateCopyWith<ConsolePricing, $Res> get saving;@override $ConsolePricingCopyWith<$Res>? get draft;

}
/// @nodoc
class __$PricingStateCopyWithImpl<$Res>
    implements _$PricingStateCopyWith<$Res> {
  __$PricingStateCopyWithImpl(this._self, this._then);

  final _PricingState _self;
  final $Res Function(_PricingState) _then;

/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pricing = null,Object? saving = null,Object? draft = freezed,Object? saveError = freezed,}) {
  return _then(_PricingState(
pricing: null == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as LoadState<ConsolePricing>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<ConsolePricing>,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ConsolePricing?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConsolePricing, $Res> get pricing {
  
  return $LoadStateCopyWith<ConsolePricing, $Res>(_self.pricing, (value) {
    return _then(_self.copyWith(pricing: value));
  });
}/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConsolePricing, $Res> get saving {
  
  return $LoadStateCopyWith<ConsolePricing, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of PricingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsolePricingCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $ConsolePricingCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
