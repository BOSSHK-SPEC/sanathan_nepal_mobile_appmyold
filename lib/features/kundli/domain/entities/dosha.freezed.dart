// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dosha.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoshaReading {

 DoshaKind get kind; DoshaSeverity get severity;/// Which houses or placements triggered it, for the explanation.
 List<String> get factors;/// Classical cancellations that reduce or nullify the affliction.
 List<String> get cancellations;
/// Create a copy of DoshaReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoshaReadingCopyWith<DoshaReading> get copyWith => _$DoshaReadingCopyWithImpl<DoshaReading>(this as DoshaReading, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoshaReading&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.severity, severity) || other.severity == severity)&&const DeepCollectionEquality().equals(other.factors, factors)&&const DeepCollectionEquality().equals(other.cancellations, cancellations));
}


@override
int get hashCode => Object.hash(runtimeType,kind,severity,const DeepCollectionEquality().hash(factors),const DeepCollectionEquality().hash(cancellations));

@override
String toString() {
  return 'DoshaReading(kind: $kind, severity: $severity, factors: $factors, cancellations: $cancellations)';
}


}

/// @nodoc
abstract mixin class $DoshaReadingCopyWith<$Res>  {
  factory $DoshaReadingCopyWith(DoshaReading value, $Res Function(DoshaReading) _then) = _$DoshaReadingCopyWithImpl;
@useResult
$Res call({
 DoshaKind kind, DoshaSeverity severity, List<String> factors, List<String> cancellations
});




}
/// @nodoc
class _$DoshaReadingCopyWithImpl<$Res>
    implements $DoshaReadingCopyWith<$Res> {
  _$DoshaReadingCopyWithImpl(this._self, this._then);

  final DoshaReading _self;
  final $Res Function(DoshaReading) _then;

/// Create a copy of DoshaReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? severity = null,Object? factors = null,Object? cancellations = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DoshaKind,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DoshaSeverity,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,cancellations: null == cancellations ? _self.cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}



/// @nodoc


class _DoshaReading extends DoshaReading {
  const _DoshaReading({required this.kind, required this.severity, final  List<String> factors = const <String>[], final  List<String> cancellations = const <String>[]}): _factors = factors,_cancellations = cancellations,super._();
  

@override final  DoshaKind kind;
@override final  DoshaSeverity severity;
/// Which houses or placements triggered it, for the explanation.
 final  List<String> _factors;
/// Which houses or placements triggered it, for the explanation.
@override@JsonKey() List<String> get factors {
  if (_factors is EqualUnmodifiableListView) return _factors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_factors);
}

/// Classical cancellations that reduce or nullify the affliction.
 final  List<String> _cancellations;
/// Classical cancellations that reduce or nullify the affliction.
@override@JsonKey() List<String> get cancellations {
  if (_cancellations is EqualUnmodifiableListView) return _cancellations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cancellations);
}


/// Create a copy of DoshaReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoshaReadingCopyWith<_DoshaReading> get copyWith => __$DoshaReadingCopyWithImpl<_DoshaReading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoshaReading&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.severity, severity) || other.severity == severity)&&const DeepCollectionEquality().equals(other._factors, _factors)&&const DeepCollectionEquality().equals(other._cancellations, _cancellations));
}


@override
int get hashCode => Object.hash(runtimeType,kind,severity,const DeepCollectionEquality().hash(_factors),const DeepCollectionEquality().hash(_cancellations));

@override
String toString() {
  return 'DoshaReading(kind: $kind, severity: $severity, factors: $factors, cancellations: $cancellations)';
}


}

/// @nodoc
abstract mixin class _$DoshaReadingCopyWith<$Res> implements $DoshaReadingCopyWith<$Res> {
  factory _$DoshaReadingCopyWith(_DoshaReading value, $Res Function(_DoshaReading) _then) = __$DoshaReadingCopyWithImpl;
@override @useResult
$Res call({
 DoshaKind kind, DoshaSeverity severity, List<String> factors, List<String> cancellations
});




}
/// @nodoc
class __$DoshaReadingCopyWithImpl<$Res>
    implements _$DoshaReadingCopyWith<$Res> {
  __$DoshaReadingCopyWithImpl(this._self, this._then);

  final _DoshaReading _self;
  final $Res Function(_DoshaReading) _then;

/// Create a copy of DoshaReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? severity = null,Object? factors = null,Object? cancellations = null,}) {
  return _then(_DoshaReading(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DoshaKind,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as DoshaSeverity,factors: null == factors ? _self._factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,cancellations: null == cancellations ? _self._cancellations : cancellations // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
