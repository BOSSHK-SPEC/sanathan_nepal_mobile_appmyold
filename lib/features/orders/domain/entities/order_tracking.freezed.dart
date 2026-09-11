// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_tracking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderEvent {

 OrderStage get stage; DateTime get at; String get note;
/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderEventCopyWith<OrderEvent> get copyWith => _$OrderEventCopyWithImpl<OrderEvent>(this as OrderEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderEvent&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.at, at) || other.at == at)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,stage,at,note);

@override
String toString() {
  return 'OrderEvent(stage: $stage, at: $at, note: $note)';
}


}

/// @nodoc
abstract mixin class $OrderEventCopyWith<$Res>  {
  factory $OrderEventCopyWith(OrderEvent value, $Res Function(OrderEvent) _then) = _$OrderEventCopyWithImpl;
@useResult
$Res call({
 OrderStage stage, DateTime at, String note
});




}
/// @nodoc
class _$OrderEventCopyWithImpl<$Res>
    implements $OrderEventCopyWith<$Res> {
  _$OrderEventCopyWithImpl(this._self, this._then);

  final OrderEvent _self;
  final $Res Function(OrderEvent) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? at = null,Object? note = null,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as OrderStage,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _OrderEvent implements OrderEvent {
  const _OrderEvent({required this.stage, required this.at, this.note = ''});
  

@override final  OrderStage stage;
@override final  DateTime at;
@override@JsonKey() final  String note;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderEventCopyWith<_OrderEvent> get copyWith => __$OrderEventCopyWithImpl<_OrderEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderEvent&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.at, at) || other.at == at)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,stage,at,note);

@override
String toString() {
  return 'OrderEvent(stage: $stage, at: $at, note: $note)';
}


}

/// @nodoc
abstract mixin class _$OrderEventCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$OrderEventCopyWith(_OrderEvent value, $Res Function(_OrderEvent) _then) = __$OrderEventCopyWithImpl;
@override @useResult
$Res call({
 OrderStage stage, DateTime at, String note
});




}
/// @nodoc
class __$OrderEventCopyWithImpl<$Res>
    implements _$OrderEventCopyWith<$Res> {
  __$OrderEventCopyWithImpl(this._self, this._then);

  final _OrderEvent _self;
  final $Res Function(_OrderEvent) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? at = null,Object? note = null,}) {
  return _then(_OrderEvent(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as OrderStage,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OrderItem {

 String get productId; String get name; int get quantity; double get unitPrice; String? get imageAsset;
/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemCopyWith<OrderItem> get copyWith => _$OrderItemCopyWithImpl<OrderItem>(this as OrderItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,quantity,unitPrice,imageAsset);

@override
String toString() {
  return 'OrderItem(productId: $productId, name: $name, quantity: $quantity, unitPrice: $unitPrice, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class $OrderItemCopyWith<$Res>  {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) _then) = _$OrderItemCopyWithImpl;
@useResult
$Res call({
 String productId, String name, int quantity, double unitPrice, String? imageAsset
});




}
/// @nodoc
class _$OrderItemCopyWithImpl<$Res>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._self, this._then);

  final OrderItem _self;
  final $Res Function(OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? name = null,Object? quantity = null,Object? unitPrice = null,Object? imageAsset = freezed,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _OrderItem extends OrderItem {
  const _OrderItem({required this.productId, required this.name, required this.quantity, required this.unitPrice, this.imageAsset}): super._();
  

@override final  String productId;
@override final  String name;
@override final  int quantity;
@override final  double unitPrice;
@override final  String? imageAsset;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemCopyWith<_OrderItem> get copyWith => __$OrderItemCopyWithImpl<_OrderItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,quantity,unitPrice,imageAsset);

@override
String toString() {
  return 'OrderItem(productId: $productId, name: $name, quantity: $quantity, unitPrice: $unitPrice, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$OrderItemCopyWith<$Res> implements $OrderItemCopyWith<$Res> {
  factory _$OrderItemCopyWith(_OrderItem value, $Res Function(_OrderItem) _then) = __$OrderItemCopyWithImpl;
@override @useResult
$Res call({
 String productId, String name, int quantity, double unitPrice, String? imageAsset
});




}
/// @nodoc
class __$OrderItemCopyWithImpl<$Res>
    implements _$OrderItemCopyWith<$Res> {
  __$OrderItemCopyWithImpl(this._self, this._then);

  final _OrderItem _self;
  final $Res Function(_OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? name = null,Object? quantity = null,Object? unitPrice = null,Object? imageAsset = freezed,}) {
  return _then(_OrderItem(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TrackedOrder {

 String get id; String get reference; OrderStage get stage; List<OrderItem> get items; DateTime get placedAt; String get deliveryAddress; List<OrderEvent> get events; double get shipping; double get discount;/// Counterparty: the seller for a buyer, the buyer for a seller.
 String get counterpartyName; String? get courierName; String? get trackingNumber; DateTime? get expectedBy;/// Set once a return has been raised.
 String? get returnReason;
/// Create a copy of TrackedOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackedOrderCopyWith<TrackedOrder> get copyWith => _$TrackedOrderCopyWithImpl<TrackedOrder>(this as TrackedOrder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackedOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.stage, stage) || other.stage == stage)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.placedAt, placedAt) || other.placedAt == placedAt)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.counterpartyName, counterpartyName) || other.counterpartyName == counterpartyName)&&(identical(other.courierName, courierName) || other.courierName == courierName)&&(identical(other.trackingNumber, trackingNumber) || other.trackingNumber == trackingNumber)&&(identical(other.expectedBy, expectedBy) || other.expectedBy == expectedBy)&&(identical(other.returnReason, returnReason) || other.returnReason == returnReason));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,stage,const DeepCollectionEquality().hash(items),placedAt,deliveryAddress,const DeepCollectionEquality().hash(events),shipping,discount,counterpartyName,courierName,trackingNumber,expectedBy,returnReason);

@override
String toString() {
  return 'TrackedOrder(id: $id, reference: $reference, stage: $stage, items: $items, placedAt: $placedAt, deliveryAddress: $deliveryAddress, events: $events, shipping: $shipping, discount: $discount, counterpartyName: $counterpartyName, courierName: $courierName, trackingNumber: $trackingNumber, expectedBy: $expectedBy, returnReason: $returnReason)';
}


}

/// @nodoc
abstract mixin class $TrackedOrderCopyWith<$Res>  {
  factory $TrackedOrderCopyWith(TrackedOrder value, $Res Function(TrackedOrder) _then) = _$TrackedOrderCopyWithImpl;
@useResult
$Res call({
 String id, String reference, OrderStage stage, List<OrderItem> items, DateTime placedAt, String deliveryAddress, List<OrderEvent> events, double shipping, double discount, String counterpartyName, String? courierName, String? trackingNumber, DateTime? expectedBy, String? returnReason
});




}
/// @nodoc
class _$TrackedOrderCopyWithImpl<$Res>
    implements $TrackedOrderCopyWith<$Res> {
  _$TrackedOrderCopyWithImpl(this._self, this._then);

  final TrackedOrder _self;
  final $Res Function(TrackedOrder) _then;

/// Create a copy of TrackedOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? stage = null,Object? items = null,Object? placedAt = null,Object? deliveryAddress = null,Object? events = null,Object? shipping = null,Object? discount = null,Object? counterpartyName = null,Object? courierName = freezed,Object? trackingNumber = freezed,Object? expectedBy = freezed,Object? returnReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as OrderStage,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<OrderEvent>,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,counterpartyName: null == counterpartyName ? _self.counterpartyName : counterpartyName // ignore: cast_nullable_to_non_nullable
as String,courierName: freezed == courierName ? _self.courierName : courierName // ignore: cast_nullable_to_non_nullable
as String?,trackingNumber: freezed == trackingNumber ? _self.trackingNumber : trackingNumber // ignore: cast_nullable_to_non_nullable
as String?,expectedBy: freezed == expectedBy ? _self.expectedBy : expectedBy // ignore: cast_nullable_to_non_nullable
as DateTime?,returnReason: freezed == returnReason ? _self.returnReason : returnReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _TrackedOrder extends TrackedOrder {
  const _TrackedOrder({required this.id, required this.reference, required this.stage, required final  List<OrderItem> items, required this.placedAt, required this.deliveryAddress, final  List<OrderEvent> events = const <OrderEvent>[], this.shipping = 0, this.discount = 0, this.counterpartyName = '', this.courierName, this.trackingNumber, this.expectedBy, this.returnReason}): _items = items,_events = events,super._();
  

@override final  String id;
@override final  String reference;
@override final  OrderStage stage;
 final  List<OrderItem> _items;
@override List<OrderItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  DateTime placedAt;
@override final  String deliveryAddress;
 final  List<OrderEvent> _events;
@override@JsonKey() List<OrderEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override@JsonKey() final  double shipping;
@override@JsonKey() final  double discount;
/// Counterparty: the seller for a buyer, the buyer for a seller.
@override@JsonKey() final  String counterpartyName;
@override final  String? courierName;
@override final  String? trackingNumber;
@override final  DateTime? expectedBy;
/// Set once a return has been raised.
@override final  String? returnReason;

/// Create a copy of TrackedOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackedOrderCopyWith<_TrackedOrder> get copyWith => __$TrackedOrderCopyWithImpl<_TrackedOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackedOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.stage, stage) || other.stage == stage)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.placedAt, placedAt) || other.placedAt == placedAt)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.counterpartyName, counterpartyName) || other.counterpartyName == counterpartyName)&&(identical(other.courierName, courierName) || other.courierName == courierName)&&(identical(other.trackingNumber, trackingNumber) || other.trackingNumber == trackingNumber)&&(identical(other.expectedBy, expectedBy) || other.expectedBy == expectedBy)&&(identical(other.returnReason, returnReason) || other.returnReason == returnReason));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,stage,const DeepCollectionEquality().hash(_items),placedAt,deliveryAddress,const DeepCollectionEquality().hash(_events),shipping,discount,counterpartyName,courierName,trackingNumber,expectedBy,returnReason);

@override
String toString() {
  return 'TrackedOrder(id: $id, reference: $reference, stage: $stage, items: $items, placedAt: $placedAt, deliveryAddress: $deliveryAddress, events: $events, shipping: $shipping, discount: $discount, counterpartyName: $counterpartyName, courierName: $courierName, trackingNumber: $trackingNumber, expectedBy: $expectedBy, returnReason: $returnReason)';
}


}

/// @nodoc
abstract mixin class _$TrackedOrderCopyWith<$Res> implements $TrackedOrderCopyWith<$Res> {
  factory _$TrackedOrderCopyWith(_TrackedOrder value, $Res Function(_TrackedOrder) _then) = __$TrackedOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, OrderStage stage, List<OrderItem> items, DateTime placedAt, String deliveryAddress, List<OrderEvent> events, double shipping, double discount, String counterpartyName, String? courierName, String? trackingNumber, DateTime? expectedBy, String? returnReason
});




}
/// @nodoc
class __$TrackedOrderCopyWithImpl<$Res>
    implements _$TrackedOrderCopyWith<$Res> {
  __$TrackedOrderCopyWithImpl(this._self, this._then);

  final _TrackedOrder _self;
  final $Res Function(_TrackedOrder) _then;

/// Create a copy of TrackedOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? stage = null,Object? items = null,Object? placedAt = null,Object? deliveryAddress = null,Object? events = null,Object? shipping = null,Object? discount = null,Object? counterpartyName = null,Object? courierName = freezed,Object? trackingNumber = freezed,Object? expectedBy = freezed,Object? returnReason = freezed,}) {
  return _then(_TrackedOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as OrderStage,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<OrderEvent>,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as double,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,counterpartyName: null == counterpartyName ? _self.counterpartyName : counterpartyName // ignore: cast_nullable_to_non_nullable
as String,courierName: freezed == courierName ? _self.courierName : courierName // ignore: cast_nullable_to_non_nullable
as String?,trackingNumber: freezed == trackingNumber ? _self.trackingNumber : trackingNumber // ignore: cast_nullable_to_non_nullable
as String?,expectedBy: freezed == expectedBy ? _self.expectedBy : expectedBy // ignore: cast_nullable_to_non_nullable
as DateTime?,returnReason: freezed == returnReason ? _self.returnReason : returnReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ReturnDraft {

 String get orderId; ReturnReason get reason; List<String> get productIds; String get details; List<String> get photoRefs;
/// Create a copy of ReturnDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReturnDraftCopyWith<ReturnDraft> get copyWith => _$ReturnDraftCopyWithImpl<ReturnDraft>(this as ReturnDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReturnDraft&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.productIds, productIds)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other.photoRefs, photoRefs));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,reason,const DeepCollectionEquality().hash(productIds),details,const DeepCollectionEquality().hash(photoRefs));

@override
String toString() {
  return 'ReturnDraft(orderId: $orderId, reason: $reason, productIds: $productIds, details: $details, photoRefs: $photoRefs)';
}


}

/// @nodoc
abstract mixin class $ReturnDraftCopyWith<$Res>  {
  factory $ReturnDraftCopyWith(ReturnDraft value, $Res Function(ReturnDraft) _then) = _$ReturnDraftCopyWithImpl;
@useResult
$Res call({
 String orderId, ReturnReason reason, List<String> productIds, String details, List<String> photoRefs
});




}
/// @nodoc
class _$ReturnDraftCopyWithImpl<$Res>
    implements $ReturnDraftCopyWith<$Res> {
  _$ReturnDraftCopyWithImpl(this._self, this._then);

  final ReturnDraft _self;
  final $Res Function(ReturnDraft) _then;

/// Create a copy of ReturnDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? reason = null,Object? productIds = null,Object? details = null,Object? photoRefs = null,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReturnReason,productIds: null == productIds ? _self.productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,photoRefs: null == photoRefs ? _self.photoRefs : photoRefs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}



/// @nodoc


class _ReturnDraft implements ReturnDraft {
  const _ReturnDraft({required this.orderId, required this.reason, final  List<String> productIds = const <String>[], this.details = '', final  List<String> photoRefs = const <String>[]}): _productIds = productIds,_photoRefs = photoRefs;
  

@override final  String orderId;
@override final  ReturnReason reason;
 final  List<String> _productIds;
@override@JsonKey() List<String> get productIds {
  if (_productIds is EqualUnmodifiableListView) return _productIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productIds);
}

@override@JsonKey() final  String details;
 final  List<String> _photoRefs;
@override@JsonKey() List<String> get photoRefs {
  if (_photoRefs is EqualUnmodifiableListView) return _photoRefs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoRefs);
}


/// Create a copy of ReturnDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReturnDraftCopyWith<_ReturnDraft> get copyWith => __$ReturnDraftCopyWithImpl<_ReturnDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReturnDraft&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other._productIds, _productIds)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other._photoRefs, _photoRefs));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,reason,const DeepCollectionEquality().hash(_productIds),details,const DeepCollectionEquality().hash(_photoRefs));

@override
String toString() {
  return 'ReturnDraft(orderId: $orderId, reason: $reason, productIds: $productIds, details: $details, photoRefs: $photoRefs)';
}


}

/// @nodoc
abstract mixin class _$ReturnDraftCopyWith<$Res> implements $ReturnDraftCopyWith<$Res> {
  factory _$ReturnDraftCopyWith(_ReturnDraft value, $Res Function(_ReturnDraft) _then) = __$ReturnDraftCopyWithImpl;
@override @useResult
$Res call({
 String orderId, ReturnReason reason, List<String> productIds, String details, List<String> photoRefs
});




}
/// @nodoc
class __$ReturnDraftCopyWithImpl<$Res>
    implements _$ReturnDraftCopyWith<$Res> {
  __$ReturnDraftCopyWithImpl(this._self, this._then);

  final _ReturnDraft _self;
  final $Res Function(_ReturnDraft) _then;

/// Create a copy of ReturnDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? reason = null,Object? productIds = null,Object? details = null,Object? photoRefs = null,}) {
  return _then(_ReturnDraft(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReturnReason,productIds: null == productIds ? _self._productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,photoRefs: null == photoRefs ? _self._photoRefs : photoRefs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
