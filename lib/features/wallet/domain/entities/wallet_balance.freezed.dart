// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WalletBalance {

 double get available; double get promotional; List<WalletTransaction> get recent; DateTime? get updatedAt;
/// Create a copy of WalletBalance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletBalanceCopyWith<WalletBalance> get copyWith => _$WalletBalanceCopyWithImpl<WalletBalance>(this as WalletBalance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletBalance&&(identical(other.available, available) || other.available == available)&&(identical(other.promotional, promotional) || other.promotional == promotional)&&const DeepCollectionEquality().equals(other.recent, recent)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,available,promotional,const DeepCollectionEquality().hash(recent),updatedAt);

@override
String toString() {
  return 'WalletBalance(available: $available, promotional: $promotional, recent: $recent, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WalletBalanceCopyWith<$Res>  {
  factory $WalletBalanceCopyWith(WalletBalance value, $Res Function(WalletBalance) _then) = _$WalletBalanceCopyWithImpl;
@useResult
$Res call({
 double available, double promotional, List<WalletTransaction> recent, DateTime? updatedAt
});




}
/// @nodoc
class _$WalletBalanceCopyWithImpl<$Res>
    implements $WalletBalanceCopyWith<$Res> {
  _$WalletBalanceCopyWithImpl(this._self, this._then);

  final WalletBalance _self;
  final $Res Function(WalletBalance) _then;

/// Create a copy of WalletBalance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? available = null,Object? promotional = null,Object? recent = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,promotional: null == promotional ? _self.promotional : promotional // ignore: cast_nullable_to_non_nullable
as double,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as List<WalletTransaction>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



/// @nodoc


class _WalletBalance extends WalletBalance {
  const _WalletBalance({this.available = 0, this.promotional = 0, final  List<WalletTransaction> recent = const <WalletTransaction>[], this.updatedAt}): _recent = recent,super._();
  

@override@JsonKey() final  double available;
@override@JsonKey() final  double promotional;
 final  List<WalletTransaction> _recent;
@override@JsonKey() List<WalletTransaction> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

@override final  DateTime? updatedAt;

/// Create a copy of WalletBalance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletBalanceCopyWith<_WalletBalance> get copyWith => __$WalletBalanceCopyWithImpl<_WalletBalance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletBalance&&(identical(other.available, available) || other.available == available)&&(identical(other.promotional, promotional) || other.promotional == promotional)&&const DeepCollectionEquality().equals(other._recent, _recent)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,available,promotional,const DeepCollectionEquality().hash(_recent),updatedAt);

@override
String toString() {
  return 'WalletBalance(available: $available, promotional: $promotional, recent: $recent, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WalletBalanceCopyWith<$Res> implements $WalletBalanceCopyWith<$Res> {
  factory _$WalletBalanceCopyWith(_WalletBalance value, $Res Function(_WalletBalance) _then) = __$WalletBalanceCopyWithImpl;
@override @useResult
$Res call({
 double available, double promotional, List<WalletTransaction> recent, DateTime? updatedAt
});




}
/// @nodoc
class __$WalletBalanceCopyWithImpl<$Res>
    implements _$WalletBalanceCopyWith<$Res> {
  __$WalletBalanceCopyWithImpl(this._self, this._then);

  final _WalletBalance _self;
  final $Res Function(_WalletBalance) _then;

/// Create a copy of WalletBalance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? available = null,Object? promotional = null,Object? recent = null,Object? updatedAt = freezed,}) {
  return _then(_WalletBalance(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,promotional: null == promotional ? _self.promotional : promotional // ignore: cast_nullable_to_non_nullable
as double,recent: null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<WalletTransaction>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
