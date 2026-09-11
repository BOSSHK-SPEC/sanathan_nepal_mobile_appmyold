// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'console_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardStats {

 double get earningsToday; double get earningsThisWeek; int get sessionsToday; int get minutesToday; int get waitingNow; double get rating; int get reviewCount;/// Share of requests accepted, 0–1. The single number that most affects
/// how often the platform routes work to an astrologer.
 double get acceptanceRate;/// Median seconds to accept a request.
 int get responseSeconds;/// Share of clients who came back, 0–1.
 double get repeatRate;/// Last seven days of earnings, oldest first — the sparkline series.
 List<double> get earningsTrend;
/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStatsCopyWith<DashboardStats> get copyWith => _$DashboardStatsCopyWithImpl<DashboardStats>(this as DashboardStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardStats&&(identical(other.earningsToday, earningsToday) || other.earningsToday == earningsToday)&&(identical(other.earningsThisWeek, earningsThisWeek) || other.earningsThisWeek == earningsThisWeek)&&(identical(other.sessionsToday, sessionsToday) || other.sessionsToday == sessionsToday)&&(identical(other.minutesToday, minutesToday) || other.minutesToday == minutesToday)&&(identical(other.waitingNow, waitingNow) || other.waitingNow == waitingNow)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.acceptanceRate, acceptanceRate) || other.acceptanceRate == acceptanceRate)&&(identical(other.responseSeconds, responseSeconds) || other.responseSeconds == responseSeconds)&&(identical(other.repeatRate, repeatRate) || other.repeatRate == repeatRate)&&const DeepCollectionEquality().equals(other.earningsTrend, earningsTrend));
}


@override
int get hashCode => Object.hash(runtimeType,earningsToday,earningsThisWeek,sessionsToday,minutesToday,waitingNow,rating,reviewCount,acceptanceRate,responseSeconds,repeatRate,const DeepCollectionEquality().hash(earningsTrend));

@override
String toString() {
  return 'DashboardStats(earningsToday: $earningsToday, earningsThisWeek: $earningsThisWeek, sessionsToday: $sessionsToday, minutesToday: $minutesToday, waitingNow: $waitingNow, rating: $rating, reviewCount: $reviewCount, acceptanceRate: $acceptanceRate, responseSeconds: $responseSeconds, repeatRate: $repeatRate, earningsTrend: $earningsTrend)';
}


}

/// @nodoc
abstract mixin class $DashboardStatsCopyWith<$Res>  {
  factory $DashboardStatsCopyWith(DashboardStats value, $Res Function(DashboardStats) _then) = _$DashboardStatsCopyWithImpl;
@useResult
$Res call({
 double earningsToday, double earningsThisWeek, int sessionsToday, int minutesToday, int waitingNow, double rating, int reviewCount, double acceptanceRate, int responseSeconds, double repeatRate, List<double> earningsTrend
});




}
/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._self, this._then);

  final DashboardStats _self;
  final $Res Function(DashboardStats) _then;

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earningsToday = null,Object? earningsThisWeek = null,Object? sessionsToday = null,Object? minutesToday = null,Object? waitingNow = null,Object? rating = null,Object? reviewCount = null,Object? acceptanceRate = null,Object? responseSeconds = null,Object? repeatRate = null,Object? earningsTrend = null,}) {
  return _then(_self.copyWith(
earningsToday: null == earningsToday ? _self.earningsToday : earningsToday // ignore: cast_nullable_to_non_nullable
as double,earningsThisWeek: null == earningsThisWeek ? _self.earningsThisWeek : earningsThisWeek // ignore: cast_nullable_to_non_nullable
as double,sessionsToday: null == sessionsToday ? _self.sessionsToday : sessionsToday // ignore: cast_nullable_to_non_nullable
as int,minutesToday: null == minutesToday ? _self.minutesToday : minutesToday // ignore: cast_nullable_to_non_nullable
as int,waitingNow: null == waitingNow ? _self.waitingNow : waitingNow // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,acceptanceRate: null == acceptanceRate ? _self.acceptanceRate : acceptanceRate // ignore: cast_nullable_to_non_nullable
as double,responseSeconds: null == responseSeconds ? _self.responseSeconds : responseSeconds // ignore: cast_nullable_to_non_nullable
as int,repeatRate: null == repeatRate ? _self.repeatRate : repeatRate // ignore: cast_nullable_to_non_nullable
as double,earningsTrend: null == earningsTrend ? _self.earningsTrend : earningsTrend // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}



/// @nodoc


class _DashboardStats extends DashboardStats {
  const _DashboardStats({this.earningsToday = 0, this.earningsThisWeek = 0, this.sessionsToday = 0, this.minutesToday = 0, this.waitingNow = 0, this.rating = 0, this.reviewCount = 0, this.acceptanceRate = 0, this.responseSeconds = 0, this.repeatRate = 0, final  List<double> earningsTrend = const <double>[]}): _earningsTrend = earningsTrend,super._();
  

@override@JsonKey() final  double earningsToday;
@override@JsonKey() final  double earningsThisWeek;
@override@JsonKey() final  int sessionsToday;
@override@JsonKey() final  int minutesToday;
@override@JsonKey() final  int waitingNow;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
/// Share of requests accepted, 0–1. The single number that most affects
/// how often the platform routes work to an astrologer.
@override@JsonKey() final  double acceptanceRate;
/// Median seconds to accept a request.
@override@JsonKey() final  int responseSeconds;
/// Share of clients who came back, 0–1.
@override@JsonKey() final  double repeatRate;
/// Last seven days of earnings, oldest first — the sparkline series.
 final  List<double> _earningsTrend;
/// Last seven days of earnings, oldest first — the sparkline series.
@override@JsonKey() List<double> get earningsTrend {
  if (_earningsTrend is EqualUnmodifiableListView) return _earningsTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earningsTrend);
}


/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStatsCopyWith<_DashboardStats> get copyWith => __$DashboardStatsCopyWithImpl<_DashboardStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardStats&&(identical(other.earningsToday, earningsToday) || other.earningsToday == earningsToday)&&(identical(other.earningsThisWeek, earningsThisWeek) || other.earningsThisWeek == earningsThisWeek)&&(identical(other.sessionsToday, sessionsToday) || other.sessionsToday == sessionsToday)&&(identical(other.minutesToday, minutesToday) || other.minutesToday == minutesToday)&&(identical(other.waitingNow, waitingNow) || other.waitingNow == waitingNow)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.acceptanceRate, acceptanceRate) || other.acceptanceRate == acceptanceRate)&&(identical(other.responseSeconds, responseSeconds) || other.responseSeconds == responseSeconds)&&(identical(other.repeatRate, repeatRate) || other.repeatRate == repeatRate)&&const DeepCollectionEquality().equals(other._earningsTrend, _earningsTrend));
}


@override
int get hashCode => Object.hash(runtimeType,earningsToday,earningsThisWeek,sessionsToday,minutesToday,waitingNow,rating,reviewCount,acceptanceRate,responseSeconds,repeatRate,const DeepCollectionEquality().hash(_earningsTrend));

@override
String toString() {
  return 'DashboardStats(earningsToday: $earningsToday, earningsThisWeek: $earningsThisWeek, sessionsToday: $sessionsToday, minutesToday: $minutesToday, waitingNow: $waitingNow, rating: $rating, reviewCount: $reviewCount, acceptanceRate: $acceptanceRate, responseSeconds: $responseSeconds, repeatRate: $repeatRate, earningsTrend: $earningsTrend)';
}


}

/// @nodoc
abstract mixin class _$DashboardStatsCopyWith<$Res> implements $DashboardStatsCopyWith<$Res> {
  factory _$DashboardStatsCopyWith(_DashboardStats value, $Res Function(_DashboardStats) _then) = __$DashboardStatsCopyWithImpl;
@override @useResult
$Res call({
 double earningsToday, double earningsThisWeek, int sessionsToday, int minutesToday, int waitingNow, double rating, int reviewCount, double acceptanceRate, int responseSeconds, double repeatRate, List<double> earningsTrend
});




}
/// @nodoc
class __$DashboardStatsCopyWithImpl<$Res>
    implements _$DashboardStatsCopyWith<$Res> {
  __$DashboardStatsCopyWithImpl(this._self, this._then);

  final _DashboardStats _self;
  final $Res Function(_DashboardStats) _then;

/// Create a copy of DashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earningsToday = null,Object? earningsThisWeek = null,Object? sessionsToday = null,Object? minutesToday = null,Object? waitingNow = null,Object? rating = null,Object? reviewCount = null,Object? acceptanceRate = null,Object? responseSeconds = null,Object? repeatRate = null,Object? earningsTrend = null,}) {
  return _then(_DashboardStats(
earningsToday: null == earningsToday ? _self.earningsToday : earningsToday // ignore: cast_nullable_to_non_nullable
as double,earningsThisWeek: null == earningsThisWeek ? _self.earningsThisWeek : earningsThisWeek // ignore: cast_nullable_to_non_nullable
as double,sessionsToday: null == sessionsToday ? _self.sessionsToday : sessionsToday // ignore: cast_nullable_to_non_nullable
as int,minutesToday: null == minutesToday ? _self.minutesToday : minutesToday // ignore: cast_nullable_to_non_nullable
as int,waitingNow: null == waitingNow ? _self.waitingNow : waitingNow // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,acceptanceRate: null == acceptanceRate ? _self.acceptanceRate : acceptanceRate // ignore: cast_nullable_to_non_nullable
as double,responseSeconds: null == responseSeconds ? _self.responseSeconds : responseSeconds // ignore: cast_nullable_to_non_nullable
as int,repeatRate: null == repeatRate ? _self.repeatRate : repeatRate // ignore: cast_nullable_to_non_nullable
as double,earningsTrend: null == earningsTrend ? _self._earningsTrend : earningsTrend // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

/// @nodoc
mixin _$PerformanceMetrics {

 int get totalSessions; int get totalMinutes; double get totalEarnings; double get averageRating; double get acceptanceRate; double get repeatRate;/// Sessions by channel, for the split chart.
 Map<String, int> get sessionsByChannel;/// Earnings per day over the selected range, oldest first.
 List<double> get earningsSeries;
/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceMetricsCopyWith<PerformanceMetrics> get copyWith => _$PerformanceMetricsCopyWithImpl<PerformanceMetrics>(this as PerformanceMetrics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceMetrics&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.acceptanceRate, acceptanceRate) || other.acceptanceRate == acceptanceRate)&&(identical(other.repeatRate, repeatRate) || other.repeatRate == repeatRate)&&const DeepCollectionEquality().equals(other.sessionsByChannel, sessionsByChannel)&&const DeepCollectionEquality().equals(other.earningsSeries, earningsSeries));
}


@override
int get hashCode => Object.hash(runtimeType,totalSessions,totalMinutes,totalEarnings,averageRating,acceptanceRate,repeatRate,const DeepCollectionEquality().hash(sessionsByChannel),const DeepCollectionEquality().hash(earningsSeries));

@override
String toString() {
  return 'PerformanceMetrics(totalSessions: $totalSessions, totalMinutes: $totalMinutes, totalEarnings: $totalEarnings, averageRating: $averageRating, acceptanceRate: $acceptanceRate, repeatRate: $repeatRate, sessionsByChannel: $sessionsByChannel, earningsSeries: $earningsSeries)';
}


}

/// @nodoc
abstract mixin class $PerformanceMetricsCopyWith<$Res>  {
  factory $PerformanceMetricsCopyWith(PerformanceMetrics value, $Res Function(PerformanceMetrics) _then) = _$PerformanceMetricsCopyWithImpl;
@useResult
$Res call({
 int totalSessions, int totalMinutes, double totalEarnings, double averageRating, double acceptanceRate, double repeatRate, Map<String, int> sessionsByChannel, List<double> earningsSeries
});




}
/// @nodoc
class _$PerformanceMetricsCopyWithImpl<$Res>
    implements $PerformanceMetricsCopyWith<$Res> {
  _$PerformanceMetricsCopyWithImpl(this._self, this._then);

  final PerformanceMetrics _self;
  final $Res Function(PerformanceMetrics) _then;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSessions = null,Object? totalMinutes = null,Object? totalEarnings = null,Object? averageRating = null,Object? acceptanceRate = null,Object? repeatRate = null,Object? sessionsByChannel = null,Object? earningsSeries = null,}) {
  return _then(_self.copyWith(
totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,acceptanceRate: null == acceptanceRate ? _self.acceptanceRate : acceptanceRate // ignore: cast_nullable_to_non_nullable
as double,repeatRate: null == repeatRate ? _self.repeatRate : repeatRate // ignore: cast_nullable_to_non_nullable
as double,sessionsByChannel: null == sessionsByChannel ? _self.sessionsByChannel : sessionsByChannel // ignore: cast_nullable_to_non_nullable
as Map<String, int>,earningsSeries: null == earningsSeries ? _self.earningsSeries : earningsSeries // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}



/// @nodoc


class _PerformanceMetrics extends PerformanceMetrics {
  const _PerformanceMetrics({this.totalSessions = 0, this.totalMinutes = 0, this.totalEarnings = 0, this.averageRating = 0, this.acceptanceRate = 0, this.repeatRate = 0, final  Map<String, int> sessionsByChannel = const <String, int>{}, final  List<double> earningsSeries = const <double>[]}): _sessionsByChannel = sessionsByChannel,_earningsSeries = earningsSeries,super._();
  

@override@JsonKey() final  int totalSessions;
@override@JsonKey() final  int totalMinutes;
@override@JsonKey() final  double totalEarnings;
@override@JsonKey() final  double averageRating;
@override@JsonKey() final  double acceptanceRate;
@override@JsonKey() final  double repeatRate;
/// Sessions by channel, for the split chart.
 final  Map<String, int> _sessionsByChannel;
/// Sessions by channel, for the split chart.
@override@JsonKey() Map<String, int> get sessionsByChannel {
  if (_sessionsByChannel is EqualUnmodifiableMapView) return _sessionsByChannel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sessionsByChannel);
}

/// Earnings per day over the selected range, oldest first.
 final  List<double> _earningsSeries;
/// Earnings per day over the selected range, oldest first.
@override@JsonKey() List<double> get earningsSeries {
  if (_earningsSeries is EqualUnmodifiableListView) return _earningsSeries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earningsSeries);
}


/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceMetricsCopyWith<_PerformanceMetrics> get copyWith => __$PerformanceMetricsCopyWithImpl<_PerformanceMetrics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceMetrics&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.acceptanceRate, acceptanceRate) || other.acceptanceRate == acceptanceRate)&&(identical(other.repeatRate, repeatRate) || other.repeatRate == repeatRate)&&const DeepCollectionEquality().equals(other._sessionsByChannel, _sessionsByChannel)&&const DeepCollectionEquality().equals(other._earningsSeries, _earningsSeries));
}


@override
int get hashCode => Object.hash(runtimeType,totalSessions,totalMinutes,totalEarnings,averageRating,acceptanceRate,repeatRate,const DeepCollectionEquality().hash(_sessionsByChannel),const DeepCollectionEquality().hash(_earningsSeries));

@override
String toString() {
  return 'PerformanceMetrics(totalSessions: $totalSessions, totalMinutes: $totalMinutes, totalEarnings: $totalEarnings, averageRating: $averageRating, acceptanceRate: $acceptanceRate, repeatRate: $repeatRate, sessionsByChannel: $sessionsByChannel, earningsSeries: $earningsSeries)';
}


}

/// @nodoc
abstract mixin class _$PerformanceMetricsCopyWith<$Res> implements $PerformanceMetricsCopyWith<$Res> {
  factory _$PerformanceMetricsCopyWith(_PerformanceMetrics value, $Res Function(_PerformanceMetrics) _then) = __$PerformanceMetricsCopyWithImpl;
@override @useResult
$Res call({
 int totalSessions, int totalMinutes, double totalEarnings, double averageRating, double acceptanceRate, double repeatRate, Map<String, int> sessionsByChannel, List<double> earningsSeries
});




}
/// @nodoc
class __$PerformanceMetricsCopyWithImpl<$Res>
    implements _$PerformanceMetricsCopyWith<$Res> {
  __$PerformanceMetricsCopyWithImpl(this._self, this._then);

  final _PerformanceMetrics _self;
  final $Res Function(_PerformanceMetrics) _then;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSessions = null,Object? totalMinutes = null,Object? totalEarnings = null,Object? averageRating = null,Object? acceptanceRate = null,Object? repeatRate = null,Object? sessionsByChannel = null,Object? earningsSeries = null,}) {
  return _then(_PerformanceMetrics(
totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,acceptanceRate: null == acceptanceRate ? _self.acceptanceRate : acceptanceRate // ignore: cast_nullable_to_non_nullable
as double,repeatRate: null == repeatRate ? _self.repeatRate : repeatRate // ignore: cast_nullable_to_non_nullable
as double,sessionsByChannel: null == sessionsByChannel ? _self._sessionsByChannel : sessionsByChannel // ignore: cast_nullable_to_non_nullable
as Map<String, int>,earningsSeries: null == earningsSeries ? _self._earningsSeries : earningsSeries // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
