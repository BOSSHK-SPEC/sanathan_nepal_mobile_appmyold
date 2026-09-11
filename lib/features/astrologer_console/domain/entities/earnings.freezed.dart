// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earnings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarningEntry {

 String get id; String get clientName; String get channel; int get minutes; double get gross; double get commission; DateTime get occurredAt;/// True once the amount has been paid out.
 bool get settled;
/// Create a copy of EarningEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningEntryCopyWith<EarningEntry> get copyWith => _$EarningEntryCopyWithImpl<EarningEntry>(this as EarningEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.gross, gross) || other.gross == gross)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.settled, settled) || other.settled == settled));
}


@override
int get hashCode => Object.hash(runtimeType,id,clientName,channel,minutes,gross,commission,occurredAt,settled);

@override
String toString() {
  return 'EarningEntry(id: $id, clientName: $clientName, channel: $channel, minutes: $minutes, gross: $gross, commission: $commission, occurredAt: $occurredAt, settled: $settled)';
}


}

/// @nodoc
abstract mixin class $EarningEntryCopyWith<$Res>  {
  factory $EarningEntryCopyWith(EarningEntry value, $Res Function(EarningEntry) _then) = _$EarningEntryCopyWithImpl;
@useResult
$Res call({
 String id, String clientName, String channel, int minutes, double gross, double commission, DateTime occurredAt, bool settled
});




}
/// @nodoc
class _$EarningEntryCopyWithImpl<$Res>
    implements $EarningEntryCopyWith<$Res> {
  _$EarningEntryCopyWithImpl(this._self, this._then);

  final EarningEntry _self;
  final $Res Function(EarningEntry) _then;

/// Create a copy of EarningEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientName = null,Object? channel = null,Object? minutes = null,Object? gross = null,Object? commission = null,Object? occurredAt = null,Object? settled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,gross: null == gross ? _self.gross : gross // ignore: cast_nullable_to_non_nullable
as double,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as double,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,settled: null == settled ? _self.settled : settled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _EarningEntry extends EarningEntry {
  const _EarningEntry({required this.id, required this.clientName, required this.channel, required this.minutes, required this.gross, required this.commission, required this.occurredAt, this.settled = false}): super._();
  

@override final  String id;
@override final  String clientName;
@override final  String channel;
@override final  int minutes;
@override final  double gross;
@override final  double commission;
@override final  DateTime occurredAt;
/// True once the amount has been paid out.
@override@JsonKey() final  bool settled;

/// Create a copy of EarningEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningEntryCopyWith<_EarningEntry> get copyWith => __$EarningEntryCopyWithImpl<_EarningEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.gross, gross) || other.gross == gross)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.settled, settled) || other.settled == settled));
}


@override
int get hashCode => Object.hash(runtimeType,id,clientName,channel,minutes,gross,commission,occurredAt,settled);

@override
String toString() {
  return 'EarningEntry(id: $id, clientName: $clientName, channel: $channel, minutes: $minutes, gross: $gross, commission: $commission, occurredAt: $occurredAt, settled: $settled)';
}


}

/// @nodoc
abstract mixin class _$EarningEntryCopyWith<$Res> implements $EarningEntryCopyWith<$Res> {
  factory _$EarningEntryCopyWith(_EarningEntry value, $Res Function(_EarningEntry) _then) = __$EarningEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientName, String channel, int minutes, double gross, double commission, DateTime occurredAt, bool settled
});




}
/// @nodoc
class __$EarningEntryCopyWithImpl<$Res>
    implements _$EarningEntryCopyWith<$Res> {
  __$EarningEntryCopyWithImpl(this._self, this._then);

  final _EarningEntry _self;
  final $Res Function(_EarningEntry) _then;

/// Create a copy of EarningEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientName = null,Object? channel = null,Object? minutes = null,Object? gross = null,Object? commission = null,Object? occurredAt = null,Object? settled = null,}) {
  return _then(_EarningEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,gross: null == gross ? _self.gross : gross // ignore: cast_nullable_to_non_nullable
as double,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as double,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,settled: null == settled ? _self.settled : settled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$EarningsSummary {

 List<EarningEntry> get entries;/// Earned but not yet paid out.
 double get pendingBalance;/// Available to withdraw right now.
 double get availableBalance; EarningsRange get range;
/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsSummaryCopyWith<EarningsSummary> get copyWith => _$EarningsSummaryCopyWithImpl<EarningsSummary>(this as EarningsSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsSummary&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.pendingBalance, pendingBalance) || other.pendingBalance == pendingBalance)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entries),pendingBalance,availableBalance,range);

@override
String toString() {
  return 'EarningsSummary(entries: $entries, pendingBalance: $pendingBalance, availableBalance: $availableBalance, range: $range)';
}


}

/// @nodoc
abstract mixin class $EarningsSummaryCopyWith<$Res>  {
  factory $EarningsSummaryCopyWith(EarningsSummary value, $Res Function(EarningsSummary) _then) = _$EarningsSummaryCopyWithImpl;
@useResult
$Res call({
 List<EarningEntry> entries, double pendingBalance, double availableBalance, EarningsRange range
});




}
/// @nodoc
class _$EarningsSummaryCopyWithImpl<$Res>
    implements $EarningsSummaryCopyWith<$Res> {
  _$EarningsSummaryCopyWithImpl(this._self, this._then);

  final EarningsSummary _self;
  final $Res Function(EarningsSummary) _then;

/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,Object? pendingBalance = null,Object? availableBalance = null,Object? range = null,}) {
  return _then(_self.copyWith(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EarningEntry>,pendingBalance: null == pendingBalance ? _self.pendingBalance : pendingBalance // ignore: cast_nullable_to_non_nullable
as double,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as EarningsRange,
  ));
}

}



/// @nodoc


class _EarningsSummary extends EarningsSummary {
  const _EarningsSummary({final  List<EarningEntry> entries = const <EarningEntry>[], this.pendingBalance = 0, this.availableBalance = 0, this.range = EarningsRange.week}): _entries = entries,super._();
  

 final  List<EarningEntry> _entries;
@override@JsonKey() List<EarningEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

/// Earned but not yet paid out.
@override@JsonKey() final  double pendingBalance;
/// Available to withdraw right now.
@override@JsonKey() final  double availableBalance;
@override@JsonKey() final  EarningsRange range;

/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsSummaryCopyWith<_EarningsSummary> get copyWith => __$EarningsSummaryCopyWithImpl<_EarningsSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsSummary&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.pendingBalance, pendingBalance) || other.pendingBalance == pendingBalance)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),pendingBalance,availableBalance,range);

@override
String toString() {
  return 'EarningsSummary(entries: $entries, pendingBalance: $pendingBalance, availableBalance: $availableBalance, range: $range)';
}


}

/// @nodoc
abstract mixin class _$EarningsSummaryCopyWith<$Res> implements $EarningsSummaryCopyWith<$Res> {
  factory _$EarningsSummaryCopyWith(_EarningsSummary value, $Res Function(_EarningsSummary) _then) = __$EarningsSummaryCopyWithImpl;
@override @useResult
$Res call({
 List<EarningEntry> entries, double pendingBalance, double availableBalance, EarningsRange range
});




}
/// @nodoc
class __$EarningsSummaryCopyWithImpl<$Res>
    implements _$EarningsSummaryCopyWith<$Res> {
  __$EarningsSummaryCopyWithImpl(this._self, this._then);

  final _EarningsSummary _self;
  final $Res Function(_EarningsSummary) _then;

/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? pendingBalance = null,Object? availableBalance = null,Object? range = null,}) {
  return _then(_EarningsSummary(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EarningEntry>,pendingBalance: null == pendingBalance ? _self.pendingBalance : pendingBalance // ignore: cast_nullable_to_non_nullable
as double,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as EarningsRange,
  ));
}


}

// dart format on
