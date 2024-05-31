import 'dart:convert';

import 'package:spsp_mobile/models/reservation/reservation.dart';
import 'package:spsp_mobile/providers/base_provider.dart';

class ReservationProvider extends BaseProvider<Reservation> {
  ReservationProvider() : super("Reservation");

  @override
  Reservation fromJson(data) {
    return Reservation.fromJson(data);
  }

  Future<List<String>> getAllowedActions(String id) async {
    var url = "${BaseProvider.baseUrl}$endpoint/$id/allowedActions";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);

      List<String> searchResult = [];

      // Iterate over the elements in jsonData['result'] and cast each element to a string
      for (var item in jsonData) {
        searchResult.add(item.toString());
      }

      return searchResult;
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<Reservation> setState(int id, String state) async {
    var url = "${BaseProvider.baseUrl}$endpoint/$id/$state";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    // var jsonRequest = jsonEncode(request);

    var response = await http!.put(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      throw new Exception("Unknown error");
    }
  }
}
