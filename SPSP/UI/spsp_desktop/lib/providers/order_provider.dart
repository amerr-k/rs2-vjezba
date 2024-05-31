import 'dart:convert';

import 'package:spsp_desktop/models/order/order.dart';
import 'package:spsp_desktop/providers/base_provider.dart';

class OrderProvider extends BaseProvider<Order> {
  OrderProvider() : super("Order");

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }

  Future<Order> cancelOrder(int id) async {
    var url = "${baseUrl}$endpoint/$id/cancel";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.put(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<Order> completeOrder(int id) async {
    var url = "${baseUrl}$endpoint/$id/complete";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.put(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      throw new Exception("Unknown error");
    }
  }
}
