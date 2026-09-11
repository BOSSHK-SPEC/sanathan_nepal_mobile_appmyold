// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventFilter {

 EventGroup? get group; EventCategory? get category; bool get onlyHolidays; bool get onlyVrat; bool get onlyImportant; bool get upcomingOnly; DateTime? get from; DateTime? get to; int? get limit;
/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventFilterCopyWith<EventFilter> get copyWith => _$EventFilterCopyWithImpl<EventFilter>(this as EventFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventFilter&&(identical(other.group, group) || other.group == group)&&(identical(other.category, category) || other.category == category)&&(identical(other.onlyHolidays, onlyHolidays) || other.onlyHolidays == onlyHolidays)&&(identical(other.onlyVrat, onlyVrat) || other.onlyVrat == onlyVrat)&&(identical(other.onlyImportant, onlyImportant) || other.onlyImportant == onlyImportant)&&(identical(other.upcomingOnly, upcomingOnly) || other.upcomingOnly == upcomingOnly)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,group,category,onlyHolidays,onlyVrat,onlyImportant,upcomingOnly,from,to,limit);

@override
String toString() {
  return 'EventFilter(group: $group, category: $category, onlyHolidays: $onlyHolidays, onlyVrat: $onlyVrat, onlyImportant: $onlyImportant, upcomingOnly: $upcomingOnly, from: $from, to: $to, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $EventFilterCopyWith<$Res>  {
  factory $EventFilterCopyWith(EventFilter value, $Res Function(EventFilter) _then) = _$EventFilterCopyWithImpl;
@useResult
$Res call({
 EventGroup? group, EventCategory? category, bool onlyHolidays, bool onlyVrat, bool onlyImportant, bool upcomingOnly, DateTime? from, DateTime? to, int? limit
});




}
/// @nodoc
class _$EventFilterCopyWithImpl<$Res>
    implements $EventFilterCopyWith<$Res> {
  _$EventFilterCopyWithImpl(this._self, this._then);

  final EventFilter _self;
  final $Res Function(EventFilter) _then;

/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? group = freezed,Object? category = freezed,Object? onlyHolidays = null,Object? onlyVrat = null,Object? onlyImportant = null,Object? upcomingOnly = null,Object? from = freezed,Object? to = freezed,Object? limit = freezed,}) {
  return _then(_self.copyWith(
group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as EventGroup?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory?,onlyHolidays: null == onlyHolidays ? _self.onlyHolidays : onlyHolidays // ignore: cast_nullable_to_non_nullable
as bool,onlyVrat: null == onlyVrat ? _self.onlyVrat : onlyVrat // ignore: cast_nullable_to_non_nullable
as bool,onlyImportant: null == onlyImportant ? _self.onlyImportant : onlyImportant // ignore: cast_nullable_to_non_nullable
as bool,upcomingOnly: null == upcomingOnly ? _self.upcomingOnly : upcomingOnly // ignore: cast_nullable_to_non_nullable
as bool,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}



/// @nodoc


class _EventFilter extends EventFilter {
  const _EventFilter({this.group, this.category, this.onlyHolidays = false, this.onlyVrat = false, this.onlyImportant = false, this.upcomingOnly = true, this.from, this.to, this.limit}): super._();
  

@override final  EventGroup? group;
@override final  EventCategory? category;
@override@JsonKey() final  bool onlyHolidays;
@override@JsonKey() final  bool onlyVrat;
@override@JsonKey() final  bool onlyImportant;
@override@JsonKey() final  bool upcomingOnly;
@override final  DateTime? from;
@override final  DateTime? to;
@override final  int? limit;

/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventFilterCopyWith<_EventFilter> get copyWith => __$EventFilterCopyWithImpl<_EventFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventFilter&&(identical(other.group, group) || other.group == group)&&(identical(other.category, category) || other.category == category)&&(identical(other.onlyHolidays, onlyHolidays) || other.onlyHolidays == onlyHolidays)&&(identical(other.onlyVrat, onlyVrat) || other.onlyVrat == onlyVrat)&&(identical(other.onlyImportant, onlyImportant) || other.onlyImportant == onlyImportant)&&(identical(other.upcomingOnly, upcomingOnly) || other.upcomingOnly == upcomingOnly)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,group,category,onlyHolidays,onlyVrat,onlyImportant,upcomingOnly,from,to,limit);

@override
String toString() {
  return 'EventFilter(group: $group, category: $category, onlyHolidays: $onlyHolidays, onlyVrat: $onlyVrat, onlyImportant: $onlyImportant, upcomingOnly: $upcomingOnly, from: $from, to: $to, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$EventFilterCopyWith<$Res> implements $EventFilterCopyWith<$Res> {
  factory _$EventFilterCopyWith(_EventFilter value, $Res Function(_EventFilter) _then) = __$EventFilterCopyWithImpl;
@override @useResult
$Res call({
 EventGroup? group, EventCategory? category, bool onlyHolidays, bool onlyVrat, bool onlyImportant, bool upcomingOnly, DateTime? from, DateTime? to, int? limit
});




}
/// @nodoc
class __$EventFilterCopyWithImpl<$Res>
    implements _$EventFilterCopyWith<$Res> {
  __$EventFilterCopyWithImpl(this._self, this._then);

  final _EventFilter _self;
  final $Res Function(_EventFilter) _then;

/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? group = freezed,Object? category = freezed,Object? onlyHolidays = null,Object? onlyVrat = null,Object? onlyImportant = null,Object? upcomingOnly = null,Object? from = freezed,Object? to = freezed,Object? limit = freezed,}) {
  return _then(_EventFilter(
group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as EventGroup?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EventCategory?,onlyHolidays: null == onlyHolidays ? _self.onlyHolidays : onlyHolidays // ignore: cast_nullable_to_non_nullable
as bool,onlyVrat: null == onlyVrat ? _self.onlyVrat : onlyVrat // ignore: cast_nullable_to_non_nullable
as bool,onlyImportant: null == onlyImportant ? _self.onlyImportant : onlyImportant // ignore: cast_nullable_to_non_nullable
as bool,upcomingOnly: null == upcomingOnly ? _self.upcomingOnly : upcomingOnly // ignore: cast_nullable_to_non_nullable
as bool,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
