// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_payout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingPayout {

 String get id; String get userId;/// Major units — see [FinancialSummary] on why the conversion happens once,
/// at the data source.
 double get amount; DateTime get createdAt;
/// Create a copy of PendingPayout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingPayoutCopyWith<PendingPayout> get copyWith => _$PendingPayoutCopyWithImpl<PendingPayout>(this as PendingPayout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingPayout&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,createdAt);

@override
String toString() {
  return 'PendingPayout(id: $id, userId: $userId, amount: $amount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PendingPayoutCopyWith<$Res>  {
  factory $PendingPayoutCopyWith(PendingPayout value, $Res Function(PendingPayout) _then) = _$PendingPayoutCopyWithImpl;
@useResult
$Res call({
 String id, String userId, double amount, DateTime createdAt
});




}
/// @nodoc
class _$PendingPayoutCopyWithImpl<$Res>
    implements $PendingPayoutCopyWith<$Res> {
  _$PendingPayoutCopyWithImpl(this._self, this._then);

  final PendingPayout _self;
  final $Res Function(PendingPayout) _then;

/// Create a copy of PendingPayout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc


class _PendingPayout implements PendingPayout {
  const _PendingPayout({required this.id, required this.userId, this.amount = 0, required this.createdAt});
  

@override final  String id;
@override final  String userId;
/// Major units — see [FinancialSummary] on why the conversion happens once,
/// at the data source.
@override@JsonKey() final  double amount;
@override final  DateTime createdAt;

/// Create a copy of PendingPayout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingPayoutCopyWith<_PendingPayout> get copyWith => __$PendingPayoutCopyWithImpl<_PendingPayout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingPayout&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,createdAt);

@override
String toString() {
  return 'PendingPayout(id: $id, userId: $userId, amount: $amount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PendingPayoutCopyWith<$Res> implements $PendingPayoutCopyWith<$Res> {
  factory _$PendingPayoutCopyWith(_PendingPayout value, $Res Function(_PendingPayout) _then) = __$PendingPayoutCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, double amount, DateTime createdAt
});




}
/// @nodoc
class __$PendingPayoutCopyWithImpl<$Res>
    implements _$PendingPayoutCopyWith<$Res> {
  __$PendingPayoutCopyWithImpl(this._self, this._then);

  final _PendingPayout _self;
  final $Res Function(_PendingPayout) _then;

/// Create a copy of PendingPayout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? createdAt = null,}) {
  return _then(_PendingPayout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$DecisionOutcome {

 String get id; String get status;
/// Create a copy of DecisionOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DecisionOutcomeCopyWith<DecisionOutcome> get copyWith => _$DecisionOutcomeCopyWithImpl<DecisionOutcome>(this as DecisionOutcome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DecisionOutcome&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,status);

@override
String toString() {
  return 'DecisionOutcome(id: $id, status: $status)';
}


}

/// @nodoc
abstract mixin class $DecisionOutcomeCopyWith<$Res>  {
  factory $DecisionOutcomeCopyWith(DecisionOutcome value, $Res Function(DecisionOutcome) _then) = _$DecisionOutcomeCopyWithImpl;
@useResult
$Res call({
 String id, String status
});




}
/// @nodoc
class _$DecisionOutcomeCopyWithImpl<$Res>
    implements $DecisionOutcomeCopyWith<$Res> {
  _$DecisionOutcomeCopyWithImpl(this._self, this._then);

  final DecisionOutcome _self;
  final $Res Function(DecisionOutcome) _then;

/// Create a copy of DecisionOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _DecisionOutcome implements DecisionOutcome {
  const _DecisionOutcome({required this.id, required this.status});
  

@override final  String id;
@override final  String status;

/// Create a copy of DecisionOutcome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecisionOutcomeCopyWith<_DecisionOutcome> get copyWith => __$DecisionOutcomeCopyWithImpl<_DecisionOutcome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecisionOutcome&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,status);

@override
String toString() {
  return 'DecisionOutcome(id: $id, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DecisionOutcomeCopyWith<$Res> implements $DecisionOutcomeCopyWith<$Res> {
  factory _$DecisionOutcomeCopyWith(_DecisionOutcome value, $Res Function(_DecisionOutcome) _then) = __$DecisionOutcomeCopyWithImpl;
@override @useResult
$Res call({
 String id, String status
});




}
/// @nodoc
class __$DecisionOutcomeCopyWithImpl<$Res>
    implements _$DecisionOutcomeCopyWith<$Res> {
  __$DecisionOutcomeCopyWithImpl(this._self, this._then);

  final _DecisionOutcome _self;
  final $Res Function(_DecisionOutcome) _then;

/// Create a copy of DecisionOutcome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,}) {
  return _then(_DecisionOutcome(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
