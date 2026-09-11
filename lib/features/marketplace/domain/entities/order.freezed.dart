// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShippingAddress {

 String get firstName; String get lastName; String get country; String get street; String get city; String get province; String get email; String get apartment; String get postcode; String get phone;
/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<ShippingAddress> get copyWith => _$ShippingAddressCopyWithImpl<ShippingAddress>(this as ShippingAddress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShippingAddress&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.country, country) || other.country == country)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.email, email) || other.email == email)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.postcode, postcode) || other.postcode == postcode)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,country,street,city,province,email,apartment,postcode,phone);

@override
String toString() {
  return 'ShippingAddress(firstName: $firstName, lastName: $lastName, country: $country, street: $street, city: $city, province: $province, email: $email, apartment: $apartment, postcode: $postcode, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $ShippingAddressCopyWith<$Res>  {
  factory $ShippingAddressCopyWith(ShippingAddress value, $Res Function(ShippingAddress) _then) = _$ShippingAddressCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String country, String street, String city, String province, String email, String apartment, String postcode, String phone
});




}
/// @nodoc
class _$ShippingAddressCopyWithImpl<$Res>
    implements $ShippingAddressCopyWith<$Res> {
  _$ShippingAddressCopyWithImpl(this._self, this._then);

  final ShippingAddress _self;
  final $Res Function(ShippingAddress) _then;

/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? country = null,Object? street = null,Object? city = null,Object? province = null,Object? email = null,Object? apartment = null,Object? postcode = null,Object? phone = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,postcode: null == postcode ? _self.postcode : postcode // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _ShippingAddress extends ShippingAddress {
  const _ShippingAddress({required this.firstName, required this.lastName, required this.country, required this.street, required this.city, required this.province, required this.email, this.apartment = '', this.postcode = '', this.phone = ''}): super._();
  

@override final  String firstName;
@override final  String lastName;
@override final  String country;
@override final  String street;
@override final  String city;
@override final  String province;
@override final  String email;
@override@JsonKey() final  String apartment;
@override@JsonKey() final  String postcode;
@override@JsonKey() final  String phone;

/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShippingAddressCopyWith<_ShippingAddress> get copyWith => __$ShippingAddressCopyWithImpl<_ShippingAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShippingAddress&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.country, country) || other.country == country)&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.email, email) || other.email == email)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.postcode, postcode) || other.postcode == postcode)&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,country,street,city,province,email,apartment,postcode,phone);

@override
String toString() {
  return 'ShippingAddress(firstName: $firstName, lastName: $lastName, country: $country, street: $street, city: $city, province: $province, email: $email, apartment: $apartment, postcode: $postcode, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$ShippingAddressCopyWith<$Res> implements $ShippingAddressCopyWith<$Res> {
  factory _$ShippingAddressCopyWith(_ShippingAddress value, $Res Function(_ShippingAddress) _then) = __$ShippingAddressCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String country, String street, String city, String province, String email, String apartment, String postcode, String phone
});




}
/// @nodoc
class __$ShippingAddressCopyWithImpl<$Res>
    implements _$ShippingAddressCopyWith<$Res> {
  __$ShippingAddressCopyWithImpl(this._self, this._then);

  final _ShippingAddress _self;
  final $Res Function(_ShippingAddress) _then;

/// Create a copy of ShippingAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? country = null,Object? street = null,Object? city = null,Object? province = null,Object? email = null,Object? apartment = null,Object? postcode = null,Object? phone = null,}) {
  return _then(_ShippingAddress(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,postcode: null == postcode ? _self.postcode : postcode // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OrderRequest {

 Cart get cart; ShippingAddress get address; PaymentMethod get paymentMethod; String get notes; bool get shipToDifferentAddress;
/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderRequestCopyWith<OrderRequest> get copyWith => _$OrderRequestCopyWithImpl<OrderRequest>(this as OrderRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderRequest&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.address, address) || other.address == address)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.shipToDifferentAddress, shipToDifferentAddress) || other.shipToDifferentAddress == shipToDifferentAddress));
}


@override
int get hashCode => Object.hash(runtimeType,cart,address,paymentMethod,notes,shipToDifferentAddress);

@override
String toString() {
  return 'OrderRequest(cart: $cart, address: $address, paymentMethod: $paymentMethod, notes: $notes, shipToDifferentAddress: $shipToDifferentAddress)';
}


}

/// @nodoc
abstract mixin class $OrderRequestCopyWith<$Res>  {
  factory $OrderRequestCopyWith(OrderRequest value, $Res Function(OrderRequest) _then) = _$OrderRequestCopyWithImpl;
@useResult
$Res call({
 Cart cart, ShippingAddress address, PaymentMethod paymentMethod, String notes, bool shipToDifferentAddress
});


$CartCopyWith<$Res> get cart;$ShippingAddressCopyWith<$Res> get address;

}
/// @nodoc
class _$OrderRequestCopyWithImpl<$Res>
    implements $OrderRequestCopyWith<$Res> {
  _$OrderRequestCopyWithImpl(this._self, this._then);

  final OrderRequest _self;
  final $Res Function(OrderRequest) _then;

/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cart = null,Object? address = null,Object? paymentMethod = null,Object? notes = null,Object? shipToDifferentAddress = null,}) {
  return _then(_self.copyWith(
cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as Cart,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddress,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,shipToDifferentAddress: null == shipToDifferentAddress ? _self.shipToDifferentAddress : shipToDifferentAddress // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartCopyWith<$Res> get cart {
  
  return $CartCopyWith<$Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<$Res> get address {
  
  return $ShippingAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}



/// @nodoc


class _OrderRequest implements OrderRequest {
  const _OrderRequest({required this.cart, required this.address, required this.paymentMethod, this.notes = '', this.shipToDifferentAddress = false});
  

@override final  Cart cart;
@override final  ShippingAddress address;
@override final  PaymentMethod paymentMethod;
@override@JsonKey() final  String notes;
@override@JsonKey() final  bool shipToDifferentAddress;

/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderRequestCopyWith<_OrderRequest> get copyWith => __$OrderRequestCopyWithImpl<_OrderRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderRequest&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.address, address) || other.address == address)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.shipToDifferentAddress, shipToDifferentAddress) || other.shipToDifferentAddress == shipToDifferentAddress));
}


@override
int get hashCode => Object.hash(runtimeType,cart,address,paymentMethod,notes,shipToDifferentAddress);

@override
String toString() {
  return 'OrderRequest(cart: $cart, address: $address, paymentMethod: $paymentMethod, notes: $notes, shipToDifferentAddress: $shipToDifferentAddress)';
}


}

/// @nodoc
abstract mixin class _$OrderRequestCopyWith<$Res> implements $OrderRequestCopyWith<$Res> {
  factory _$OrderRequestCopyWith(_OrderRequest value, $Res Function(_OrderRequest) _then) = __$OrderRequestCopyWithImpl;
@override @useResult
$Res call({
 Cart cart, ShippingAddress address, PaymentMethod paymentMethod, String notes, bool shipToDifferentAddress
});


@override $CartCopyWith<$Res> get cart;@override $ShippingAddressCopyWith<$Res> get address;

}
/// @nodoc
class __$OrderRequestCopyWithImpl<$Res>
    implements _$OrderRequestCopyWith<$Res> {
  __$OrderRequestCopyWithImpl(this._self, this._then);

  final _OrderRequest _self;
  final $Res Function(_OrderRequest) _then;

/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cart = null,Object? address = null,Object? paymentMethod = null,Object? notes = null,Object? shipToDifferentAddress = null,}) {
  return _then(_OrderRequest(
cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as Cart,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddress,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,shipToDifferentAddress: null == shipToDifferentAddress ? _self.shipToDifferentAddress : shipToDifferentAddress // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartCopyWith<$Res> get cart {
  
  return $CartCopyWith<$Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}/// Create a copy of OrderRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<$Res> get address {
  
  return $ShippingAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

/// @nodoc
mixin _$Order {

 String get id; List<CartItem> get items; double get subtotal; double get discount; double get shippingCost; double get total; PaymentMethod get paymentMethod; ShippingAddress get address; DateTime get placedAt; String get status;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.total, total) || other.total == total)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.address, address) || other.address == address)&&(identical(other.placedAt, placedAt) || other.placedAt == placedAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(items),subtotal,discount,shippingCost,total,paymentMethod,address,placedAt,status);

@override
String toString() {
  return 'Order(id: $id, items: $items, subtotal: $subtotal, discount: $discount, shippingCost: $shippingCost, total: $total, paymentMethod: $paymentMethod, address: $address, placedAt: $placedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String id, List<CartItem> items, double subtotal, double discount, double shippingCost, double total, PaymentMethod paymentMethod, ShippingAddress address, DateTime placedAt, String status
});


$ShippingAddressCopyWith<$Res> get address;

}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? items = null,Object? subtotal = null,Object? discount = null,Object? shippingCost = null,Object? total = null,Object? paymentMethod = null,Object? address = null,Object? placedAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,shippingCost: null == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddress,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<$Res> get address {
  
  return $ShippingAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}



/// @nodoc


class _Order implements Order {
  const _Order({required this.id, required final  List<CartItem> items, required this.subtotal, required this.discount, required this.shippingCost, required this.total, required this.paymentMethod, required this.address, required this.placedAt, this.status = 'paid'}): _items = items;
  

@override final  String id;
 final  List<CartItem> _items;
@override List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  double subtotal;
@override final  double discount;
@override final  double shippingCost;
@override final  double total;
@override final  PaymentMethod paymentMethod;
@override final  ShippingAddress address;
@override final  DateTime placedAt;
@override@JsonKey() final  String status;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.shippingCost, shippingCost) || other.shippingCost == shippingCost)&&(identical(other.total, total) || other.total == total)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.address, address) || other.address == address)&&(identical(other.placedAt, placedAt) || other.placedAt == placedAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_items),subtotal,discount,shippingCost,total,paymentMethod,address,placedAt,status);

@override
String toString() {
  return 'Order(id: $id, items: $items, subtotal: $subtotal, discount: $discount, shippingCost: $shippingCost, total: $total, paymentMethod: $paymentMethod, address: $address, placedAt: $placedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String id, List<CartItem> items, double subtotal, double discount, double shippingCost, double total, PaymentMethod paymentMethod, ShippingAddress address, DateTime placedAt, String status
});


@override $ShippingAddressCopyWith<$Res> get address;

}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? items = null,Object? subtotal = null,Object? discount = null,Object? shippingCost = null,Object? total = null,Object? paymentMethod = null,Object? address = null,Object? placedAt = null,Object? status = null,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,shippingCost: null == shippingCost ? _self.shippingCost : shippingCost // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as ShippingAddress,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingAddressCopyWith<$Res> get address {
  
  return $ShippingAddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
