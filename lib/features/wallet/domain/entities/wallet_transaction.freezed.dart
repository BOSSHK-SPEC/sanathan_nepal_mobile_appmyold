// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WalletTransaction {

 String get id; TransactionCategory get category;/// Always positive; [isCredit] carries the direction.
 double get amount; DateTime get createdAt;/// Wallet balance immediately after this entry — lets the ledger be
/// audited without re-summing every prior row.
 double get balanceAfter;/// Free-text detail, e.g. the astrologer's name or the product title.
 String get description;/// Links back to the consultation / order / payment that caused it.
 String? get referenceId;/// Only set for adjustments that reduce the balance.
 bool get forceDebit;
/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionCopyWith<WalletTransaction> get copyWith => _$WalletTransactionCopyWithImpl<WalletTransaction>(this as WalletTransaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.description, description) || other.description == description)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.forceDebit, forceDebit) || other.forceDebit == forceDebit));
}


@override
int get hashCode => Object.hash(runtimeType,id,category,amount,createdAt,balanceAfter,description,referenceId,forceDebit);

@override
String toString() {
  return 'WalletTransaction(id: $id, category: $category, amount: $amount, createdAt: $createdAt, balanceAfter: $balanceAfter, description: $description, referenceId: $referenceId, forceDebit: $forceDebit)';
}


}

/// @nodoc
abstract mixin class $WalletTransactionCopyWith<$Res>  {
  factory $WalletTransactionCopyWith(WalletTransaction value, $Res Function(WalletTransaction) _then) = _$WalletTransactionCopyWithImpl;
@useResult
$Res call({
 String id, TransactionCategory category, double amount, DateTime createdAt, double balanceAfter, String description, String? referenceId, bool forceDebit
});




}
/// @nodoc
class _$WalletTransactionCopyWithImpl<$Res>
    implements $WalletTransactionCopyWith<$Res> {
  _$WalletTransactionCopyWithImpl(this._self, this._then);

  final WalletTransaction _self;
  final $Res Function(WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? amount = null,Object? createdAt = null,Object? balanceAfter = null,Object? description = null,Object? referenceId = freezed,Object? forceDebit = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TransactionCategory,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,balanceAfter: null == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,forceDebit: null == forceDebit ? _self.forceDebit : forceDebit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _WalletTransaction extends WalletTransaction {
  const _WalletTransaction({required this.id, required this.category, required this.amount, required this.createdAt, required this.balanceAfter, this.description = '', this.referenceId, this.forceDebit = false}): super._();
  

@override final  String id;
@override final  TransactionCategory category;
/// Always positive; [isCredit] carries the direction.
@override final  double amount;
@override final  DateTime createdAt;
/// Wallet balance immediately after this entry — lets the ledger be
/// audited without re-summing every prior row.
@override final  double balanceAfter;
/// Free-text detail, e.g. the astrologer's name or the product title.
@override@JsonKey() final  String description;
/// Links back to the consultation / order / payment that caused it.
@override final  String? referenceId;
/// Only set for adjustments that reduce the balance.
@override@JsonKey() final  bool forceDebit;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionCopyWith<_WalletTransaction> get copyWith => __$WalletTransactionCopyWithImpl<_WalletTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.description, description) || other.description == description)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.forceDebit, forceDebit) || other.forceDebit == forceDebit));
}


@override
int get hashCode => Object.hash(runtimeType,id,category,amount,createdAt,balanceAfter,description,referenceId,forceDebit);

@override
String toString() {
  return 'WalletTransaction(id: $id, category: $category, amount: $amount, createdAt: $createdAt, balanceAfter: $balanceAfter, description: $description, referenceId: $referenceId, forceDebit: $forceDebit)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionCopyWith<$Res> implements $WalletTransactionCopyWith<$Res> {
  factory _$WalletTransactionCopyWith(_WalletTransaction value, $Res Function(_WalletTransaction) _then) = __$WalletTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, TransactionCategory category, double amount, DateTime createdAt, double balanceAfter, String description, String? referenceId, bool forceDebit
});




}
/// @nodoc
class __$WalletTransactionCopyWithImpl<$Res>
    implements _$WalletTransactionCopyWith<$Res> {
  __$WalletTransactionCopyWithImpl(this._self, this._then);

  final _WalletTransaction _self;
  final $Res Function(_WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? amount = null,Object? createdAt = null,Object? balanceAfter = null,Object? description = null,Object? referenceId = freezed,Object? forceDebit = null,}) {
  return _then(_WalletTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TransactionCategory,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,balanceAfter: null == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,forceDebit: null == forceDebit ? _self.forceDebit : forceDebit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
