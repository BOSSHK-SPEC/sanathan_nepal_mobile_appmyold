// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionFilter {

 LedgerRange get range;/// Empty means every category.
 Set<TransactionCategory> get categories;/// Null means both directions.
 TransactionDirection? get direction;
/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionFilterCopyWith<TransactionFilter> get copyWith => _$TransactionFilterCopyWithImpl<TransactionFilter>(this as TransactionFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionFilter&&(identical(other.range, range) || other.range == range)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.direction, direction) || other.direction == direction));
}


@override
int get hashCode => Object.hash(runtimeType,range,const DeepCollectionEquality().hash(categories),direction);

@override
String toString() {
  return 'TransactionFilter(range: $range, categories: $categories, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $TransactionFilterCopyWith<$Res>  {
  factory $TransactionFilterCopyWith(TransactionFilter value, $Res Function(TransactionFilter) _then) = _$TransactionFilterCopyWithImpl;
@useResult
$Res call({
 LedgerRange range, Set<TransactionCategory> categories, TransactionDirection? direction
});




}
/// @nodoc
class _$TransactionFilterCopyWithImpl<$Res>
    implements $TransactionFilterCopyWith<$Res> {
  _$TransactionFilterCopyWithImpl(this._self, this._then);

  final TransactionFilter _self;
  final $Res Function(TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,Object? categories = null,Object? direction = freezed,}) {
  return _then(_self.copyWith(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as LedgerRange,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as Set<TransactionCategory>,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TransactionDirection?,
  ));
}

}



/// @nodoc


class _TransactionFilter extends TransactionFilter {
  const _TransactionFilter({this.range = LedgerRange.last30Days, final  Set<TransactionCategory> categories = const <TransactionCategory>{}, this.direction}): _categories = categories,super._();
  

@override@JsonKey() final  LedgerRange range;
/// Empty means every category.
 final  Set<TransactionCategory> _categories;
/// Empty means every category.
@override@JsonKey() Set<TransactionCategory> get categories {
  if (_categories is EqualUnmodifiableSetView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_categories);
}

/// Null means both directions.
@override final  TransactionDirection? direction;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionFilterCopyWith<_TransactionFilter> get copyWith => __$TransactionFilterCopyWithImpl<_TransactionFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionFilter&&(identical(other.range, range) || other.range == range)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.direction, direction) || other.direction == direction));
}


@override
int get hashCode => Object.hash(runtimeType,range,const DeepCollectionEquality().hash(_categories),direction);

@override
String toString() {
  return 'TransactionFilter(range: $range, categories: $categories, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$TransactionFilterCopyWith<$Res> implements $TransactionFilterCopyWith<$Res> {
  factory _$TransactionFilterCopyWith(_TransactionFilter value, $Res Function(_TransactionFilter) _then) = __$TransactionFilterCopyWithImpl;
@override @useResult
$Res call({
 LedgerRange range, Set<TransactionCategory> categories, TransactionDirection? direction
});




}
/// @nodoc
class __$TransactionFilterCopyWithImpl<$Res>
    implements _$TransactionFilterCopyWith<$Res> {
  __$TransactionFilterCopyWithImpl(this._self, this._then);

  final _TransactionFilter _self;
  final $Res Function(_TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,Object? categories = null,Object? direction = freezed,}) {
  return _then(_TransactionFilter(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as LedgerRange,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as Set<TransactionCategory>,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as TransactionDirection?,
  ));
}


}

// dart format on
