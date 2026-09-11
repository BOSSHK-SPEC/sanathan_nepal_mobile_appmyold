// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuditState {

 int get limit; String get query; LoadState<List<AuditEntry>> get entries;
/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditStateCopyWith<AuditState> get copyWith => _$AuditStateCopyWithImpl<AuditState>(this as AuditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditState&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.query, query) || other.query == query)&&(identical(other.entries, entries) || other.entries == entries));
}


@override
int get hashCode => Object.hash(runtimeType,limit,query,entries);

@override
String toString() {
  return 'AuditState(limit: $limit, query: $query, entries: $entries)';
}


}

/// @nodoc
abstract mixin class $AuditStateCopyWith<$Res>  {
  factory $AuditStateCopyWith(AuditState value, $Res Function(AuditState) _then) = _$AuditStateCopyWithImpl;
@useResult
$Res call({
 int limit, String query, LoadState<List<AuditEntry>> entries
});


$LoadStateCopyWith<List<AuditEntry>, $Res> get entries;

}
/// @nodoc
class _$AuditStateCopyWithImpl<$Res>
    implements $AuditStateCopyWith<$Res> {
  _$AuditStateCopyWithImpl(this._self, this._then);

  final AuditState _self;
  final $Res Function(AuditState) _then;

/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = null,Object? query = null,Object? entries = null,}) {
  return _then(_self.copyWith(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as LoadState<List<AuditEntry>>,
  ));
}
/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AuditEntry>, $Res> get entries {
  
  return $LoadStateCopyWith<List<AuditEntry>, $Res>(_self.entries, (value) {
    return _then(_self.copyWith(entries: value));
  });
}
}



/// @nodoc


class _AuditState extends AuditState {
  const _AuditState({this.limit = 100, this.query = '', this.entries = const LoadState<List<AuditEntry>>.idle()}): super._();
  

@override@JsonKey() final  int limit;
@override@JsonKey() final  String query;
@override@JsonKey() final  LoadState<List<AuditEntry>> entries;

/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditStateCopyWith<_AuditState> get copyWith => __$AuditStateCopyWithImpl<_AuditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditState&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.query, query) || other.query == query)&&(identical(other.entries, entries) || other.entries == entries));
}


@override
int get hashCode => Object.hash(runtimeType,limit,query,entries);

@override
String toString() {
  return 'AuditState(limit: $limit, query: $query, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$AuditStateCopyWith<$Res> implements $AuditStateCopyWith<$Res> {
  factory _$AuditStateCopyWith(_AuditState value, $Res Function(_AuditState) _then) = __$AuditStateCopyWithImpl;
@override @useResult
$Res call({
 int limit, String query, LoadState<List<AuditEntry>> entries
});


@override $LoadStateCopyWith<List<AuditEntry>, $Res> get entries;

}
/// @nodoc
class __$AuditStateCopyWithImpl<$Res>
    implements _$AuditStateCopyWith<$Res> {
  __$AuditStateCopyWithImpl(this._self, this._then);

  final _AuditState _self;
  final $Res Function(_AuditState) _then;

/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = null,Object? query = null,Object? entries = null,}) {
  return _then(_AuditState(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as LoadState<List<AuditEntry>>,
  ));
}

/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AuditEntry>, $Res> get entries {
  
  return $LoadStateCopyWith<List<AuditEntry>, $Res>(_self.entries, (value) {
    return _then(_self.copyWith(entries: value));
  });
}
}

// dart format on
