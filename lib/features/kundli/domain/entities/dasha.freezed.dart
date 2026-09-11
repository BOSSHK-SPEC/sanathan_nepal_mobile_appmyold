// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dasha.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashaPeriod {

 Graha get graha; DateTime get start; DateTime get end; List<DashaPeriod> get children;
/// Create a copy of DashaPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashaPeriodCopyWith<DashaPeriod> get copyWith => _$DashaPeriodCopyWithImpl<DashaPeriod>(this as DashaPeriod, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashaPeriod&&(identical(other.graha, graha) || other.graha == graha)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&const DeepCollectionEquality().equals(other.children, children));
}


@override
int get hashCode => Object.hash(runtimeType,graha,start,end,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'DashaPeriod(graha: $graha, start: $start, end: $end, children: $children)';
}


}

/// @nodoc
abstract mixin class $DashaPeriodCopyWith<$Res>  {
  factory $DashaPeriodCopyWith(DashaPeriod value, $Res Function(DashaPeriod) _then) = _$DashaPeriodCopyWithImpl;
@useResult
$Res call({
 Graha graha, DateTime start, DateTime end, List<DashaPeriod> children
});




}
/// @nodoc
class _$DashaPeriodCopyWithImpl<$Res>
    implements $DashaPeriodCopyWith<$Res> {
  _$DashaPeriodCopyWithImpl(this._self, this._then);

  final DashaPeriod _self;
  final $Res Function(DashaPeriod) _then;

/// Create a copy of DashaPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? graha = null,Object? start = null,Object? end = null,Object? children = null,}) {
  return _then(_self.copyWith(
graha: null == graha ? _self.graha : graha // ignore: cast_nullable_to_non_nullable
as Graha,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<DashaPeriod>,
  ));
}

}



/// @nodoc


class _DashaPeriod extends DashaPeriod {
  const _DashaPeriod({required this.graha, required this.start, required this.end, final  List<DashaPeriod> children = const <DashaPeriod>[]}): _children = children,super._();
  

@override final  Graha graha;
@override final  DateTime start;
@override final  DateTime end;
 final  List<DashaPeriod> _children;
@override@JsonKey() List<DashaPeriod> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of DashaPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashaPeriodCopyWith<_DashaPeriod> get copyWith => __$DashaPeriodCopyWithImpl<_DashaPeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashaPeriod&&(identical(other.graha, graha) || other.graha == graha)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&const DeepCollectionEquality().equals(other._children, _children));
}


@override
int get hashCode => Object.hash(runtimeType,graha,start,end,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'DashaPeriod(graha: $graha, start: $start, end: $end, children: $children)';
}


}

/// @nodoc
abstract mixin class _$DashaPeriodCopyWith<$Res> implements $DashaPeriodCopyWith<$Res> {
  factory _$DashaPeriodCopyWith(_DashaPeriod value, $Res Function(_DashaPeriod) _then) = __$DashaPeriodCopyWithImpl;
@override @useResult
$Res call({
 Graha graha, DateTime start, DateTime end, List<DashaPeriod> children
});




}
/// @nodoc
class __$DashaPeriodCopyWithImpl<$Res>
    implements _$DashaPeriodCopyWith<$Res> {
  __$DashaPeriodCopyWithImpl(this._self, this._then);

  final _DashaPeriod _self;
  final $Res Function(_DashaPeriod) _then;

/// Create a copy of DashaPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? graha = null,Object? start = null,Object? end = null,Object? children = null,}) {
  return _then(_DashaPeriod(
graha: null == graha ? _self.graha : graha // ignore: cast_nullable_to_non_nullable
as Graha,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<DashaPeriod>,
  ));
}


}

// dart format on
