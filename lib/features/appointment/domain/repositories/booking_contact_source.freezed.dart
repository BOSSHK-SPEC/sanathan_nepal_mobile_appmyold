// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_contact_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingContact {

 String get name; String get phone; String get email; String? get birthPlace; DateTime? get birthDate;/// "HH:mm" 24h.
 String? get birthTime;
/// Create a copy of BookingContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingContactCopyWith<BookingContact> get copyWith => _$BookingContactCopyWithImpl<BookingContact>(this as BookingContact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingContact&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone,email,birthPlace,birthDate,birthTime);

@override
String toString() {
  return 'BookingContact(name: $name, phone: $phone, email: $email, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime)';
}


}

/// @nodoc
abstract mixin class $BookingContactCopyWith<$Res>  {
  factory $BookingContactCopyWith(BookingContact value, $Res Function(BookingContact) _then) = _$BookingContactCopyWithImpl;
@useResult
$Res call({
 String name, String phone, String email, String? birthPlace, DateTime? birthDate, String? birthTime
});




}
/// @nodoc
class _$BookingContactCopyWithImpl<$Res>
    implements $BookingContactCopyWith<$Res> {
  _$BookingContactCopyWithImpl(this._self, this._then);

  final BookingContact _self;
  final $Res Function(BookingContact) _then;

/// Create a copy of BookingContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = null,Object? email = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _BookingContact implements BookingContact {
  const _BookingContact({this.name = '', this.phone = '', this.email = '', this.birthPlace, this.birthDate, this.birthTime});
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String email;
@override final  String? birthPlace;
@override final  DateTime? birthDate;
/// "HH:mm" 24h.
@override final  String? birthTime;

/// Create a copy of BookingContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingContactCopyWith<_BookingContact> get copyWith => __$BookingContactCopyWithImpl<_BookingContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingContact&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone,email,birthPlace,birthDate,birthTime);

@override
String toString() {
  return 'BookingContact(name: $name, phone: $phone, email: $email, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime)';
}


}

/// @nodoc
abstract mixin class _$BookingContactCopyWith<$Res> implements $BookingContactCopyWith<$Res> {
  factory _$BookingContactCopyWith(_BookingContact value, $Res Function(_BookingContact) _then) = __$BookingContactCopyWithImpl;
@override @useResult
$Res call({
 String name, String phone, String email, String? birthPlace, DateTime? birthDate, String? birthTime
});




}
/// @nodoc
class __$BookingContactCopyWithImpl<$Res>
    implements _$BookingContactCopyWith<$Res> {
  __$BookingContactCopyWithImpl(this._self, this._then);

  final _BookingContact _self;
  final $Res Function(_BookingContact) _then;

/// Create a copy of BookingContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? email = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,}) {
  return _then(_BookingContact(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
