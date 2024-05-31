import 'dart:convert';

import 'package:spsp_mobile/models/customer.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class CustomerProvider extends BaseProvider<Customer> {
  CustomerProvider() : super("Customer");

  @override
  Customer fromJson(data) {
    return Customer.fromJson(data);
  }

  Future<Customer> getCustomerAccountInfo({dynamic filter}) async {
    var url = "${BaseProvider.baseUrl}$endpoint/GetCustomerAccountInfo";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);

      var customer = fromJson(jsonData);
      return customer;
    } else {
      throw new Exception("Unknown error");
    }
  }
}
