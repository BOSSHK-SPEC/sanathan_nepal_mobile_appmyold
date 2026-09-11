// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forex_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForexState {

/// Latest published rates (all currencies of the region's catalogue).
 LoadState<List<ForexRate>> get rates;/// Currency shown in the trend chart.
 String get trendIso3; ForexRange get range;/// Daily history of [trendIso3] over [range].
 LoadState<List<ForexHistoryPoint>> get history;// Converter
 String get fromIso3; String get toIso3; double get amount;/// Result of the converter; `null` until rates are loaded or when a
/// selected currency has no quote.
 ConversionResult? get conversion;/// ISO codes pinned to the home page (max 4).
 List<String> get favourites;/// Local (quote) currency of the active region – NPR / INR.
 Currency get local;
/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForexStateCopyWith<ForexState> get copyWith => _$ForexStateCopyWithImpl<ForexState>(this as ForexState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForexState&&(identical(other.rates, rates) || other.rates == rates)&&(identical(other.trendIso3, trendIso3) || other.trendIso3 == trendIso3)&&(identical(other.range, range) || other.range == range)&&(identical(other.history, history) || other.history == history)&&(identical(other.fromIso3, fromIso3) || other.fromIso3 == fromIso3)&&(identical(other.toIso3, toIso3) || other.toIso3 == toIso3)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.conversion, conversion) || other.conversion == conversion)&&const DeepCollectionEquality().equals(other.favourites, favourites)&&(identical(other.local, local) || other.local == local));
}


@override
int get hashCode => Object.hash(runtimeType,rates,trendIso3,range,history,fromIso3,toIso3,amount,conversion,const DeepCollectionEquality().hash(favourites),local);

@override
String toString() {
  return 'ForexState(rates: $rates, trendIso3: $trendIso3, range: $range, history: $history, fromIso3: $fromIso3, toIso3: $toIso3, amount: $amount, conversion: $conversion, favourites: $favourites, local: $local)';
}


}

/// @nodoc
abstract mixin class $ForexStateCopyWith<$Res>  {
  factory $ForexStateCopyWith(ForexState value, $Res Function(ForexState) _then) = _$ForexStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<ForexRate>> rates, String trendIso3, ForexRange range, LoadState<List<ForexHistoryPoint>> history, String fromIso3, String toIso3, double amount, ConversionResult? conversion, List<String> favourites, Currency local
});


$LoadStateCopyWith<List<ForexRate>, $Res> get rates;$LoadStateCopyWith<List<ForexHistoryPoint>, $Res> get history;$ConversionResultCopyWith<$Res>? get conversion;$CurrencyCopyWith<$Res> get local;

}
/// @nodoc
class _$ForexStateCopyWithImpl<$Res>
    implements $ForexStateCopyWith<$Res> {
  _$ForexStateCopyWithImpl(this._self, this._then);

  final ForexState _self;
  final $Res Function(ForexState) _then;

/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rates = null,Object? trendIso3 = null,Object? range = null,Object? history = null,Object? fromIso3 = null,Object? toIso3 = null,Object? amount = null,Object? conversion = freezed,Object? favourites = null,Object? local = null,}) {
  return _then(_self.copyWith(
rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as LoadState<List<ForexRate>>,trendIso3: null == trendIso3 ? _self.trendIso3 : trendIso3 // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ForexRange,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as LoadState<List<ForexHistoryPoint>>,fromIso3: null == fromIso3 ? _self.fromIso3 : fromIso3 // ignore: cast_nullable_to_non_nullable
as String,toIso3: null == toIso3 ? _self.toIso3 : toIso3 // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,conversion: freezed == conversion ? _self.conversion : conversion // ignore: cast_nullable_to_non_nullable
as ConversionResult?,favourites: null == favourites ? _self.favourites : favourites // ignore: cast_nullable_to_non_nullable
as List<String>,local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as Currency,
  ));
}
/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ForexRate>, $Res> get rates {
  
  return $LoadStateCopyWith<List<ForexRate>, $Res>(_self.rates, (value) {
    return _then(_self.copyWith(rates: value));
  });
}/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ForexHistoryPoint>, $Res> get history {
  
  return $LoadStateCopyWith<List<ForexHistoryPoint>, $Res>(_self.history, (value) {
    return _then(_self.copyWith(history: value));
  });
}/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversionResultCopyWith<$Res>? get conversion {
    if (_self.conversion == null) {
    return null;
  }

  return $ConversionResultCopyWith<$Res>(_self.conversion!, (value) {
    return _then(_self.copyWith(conversion: value));
  });
}/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get local {
  
  return $CurrencyCopyWith<$Res>(_self.local, (value) {
    return _then(_self.copyWith(local: value));
  });
}
}



/// @nodoc


class _ForexState extends ForexState {
  const _ForexState({this.rates = const LoadState.idle(), this.trendIso3 = 'USD', this.range = ForexRange.week, this.history = const LoadState.idle(), this.fromIso3 = 'USD', this.toIso3 = 'NPR', this.amount = 1, this.conversion, final  List<String> favourites = const ['USD', 'GBP', 'AUD'], this.local = Currency.npr}): _favourites = favourites,super._();
  

/// Latest published rates (all currencies of the region's catalogue).
@override@JsonKey() final  LoadState<List<ForexRate>> rates;
/// Currency shown in the trend chart.
@override@JsonKey() final  String trendIso3;
@override@JsonKey() final  ForexRange range;
/// Daily history of [trendIso3] over [range].
@override@JsonKey() final  LoadState<List<ForexHistoryPoint>> history;
// Converter
@override@JsonKey() final  String fromIso3;
@override@JsonKey() final  String toIso3;
@override@JsonKey() final  double amount;
/// Result of the converter; `null` until rates are loaded or when a
/// selected currency has no quote.
@override final  ConversionResult? conversion;
/// ISO codes pinned to the home page (max 4).
 final  List<String> _favourites;
/// ISO codes pinned to the home page (max 4).
@override@JsonKey() List<String> get favourites {
  if (_favourites is EqualUnmodifiableListView) return _favourites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favourites);
}

/// Local (quote) currency of the active region – NPR / INR.
@override@JsonKey() final  Currency local;

/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForexStateCopyWith<_ForexState> get copyWith => __$ForexStateCopyWithImpl<_ForexState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForexState&&(identical(other.rates, rates) || other.rates == rates)&&(identical(other.trendIso3, trendIso3) || other.trendIso3 == trendIso3)&&(identical(other.range, range) || other.range == range)&&(identical(other.history, history) || other.history == history)&&(identical(other.fromIso3, fromIso3) || other.fromIso3 == fromIso3)&&(identical(other.toIso3, toIso3) || other.toIso3 == toIso3)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.conversion, conversion) || other.conversion == conversion)&&const DeepCollectionEquality().equals(other._favourites, _favourites)&&(identical(other.local, local) || other.local == local));
}


@override
int get hashCode => Object.hash(runtimeType,rates,trendIso3,range,history,fromIso3,toIso3,amount,conversion,const DeepCollectionEquality().hash(_favourites),local);

@override
String toString() {
  return 'ForexState(rates: $rates, trendIso3: $trendIso3, range: $range, history: $history, fromIso3: $fromIso3, toIso3: $toIso3, amount: $amount, conversion: $conversion, favourites: $favourites, local: $local)';
}


}

/// @nodoc
abstract mixin class _$ForexStateCopyWith<$Res> implements $ForexStateCopyWith<$Res> {
  factory _$ForexStateCopyWith(_ForexState value, $Res Function(_ForexState) _then) = __$ForexStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<ForexRate>> rates, String trendIso3, ForexRange range, LoadState<List<ForexHistoryPoint>> history, String fromIso3, String toIso3, double amount, ConversionResult? conversion, List<String> favourites, Currency local
});


@override $LoadStateCopyWith<List<ForexRate>, $Res> get rates;@override $LoadStateCopyWith<List<ForexHistoryPoint>, $Res> get history;@override $ConversionResultCopyWith<$Res>? get conversion;@override $CurrencyCopyWith<$Res> get local;

}
/// @nodoc
class __$ForexStateCopyWithImpl<$Res>
    implements _$ForexStateCopyWith<$Res> {
  __$ForexStateCopyWithImpl(this._self, this._then);

  final _ForexState _self;
  final $Res Function(_ForexState) _then;

/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rates = null,Object? trendIso3 = null,Object? range = null,Object? history = null,Object? fromIso3 = null,Object? toIso3 = null,Object? amount = null,Object? conversion = freezed,Object? favourites = null,Object? local = null,}) {
  return _then(_ForexState(
rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as LoadState<List<ForexRate>>,trendIso3: null == trendIso3 ? _self.trendIso3 : trendIso3 // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ForexRange,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as LoadState<List<ForexHistoryPoint>>,fromIso3: null == fromIso3 ? _self.fromIso3 : fromIso3 // ignore: cast_nullable_to_non_nullable
as String,toIso3: null == toIso3 ? _self.toIso3 : toIso3 // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,conversion: freezed == conversion ? _self.conversion : conversion // ignore: cast_nullable_to_non_nullable
as ConversionResult?,favourites: null == favourites ? _self._favourites : favourites // ignore: cast_nullable_to_non_nullable
as List<String>,local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as Currency,
  ));
}

/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ForexRate>, $Res> get rates {
  
  return $LoadStateCopyWith<List<ForexRate>, $Res>(_self.rates, (value) {
    return _then(_self.copyWith(rates: value));
  });
}/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ForexHistoryPoint>, $Res> get history {
  
  return $LoadStateCopyWith<List<ForexHistoryPoint>, $Res>(_self.history, (value) {
    return _then(_self.copyWith(history: value));
  });
}/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversionResultCopyWith<$Res>? get conversion {
    if (_self.conversion == null) {
    return null;
  }

  return $ConversionResultCopyWith<$Res>(_self.conversion!, (value) {
    return _then(_self.copyWith(conversion: value));
  });
}/// Create a copy of ForexState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get local {
  
  return $CurrencyCopyWith<$Res>(_self.local, (value) {
    return _then(_self.copyWith(local: value));
  });
}
}

// dart format on
