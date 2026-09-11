// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LegalState {

 LoadState<LegalDocument> get document;
/// Create a copy of LegalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalStateCopyWith<LegalState> get copyWith => _$LegalStateCopyWithImpl<LegalState>(this as LegalState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalState&&(identical(other.document, document) || other.document == document));
}


@override
int get hashCode => Object.hash(runtimeType,document);

@override
String toString() {
  return 'LegalState(document: $document)';
}


}

/// @nodoc
abstract mixin class $LegalStateCopyWith<$Res>  {
  factory $LegalStateCopyWith(LegalState value, $Res Function(LegalState) _then) = _$LegalStateCopyWithImpl;
@useResult
$Res call({
 LoadState<LegalDocument> document
});


$LoadStateCopyWith<LegalDocument, $Res> get document;

}
/// @nodoc
class _$LegalStateCopyWithImpl<$Res>
    implements $LegalStateCopyWith<$Res> {
  _$LegalStateCopyWithImpl(this._self, this._then);

  final LegalState _self;
  final $Res Function(LegalState) _then;

/// Create a copy of LegalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? document = null,}) {
  return _then(_self.copyWith(
document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as LoadState<LegalDocument>,
  ));
}
/// Create a copy of LegalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<LegalDocument, $Res> get document {
  
  return $LoadStateCopyWith<LegalDocument, $Res>(_self.document, (value) {
    return _then(_self.copyWith(document: value));
  });
}
}



/// @nodoc


class _LegalState implements LegalState {
  const _LegalState({this.document = const LoadState.idle()});
  

@override@JsonKey() final  LoadState<LegalDocument> document;

/// Create a copy of LegalState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalStateCopyWith<_LegalState> get copyWith => __$LegalStateCopyWithImpl<_LegalState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalState&&(identical(other.document, document) || other.document == document));
}


@override
int get hashCode => Object.hash(runtimeType,document);

@override
String toString() {
  return 'LegalState(document: $document)';
}


}

/// @nodoc
abstract mixin class _$LegalStateCopyWith<$Res> implements $LegalStateCopyWith<$Res> {
  factory _$LegalStateCopyWith(_LegalState value, $Res Function(_LegalState) _then) = __$LegalStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<LegalDocument> document
});


@override $LoadStateCopyWith<LegalDocument, $Res> get document;

}
/// @nodoc
class __$LegalStateCopyWithImpl<$Res>
    implements _$LegalStateCopyWith<$Res> {
  __$LegalStateCopyWithImpl(this._self, this._then);

  final _LegalState _self;
  final $Res Function(_LegalState) _then;

/// Create a copy of LegalState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? document = null,}) {
  return _then(_LegalState(
document: null == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as LoadState<LegalDocument>,
  ));
}

/// Create a copy of LegalState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<LegalDocument, $Res> get document {
  
  return $LoadStateCopyWith<LegalDocument, $Res>(_self.document, (value) {
    return _then(_self.copyWith(document: value));
  });
}
}

// dart format on
