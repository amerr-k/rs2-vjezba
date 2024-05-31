import 'package:json_annotation/json_annotation.dart';
import 'package:spsp_mobile/models/cart.dart';
import 'package:spsp_mobile/models/order_item.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;
  int? customerId;
  DateTime? orderDateTime;
  double? totalAmount;
  double? totalAmountWithVAT;
  double? vat;
  double? vatAmount;
  String? status;
  int? qrTableId;
  List<OrderItem> orderItems;

  Order(
    this.orderItems, {
    this.id,
    this.customerId,
    this.orderDateTime,
    this.totalAmount,
    this.totalAmountWithVAT,
    this.vat,
    this.vatAmount,
    this.status,
    this.qrTableId,
  });

  factory Order.fromCart(Cart cart) {
    List<OrderItem> orderItems = cart.items.map((cartItem) {
      return OrderItem(
        null,
        null,
        cartItem.menuItem.id, // Assuming menuItem has an id attribute
        cartItem.quantity,
        cartItem.subtotal,
        null, // menuItem will be populated later
      );
    }).toList();

    return Order(
      orderDateTime: DateTime.now(),
      totalAmount: cart.totalAmount,
      totalAmountWithVAT: cart.totalAmountWithVAT,
      vat: cart.VAT,
      qrTableId: cart.qrTable?.id,
      orderItems,
    );
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
