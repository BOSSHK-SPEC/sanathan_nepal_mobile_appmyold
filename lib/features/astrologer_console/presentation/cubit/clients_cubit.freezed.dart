// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clients_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientsState {

 LoadState<List<AstrologerClient>> get clients; String get query; ClientSort get sort;
/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientsStateCopyWith<ClientsState> get copyWith => _$ClientsStateCopyWithImpl<ClientsState>(this as ClientsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientsState&&(identical(other.clients, clients) || other.clients == clients)&&(identical(other.query, query) || other.query == query)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,clients,query,sort);

@override
String toString() {
  return 'ClientsState(clients: $clients, query: $query, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $ClientsStateCopyWith<$Res>  {
  factory $ClientsStateCopyWith(ClientsState value, $Res Function(ClientsState) _then) = _$ClientsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<AstrologerClient>> clients, String query, ClientSort sort
});


$LoadStateCopyWith<List<AstrologerClient>, $Res> get clients;

}
/// @nodoc
class _$ClientsStateCopyWithImpl<$Res>
    implements $ClientsStateCopyWith<$Res> {
  _$ClientsStateCopyWithImpl(this._self, this._then);

  final ClientsState _self;
  final $Res Function(ClientsState) _then;

/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clients = null,Object? query = null,Object? sort = null,}) {
  return _then(_self.copyWith(
clients: null == clients ? _self.clients : clients // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerClient>>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ClientSort,
  ));
}
/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerClient>, $Res> get clients {
  
  return $LoadStateCopyWith<List<AstrologerClient>, $Res>(_self.clients, (value) {
    return _then(_self.copyWith(clients: value));
  });
}
}



/// @nodoc


class _ClientsState extends ClientsState {
  const _ClientsState({this.clients = const LoadState.idle(), this.query = '', this.sort = ClientSort.recent}): super._();
  

@override@JsonKey() final  LoadState<List<AstrologerClient>> clients;
@override@JsonKey() final  String query;
@override@JsonKey() final  ClientSort sort;

/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientsStateCopyWith<_ClientsState> get copyWith => __$ClientsStateCopyWithImpl<_ClientsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientsState&&(identical(other.clients, clients) || other.clients == clients)&&(identical(other.query, query) || other.query == query)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,clients,query,sort);

@override
String toString() {
  return 'ClientsState(clients: $clients, query: $query, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$ClientsStateCopyWith<$Res> implements $ClientsStateCopyWith<$Res> {
  factory _$ClientsStateCopyWith(_ClientsState value, $Res Function(_ClientsState) _then) = __$ClientsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<AstrologerClient>> clients, String query, ClientSort sort
});


@override $LoadStateCopyWith<List<AstrologerClient>, $Res> get clients;

}
/// @nodoc
class __$ClientsStateCopyWithImpl<$Res>
    implements _$ClientsStateCopyWith<$Res> {
  __$ClientsStateCopyWithImpl(this._self, this._then);

  final _ClientsState _self;
  final $Res Function(_ClientsState) _then;

/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clients = null,Object? query = null,Object? sort = null,}) {
  return _then(_ClientsState(
clients: null == clients ? _self.clients : clients // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerClient>>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ClientSort,
  ));
}

/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerClient>, $Res> get clients {
  
  return $LoadStateCopyWith<List<AstrologerClient>, $Res>(_self.clients, (value) {
    return _then(_self.copyWith(clients: value));
  });
}
}

// dart format on
