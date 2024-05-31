import 'package:spsp_mobile/models/menu_item.dart';
import 'package:spsp_mobile/models/qr_table.dart';

class Cart {
  List<CartItem> items = [];
  late double totalAmountWithVAT = 0;
  late int qrTableId;
  QRTable? qrTable;
  double VAT = 0.17;

  // Getter method
  double get totalAmount => totalAmountWithVAT - (totalAmountWithVAT * VAT);
}

class CartItem {
  CartItem(this.menuItem, this.quantity, this.subtotal);
  late MenuItem menuItem;
  late int quantity;
  late double subtotal;
}
